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


array1		dw	1,2,3,4,5,6	; array1 = [1,2,3,4,5]
before		db	"before:",10,0
after		db	"after:",10,0

; uninitialized data is put in the .bss segment
;
segment .bss

;
; code is put in the .text segment
;
segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha
; *********** Start  Assignment Code *******************

	mov	eax, before
	call	print_string
	mov	eax, 0
	mov	ebx, 0
	mov	ecx, array1
start_loop:	

	mov	ax, [ecx + ebx] 
	call	print_int
	call	print_nl
	add	ebx, 2
	cmp	ebx,10
	jl	start_loop

	mov	eax, after
	call	print_string

	mov	eax, 0
	mov	ecx, array1
	mov	ebx, 0			; clear ebx
scale_loop:
	mov	ax, [ecx + ebx]	
	imul	ax, 5
	mov	[array1 + ebx] , ax
	add	ebx, 2
	cmp	ebx, 10	
	jl	scale_loop

	mov	ebx, 0			; clear ebx
print_loop:
	mov	ax, [array1 + ebx]
	call	print_int
	call	print_nl
	add	ebx, 2
	cmp	ebx, 10
	jl	print_loop
	



; *********** End Assignment Code **********************

        popa
        mov     eax, SUCCESS       ; return back to the C program
        leave                     
        ret

