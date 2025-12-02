;Programm von Max Schmidt und Axel Soler García

extern printf
extern atoi

section .data
	decformat: db `%d \n`,0
        Fehler: db `Ein Fehler ist aufgetreten!\n`,0
section .text

global main
main:
	push ebp
	mov ebp, esp

; Check if 1 arg
	mov eax, [ebp+8]
	cmp eax, 2
	jne error
        mov eax, 0

	mov edx, ebp
        add edx, 16
	;ISBN saved at [ebx+4]	
        call checkdigit
	add edx, 1
	call checkdigit
	add edx, 1
	call checkdigit

	cmp eax, 1
	jz error
	jmp validation




checkchar:
	; compares the value of ecx and the value of [edx], and returns eax=0 if they are the same
	; it does not change edx not ecx
	push eax
	mov eax, [edx]
	; only first char is kept
	sal eax, 24
	shr eax, 24
	cmp eax, ecx
	js checkret
checkerror:
	mov eax, 1
	ret

checkret:
	pop eax
	ret

checkdigit:
	; compares the value of [edx] and sees if it is a digit, and returns eax=0 if they are the same
	; it does not change edx not ecx
	push eax
        mov eax, 0
        mov al, [edx]
	; only first char is kept
	sub al, '0' ;  transforms into number
	cmp al, 9
        ja digiterror
	jmp digitret
digiterror:
        pop eax
        mov eax, 1
	ret
digitret:
	pop eax
        ret

validation:
	; Das ist dein Tel
	jmp ende

error:
	push Fehler
	call printf
	add esp, 4
	jmp ende



ende:
	mov esp, ebp
	pop ebp
ret


