
Test:
return

;Use: TP_Show([ Title, Message, Lifespan, FontSize, FontColor, BGColor, CallbackLabel ])   
TP_Show(TP_Title="", TP_Message="Hello, World", TP_Lifespan=0, TP_FontSize="12", TP_FontColor="Blue", TP_BGColor="White",  TP_CallBack="")
{
	Global TP_GuiEvent
	Static TP_CallBackTarget, TP_GUI_ID
	TP_CallBackTarget := TP_CallBack
	
	DetectHiddenWindows, On
	SysGet, Workspace, MonitorWorkArea
	
	Gui, 89:-Caption +ToolWindow +LastFound +AlwaysOnTop +Border
	Gui, 89:Color, %TP_BGColor%
	If (TP_Title) {
		TP_TitleSize := TP_FontSize + 1
		Gui, 89:Font, s%TP_TitleSize% c%TP_FontColor% w700
		Gui, 89:Add, Text, r1 center gTP_Fade x5 y5, %TP_Title%
		Gui, 89:Margin, 0, 0
	}
	Gui, 89:Font, s%TP_FontSize% c%TP_FontColor% w400
	Gui, 89:Add, Text, gTP_Fade x5, %TP_Message%
	IfNotEqual, TP_Title,, Gui, 89:Margin, 5, 5
	Gui, 89:Show, Hide, TP_Gui
	TP_GUI_ID := WinExist("TP_Gui")
	WinGetPos, , , GUIWidth, GUIHeight, ahk_id %TP_GUI_ID%
	NewX := WorkSpaceRight-GUIWidth-5
	NewY := WorkspaceBottom-GUIHeight-5
	Gui, 89:Show, Hide x%NewX% y%NewY%
	DllCall("AnimateWindow","UInt", TP_GUI_ID,"Int", GuiHeight*10,"UInt", 0x40008)
	If (TP_Lifespan)
		SetTimer, TP_Fade, -%TP_Lifespan%
Return TP_GUI_ID

89GuiContextMenu:
TP_Fade:
	If (A_GuiEvent and TP_CallBackTarget)
	{
		TP_GuiEvent := A_GuiEvent
		If IsLabel(TP_CallBackTarget)
			Gosub, %TP_CallBackTarget%
		else
		{
			If InStr(TP_CallBackTarget, "(")
			Msgbox Cannot yet callback a function
			else
			Msgbox, not a valid CallBack
		}
	}
	DllCall("AnimateWindow","UInt", TP_GUI_ID,"Int", 600,"UInt", 0x90000)
	Gui, 89:Destroy
Return
}

TP_Wait(TP_GUI_ID="") {
  If not (TP_GUI_ID)
   TP_GUI_ID := WinExist("TP_Gui")
  WinWaitClose, ahk_id %TP_GUI_ID%
}