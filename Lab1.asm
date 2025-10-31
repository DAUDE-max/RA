;
;---------------------------------------------------------------
; Lab1.asm
; 
;
; Author: NSFR
;
; ---------------------------------------------------------------

; declaration of functions that are not defined in the module being assembled, i.e. this file

extern printf; Using the  c function for output - the object file needs to be linked with a C library

section .data ; defines which section of the output file the code will be assembled into
              ; here: initialised data
              ; segment can be used instead (exactly equivalent synonym)

  decformat: db `%d \n`,0 ; we define the decimal format for use with C's printf function
  hexformat: db `%x\n`,0    ; and the hex format
  v1: dd 17, 11, 4 
  v2: dd 4, -9, 8
  lenght: dd 3

section .text    ;code segment starts here

global main

main:

      push ebp
      mov ebp, esp
      mov ecx, 0
      mov edx, 0
next: mov eax, [v1+4*ecx]
      mov ebx, [v2+4*ecx]
      imul eax,ebx
      add edx, eax
      inc ecx
      cmp ecx, [lenght]
      jne next
      push edx
      push hexformat
      call printf
      add esp, 8
      mov eax,0      ; returning 0 by convention
      mov esp, ebp   ; clean up after ourselves 
      pop ebp        ; leave could be used alternatively for the last two commands
   ret
