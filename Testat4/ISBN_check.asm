;Programm von Max Schmidt und Axel Soler García
;Dieses Programm checkt durch ISBNcheck, ob das übergegebene ISBN ein gültiges Format ist
;EAX = 1, falls es nicht stimmt
global ISBNcheck

extern printf
extern atoi

section .data
	decformat: db `%d \n`,0
        Fehler: db `Ein Fehler ist aufgetreten!\n`,0
section .text

        
ISBNcheck:
        ;z.B.: 978-3-455-01430\0
        ;erste 3 Zahlen werden gecheckt
        
        mov edx, [esp+4]
        call checkdigit
	add edx, 1
	call checkdigit
	add edx, 1
	call checkdigit

        ;erstes- wird geckeckt
        add edx, 1
        mov ecx, '-'
        call checkchar

        ;aleinige Zahl wird gecheckt
        add edx, 1
        call checkdigit

        ;zweites - wird geckeckt
        add edx, 1
        mov ecx, '-'
        call checkchar

        ;dritte Zahlenreihe wird gecheckt
	add edx, 1
	call checkdigit
	add edx, 1
	call checkdigit
	add edx, 1
	call checkdigit

        ;letztes - wird gecheckt
        add edx, 1
        mov ecx, '-'
        call checkchar

        ;letzte -Zahlenreihe wird geckeckt
	add edx, 1
	call checkdigit
	add edx, 1
	call checkdigit
	add edx, 1
	call checkdigit
	add edx, 1
	call checkdigit
	add edx, 1
	call checkdigit
        
        ;'\0' wird geckeckt
        add edx, 1
        mov ecx, 0
        call checkchar

        sub edx, 15

	ret




checkchar:
	; compares the value of ecx and the value of [edx], and returns eax=0 if they are the same
	; it does not change edx not ecx
	push eax
        mov eax, 0
        mov al, [edx]
	; only first char is kept
	cmp al, cl
        jz charret
	jmp charerror
charerror:
	pop eax
        mov eax, 1
	ret

charret:
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
