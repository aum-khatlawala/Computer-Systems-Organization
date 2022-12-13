.global isprime

isprime:
    cmp $1, %rdi                                # if input is less than or equal to 1, it is an exception
    jle .exception
    mov $2, %r8                                 # iterator in the loop starts from 2 and ends at the number inputted
    cmp %r8, %rdi                               # if input is 2, we output TRUE
    je .end
    jmp .computation                            # jump to the computation
    ret

.exception:
    mov $0, %rax                                # FALSE
    ret

.computation:
    cmp %rdi, %r8                               # if iterator reaches a point where it is equal to the number inputted, we break and output TRUE because this shows the number inputted is prime
    jge .end
    mov %rdi, %rax                              # performing division using idivq
    cqto
    idivq %r8                                   # upon performing this action, %rdx stores the remainder
    cmp $0, %rdx                                # if a number smaller than the number inputted divides the number while giving 0 as remainder, it is not prime and thus, we output FALSE
    je .break
    inc %r8                                     # increase the value of iterator by 1
    jmp .computation                            # loop
    ret

.end:
    mov $1, %rax                                # TRUE
    ret

.break:
    mov $0, %rax                                # FALSE
    ret
