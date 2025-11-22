; Schmid Maximilian, Axel Soler García
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
  n: dd 40


section .text    ;code segment starts here

global main

main:
      push ebp
      push esp

      mov ebx, 0 ;Counter
      push 0     ;var1 im Stack
      mov edx, 1 ;var2
      push edx   ;var 2 -> Stack


next:
      
      push edx
      push decformat
      call printf  
      add esp, 8
      
      pop edx
      pop eax

      push edx
      add edx, eax
      push edx 
      

      inc ebx
      cmp ebx, [n] 
      jne next

      add esp, 8
      pop esp
      pop ebp  
   ret
