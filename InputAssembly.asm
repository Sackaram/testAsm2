global _start  ; Declare _start as global so that it's accessible from outside this file.

section .data  ; This section is for initialized data.
    prompt db 'Enter your name: ', 0  ; Store a null-terminated prompt string in memory.
    prompt_len equ $ - prompt  ; Calculate the length of the prompt string.

    hello db 'Hello, '  ; Store a null-terminated string 'Hello, ' in memory.
    hello_len equ $ - hello  ; Calculate the length of the 'Hello, ' string.

    name db 128 dup(0)  ; Reserve space for the name input, initialize all to null.

section .bss  ; This section is for uninitialized data.
    name_len resb 128  ; Reserve space for storing the length of the input name.

section .text  ; This section is for the code.
_start:  ; Start of the main program.
    ; Write the prompt to stdout.
    mov eax, 4  ; The system call number for sys_write is 4.
    mov ebx, 1  ; The file descriptor for stdout is 1.
    mov ecx, prompt  ; The pointer to the data to write.
    mov edx, prompt_len  ; The length of the data to write.
    int 0x80  ; Execute the system call.

    ; Read the input name from stdin.
    mov eax, 3  ; The system call number for sys_read is 3.
    mov ebx, 0  ; The file descriptor for stdin is 0.
    mov ecx, name  ; The buffer to store the read data.
    mov edx, 128  ; The maximum number of bytes to read.
    int 0x80  ; Execute the system call.

    mov [name_len], eax  ; Store the number of bytes read, i.e., the length of the input name.

    ; Write the 'Hello, ' string to stdout.
    mov eax, 4  ; The system call number for sys_write is 4.
    mov ebx, 1  ; The file descriptor for stdout is 1.
    mov ecx, hello  ; The pointer to the data to write.
    mov edx, hello_len  ; The length of the data to write.
    int 0x80  ; Execute the system call.

    ; Write the input name to stdout.
    mov eax, 4  ; The system call number for sys_write is 4.
    mov ebx, 1  ; The file descriptor for stdout is 1.
    mov ecx, name  ; The pointer to the data to write.
    mov edx, [name_len]  ; The length of the data to write.
    int 0x80  ; Execute the system call.

    ; Exit the program.
    mov eax, 1  ; The system call number for sys_exit is 1.
    xor ebx, ebx  ; The status to return to the parent process, 0 means normal termination.
    int 0x80  ; Execute the system call.
