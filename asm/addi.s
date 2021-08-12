    .text
    .globl    main
main:
    addi  x1, x1, 5
    addi  x2, x1, 1
    sub   x3, x2, x1
    lui   x4, 10
    sd    x4, 0(x4)
    ld    x5, 0(x4)

