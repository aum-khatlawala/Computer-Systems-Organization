.global quotient

quotient:
    mov $0, %r10                                # sign flag (if M and N are both positive or if M and N are both negative, sign flag will have 0 (+), else 1 (-))
    mov $-9223372036854775808, %r11             # special case: long long int min is given as input numerator 
    cmp %r11, %rdi                              # if long long int min is input numerator, handle that case
    je .llmincase_num
    cmp %r11, %rsi                              # special case: long long int min is given as input denominator
    je .llmincase_den                           # if long long int min is input denominator, handle that case
    cmp $0, %rdi                                # special case: if 0 is numerator, quotient is zero
    je .zero
    cmp $0, %rsi                                # special case: if 0 is denominator, quotient is undefined (infinity) and thus, we output -1
    je .err
    cmp $0, %rdi                                # if numerator is negative, deal with that case
    jl .negative_numerator
    cmp $0, %rsi                                # if denominator is negative, deal with that case
    jl .negative_denominator
    mov %rdi, %r8                               # move the input numerator to %r8 register to create a copy that is used during computation
    mov $0, %rax                                # not required but better to initialise the return value to 0
    jmp .computation                            # jump to computation of the answer
    ret

.llmincase_num:
    mov $-1, %rdi                               # overflow case: -9223372036854775808 % 9223372036854775807 = -1
    jmp quotient

.llmincase_den:
    mov $-1, %rsi                               # overflow case: -9223372036854775808 % 9223372036854775807 = -1
    jmp quotient

.zero:
    mov $0, %rax                                # return 0 as the quotient
    ret

.err:
    mov $-1, %rax                               # return -1 as the answer as the denominator is 0 (quotient is undefined (infinity))
    ret

.negative_numerator:
    cmp $0, %rsi                                # check if denominator is less than 0 and if so, deal with that case by jumping
    jl .negative_numerator_and_denominator
    inc %r10                                    # if not, make value of sign flag 1 (-)
    neg %rdi                                    # take absolute value of numerator
    mov %rdi, %r8                               # move the input numerator to %r8 register to create a copy that is used during computation
    mov $0, %rax                                # not required but better to initialise the return value to 0
    jmp .computation                            # jump to computation of the answer
    ret

.negative_denominator:                          # only the case where numerator is + and denominator is - is left when we reach this statement
    inc %r10                                    # we make the value of sign flag 1 (-)
    neg %rsi                                    # take absolute value of denominator
    mov %rdi, %r8                               # explained twice before
    mov $0, %rax
    jmp .computation
    ret

.negative_numerator_and_denominator:
    neg %rdi                                    # since both numerator and denominator are negative, the quotient will be positive so we don't make sign flag value 1 (-)
    neg %rsi                                    # everything else in this is similar to the previous cases
    mov %rdi, %r8
    mov $0, %rax
    jmp .computation
    ret

.computation:                                   # our numerator is stored in %r8 (the value in this is modified as the computation happens) and %rdi (original value of numerator)
    cmp %r8, %rsi                               # if the value in %rsi (denominator) is greater than the value in %r8 , break and output the answer
    jg .break
    sub %rsi, %r8                               # if not, then subtract the denominator from the current value in %r8
    inc %rax                                    # increase the value to be outputted by 1
    jmp .computation                            # loop till we can break

                                                # example dry run of the computation: Input: M = 8 and N = 3
                                                # first iteration: 8 => 8 - 3 and increase value of output by 1
                                                # second iteration: 5 => 5 - 3 and increase the value of output by 1
                                                # third iteration: since 2 is less than 3, break to return answer

.break:
    cmp $1, %r10                                # if sign flag is 1, negate the answer (in signhandler) received as we are either dividing a positive by a negative or the opposite
    je .signhandler
    ret                                         # return final answer (value in %rax)

.signhandler:
    neg %rax
    ret

.global rem

rem:
    mov $0, %r10                                # sign flag (if M and N are both positive or if M is positive and N is negative, sign flag will have 0 (+), else 1 (-))
    mov $-9223372036854775808, %r11
    cmp %r11, %rdi
    je .llmincase_num_2
    cmp %r11, %rsi
    je .llmincase_den_2
    cmp $0, %rdi
    je .zero_2
    cmp $0, %rsi
    je .err_2
    cmp $0, %rdi
    jl .negative_numerator2
    cmp $0, %rsi
    jl .negative_denominator2
    mov %rdi, %r8
    mov $0, %rax
    jmp .computation2
    ret

.llmincase_num_2:
    mov $-1, %rdi
    jmp rem

.llmincase_den_2:
    mov $-1, %rsi
    jmp rem

.zero_2:
    mov $0, %rax
    ret

.err_2:
    mov $-1, %rax
    ret

.negative_numerator2:
    cmp $0, %rsi
    jl .negative_numerator_and_denominator2
    inc %r10
    neg %rdi
    mov %rdi, %r8
    mov $0, %rax
    jmp .computation2
    ret

.negative_denominator2:
    neg %rsi
    mov %rdi, %r8
    mov $0, %rax
    jmp .computation2
    ret

.negative_numerator_and_denominator2:
    inc %r10
    neg %rdi
    neg %rsi
    mov %rdi, %r8
    mov $0, %rax
    jmp .computation2
    ret

.computation2:
    cmp %r8, %rsi
    jg .break2
    sub %rsi, %r8
    jmp .computation2

.break2:
    mov %r8, %rax                               # similar code to the quotient function but instead of returning the quotient, we output the value left in %r8 after the last iteration as that is the remainder
    cmp $1, %r10
    je .signhandler2
    ret

.signhandler2:
    neg %rax
    ret
