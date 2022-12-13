.global gcd

gcd:
    mov $-9223372036854775808, %r12             # special case: long long int min is given as input numerator 
    cmp %r12, %rdi                              # if long long int min is the first argument of the input, handle that case
    je .llmincase_m
    cmp %r12, %rsi                              # special case: long long int min is given as input denominator
    je .llmincase_n                             # if long long int min is the second argument of the input, handle that case
    cmp $0, %rdi                                # if one of the numbers is 0, the gcd is the other number as the other number divides that number and 0
    je .zerocase1
    cmp $0, %rsi
    je .zerocase2
    cmp $0, %rdi                                # if either of the numbers is negative, then we take absolute value of it as gcd(x, y) = gcd(-x, y) = gcd(x, -y) = gcd(-x, -y)
    jl .take_abs1
    cmp $0, %rsi
    jl .take_abs2
    mov %rdi, %r8                               # move the argument M to %r8
    mov %rsi, %r9                               # move the argument N to %r9
    jmp .computation
    ret

.llmincase_m:
    mov $-1, %rdi                               # overflow case: -9223372036854775808 % 9223372036854775807 = -1
    jmp gcd

.llmincase_n:
    mov $-1, %rsi                               # overflow case: -9223372036854775808 % 9223372036854775807 = -1
    jmp gcd

.zerocase1:
    mov %rsi, %rax
    ret

.zerocase2:
    mov %rdi, %rax
    ret

.take_abs1:
    neg %rdi
    cmp $0, %rsi
    jl .take_abs2
    mov %rdi, %r8
    mov %rsi, %r9
    jmp .computation

.take_abs2:
    neg %rsi
    mov %rdi, %r8
    mov %rsi, %r9
    jmp .computation

.computation:                                   # using euclid's algorithm to find gcd
    mov %r8, %rax                               # dividing M by N
    cqto
    idivq %r9
    mov %rdx, %r11                              # move the remainder after division to %r11 register (R = M % N)
    mov %r9, %r8                                # move N to M (M = N)
    mov %r11, %r9                               # move the remainder to N (N = R)
    cmp $0, %r9                                 # if N is 0, break and output the answer
    je .break
    jmp .computation                            # loop till we arrive at the condition
    ret

.break:
    mov %r8, %rax                               # current value of %r8 register is the output
    ret
