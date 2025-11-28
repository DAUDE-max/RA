;Programm von Max Schmidt und Axel Soler García

extern printf
extern atoi
extern rand

section .data
	decformat: db `%d \n`,0
        Fehler: db `Ein Fehler ist aufgetreten!\nDu darst nur eine Zahl grösser als 5 eingeben! \n`,0
        Space: db ` `,0
        Enter: db `\n`,0
        Top: db `^`,0
        LLeave: db `/`,0
        RLeave: db `\\`,0 
        Minus: db `-`,0
        Stomp1: db `| |`,0
        Stomp2: db `|_|`,0
        Ball: db `°`,0
        Frohe_Weihnacht: db `Frohe Weihnachten!!\n`,0

section .text

global main
main:
	push ebp
	mov ebp, esp

        ; Check if 1 arg
	mov eax, [ebp+8]
	cmp eax, 2
	jne error

	; Check arg > 0
	mov ebx, [ebp +12]
	push dword[ebx+4]
	call atoi
	add esp, 4
	mov ebx, eax
	cmp ebx, 5 
	jng error

        ;start mit den Weihnachtsbaum 
        sub eax, 2
        mov esi, eax
        call printspace
        ;print top
        push Top
        call printf
        push Enter
        call printf
        add esp, 8

        sub ebx, 3
        mov edi, 1
        call printleaves
        jmp ende

printleaves:
        ;uses EBX as amount of space on the left
        ;uses EDI as amount of space in the middle
        mov esi, ebx
        call printspace
        push LLeave
        call printf
        add esp, 4
        mov esi, edi
        call printballspace
        push RLeave
        call printf
        add esp, 4
        push Enter
        call printf
        add esp, 4
        
        add edi, 2
        dec ebx
        cmp ebx, 1
        jns printleaves
        jmp finishedleaves

printspace:
        ;uses esi for loop
        cmp esi,0
        jz ret

        push Space
        call printf
        add esp, 4
        
        dec esi
        jnz printspace
ret:    ret

printballspace:
        ;uses esi for loop
        cmp esi,0
        jz ret
        
        call rand
        and eax, 3
        cmp eax, 3
        jz ball
        
        push Space
        call printf
        add esp, 4
        jmp cont
ball:
        push Ball
        call printf
        add esp, 4
        
cont:
        dec esi
        jnz printballspace

printminus:
        ;uses esi for loop
        cmp esi,0
        jz ret

        push Minus
        call printf
        add esp, 4
        
        dec esi
        jnz printminus
        ret


finishedleaves:
        ;finished making leaves
        dec edi
        ; dividing edi by 2
        shr edi, 1
        dec edi

        push LLeave
        call printf
        add esp, 4

        mov esi, edi
        call printminus
        push Stomp1
        call printf
        add esp,4
        mov esi, edi
        call printminus

        push RLeave
        call printf
        add esp, 4

        push Enter
        call printf
        add esp,4
        
        inc edi
        mov esi, edi
        call printspace

        push Stomp2
        call printf
        push Enter
        call printf
        add esp, 8
        jmp Wunsch1

error:
        push Fehler
        call printf
	add esp, 4
        jmp ende
Wunsch1:
        push Enter
        call printf
        add esp,4
        sub edi,8
        js Wunsch2
        mov esi, edi
        call printspace


Wunsch2:
        push Frohe_Weihnacht
        call printf
        push Enter
        call printf
        add esp,8

ende:   mov esp, ebp
	pop ebp
ret


