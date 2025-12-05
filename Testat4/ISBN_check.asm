;Programm von Max Schmidt und Axel Soler García
;Dieses Programm checkt durch ISBNcheck, ob das übergegebene ISBN ein gültiges Format ist
;EAX = 1, falls es nicht stimmt
global ISBNcheck

extern printf
extern atoi

section .data
	decformat: db `Die Pruefziffer ist %1d \n`,0
        Fehler: db `Ein Fehler ist beim checken aufgetreten!\n`,0
        digitcounter: dd 0
        bindecounter: dd 0
        totalcounter: dd 0
section .text

        
ISBNcheck:
        ;z.B.: 978-3-455-01430\0
        ;erste 3 Zahlen werden gecheckt
       
        push esi; Insgessammte Zahl
        push edi
        mov edx, [esp+4]
       
        mov [totalcounter], dword 0
        mov [digitcounter], dword 0
        mov [bindecounter], dword 0
        mov esi, 0

loop:
        cmp [totalcounter], dword 15
        jz endloop

        add [totalcounter], dword 1
        call checkdigit
        cmp eax, 0
        jnz loopcheckchar 
        add [digitcounter], dword 1
        call sumdigit
        mov eax, 0
        jmp loop
loopcheckchar:
        mov ecx, '-'
        call checkchar
        cmp eax, 0
        jnz ERROR
        add [bindecounter], dword 1
        jmp loop

endloop:
        cmp [digitcounter], dword 12
        jnz ERROR
        cmp [bindecounter], dword 3
        jnz ERROR



        ;'\0' wird geckeckt
        add edx, 1
        mov ecx, 0
        call checkchar
        cmp eax, 0
        jnz ERROR
        mov eax, esi
        ecq 
        mov edi, 10
              ;dividiert eax durch angegebene
        
        idiv edi; resultat in edx
        mov eax, 10
        sub eax, edx
        push eax
        push decformat
        call printf
        add esp, 8
        
        pop edi
        pop esi
	ret

sumdigit:
        mov eax, [digitcounter]
        shr eax, 1
        jc mul1
        jmp mul2
mul1:
        sal eax, 1
        add eax, 2
        add esi, edi
        ret
mul2:
        sal eax, 1
        inc eax
        imul edi, 3
        add esi, edi
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
            ; return edi as digit
        push eax
        mov eax, 1
        mov al, [edx]
	; only first char is kept
	sub al, '0' ;  transforms into number
        mov edi, eax
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



ERROR:
      push Fehler
      call printf
      add esp, 4
      pop edi
      pop esi
      ret

