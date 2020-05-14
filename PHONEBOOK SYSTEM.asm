.model small
.stack 1000h
;-----------------------------------------gotoxy, just a function fo column and row customization
gotoxy macro columndl,rowdh
	mov ah,2
	mov dl,columndl
	mov dh,rowdh
	int 10h
endm
.data
;---------------------------------------------VARIABLE AND STRING DECLARATION		
		msgPin db 10,13, "                              Enter your PIN: $"
		pin1 db ?
		pin2 db ?
		pin3 db ?
		pin4 db ?
		wrongPin db 10,13, "                    Your PIN is incorrect. Please try again: $"
		menu db 10,13,        "                            WELCOME TO YOUR PHONEBOOK$"
		menu1 db 10,13, "                        [1] Add Contact $"
		menu2 db 10,13, "                        [2] View All Contacts $"
		menu3 db 10,13, "                        [3] Delete Contact $"
		menu4 db 10,13, "                        [4] Edit Contact $"
		menu5 db 10,13, "                        [5] Exit $"
		choiceP db 10,13,10,13,"                 Enter option: $"
		opt db ?
		invalidChoice db 10,13, "                 Invalid Choice! Please enter a valid option: $"
		promptSlot db 10,13, "     Enter your desired contact slot [00-10][ESC to go back]: $"
		s1 db ?
		s2 db ?
		promptName db 10,13,10,13, "        Enter contact name: $"
		name0 db 50 dup ('$')
		num0 db 50 dup ('$')
		name1 db 50 dup ('$')
		num1 db 50 dup ('$')
		name2 db 50 dup ('$')
		num2 db 50 dup ('$')
		name3 db 50 dup ('$')
		num3 db 50 dup ('$')
		name4 db 50 dup ('$')
		num4 db 50 dup ('$')
		name5 db 50 dup ('$')
		num5 db 50 dup ('$')
		name6 db 50 dup ('$')
		num6 db 50 dup ('$')
		name7 db 50 dup ('$')
		num7 db 50 dup ('$')
		name8 db 50 dup ('$')
		num8 db 50 dup ('$')
		name9 db 50 dup ('$')
		num9 db 50 dup ('$')
		name10 db 50 dup ('$')
		num10 db 50 dup ('$')
		pstop db 10,13,"        Desired slot is already taken! *00 to 09 only* $"
		pstopd db 10,13, "        Desired slot is empty! *00 to 09 only* $"
		pSuccess db 10,13, "                          Contact added! $"
		pSuccessd db 10,13,"                          Contact deleted! $"
		pSuccesse db 10,13, "                          Contact edited! $"
		promptNum db 10,13, "        Enter contact number: $"
		header db 10,13, "     SLOT#  NAME                       CONTACT NUMBER$"
		noC db 10,13,    "     ===================NO CONTACT===================$"
		errorD db 10,13, "    There is no contact in the slot.$"
		errorSlot db 10,13, "    Invalid slot number! Please choose between 00 to 09 only$"
		prENTER db 10,13, "                          Press enter to continue... $"
		errorinp db 10,13, "    You have entered nothing.$"
		e db ?
		emptyprompt db 10,13, "                          Phonebook is empty!$"
		promptEdit db 10,13, "   Are you sure you want to edit this contact? [Y/N]: $"
		promptDelete db 10,13, "    Are you sure you want to delete this contact? [Y/N]: $"
		choiceD db ?
		choice db ?

		M1 DB "  ",10,13,"$"
		M2 DB "    ",10,13,"$"
		M4 DB "        ",10,13,"$"
		M6 DB "                                     ",10,13,"$"
		M10 DB "                                                                              ",10,13,"$"
		M11 DB "                      ",10,13,"$"
		M12 DB "                        ",10,13,"$"
		M14 DB "                            ",10,13,"$"
		len equ $-name0
		cntr dw ?

		
		
.code	
include addF.txt
include viewF.txt
include delF.txt
include editF.txt
include borderF.txt

start:	
;---------------------------------------------MAIN FUNCTION
main 	proc near
		mov ax,@data
		mov ds,ax
	
		call initialize
		
		call cls
		call user
		call inPin
		call welcome
		mov ah,4ch
		int 21h					
main	endp
;---------------------------------------------PRINT STRING FUNCTION
cout	proc near
		mov ah,9
		int 21h
		ret
cout endp
;---------------------------------------------PRINT CHARACTER FUNCTION
coutc	proc near
		mov ah,2
		int 21h
		ret
