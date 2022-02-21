(module
  (import "console" "log" (func $log (param i32)))
  (func $main (param $p1 i32)
    local.get $p1
    call $log
  )
  (export "main" (func $main))
)