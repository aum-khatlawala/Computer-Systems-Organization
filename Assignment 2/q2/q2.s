.global rec_count

rec_count:
    push %r12                                   # pushing registers to stack
    mov %rsi, %r8                               # move difference to register r8 (as we will be dealing with absolute values)
    mov $0, %r12                                # initialise final return value to 0
    jmp .precomp

.precomp:
    cmp $0, %r8                                 # if diff is negative, take mod and then evaluate condition
    jl .absval

.conditionchecker:
    cmp %r8, %rdi                               # if n < abs(diff)
    jl .end1
    mov $1, %r9
    cmp %rdi, %r9                               # else, if n == 1, check if diff == 0 or abs(diff) == 1
    je .end2

.calc:
    dec %rdi                                    # decrease n by 1
    inc %rsi                                    # increase diff by 1
    push %rdi
    push %rsi
    call rec_count                              # rec_count(n-1, diff+1)
    pop %rsi
    pop %rdi
    add %rax, %r12                              # final return value += output of the recursive call (rec_count(n-1, diff+1))



    dec %rsi                                    # decrease diff by 1 after we have increased it by 1 for the next recursive call
    push %rdi
    push %rsi
    call rec_count                              # rec_count(n-1, diff)
    pop %rsi
    pop %rdi
    add %rax, %rax
    add %rax, %r12                              # final return value += 2 * output of the recursive call (rec_count(n-1, diff))



    dec %rsi                                    # decrease diff by 1 after we have increased it and decreased it by 1
    push %rdi
    push %rsi
    call rec_count                              # rec_count(n-1, diff-1)
    pop %rsi
    pop %rdi
    add %rax, %r12                              # final return value += output of the recursive call (rec_count(n-1, diff-1))


    mov %r12, %rax
    # mov $13, %r12                               # taking mod of the answer with 13 and then returning answer
    # cqto
    # idivq %r12
    # mov %rdx, %rax
    
    pop %r12
    ret

.absval:
    neg %r8
    jmp .conditionchecker

.end1:
    mov $0, %rax
    pop %r12
    ret

.end2:
    cmp $0, %r8                                 # if diff == 0, return 2
    je .end3
    cmp $1, %r8                                 # if abs(diff) == 1, return 1
    je .end4
    jmp .calc

.end3:
    mov $2, %rax
    pop %r12
    ret

.end4:
    mov $1, %rax
    pop %r12
    ret