coutc	endp
;---------------------------------------------INPUT FUNCTION
cin	proc near
	mov ah,1
	int 21h
	ret
cin endp
;---------------------------------------------INPUT WITHOUT ECHO
cine	proc near
		mov ah,8
		int 21h
		ret
cine endp
;---------------------------------------------INITIALIZE VARIABLE
initialize proc near
			mov num1, 0
			mov name1, 0
			mov num2, 0
			mov name2, 0
			mov num3, 0
			mov name3, 0
			mov num4, 0
			mov name4, 0
			mov num5, 0
			mov name5, 0
			mov num6, 0
			mov name6, 0
			mov num7, 0
			mov name7, 0
			mov num8, 0
			mov name8, 0
			mov num9, 0
			mov name9, 0
			mov num0, 0
			mov name0, 0
initialize	endp
;---------------------------------------------CLEAR SCREEN
cls		proc near
		mov ax,3
		int 10h
		call border
		ret
cls		endp	
;----------------------------------------------PROMPT USER FOR PIN
user	proc near
		call border
		
		gotoxy 0, 10
		lea dx, msgPin
		call cout
		ret
user	endp
;----------------------------------------------INPUT PIN
inPin	proc near
		mov ah,8
		int 21h
		mov pin1, al
		mov dl, '*'
		call coutc
		mov ah, 8
		int 21h
		mov pin2, al
		mov dl, '*'
		call coutc
		mov ah, 8
		int 21h
		mov pin3, al
		mov dl, '*'
		call coutc
		mov ah,8
		int 21h
		mov pin4, al
		mov dl, '*'
		call coutc
		call validate
		ret
inPin	endp
;----------------------------------------------VALIDATION OF PASSWORD
validate	proc near
p1:			cmp pin1, '1'
			jne wrong
			je p2
p2:			cmp pin2, '2'
			jne wrong
			je p3
p3:			cmp pin3, '3'
			jne wrong
			je p4
p4:			cmp pin4, '4'
			jne wrong	
			je correct
wrong:		call cls
			gotoxy 0,8
			lea dx, wrongPin
			call cout
			jmp inP
correct:	lea dx, prENTER
			call cout
			mov ah, 1
			int 21h
			cmp al, 13
			jne correct
			je cont
inP:		call inPin
cont:		ret
validate	endp
;----------------------------------------------DISPLAY WELCOME
welcome		proc near
			call cls
			gotoxy 0,4
			lea dx, menu
			call cout		
			lea dx, menu1
			call cout	
			lea dx, menu2
			call cout		
			lea dx, menu3
			call cout		
			lea dx, menu4
			call cout		
			lea dx, menu5
			call cout
			call inputchoice
			ret
welcome		endp
;----------------------------------------------INPUT CHOICE
inputchoice	proc near
			mov ah,9
			lea dx, choiceP
			int 21h
			call cin
			mov opt, al
			
menuA:		cmp opt, '1'
			jne menuB
			je ad
menuB:		cmp opt, '2'
			jne menuC
			je view
menuC:		cmp opt, '3'
			jne menuD
			je delete 
menuD:		cmp opt, '5'
			jne menuE	
			je bye
menuE:		cmp opt, '4'
			jne invalid
			je edit
			
invalid:	gotoxy 0, 11
			lea dx, invalidChoice
			call cout
			call inputchoice
ad:			call addC
			jmp okay	
delete:		call delC
		    jmp okay
edit:		call editC
			jmp okay
view:		call viewC
			jmp okay
bye:		mov ah,4ch
			int 21h			


okay: call welcome
			
				ret
inputchoice		endp
;-----------------------------------------------Prompt Slot Function
promptS		proc near
			call cls
			gotoxy 0,3
			lea dx, promptSlot
			call cout
					
			call cin
			mov s1, al
			call cin
			mov s2, al

			cmp s1, 27
			je gomenu
		
	back:	ret
	gomenu: call welcome
promptS		endp
;------------------------prompt user for number
pNum proc near
lea dx, promptNum
call cout
ret
pNum endp
;-------------------prompt user for contact name
pName proc near
lea dx, promptName
call cout
ret
pName endp
;-----------------------string input
inString proc near
	goo: mov ah,1
	int 21h
	cmp al,13
	je ok
	mov [si],al
	inc si
	jmp goo
	
	ok: ret
inString endp	
;---------------------------error input
errorIn proc near
		lea dx, errorinp
		call cout
		ret
errorIn endp
end start
		
		