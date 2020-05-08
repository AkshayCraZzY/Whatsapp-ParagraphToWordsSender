
{
#NoEnv 
SetBatchLines -1
SendMode Input 
SetWorkingDir %A_ScriptDir%  
;DetectHiddenWindows, On
DetectHiddenText, On
SetTitleMatchMode 2 
#SingleInstance Force 
}


CheckNet:
{
	If (ConnectedToInternet() = 0)
	{
		MsgBox 16, ,Error Code 405 :`nERR_INTERNET_DISCONNECTED
		goto, Exit

	}
	ConnectedToInternet(flag=0x40)
	{
		Return DllCall("Wininet.dll\InternetGetConnectedState", "Str", flag,"Int",0)
	}
}

GetVer:
{
	whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	whr.Open("GET", "https://raw.githubusercontent.com/AkshayCraZzY/Whatsapp-ParagraphToWordsSender/master/version.txt", true)
	whr.Send()
	; Using 'true' above and the call below allows the script to remain responsive.
	whr.WaitForResponse()
	ver:= whr.ResponseText
}




Gui, Add, Button, x22 y19 w110 h30 gSpam vSpa , Spam   
Gui, Add, Button, x162 y19 w110 h30 gClear vClr, Clear
Gui, Add, Button, x302 y19 w110 h30 gAbout , About
Gui, Add, Text, x22 y60 vTxt, Text to send :
Gui, Add, Edit, x22 y79 w390 h190 vMsg , 
; Generated using SmartGUI Creator for SciTE
Gui, Show, w439 h282, Whatsapp ParagraphToWords Sender  %ver%
return

GuiClose:
Exit:
ExitApp


About:
{
	Gui, Submit,NoHide
	;Gui 2: color, fFffff
	;Gui 2: Font,cWhite
	Gui 2: Add, Text,,`n> A lite application to send word by word messages of a long paragraph/sentence in WhatsappWeb.`n`n> Made By Akshay Parakh
	Gui 2: Add, Link,, > <a href="https://github.com/AkshayCraZzY/Whatsapp-ParagraphToWordsSender/">Visit on GitHub</a>
	Gui 2: Add, Text,,> Version - %ver%`n
	Gui 2: show,NoActivate,About Whatsapp ParagraphToWords Sender %ver%
	Gui 2: +AlwaysOnTop
	return
}

Spam:
{
	
	GuiControlGet, OutputVar,, Spa
	If OutputVar= Spam																
	{
		GuiControlGet, Msg
		if Msg=
		{
			MsgBox, 48, ,  Enter text first!
			return
		}
		GuiControl,,Spa,Stop
		GuiControl,disable,Clr
		GuiControl,disable,txt
		GuiControl,disable,msg
		
		MouseClick, left,1076,231
		sleep 200
		Text := StrSplit(Msg, " ")
		Loop % Text.MaxIndex()
		{
			word := Text[A_Index]
			clipboard := word
			Send ^v{Enter}
			sleep 200
		}
		return
	}
	
	
	If OutputVar= Stop																
	{
		GuiControl,,Spa,Spam
		GuiControl,enable,Clr
		GuiControl,enable,txt
		GuiControl,enable,msg
		return
	}
	
}

Clear:
{
GuiControl, , msg
return
}
