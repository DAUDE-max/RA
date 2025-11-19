extern printf;

section .data
  decformat: db `%d \n`,0
  n: dd
  m: dd 

section .text

global main
mov [n], ebp
mov [m], esp

main:
  ; Check if 1 arg
  add esp, 4
  pop ebx
  cmp ebx, 1
  jne ende

  ; Check arg > 0
  add esp, 8
  pop ebx
  cmp ebx, 0
  jna ende

  ; Jetzt arbeiten mit arg
arbeite:
  push ebx
  DIV ebx, 2
  cmp edx, 0
  je gerade
  jne ungerade

gerade:
  ;fall gerade
  pop ebx
  div ebx, 2
  push ebx
  jmp print

ungerade:
  ;fall unegarde
  pop ebx
  mul ebx, 3
  add ebx, 1
  push ebx
  jmp print

print:
  ;abbruch und print
  push decformat
  push printf
  add esp, 12
  cmp ebx, 1
  je ende
  jne arbeit

  mov ebp, [n]
  mov esp, [m]
ret


  
  
