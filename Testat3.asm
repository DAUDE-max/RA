extern printf
extern atoi

section .data
  decformat: db `%d \n`,0

section .text

global main
main:
  push ebp
  mov ebp, esp

; Check if 1 arg
  mov eax, [ebp+8]
  cmp eax, 2
  jne ende

  ; Check arg > 0
  mov ebx, [ebp +12]
  push dword[ebx+4]
  call atoi
  add esp, 4
  mov ebx, eax
  cmp ebx, 0
  jna ende
  jmp arbeit

  arbeit:
  push ebx
  push decformat
  call printf
  add esp, 4

  pop ebx
  cmp ebx, 1
  je ende

  mov eax, ebx
  cdq
  mov ecx, 2
  idiv ecx
  cmp edx, 0
  je gerade
  jmp ungerade

gerade:
  ;fall gerade
  mov ebx, eax
  jmp arbeit

ungerade:
  ;fall unegarde
  mov eax, ebx
  mov ecx, 3
  imul eax, ecx
  add eax, 1
  mov ebx, eax
  jmp arbeit

ende:
  add esp, 4
  mov esp, ebp
  pop ebp
ret


