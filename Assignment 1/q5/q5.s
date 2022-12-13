.global sq_1_to_n_then_sum

sq_1_to_n_then_sum:
    mov $1, %r8                                 # iterator starting from 1
    cmp $1, %rdi                                # if the input is less than 1, output -1
    jl .end2
    cmp $1, %rdi                                # if input is 1, output 1
    je .end
    mov $1, %rax                                # in any other case, move 1 to the output value (first iteration is done)
    jmp .comp                                   # jump to computation

.end:
    mov $1, %rax
    ret

.end2:
    mov $-1, %rax
    ret

.comp:
    cmp %r8, %rdi                               # if iterator reaches the number inputted, return value in %rax
    je .end3
    inc %r8                                     # increase value of iterator before doing the computation for one iteration of the loop (because first iteration has been done)
    mov %r8, %r9                                # make a copy of the iterator and store it in %r9
    imul %r9, %r9                               # square the current value of the iterator and store in %r9
    add %r9, %rax                               # add the squared value to the output value
    jmp .comp                                   # loop
    ret

.end3:
    ret
