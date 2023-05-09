


main:
    # prologue
    # reserve memory for buffer (1 byte)
    sub $8, %rsp #  (-8(%rbp), the last byte is at -1(%rbp))
    # open the file (argv[1])
    # check the file descriptor
    ; if it's negative, it's an error
    # use the file descriptor to read
    push $0 # lines at -16(%rbp)
    # read one byte passing -1(%rbp) as buffer
    # check the result (rax), stating how many bytes did read
    ; if it's zero, return 0
    ; if not, increase lines by 1, and write a do-while