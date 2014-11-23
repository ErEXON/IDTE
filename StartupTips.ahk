;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : StartupTips.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================

Startuptips:
Random , Currentline, 1, 10
filereadline , Tip , %A_WorkingDir%\Help Manual\Tips.txt , %Currentline%
Gui, Tips:Add, picture,  x20 y25 w64 h64 ,%A_WorkingDir%\GUI\Tips.png 
Gui, Tips:Font , s10 bold, Arial
Gui, Tips:Add, Text,  x94 y25 ,`nDid you Know....
Gui, Tips:Font , 
Gui, Tips:Font , s9 Bold , Arial
Gui, Tips:Add, Text,  x20 y90 w296 h120 vMyTips, 
Gui, Tips:Font , 
Gui, Tips:Add, Checkbox, x13 y232 w140 h16 checked gchecktips vchecktps, &Show Tips on StartUp
Gui, Tips:Add, Button, x162 y227 w75 h23 vNxttip, &Next Tip
Gui, Tips:Add, Button, x247 y227 w75 h23 vclosetip, &Close
Gui, Tips:Add, GroupBox, x12 y9 w310 h210 , 
GuiControl , Tips:, MyTips , %Tip% 
Gui, Tips:Show, w341 h261, Tips
WinSet , Alwaysontop , , Tips
Currentline = 0
return

TipsButtonClose:
TipsGuiClose:
gui , Tips:destroy
return

checktips:
if flag_tip=
{
flag_tip=1
IniWrite , 0,%A_Mydocuments%\IDTE_Configuration.ini,Album_Art,Enable_AlbumArt
}
else
{
flag_tip=
IniWrite , 1,%A_Mydocuments%\IDTE_Configuration.ini,Album_Art,Enable_AlbumArt
}
return

TipsButtonNextTip:
Currentline++
if(Currentline>10)
    Currentline = 1
filereadline , Tip , %A_WorkingDir%\Help Manual\Tips.txt , %Currentline%
GuiControl , Tips:, MyTips , %Tip% 
return