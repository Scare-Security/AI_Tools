; filename: vulnerable.s | Written by an AI called OpenAI

.section .data

buf:     .space  100         ; define a 100-byte buffer

.section .text

.globl _start

_start:
    movl    $buf, %esi       ; move the address of buf into %esi
    movl    $0, %edi         ; move 0 into %edi (to clear the buffer)
    movl    $100, %ecx       ; move the size of the buffer into %ecx
    rep     stosl            ; clear the buffer with zeros
    movl    $4, %eax         ; move 4 into %eax (to use the read syscall)
    movl    $0, %ebx         ; move 0 into %ebx (to read from stdin)
    movl    $buf, %ecx       ; move the address of buf into %ecx
    movl    $100, %edx       ; move the size of the buffer into %edx
    int     $0x80            ; call the read syscall
    movl    $1, %eax         ; move 1 into %eax (to use the write syscall)
    movl    $1, %ebx         ; move 1 into %ebx (to write to stdout)
    movl    $buf, %ecx       ; move the address of buf into %ecx
    movl    $100, %edx       ; move the size of the buffer into %edx
    int     $0x80            ; call the write syscall
    movl    $1, %eax         ; move 1 into %eax (to use the exit syscall)
    xorl    %ebx, %ebx       ; clear %ebx
    int     $0x80            ; call the exit syscall 
    
