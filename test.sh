#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

test () {
  args=("$@")
  expected=$1
  input=$2
  rest=("${args[@]:2}")
  echo "run '$input'"
  res=$(wat2wasm $2 --output=a.wasm && deno run --allow-read index.ts ${rest[@]})
  if [ "$res" -ne "$1" ] ; then
    echo "${RED}failed! '$2', expected: '$expected', actual: '$res'${NC}"
    exit 1;
  fi
}

test_importjs () {
  arg=$1
  input="./importjs.wat"
  echo "run '$input'"
  res=$(wat2wasm $input --output=a.wasm && deno run --allow-read importjs.ts ${arg})
  if [ $res = "$arg" ] ; then
    echo "${RED}failed! 'input', expected: '42', actual: '$res'${NC}"
    exit 1;
  fi
}

test 42 ./helloworld.wat

test 1 ./argument.wat 1
test 0 ./argument.wat 0
test -1 ./argument.wat -1
test 256 ./argument.wat 256

test 3 ./stackmachine.wat 1 2
test -1 ./stackmachine.wat -1 0
test 0 ./stackmachine.wat -1 1
test -3 ./stackmachine.wat -1 -2

test 3 ./multimodule.wat 1 2

test_importjs 42
test_importjs Hello

echo "done!"