#!/bin/bash

test () {
  res=$(wat2wasm $1 --output=a.wat && deno run --allow-read index.ts)
  if [ "$res" -ne "$2" ] ; then
  echo "failed. '$1'"
  exit 1;
  fi
}

test ./helloworld.wat 42

echo "done!"