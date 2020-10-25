; Author: Austin Chayka
; Project name: Program 4
; Description: 
;	Gets a number of terms from the user, checks if its
;	within bounds, then calculates and prints that many
;	composite numbers

INCLUDE irvine32.inc

LIMIT = 400

.data
	;print strings
	progTitle BYTE "Composite Numberss	Programmed byte Austin Chayka", 13, 10, 0
	instructions BYTE "Enter a number offset composite numbers you would like to see.", 13, 10, 0
	limitIntro BYTE "I'll accept orders for up to ", 0
	limitIntro2 BYTE " composites.", 13, 10, 0
	enterData BYTE "Enter the number offset composites to display [1, ", 0
	enterData2 BYTE "]:", 0
	dataError BYTE "Out of range. Try Again.", 13, 10, 0
	space BYTE "	", 0
	newLine BYTE 13, 10, 0
	goodbye BYTE "Results certified by Austin Chayka.		Goodbye.", 13, 10, 0
	;variables
	userInput DWORD	?
	testValue DWORD 4
	counter DWORD 0

.code

intro PROC
;procedure to print the intro
	mov		edx, OFFSET progTitle
	call	WriteString
	mov		edx, OFFSET instructions
	call	WriteString
	mov		edx, OFFSET limitIntro
	call	WriteString
	mov		eax, LIMIT
	call	WriteInt
	mov		edx, OFFSET limitIntro2
	call	WriteString

	ret
intro ENDP

validate PROC
;procedure to validate input
	;checks if input is within bounds
	cmp		eax, 1
	jl		error
	cmp		eax, LIMIT
	jg		error
	jmp		endVal

error:
	;input is out of bounds
	mov		eax, 0
endVal:

	ret
validate ENDP

getUserData PROC
;procedure gets term input fron the user 

	jmp		getData

rangeError:
;notify the user input is out of bounds
	mov		edx, OFFSET dataError
	call	WriteString
getData:
;gets input from the user
	mov		edx, OFFSET enterData
	call	WriteString
	mov		eax, LIMIT
	call	WriteInt
	mov		edx, OFFSET enterData2
	call	WriteString
	call	ReadInt
	;check input
	call	validate
	cmp		eax, 0
	je		rangeError
	mov		userInput, eax

	ret
getUserData ENDP

isComposite PROC
;checks if number is a composite
	;check if it is an initial prime
	mov		eax, testValue
	cmp		eax, 3
	je		fail
	mov		eax, testValue
	cmp		eax, 5
	je		fail
	mov		eax, testValue
	cmp		eax, 7
	je		fail
	mov		eax, testValue
	cmp		eax, 11
	je		fail
	mov		eax, testValue
	cmp		eax, 13
	je		fail
	;check if number has divisors
	mov		edx, 0
	mov		eax, testValue
	mov		ecx, 2
	div		ecx
	cmp		edx, 0
	je		pass
	mov		edx, 0
	mov		eax, testValue
	mov		ecx, 3
	div		ecx
	cmp		edx, 0
	je		pass
	mov		edx, 0
	mov		eax, testValue
	mov		ecx, 5
	div		ecx
	cmp		edx, 0
	je		pass
	mov		edx, 0
	mov		eax, testValue
	mov		ecx, 7
	div		ecx
	cmp		edx, 0
	je		pass
	mov		edx, 0
	mov		eax, testValue
	mov		ecx, 11
	div		ecx
	cmp		edx, 0
	je		pass
	mov		edx, 0
	mov		eax, testValue
	mov		ecx, 13
	div		ecx
	cmp		edx, 0
	je		pass
	jmp		fail
fail:
	mov		eax, 0
	jmp		endTest
pass:
	mov		eax, 1
	
endTest:

	ret
isComposite ENDP

showComposites PROC
;procedure to show all composites terms
start:
	;call check procedure
	call	isComposite
	cmp		eax, 0
	je		notComp
	;print number
	mov		eax, testValue
	call	WriteInt
	mov		edx, OFFSET space
	call	WriteString
	;increment counter
	add		counter, 1
	;maintain line formatting
	mov		edx, 0
	mov		eax, counter
	mov		ecx, 8
	div		ecx
	cmp		edx, 0
	jne		cont
	mov		edx, OFFSET newLine
	call	WriteString
cont:
	;continue loop
	mov		eax, counter
	cmp		eax, userInput
	jge		endLoop
notComp:
	add		testValue, 1
	loop	start
endLoop:

	ret
showComposites ENDP

farewell PROC
;procedure prints goodbye message
	mov		edx, OFFSET newLine
	call	WriteString
	mov		edx, OFFSET goodbye
	call	WriteString

	ret
farewell ENDP

main PROC
;call program procedures in order
	call	intro		
	call	getUserData
	call	showComposites
	call	farewell

	exit
main ENDP

end main