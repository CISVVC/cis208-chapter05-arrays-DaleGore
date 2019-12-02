;
; file: asm_main.asm

%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
        syswrite: equ 4
        stdout: equ 1
        exit: equ 1
        SUCCESS: equ 0
        kernelcall: equ 80h


array1		dw	1,2,3,4,5	; array1 = [1,2,3,4,5]

; uninitialized data is put in the .bss segment
;
segment .bss

size		resw	1
scale		resw	1
ary_tmp		resw	1

;
; code is put in the .text segment
;
segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha
; *********** Start  Assignment Code *******************

	mov	eax, 0
	mov	ebx, 0
	mov	ecx, array1
start_loop:	

	mov	ax, [ecx + ebx] 
;	imul	eax, 5
	call	print_int
	call	print_nl
	add	ebx, 2
	cmp	ebx,10
	jl	start_loop


	mov	eax, 5
	push	eax
	mov	eax, 10
;	call	print_int		; test
;	call	print_nl		; test
	push	eax
	push	array1

	call	scale_int
	mov	ecx, array1
	add	esp, 12
	
	mov	ebx, 0			; clear ebx

print_loop:
	mov	ax, [ecx + ebx]	
	imul	ax, 5
	mov	[array1 + ebx] , ax

	call	print_int
	call	print_nl
	add	ebx, 2
	cmp	ebx, 10	
	jl	print_loop

	mov	ebx, 0			; clear ebx
test_loop:
	mov	ax, [array1 + ebx]
	call	print_int
	call	print_nl
	add	ebx, 2
	cmp	ebx, 10
	jl	test_loop
	



; *********** End Assignment Code **********************

        popa
        mov     eax, SUCCESS       ; return back to the C program
        leave                     
        ret

;scaler function
scale_int:
        push    ebp
        mov     ebp, esp

	mov	ebx, 0
	mov	eax, 0

        mov     eax, [esp+4]		; 5
	call	print_int		; test
	call	print_nl		; test
	mov	[scale], eax

        mov     eax, [esp+8]		; 10
	call	print_int		; test
	call	print_nl		; test
	mov	[size], eax	
	
	mov	eax, [esp+12]		; array1
	mov	ecx, eax	

loop_start:
	
	mov	ax, 5			; 5 = [ecx + ebx]	
	imul	ax, 5			; 5 = [scale]
	call	print_int		; test
	call	print_nl		; test
;	mov	[ecx + ebx] , ax
	
	add	ebx, 2
	cmp	ebx, 10			; 10 = [size]
        jl      loop_start


done:
        pop     ebp
        ret

