.386
   .model flat,stdcall
   option casemap:none
   
WndProc PROTO :DWORD,:DWORD,:DWORD,:DWORD

include \masm32\include\windows.inc
include \masm32\macros\macros.asm
uselib kernel32, user32, masm32, comctl32

   .const
IDD_DLG1 equ 1000
IDC_LST1 equ 1001
IDC_BTN1 equ 1002
;IDC_EDT1 equ 1003
.data?
  hInstance dd ?
  hWnd dd ?
  hListBox dd ?
  hEditText dd ?
  ;buffer db 512 dup(?)
  buffer db 512 dup(?)
  AppName db "Our First Dialog Box",0 
.code
  start:
    invoke GetModuleHandle, NULL
    mov hInstance, eax
    invoke DialogBoxParam, hInstance, IDD_DLG1, 0, offset WndProc, 0
    invoke ExitProcess,eax
WndProc proc hWin :DWORD, uMsg :DWORD, wParam :DWORD, lParam :DWORD
  switch uMsg
    case WM_INITDIALOG
      invoke SendMessage, hWin, WM_SETICON, 1, FUNC(LoadIcon, NULL, IDI_ASTERISK)
	  invoke GetDlgItem,hWin,IDC_LST1
	   mov hListBox, eax
	  invoke SendMessage,hListBox,LB_ADDSTRING,0,chr$("First!")
	  invoke SendMessage,hListBox,LB_ADDSTRING,0,chr$("Second")	  
	  invoke SendMessage,hListBox,LB_ADDSTRING,0,chr$("Three")	
	  invoke SendMessage,hListBox,LB_SETCURSEL,1,0
case WM_COMMAND
      switch wParam
        case IDC_BTN1
        ;invoke GetDlgItemText,hWin,IDC_EDT1,ADDR buffer,256
        ;invoke MessageBox,NULL,ADDR buffer,ADDR AppName,MB_OK

        invoke GetDlgItem,hWin,IDC_LST1
	      mov hListBox, eax
        ;invoke SendMessage,hListBox,LB_ADDSTRING, 0, buffer
        invoke SendMessage,hListBox,LB_ADDSTRING, 0, chr$("New Item")
      endsw_:	  
      endsw
    case WM_CLOSE
      exit_program:
      invoke EndDialog, hWin, 0
    endsw
  xor eax,eax
ret
WndProc ENDP
end start
