(module
 (type $ii (func (param i32) (result i32)))
 (type $iiii (func (param i32 i32 i32) (result i32)))
 (type $iv (func (param i32)))
 (type $iiv (func (param i32 i32)))
 (type $iii (func (param i32 i32) (result i32)))
 (type $v (func))
 (global $std:heap/HEAP_OFFSET (mut i32) (i32.const 0))
 (global $std/array/arr (mut i32) (i32.const 0))
 (global $std/array/i (mut i32) (i32.const 0))
 (global $HEAP_BASE i32 (i32.const 4))
 (memory $0 1)
 (export "memory" (memory $0))
 (start $start)
 (func $std:heap/Heap.allocate (; 0 ;) (type $ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (if
   (i32.eqz
    (get_local $0)
   )
   (return
    (i32.const 0)
   )
  )
  (set_local $1
   (current_memory)
  )
  (if
   (i32.gt_u
    (i32.add
     (get_global $std:heap/HEAP_OFFSET)
     (get_local $0)
    )
    (i32.shl
     (get_local $1)
     (i32.const 16)
    )
   )
   (if
    (i32.lt_s
     (grow_memory
      (select
       (tee_local $2
        (i32.trunc_s/f64
         (f64.ceil
          (f64.div
           (f64.convert_u/i32
            (get_local $0)
           )
           (f64.const 65536)
          )
         )
        )
       )
       (tee_local $1
        (i32.sub
         (i32.mul
          (get_local $1)
          (i32.const 2)
         )
         (get_local $1)
        )
       )
       (i32.gt_s
        (get_local $2)
        (get_local $1)
       )
      )
     )
     (i32.const 0)
    )
    (unreachable)
   )
  )
  (set_local $1
   (get_global $std:heap/HEAP_OFFSET)
  )
  (if
   (block (result i32)
    (set_global $std:heap/HEAP_OFFSET
     (i32.add
      (get_global $std:heap/HEAP_OFFSET)
      (get_local $0)
     )
    )
    (i32.and
     (get_global $std:heap/HEAP_OFFSET)
     (i32.const 7)
    )
   )
   (set_global $std:heap/HEAP_OFFSET
    (i32.add
     (i32.or
      (get_global $std:heap/HEAP_OFFSET)
      (i32.const 7)
     )
     (i32.const 1)
    )
   )
  )
  (get_local $1)
 )
 (func $std:heap/Heap.copy (; 1 ;) (type $iiii) (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (if
   (i32.lt_u
    (get_local $0)
    (get_global $HEAP_BASE)
   )
   (unreachable)
  )
  (set_local $4
   (get_local $0)
  )
  (loop $continue|0
   (if
    (if (result i32)
     (get_local $2)
     (i32.rem_u
      (get_local $1)
      (i32.const 4)
     )
     (get_local $2)
    )
    (block
     (set_local $4
      (i32.add
       (tee_local $3
        (get_local $4)
       )
       (i32.const 1)
      )
     )
     (i32.store8
      (get_local $3)
      (block (result i32)
       (set_local $1
        (i32.add
         (tee_local $3
          (get_local $1)
         )
         (i32.const 1)
        )
       )
       (i32.load8_u
        (get_local $3)
       )
      )
     )
     (set_local $2
      (i32.sub
       (get_local $2)
       (i32.const 1)
      )
     )
     (br $continue|0)
    )
   )
  )
  (if
   (i32.eqz
    (i32.rem_u
     (get_local $4)
     (i32.const 4)
    )
   )
   (block
    (loop $continue|1
     (if
      (i32.ge_u
       (get_local $2)
       (i32.const 16)
      )
      (block
       (i32.store
        (get_local $4)
        (i32.load
         (get_local $1)
        )
       )
       (i32.store
        (i32.add
         (get_local $4)
         (i32.const 4)
        )
        (i32.load
         (i32.add
          (get_local $1)
          (i32.const 4)
         )
        )
       )
       (i32.store
        (i32.add
         (get_local $4)
         (i32.const 8)
        )
        (i32.load
         (i32.add
          (get_local $1)
          (i32.const 8)
         )
        )
       )
       (i32.store
        (i32.add
         (get_local $4)
         (i32.const 12)
        )
        (i32.load
         (i32.add
          (get_local $1)
          (i32.const 12)
         )
        )
       )
       (set_local $1
        (i32.add
         (get_local $1)
         (i32.const 16)
        )
       )
       (set_local $4
        (i32.add
         (get_local $4)
         (i32.const 16)
        )
       )
       (set_local $2
        (i32.sub
         (get_local $2)
         (i32.const 16)
        )
       )
       (br $continue|1)
      )
     )
    )
    (if
     (i32.and
      (get_local $2)
      (i32.const 8)
     )
     (block
      (i32.store
       (get_local $4)
       (i32.load
        (get_local $1)
       )
      )
      (i32.store
       (i32.add
        (get_local $4)
        (i32.const 4)
       )
       (i32.load
        (i32.add
         (get_local $1)
         (i32.const 4)
        )
       )
      )
      (set_local $4
       (i32.add
        (get_local $4)
        (i32.const 8)
       )
      )
      (set_local $1
       (i32.add
        (get_local $1)
        (i32.const 8)
       )
      )
     )
    )
    (if
     (i32.and
      (get_local $2)
      (i32.const 4)
     )
     (block
      (i32.store
       (get_local $4)
       (i32.load
        (get_local $1)
       )
      )
      (set_local $4
       (i32.add
        (get_local $4)
        (i32.const 4)
       )
      )
      (set_local $1
       (i32.add
        (get_local $1)
        (i32.const 4)
       )
      )
     )
    )
    (if
     (i32.and
      (get_local $2)
      (i32.const 2)
     )
     (block
      (i32.store16
       (get_local $4)
       (i32.load16_u
        (get_local $1)
       )
      )
      (set_local $4
       (i32.add
        (get_local $4)
        (i32.const 2)
       )
      )
      (set_local $1
       (i32.add
        (get_local $1)
        (i32.const 2)
       )
      )
     )
    )
    (if
     (i32.and
      (get_local $2)
      (i32.const 1)
     )
     (block
      (set_local $3
       (get_local $4)
      )
      (i32.store8
       (get_local $3)
       (block (result i32)
        (set_local $3
         (get_local $1)
        )
        (i32.load8_u
         (get_local $3)
        )
       )
      )
     )
    )
    (return
     (get_local $0)
    )
   )
  )
  (if
   (i32.ge_u
    (get_local $2)
    (i32.const 32)
   )
   (block $break|2
    (block $case2|2
     (block $case1|2
      (block $case0|2
       (block $tablify|0
        (br_table $case0|2 $case1|2 $case2|2 $tablify|0
         (i32.sub
          (i32.rem_u
           (get_local $4)
           (i32.const 4)
          )
          (i32.const 1)
         )
        )
       )
       (br $break|2)
      )
      (set_local $5
       (i32.load
        (get_local $1)
       )
      )
      (set_local $4
       (i32.add
        (tee_local $3
         (get_local $4)
        )
        (i32.const 1)
       )
      )
      (i32.store8
       (get_local $3)
       (block (result i32)
        (set_local $1
         (i32.add
          (tee_local $3
           (get_local $1)
          )
          (i32.const 1)
         )
        )
        (i32.load8_u
         (get_local $3)
        )
       )
      )
      (set_local $4
       (i32.add
        (tee_local $3
         (get_local $4)
        )
        (i32.const 1)
       )
      )
      (i32.store8
       (get_local $3)
       (block (result i32)
        (set_local $1
         (i32.add
          (tee_local $3
           (get_local $1)
          )
          (i32.const 1)
         )
        )
        (i32.load8_u
         (get_local $3)
        )
       )
      )
      (set_local $4
       (i32.add
        (tee_local $3
         (get_local $4)
        )
        (i32.const 1)
       )
      )
      (i32.store8
       (get_local $3)
       (block (result i32)
        (set_local $1
         (i32.add
          (tee_local $3
           (get_local $1)
          )
          (i32.const 1)
         )
        )
        (i32.load8_u
         (get_local $3)
        )
       )
      )
      (set_local $2
       (i32.sub
        (get_local $2)
        (i32.const 3)
       )
      )
      (loop $continue|3
       (if
        (i32.ge_u
         (get_local $2)
         (i32.const 17)
        )
        (block
         (i32.store
          (get_local $4)
          (i32.or
           (i32.shr_u
            (get_local $5)
            (i32.const 24)
           )
           (i32.shl
            (tee_local $3
             (i32.load
              (i32.add
               (get_local $1)
               (i32.const 1)
              )
             )
            )
            (i32.const 8)
           )
          )
         )
         (i32.store
          (i32.add
           (get_local $4)
           (i32.const 4)
          )
          (i32.or
           (i32.shr_u
            (get_local $3)
            (i32.const 24)
           )
           (i32.shl
            (tee_local $5
             (i32.load
              (i32.add
               (get_local $1)
               (i32.const 5)
              )
             )
            )
            (i32.const 8)
           )
          )
         )
         (i32.store
          (i32.add
           (get_local $4)
           (i32.const 8)
          )
          (i32.or
           (i32.shr_u
            (get_local $5)
            (i32.const 24)
           )
           (i32.shl
            (tee_local $3
             (i32.load
              (i32.add
               (get_local $1)
               (i32.const 9)
              )
             )
            )
            (i32.const 8)
           )
          )
         )
         (i32.store
          (i32.add
           (get_local $4)
           (i32.const 12)
          )
          (i32.or
           (i32.shr_u
            (get_local $3)
            (i32.const 24)
           )
           (i32.shl
            (tee_local $5
             (i32.load
              (i32.add
               (get_local $1)
               (i32.const 13)
              )
             )
            )
            (i32.const 8)
           )
          )
         )
         (set_local $1
          (i32.add
           (get_local $1)
           (i32.const 16)
          )
         )
         (set_local $4
          (i32.add
           (get_local $4)
           (i32.const 16)
          )
         )
         (set_local $2
          (i32.sub
           (get_local $2)
           (i32.const 16)
          )
         )
         (br $continue|3)
        )
       )
      )
      (br $break|2)
     )
     (set_local $5
      (i32.load
       (get_local $1)
      )
     )
     (set_local $4
      (i32.add
       (tee_local $3
        (get_local $4)
       )
       (i32.const 1)
      )
     )
     (i32.store8
      (get_local $3)
      (block (result i32)
       (set_local $1
        (i32.add
         (tee_local $3
          (get_local $1)
         )
         (i32.const 1)
        )
       )
       (i32.load8_u
        (get_local $3)
       )
      )
     )
     (set_local $4
      (i32.add
       (tee_local $3
        (get_local $4)
       )
       (i32.const 1)
      )
     )
     (i32.store8
      (get_local $3)
      (block (result i32)
       (set_local $1
        (i32.add
         (tee_local $3
          (get_local $1)
         )
         (i32.const 1)
        )
       )
       (i32.load8_u
        (get_local $3)
       )
      )
     )
     (set_local $2
      (i32.sub
       (get_local $2)
       (i32.const 2)
      )
     )
     (loop $continue|4
      (if
       (i32.ge_u
        (get_local $2)
        (i32.const 18)
       )
       (block
        (i32.store
         (get_local $4)
         (i32.or
          (i32.shr_u
           (get_local $5)
           (i32.const 16)
          )
          (i32.shl
           (tee_local $3
            (i32.load
             (i32.add
              (get_local $1)
              (i32.const 2)
             )
            )
           )
           (i32.const 16)
          )
         )
        )
        (i32.store
         (i32.add
          (get_local $4)
          (i32.const 4)
         )
         (i32.or
          (i32.shr_u
           (get_local $3)
           (i32.const 16)
          )
          (i32.shl
           (tee_local $5
            (i32.load
             (i32.add
              (get_local $1)
              (i32.const 6)
             )
            )
           )
           (i32.const 16)
          )
         )
        )
        (i32.store
         (i32.add
          (get_local $4)
          (i32.const 8)
         )
         (i32.or
          (i32.shr_u
           (get_local $5)
           (i32.const 16)
          )
          (i32.shl
           (tee_local $3
            (i32.load
             (i32.add
              (get_local $1)
              (i32.const 10)
             )
            )
           )
           (i32.const 16)
          )
         )
        )
        (i32.store
         (i32.add
          (get_local $4)
          (i32.const 12)
         )
         (i32.or
          (i32.shr_u
           (get_local $3)
           (i32.const 16)
          )
          (i32.shl
           (tee_local $5
            (i32.load
             (i32.add
              (get_local $1)
              (i32.const 14)
             )
            )
           )
           (i32.const 16)
          )
         )
        )
        (set_local $1
         (i32.add
          (get_local $1)
          (i32.const 16)
         )
        )
        (set_local $4
         (i32.add
          (get_local $4)
          (i32.const 16)
         )
        )
        (set_local $2
         (i32.sub
          (get_local $2)
          (i32.const 16)
         )
        )
        (br $continue|4)
       )
      )
     )
     (br $break|2)
    )
    (set_local $5
     (i32.load
      (get_local $1)
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $2
     (i32.sub
      (get_local $2)
      (i32.const 1)
     )
    )
    (loop $continue|5
     (if
      (i32.ge_u
       (get_local $2)
       (i32.const 19)
      )
      (block
       (i32.store
        (get_local $4)
        (i32.or
         (i32.shr_u
          (get_local $5)
          (i32.const 8)
         )
         (i32.shl
          (tee_local $3
           (i32.load
            (i32.add
             (get_local $1)
             (i32.const 3)
            )
           )
          )
          (i32.const 24)
         )
        )
       )
       (i32.store
        (i32.add
         (get_local $4)
         (i32.const 4)
        )
        (i32.or
         (i32.shr_u
          (get_local $3)
          (i32.const 8)
         )
         (i32.shl
          (tee_local $5
           (i32.load
            (i32.add
             (get_local $1)
             (i32.const 7)
            )
           )
          )
          (i32.const 24)
         )
        )
       )
       (i32.store
        (i32.add
         (get_local $4)
         (i32.const 8)
        )
        (i32.or
         (i32.shr_u
          (get_local $5)
          (i32.const 8)
         )
         (i32.shl
          (tee_local $3
           (i32.load
            (i32.add
             (get_local $1)
             (i32.const 11)
            )
           )
          )
          (i32.const 24)
         )
        )
       )
       (i32.store
        (i32.add
         (get_local $4)
         (i32.const 12)
        )
        (i32.or
         (i32.shr_u
          (get_local $3)
          (i32.const 8)
         )
         (i32.shl
          (tee_local $5
           (i32.load
            (i32.add
             (get_local $1)
             (i32.const 15)
            )
           )
          )
          (i32.const 24)
         )
        )
       )
       (set_local $1
        (i32.add
         (get_local $1)
         (i32.const 16)
        )
       )
       (set_local $4
        (i32.add
         (get_local $4)
         (i32.const 16)
        )
       )
       (set_local $2
        (i32.sub
         (get_local $2)
         (i32.const 16)
        )
       )
       (br $continue|5)
      )
     )
    )
   )
  )
  (if
   (i32.and
    (get_local $2)
    (i32.const 16)
   )
   (block
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
   )
  )
  (if
   (i32.and
    (get_local $2)
    (i32.const 8)
   )
   (block
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
   )
  )
  (if
   (i32.and
    (get_local $2)
    (i32.const 4)
   )
   (block
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
   )
  )
  (if
   (i32.and
    (get_local $2)
    (i32.const 2)
   )
   (block
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
    (set_local $4
     (i32.add
      (tee_local $3
       (get_local $4)
      )
      (i32.const 1)
     )
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $1
       (i32.add
        (tee_local $3
         (get_local $1)
        )
        (i32.const 1)
       )
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
   )
  )
  (if
   (i32.and
    (get_local $2)
    (i32.const 1)
   )
   (block
    (set_local $3
     (get_local $4)
    )
    (i32.store8
     (get_local $3)
     (block (result i32)
      (set_local $3
       (get_local $1)
      )
      (i32.load8_u
       (get_local $3)
      )
     )
    )
   )
  )
  (get_local $0)
 )
 (func $std:heap/Heap.dispose (; 2 ;) (type $iv) (param $0 i32)
  (nop)
 )
 (func $std:array/Array#__grow (; 3 ;) (type $iiv) (param $0 i32) (param $1 i32)
  (local $2 i32)
  (if
   (i32.le_s
    (get_local $1)
    (i32.load offset=4
     (get_local $0)
    )
   )
   (unreachable)
  )
  (set_local $2
   (call $std:heap/Heap.allocate
    (i32.mul
     (get_local $1)
     (i32.const 4)
    )
   )
  )
  (if
   (i32.load
    (get_local $0)
   )
   (drop
    (call $std:heap/Heap.copy
     (get_local $2)
     (i32.load
      (get_local $0)
     )
     (i32.mul
      (i32.load offset=4
       (get_local $0)
      )
      (i32.const 4)
     )
    )
   )
  )
  (call $std:heap/Heap.dispose
   (i32.load
    (get_local $0)
   )
  )
  (i32.store
   (get_local $0)
   (get_local $2)
  )
  (i32.store offset=4
   (get_local $0)
   (get_local $1)
  )
 )
 (func $std:array/Array#push (; 4 ;) (type $iii) (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (if
   (i32.ge_u
    (i32.load offset=8
     (get_local $0)
    )
    (i32.load offset=4
     (get_local $0)
    )
   )
   (call $std:array/Array#__grow
    (get_local $0)
    (select
     (tee_local $2
      (i32.add
       (i32.load offset=8
        (get_local $0)
       )
       (i32.const 1)
      )
     )
     (tee_local $3
      (i32.mul
       (i32.load offset=4
        (get_local $0)
       )
       (i32.const 2)
      )
     )
     (i32.gt_s
      (get_local $2)
      (get_local $3)
     )
    )
   )
  )
  (i32.store
   (i32.add
    (i32.load
     (get_local $0)
    )
    (i32.mul
     (i32.load offset=8
      (get_local $0)
     )
     (i32.const 4)
    )
   )
   (get_local $1)
  )
  (i32.store offset=8
   (get_local $0)
   (tee_local $2
    (i32.add
     (i32.load offset=8
      (get_local $0)
     )
     (i32.const 1)
    )
   )
  )
  (get_local $2)
 )
 (func $std:array/Array#__get (; 5 ;) (type $iii) (param $0 i32) (param $1 i32) (result i32)
  (if
   (i32.ge_u
    (get_local $1)
    (i32.load offset=4
     (get_local $0)
    )
   )
   (unreachable)
  )
  (i32.load
   (i32.add
    (i32.load
     (get_local $0)
    )
    (i32.mul
     (get_local $1)
     (i32.const 4)
    )
   )
  )
 )
 (func $std:array/Array#pop (; 6 ;) (type $ii) (param $0 i32) (result i32)
  (local $1 i32)
  (if
   (i32.and
    (if (result i32)
     (tee_local $1
      (i32.lt_s
       (i32.load offset=8
        (get_local $0)
       )
       (i32.const 1)
      )
     )
     (get_local $1)
     (i32.gt_u
      (i32.load offset=8
       (get_local $0)
      )
      (i32.load offset=4
       (get_local $0)
      )
     )
    )
    (i32.const 1)
   )
   (unreachable)
  )
  (i32.store offset=8
   (get_local $0)
   (i32.sub
    (i32.load offset=8
     (get_local $0)
    )
    (i32.const 1)
   )
  )
  (i32.load
   (i32.add
    (i32.load
     (get_local $0)
    )
    (i32.mul
     (i32.load offset=8
      (get_local $0)
     )
     (i32.const 4)
    )
   )
  )
 )
 (func $std:array/Array#unshift (; 7 ;) (type $iii) (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (if
   (i32.ge_u
    (i32.load offset=8
     (get_local $0)
    )
    (tee_local $2
     (i32.load offset=4
      (get_local $0)
     )
    )
   )
   (call $std:array/Array#__grow
    (get_local $0)
    (select
     (tee_local $3
      (i32.add
       (i32.load offset=8
        (get_local $0)
       )
       (i32.const 1)
      )
     )
     (tee_local $4
      (i32.mul
       (get_local $2)
       (i32.const 2)
      )
     )
     (i32.gt_s
      (get_local $3)
      (get_local $4)
     )
    )
   )
  )
  (if
   (get_local $2)
   (loop $continue|0
    (if
     (i32.gt_u
      (get_local $2)
      (i32.const 0)
     )
     (block
      (i32.store
       (i32.add
        (i32.load
         (get_local $0)
        )
        (i32.mul
         (get_local $2)
         (i32.const 4)
        )
       )
       (i32.load
        (i32.add
         (i32.load
          (get_local $0)
         )
         (i32.mul
          (i32.sub
           (get_local $2)
           (i32.const 1)
          )
          (i32.const 4)
         )
        )
       )
      )
      (set_local $2
       (i32.sub
        (get_local $2)
        (i32.const 1)
       )
      )
      (br $continue|0)
     )
    )
   )
  )
  (i32.store
   (i32.load
    (get_local $0)
   )
   (get_local $1)
  )
  (i32.store offset=8
   (get_local $0)
   (tee_local $3
    (i32.add
     (i32.load offset=8
      (get_local $0)
     )
     (i32.const 1)
    )
   )
  )
  (get_local $3)
 )
 (func $std:heap/Heap.fill (; 8 ;) (type $iiii) (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  (local $4 i64)
  (local $5 i32)
  (if
   (i32.lt_u
    (get_local $0)
    (get_global $HEAP_BASE)
   )
   (unreachable)
  )
  (if
   (i32.eqz
    (get_local $2)
   )
   (return
    (get_local $0)
   )
  )
  (i32.store8
   (tee_local $3
    (get_local $0)
   )
   (get_local $1)
  )
  (i32.store8
   (i32.sub
    (i32.add
     (get_local $3)
     (get_local $2)
    )
    (i32.const 1)
   )
   (get_local $1)
  )
  (if
   (i32.le_u
    (get_local $2)
    (i32.const 2)
   )
   (return
    (get_local $0)
   )
  )
  (i32.store8
   (i32.add
    (get_local $3)
    (i32.const 1)
   )
   (get_local $1)
  )
  (i32.store8
   (i32.sub
    (i32.add
     (get_local $3)
     (get_local $2)
    )
    (i32.const 2)
   )
   (get_local $1)
  )
  (i32.store8
   (i32.add
    (get_local $3)
    (i32.const 2)
   )
   (get_local $1)
  )
  (i32.store8
   (i32.sub
    (i32.add
     (get_local $3)
     (get_local $2)
    )
    (i32.const 3)
   )
   (get_local $1)
  )
  (if
   (i32.le_u
    (get_local $2)
    (i32.const 6)
   )
   (return
    (get_local $0)
   )
  )
  (i32.store8
   (i32.add
    (get_local $3)
    (i32.const 3)
   )
   (get_local $1)
  )
  (i32.store8
   (i32.sub
    (i32.add
     (get_local $3)
     (get_local $2)
    )
    (i32.const 4)
   )
   (get_local $1)
  )
  (if
   (i32.le_u
    (get_local $2)
    (i32.const 8)
   )
   (return
    (get_local $0)
   )
  )
  (i32.store
   (tee_local $3
    (i32.add
     (get_local $3)
     (tee_local $5
      (i32.and
       (i32.sub
        (i32.const 0)
        (get_local $3)
       )
       (i32.const 3)
      )
     )
    )
   )
   (tee_local $1
    (i32.mul
     (get_local $1)
     (i32.const 16843009)
    )
   )
  )
  (i32.store
   (i32.sub
    (i32.add
     (get_local $3)
     (tee_local $2
      (i32.and
       (i32.sub
        (get_local $2)
        (get_local $5)
       )
       (i32.const -4)
      )
     )
    )
    (i32.const 4)
   )
   (get_local $1)
  )
  (if
   (i32.le_u
    (get_local $2)
    (i32.const 8)
   )
   (return
    (get_local $0)
   )
  )
  (i32.store
   (i32.add
    (get_local $3)
    (i32.const 4)
   )
   (get_local $1)
  )
  (i32.store
   (i32.add
    (get_local $3)
    (i32.const 8)
   )
   (get_local $1)
  )
  (i32.store
   (i32.sub
    (i32.add
     (get_local $3)
     (get_local $2)
    )
    (i32.const 12)
   )
   (get_local $1)
  )
  (i32.store
   (i32.sub
    (i32.add
     (get_local $3)
     (get_local $2)
    )
    (i32.const 8)
   )
   (get_local $1)
  )
  (if
   (i32.le_u
    (get_local $2)
    (i32.const 24)
   )
   (return
    (get_local $0)
   )
  )
  (i32.store
   (i32.add
    (get_local $3)
    (i32.const 12)
   )
   (get_local $1)
  )
  (i32.store
   (i32.add
    (get_local $3)
    (i32.const 16)
   )
   (get_local $1)
  )
  (i32.store
   (i32.add
    (get_local $3)
    (i32.const 20)
   )
   (get_local $1)
  )
  (i32.store
   (i32.add
    (get_local $3)
    (i32.const 24)
   )
   (get_local $1)
  )
  (i32.store
   (i32.sub
    (i32.add
     (get_local $3)
     (get_local $2)
    )
    (i32.const 28)
   )
   (get_local $1)
  )
  (i32.store
   (i32.sub
    (i32.add
     (get_local $3)
     (get_local $2)
    )
    (i32.const 24)
   )
   (get_local $1)
  )
  (i32.store
   (i32.sub
    (i32.add
     (get_local $3)
     (get_local $2)
    )
    (i32.const 20)
   )
   (get_local $1)
  )
  (i32.store
   (i32.sub
    (i32.add
     (get_local $3)
     (get_local $2)
    )
    (i32.const 16)
   )
   (get_local $1)
  )
  (set_local $3
   (i32.add
    (get_local $3)
    (tee_local $5
     (i32.add
      (i32.and
       (get_local $3)
       (i32.const 4)
      )
      (i32.const 24)
     )
    )
   )
  )
  (set_local $2
   (i32.sub
    (get_local $2)
    (get_local $5)
   )
  )
  (set_local $4
   (i64.or
    (i64.extend_u/i32
     (get_local $1)
    )
    (i64.shl
     (i64.extend_u/i32
      (get_local $1)
     )
     (i64.const 32)
    )
   )
  )
  (loop $continue|0
   (if
    (i32.ge_u
     (get_local $2)
     (i32.const 32)
    )
    (block
     (i64.store
      (get_local $3)
      (get_local $4)
     )
     (i64.store
      (i32.add
       (get_local $3)
       (i32.const 8)
      )
      (get_local $4)
     )
     (i64.store
      (i32.add
       (get_local $3)
       (i32.const 16)
      )
      (get_local $4)
     )
     (i64.store
      (i32.add
       (get_local $3)
       (i32.const 24)
      )
      (get_local $4)
     )
     (set_local $2
      (i32.sub
       (get_local $2)
       (i32.const 32)
      )
     )
     (set_local $3
      (i32.add
       (get_local $3)
       (i32.const 32)
      )
     )
     (br $continue|0)
    )
   )
  )
  (get_local $0)
 )
 (func $std:array/Array#shift (; 9 ;) (type $ii) (param $0 i32) (result i32)
  (local $1 i32)
  (if
   (i32.and
    (if (result i32)
     (tee_local $1
      (i32.lt_s
       (i32.load offset=8
        (get_local $0)
       )
       (i32.const 1)
      )
     )
     (get_local $1)
     (i32.gt_u
      (i32.load offset=8
       (get_local $0)
      )
      (i32.load offset=4
       (get_local $0)
      )
     )
    )
    (i32.const 1)
   )
   (unreachable)
  )
  (set_local $1
   (i32.load
    (i32.load
     (get_local $0)
    )
   )
  )
  (drop
   (call $std:heap/Heap.copy
    (i32.load
     (get_local $0)
    )
    (i32.add
     (i32.load
      (get_local $0)
     )
     (i32.const 4)
    )
    (i32.mul
     (i32.sub
      (i32.load offset=4
       (get_local $0)
      )
      (i32.const 1)
     )
     (i32.const 4)
    )
   )
  )
  (drop
   (call $std:heap/Heap.fill
    (i32.add
     (i32.load
      (get_local $0)
     )
     (i32.mul
      (i32.sub
       (i32.load offset=4
        (get_local $0)
       )
       (i32.const 1)
      )
      (i32.const 4)
     )
    )
    (i32.const 0)
    (i32.const 4)
   )
  )
  (i32.store offset=8
   (get_local $0)
   (i32.sub
    (i32.load offset=8
     (get_local $0)
    )
    (i32.const 1)
   )
  )
  (get_local $1)
 )
 (func $start (; 10 ;) (type $v)
  (set_global $std:heap/HEAP_OFFSET
   (get_global $HEAP_BASE)
  )
  (set_global $std/array/arr
   (call $std:heap/Heap.allocate
    (i32.const 12)
   )
  )
  (if
   (i32.load offset=8
    (get_global $std/array/arr)
   )
   (unreachable)
  )
  (if
   (i32.load offset=4
    (get_global $std/array/arr)
   )
   (unreachable)
  )
  (drop
   (call $std:array/Array#push
    (get_global $std/array/arr)
    (i32.const 42)
   )
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 0)
    )
    (i32.const 42)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (i32.load offset=8
     (get_global $std/array/arr)
    )
    (i32.const 1)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (i32.load offset=4
     (get_global $std/array/arr)
    )
    (i32.const 1)
   )
   (unreachable)
  )
  (set_global $std/array/i
   (call $std:array/Array#pop
    (get_global $std/array/arr)
   )
  )
  (if
   (i32.ne
    (get_global $std/array/i)
    (i32.const 42)
   )
   (unreachable)
  )
  (if
   (i32.load offset=8
    (get_global $std/array/arr)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (i32.load offset=4
     (get_global $std/array/arr)
    )
    (i32.const 1)
   )
   (unreachable)
  )
  (drop
   (call $std:array/Array#push
    (get_global $std/array/arr)
    (i32.const 43)
   )
  )
  (if
   (i32.ne
    (i32.load offset=8
     (get_global $std/array/arr)
    )
    (i32.const 1)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (i32.load offset=4
     (get_global $std/array/arr)
    )
    (i32.const 1)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 0)
    )
    (i32.const 43)
   )
   (unreachable)
  )
  (drop
   (call $std:array/Array#push
    (get_global $std/array/arr)
    (i32.const 44)
   )
  )
  (if
   (i32.ne
    (i32.load offset=8
     (get_global $std/array/arr)
    )
    (i32.const 2)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (i32.load offset=4
     (get_global $std/array/arr)
    )
    (i32.const 2)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 0)
    )
    (i32.const 43)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 1)
    )
    (i32.const 44)
   )
   (unreachable)
  )
  (drop
   (call $std:array/Array#push
    (get_global $std/array/arr)
    (i32.const 45)
   )
  )
  (if
   (i32.ne
    (i32.load offset=8
     (get_global $std/array/arr)
    )
    (i32.const 3)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (i32.load offset=4
     (get_global $std/array/arr)
    )
    (i32.const 4)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 0)
    )
    (i32.const 43)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 1)
    )
    (i32.const 44)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 2)
    )
    (i32.const 45)
   )
   (unreachable)
  )
  (drop
   (call $std:array/Array#unshift
    (get_global $std/array/arr)
    (i32.const 42)
   )
  )
  (if
   (i32.ne
    (i32.load offset=8
     (get_global $std/array/arr)
    )
    (i32.const 4)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (i32.load offset=4
     (get_global $std/array/arr)
    )
    (i32.const 4)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 0)
    )
    (i32.const 42)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 1)
    )
    (i32.const 43)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 2)
    )
    (i32.const 44)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 3)
    )
    (i32.const 45)
   )
   (unreachable)
  )
  (drop
   (call $std:array/Array#unshift
    (get_global $std/array/arr)
    (i32.const 41)
   )
  )
  (if
   (i32.ne
    (i32.load offset=8
     (get_global $std/array/arr)
    )
    (i32.const 5)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (i32.load offset=4
     (get_global $std/array/arr)
    )
    (i32.const 8)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 0)
    )
    (i32.const 41)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 1)
    )
    (i32.const 42)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 2)
    )
    (i32.const 43)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 3)
    )
    (i32.const 44)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 4)
    )
    (i32.const 45)
   )
   (unreachable)
  )
  (set_global $std/array/i
   (call $std:array/Array#shift
    (get_global $std/array/arr)
   )
  )
  (if
   (i32.ne
    (get_global $std/array/i)
    (i32.const 41)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (i32.load offset=8
     (get_global $std/array/arr)
    )
    (i32.const 4)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (i32.load offset=4
     (get_global $std/array/arr)
    )
    (i32.const 8)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 0)
    )
    (i32.const 42)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 1)
    )
    (i32.const 43)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 2)
    )
    (i32.const 44)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 3)
    )
    (i32.const 45)
   )
   (unreachable)
  )
  (set_global $std/array/i
   (call $std:array/Array#pop
    (get_global $std/array/arr)
   )
  )
  (if
   (i32.ne
    (get_global $std/array/i)
    (i32.const 45)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (i32.load offset=8
     (get_global $std/array/arr)
    )
    (i32.const 3)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (i32.load offset=4
     (get_global $std/array/arr)
    )
    (i32.const 8)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 0)
    )
    (i32.const 42)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 1)
    )
    (i32.const 43)
   )
   (unreachable)
  )
  (if
   (i32.ne
    (call $std:array/Array#__get
     (get_global $std/array/arr)
     (i32.const 2)
    )
    (i32.const 44)
   )
   (unreachable)
  )
 )
)
