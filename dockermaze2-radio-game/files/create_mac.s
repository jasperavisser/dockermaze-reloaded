	.file	"create_mac.c"
	.intel_syntax noprefix
	.globl	static_key
	.data
	.type	static_key, @object
	.size	static_key, 10
static_key:
	.string	"H4x0rK3y!"
	.text
	.globl	cipher_cmd
	.type	cipher_cmd, @function
cipher_cmd:
.LFB0:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	push	esi
	push	ebx
	sub	esp, 16
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	mov	DWORD PTR [ebp-12], 0
	jmp	.L2
.L3:
	mov	edx, DWORD PTR [ebp-12]
	mov	eax, DWORD PTR [ebp+8]
	lea	ebx, [edx+eax]
	mov	edx, DWORD PTR [ebp-12]
	mov	eax, DWORD PTR [ebp+8]
	add	eax, edx
	movzx	esi, BYTE PTR [eax]
	mov	ecx, DWORD PTR [ebp-12]
	mov	edx, 954437177
	mov	eax, ecx
	imul	edx
	sar	edx
	mov	eax, ecx
	sar	eax, 31
	sub	edx, eax
	mov	eax, edx
	mov	edx, eax
	sal	edx, 3
	add	edx, eax
	mov	eax, ecx
	sub	eax, edx
	movzx	eax, BYTE PTR static_key[eax]
	xor	eax, esi
	mov	BYTE PTR [ebx], al
	add	DWORD PTR [ebp-12], 1
.L2:
	mov	eax, DWORD PTR [ebp-12]
	cmp	eax, DWORD PTR [ebp+12]
	jl	.L3
	add	esp, 16
	pop	ebx
	.cfi_restore 3
	pop	esi
	.cfi_restore 6
	pop	ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	cipher_cmd, .-cipher_cmd
	.globl	create_mac
	.type	create_mac, @function
create_mac:
## BB#0:
	push	ebp
	mov	ebp, esp
	push	ebx
	sub	esp, 16
	mov	eax, dword ptr [ebp + 12]
	mov	ecx, dword ptr [ebp + 8]
	mov	dword ptr [ebp - 8], ecx
	mov	dword ptr [ebp - 12], eax
	mov	byte ptr [ebp - 13], 0
	mov	dword ptr [ebp - 20], 0
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	mov	eax, dword ptr [ebp - 20]
	cmp	eax, dword ptr [ebp - 12]
	jge	LBB0_4
## BB#2:                                ##   in Loop: Header=BB0_1 Depth=1
	movsx	eax, byte ptr [ebp - 13]
	mov	ecx, dword ptr [ebp - 20]
	mov	edx, dword ptr [ebp - 8]
	movsx	ecx, byte ptr [edx + ecx]
	xor	eax, ecx
	mov	bl, al
	mov	byte ptr [ebp - 13], bl
## BB#3:                                ##   in Loop: Header=BB0_1 Depth=1
	mov	eax, dword ptr [ebp - 20]
	add	eax, 1
	mov	dword ptr [ebp - 20], eax
	jmp	LBB0_1
LBB0_4:
	movsx	eax, byte ptr [ebp - 13]
	add	esp, 16
	pop	ebx
	pop	ebp
	ret
.LFB1:
	.cfi_startproc


	########### function prolog ###########
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5

	########### reserve space for local vars ###########
	sub	esp, 16

	########### char mac = 0; ###########
	mov	BYTE PTR [ebp-1], 0

	########### int i = 0; ###########
	mov	DWORD PTR [ebp-8], 0

	########### start loop in label L5 ###########
	jmp	.L5

.L6:
	########### instructions inside the 'for' loop ###########

	mov	edx, DWORD PTR [ebp-8]
	mov	eax, DWORD PTR [ebp+8]
	add	eax, edx
	########### Now eax points to the current position ('i') of the 'cmd' string ###########

	/*
		Here I guess I should add the code responsible of getting this current byte and xor it
		with the acumulated mac (stored at [ebp-1])
	*/

	########### i++ ###########
	add	DWORD PTR [ebp-8], 1

.L5:
	########### loop starts here ###########
	########### compares 'i' with 'cmd_len' ###########
	mov	eax, DWORD PTR [ebp-8]
	cmp	eax, DWORD PTR [ebp+12]

	########### if lesser, jumps to label L6 and executes instructions inside the 'for' loop ###########
	jl	.L6

	########### else, returns the result (mac) ###########
	movzx	eax, BYTE PTR [ebp-1]
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret

	.cfi_endproc
.LFE1:
	.size	create_mac, .-create_mac
	.section	.rodata
.LC0:
	.string	"%02x"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	lea	ecx, [esp+4]
	.cfi_def_cfa 1, 0
	and	esp, -16
	push	DWORD PTR [ecx-4]
	push	ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0
	mov	ebp, esp
	push	ecx
	.cfi_escape 0xf,0x3,0x75,0x7c,0x6
	sub	esp, 20
	mov	eax, ecx
	mov	eax, DWORD PTR [eax+4]
	mov	eax, DWORD PTR [eax+4]
	mov	DWORD PTR [ebp-16], eax
	sub	esp, 12
	push	DWORD PTR [ebp-16]
	call	strlen
	add	esp, 16
	mov	DWORD PTR [ebp-20], eax
	sub	esp, 8
	push	DWORD PTR [ebp-20]
	push	DWORD PTR [ebp-16]
	call	cipher_cmd
	add	esp, 16
	sub	esp, 8
	push	DWORD PTR [ebp-20]
	push	DWORD PTR [ebp-16]
	call	create_mac
	add	esp, 16
	mov	BYTE PTR [ebp-21], al
	mov	DWORD PTR [ebp-12], 0
	jmp	.L9
.L10:
	mov	edx, DWORD PTR [ebp-12]
	mov	eax, DWORD PTR [ebp-16]
	add	eax, edx
	movzx	eax, BYTE PTR [eax]
	movsx	eax, al
	sub	esp, 8
	push	eax
	push	OFFSET FLAT:.LC0
	call	printf
	add	esp, 16
	add	DWORD PTR [ebp-12], 1
.L9:
	mov	eax, DWORD PTR [ebp-12]
	cmp	eax, DWORD PTR [ebp-20]
	jl	.L10
	movsx	eax, BYTE PTR [ebp-21]
	sub	esp, 8
	push	eax
	push	OFFSET FLAT:.LC0
	call	printf
	add	esp, 16
	mov	eax, 0
	mov	ecx, DWORD PTR [ebp-4]
	.cfi_def_cfa 1, 0
	leave
	.cfi_restore 5
	lea	esp, [ecx-4]
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.ident	"GCC: (Debian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
