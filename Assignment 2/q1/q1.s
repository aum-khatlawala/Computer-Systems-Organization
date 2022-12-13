.global nearest_tallest_person_to_the_right

nearest_tallest_person_to_the_right:
    mov $0, %r8                                 # iterator
    cmp $1, %rdi                                # if there is only one number entered, return answer as -1
    je .end1
                                                # dynamic stack allocation
    push %rbp                                   # save %rbp by pushing %rbp to program stack
    mov %rsp, %rbp                              # we write these two lines as %rbp is a callee saved register
                                                # save the base of the stack frame into the base pointer register
    jmp .loop

.end1:
    mov $-1, %r13
    mov %r13, (%rdx)
    ret

.loop:
    cmp %r8, %rdi                               # if the number <= iterator, exit from the loop and return answer
    jle .end
    jmp .innerloopcondition

.innerloopcondition:
    cmp %rbp, %rsp                              # if stack is not empty, check condition 2 to enter while loop
    jne .checkcondition2
    jmp .updateiter                             # if stack is empty, update iteration value and push current index to stack

.innerloop:
    mov (%rsp), %r9                             # s.top()
    mov (%rsi, %r8, 8), %r10                    # input[i]
    mov %r10, (%rdx, %r9, 8)                    # move input[i] to result[s.top()]
    pop %r12                                    # pop value from stack to destination %r12 (doesn't really matter what the destination is)
    jmp .innerloopcondition

.checkcondition2:
    mov (%rsp), %r9                             # s.top()
    mov (%rsi, %r8, 8), %r10                    # input[i]
    cmp (%rsi, %r9, 8), %r10
    jle .updateiter                             # if input[i] <= input[s.top()], update iteration value and push current index to stack
    jmp .innerloop                              # else, jump to inner while loop

.updateiter:
    push %r8                                    # push index / current iteration value to stack
    inc %r8                                     # increment value of iterator and jump to loop
    jmp .loop

.end:
    mov %rbp, %rsp                              # deallocating the dynamically allocated stack
    pop %rbp
    ret
