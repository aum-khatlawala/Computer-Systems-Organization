.global largest_prime_factor

largest_prime_factor:
    mov $-9223372036854775808, %r11
    cmp %r11, %rdi
    je .llmincase
    cmp $0, %rdi                                # if input is negative, take absolute value
    jl .abs_val
    cmp $1, %rdi                                # if absolute value is 1 or 0, exit and output -1
    jle .exit
    mov $2, %r8                                 # iterator starts at 2
    jmp .computation                            # jump to computation of the answer
    ret

.llmincase:
    mov $-1, %rdi
    jmp largest_prime_factor

.abs_val:
    neg %rdi
    cmp $1, %rdi                                # explained before
    jle .exit
    mov $2, %r8
    jmp .computation
    ret

.exit:
    mov $-1, %rax
    ret

.computation:
    mov %rdi, %rax                              # checking if the current value in %rdi is divisible by the iterator
    cqto
    idivq %r8                                   # upon performing this action, %rdx stores the remainder
    cmp $0, %rdx                                # if remainder is 0, jump to factor branch
    je .factor
    inc %r8                                     # if the iterator is not a factor of the current value in %rdi, increase the iterator by 1
    jmp .computation                            # loop
    ret

.factor:
    mov %rdi, %r9                               # moving the current value in %rdi to %r9 so that if new value in %rdi after division = 1, we break and %r9 stores the output
    mov %rdi, %rax                              # dividing the current value in %rdi by the factor
    cqto
    idivq %r8                                   # upon performing this action, %rax stores the quotient
    mov %rax, %rdi                              # new value in %rdi = previous value in %rdi / current iterator value if it is a factor of the previous value in %rdi
    cmp $1, %rdi                                # if new value in %rdi = 1, we break and %r9 contains the output
    je .break
    jmp .computation                            # loop
    ret

.break:
    mov %r9, %rax
    ret
