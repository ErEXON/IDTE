;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : EditMenu.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================

;___________________________________________________________________________________________Copy File(s)___________________________________________________________________________;
ContextCopy:
Copy:
    if folder=
        {
            if ChooseFile=
                {
                    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
                    MsgBox , 16, error,Select File(s) First
                    return
                }
        }

Destination=
    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
    FileSelectFolder ,Destination, , 3, Select Destination Folder
    if Destination=
        return
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    SplashTextOn , , ,Copying Files...
    ControlGet, List, List, Selected, SysListView321, A
    ValueRow:= LV_GetCount("S")
    SingleTag=%ValueRow%
    Loop, Parse, List, `n  ; Rows are delimited by linefeeds (`n).
        {
            percentage := (A_Index/ValueRow)*100
            GuiControl , , GUI_Progress, %percentage%
            GuiControl , , GUI_Text, %A_Index%/%ValueRow%
            Loop, Parse, A_LoopField, %A_Tab% ; Fields (columns) in each row are delimited by tabs (A_Tab).
                {
                    if A_Index=8
                        Text=%A_LoopField%
                    else if A_Index=9
                        Folder=%A_LoopField%
                    else if A_Index=10
                        {
                            loop , %Folder%\%Text%
                                {
                                    Dest = %Destination%\%Text%
                                    address :=registercallback("update")
                                    dllcall("CopyFileEx",str,A_LoopFileFullPath,str,Dest,Uint,address,Uint,0,int,0,int,0)
                                }
                        }
                }
            SingleTag=%A_Index%
        }
    Progress , off
    GuiControl , , GUI_Progress, 0
    GuiControl , , GUI_Text, Done
    SplashTextOff
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return

;_____________________________________________________________________________________________________CUT FILE(S)__________________________________________________________________;
ContextMove:
Cut:

    if folder=
        {
            if ChooseFile=
                {
                    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
                    MsgBox , 16, Error, Select File(s) First
                    return
                }
        }
    Destination=
    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
    FileSelectFolder ,Destination, , 3, Select Destination Folder
    if Destination=
        return
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    SplashTextOn , , ,Moving Files...
    ControlGet, List, List, Selected, SysListView321, A
    ValueRow:= LV_GetCount("S")
    SingleTag=%ValueRow%
    ControlGet, List, List, Selected, SysListView321, A
    Loop, Parse, List, `n  ; Rows are delimited by linefeeds (`n).
        {
            percentage := (A_Index/ValueRow)*100
            GuiControl , , GUI_Progress, %percentage%
            GuiControl , , GUI_Text, %A_Index%/%ValueRow%
            Loop, Parse, A_LoopField, %A_Tab% ; Fields (columns) in each row are delimited by tabs (A_Tab).
                {
                    if A_Index=8
                        Text=%A_LoopField%
                    else if A_Index=9
                        Folder=%A_LoopField%    
                    else if A_Index=10
                        {
                            loop %folder%\%text%
                                {
                                    Dest = %Destination%\%Text%
                                    address :=registercallback("update")
                                    dllcall("MoveFileEx",str,A_LoopFileFullPath,str,Dest,Uint,address,Uint,0,int,0,int,0)
                                    FileDelete , A_LoopFileFullPath
                                }
                        }
                }
            SingleTag=%A_Index%
        }
    Progress , off
    SplashTextOff
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return

;__________________________________________________________________________________RENAME TAG______________________________________________________________________________________;
RenameTag:

    if Folder=
        {
            if ChooseFile=
                {
                    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
                    MsgBox , 16, Error , Select Folder First
                    return
                }
        }

    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
    InputBox , NewName , Rename Tag, Enter New Name (Name)# , , 200, 150 
    if NewName=
        return
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    SplashTextOn , , ,Renaming Files...
    ControlGet, List, List, Selected, SysListView321, A
    ValueRow:= LV_GetCount("S")
    SingleTag=%ValueRow%
    Loop, Parse, List, `n  ; Rows are delimited by linefeeds (`n).
        {
            percentage := (A_Index/ValueRow)*100
            GuiControl , , GUI_Progress, %percentage%
            GuiControl , , GUI_Text, %A_Index%/%ValueRow%
            Loop, Parse, A_LoopField, %A_Tab% ; Fields (columns) in each row are delimited by tabs (A_Tab).
                {
                    if A_Index=8
                        Text=%A_LoopField%
                    else if A_Index=9
                        Folder=%A_LoopField%
                    else if A_Index=10
                        {   
                            FileMove, %Folder%\%Text%, %Folder%\%NewName%%SingleTag%.*
                        }
                }
            SingleTag=%A_Index%
        }
    SplashTextOff
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return