;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : Updater.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================

Loop, %0%  ; For each parameter:
{
    param := %A_Index%  ; Fetch the contents of the variable whose name is contained in A_Index.
    if CMD_Recieved=
	CMD_Recieved = %param%
	else
	CMD_Recieved = %CMD_Recieved%`n%param%
}

if CMD_Recieved !=
    SplashTextOn , , , Checking For Updates.....
FileDelete , %A_Temp%\version.txt
URLDownloadToFile , http://sourceforge.net/projects/idteid3tagedito/files/version.txt/download , %A_Temp%\version.txt
;FileCopy , C:\Users\Rajat Kosh\Desktop\Uploading Data\IDTE\version.txt  , %A_Temp%\version.txt, 1
if  errorlevel
{
SplashTextOff
if CMD_Recieved !=
MsgBox , 64, Updates , Unable to Check For Updates`,Please Check your internet Connections 
Exitapp
}
FileReadLine , version , %A_Temp%\version.txt , 1

if  version=2.8
{
SplashTextOff
if CMD_Recieved !=
MsgBox , 64, Updates , No Updates Available `, Your Application is Updated to its Latest Version i.e. v2.8
ExitApp
}

FileRead , changes , %A_Temp%\version.txt

SplashTextOff
Gui, Add, Picture, x2 y0 w70 h70 , %A_WorkingDir%\GUI\Update.png
Gui, Font, S10 CDefault bold, Tahoma
Gui, Add, Text, x82 y9 w320 h50 , A newer version of IDTE is available for download`n`nWhat's new in IDTE v%version% :-
Gui, Font,  , 
Gui, Font, S8 CDefault bold, Arial
Gui, Add, Button, x12 y219 w110 h20 ,&Download
Gui, Add, Button, x332 y219 w110 h20 ,&Maybe Later
Gui, Add, Edit, x12 y69 w430 h140 vupdated readonly, 
Gui, Show, w460 h255, Updater

Guicontrol , , updated, %changes%
return

ButtonDownload:
RunWait , http://sourceforge.net/projects/idteid3tagedito
ButtonMaybeLater:
GuiClose:
ExitApp
