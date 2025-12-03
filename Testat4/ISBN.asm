;Programm von Max Schmidt und Axel Soler García

extern ISBNcheck
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

        ;Wegen irgend einen Grund ist das zweite Argument hinter 2 Pointer versteckt. Ich hasse Assembly
	mov edx, [ebp+12]
        mov edx, [edx+4]
        push edx 
        call ISBNcheck
        add esp, 4 
        cmp eax, 1
        jz error
        jmp validation
        

validation:
	; Das ist dein Teil
        ; Der ISBN ist in [edx] gespeichert
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


