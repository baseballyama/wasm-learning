(module
  (func $main (param $p1 i32) (param $p2 i32) (result i32)
    local.get $p1
    local.get $p2
    i32.add
  )
  (export "main" (func $main))
)