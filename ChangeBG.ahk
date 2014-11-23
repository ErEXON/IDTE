;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : ChangeBG.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================

ChangeBackground:
Gui, Change:Add, DropDownList, x42 y40 w170 vTheme, Black Fade|Dark Knight|Lame|Old IDTE|Fade Colors|Black Fever|White Clean|Blue|OpenSuse Colors|Ubuntu Colors
Gui, Change:Add, Button, x80 y76 w100 h25 , Select
Gui, Change:Font, S10 CDefault, Arial
Gui, Change:Add, Text, x18 y10 w210 h20 +Center, Select Theme From Below
Gui, Change:Show, w249 h107, Select Background
return

ChangeButtonSelect:
gui, Submit ,NoHide
FileDelete , %A_MyDocuments%\IDTE_Data\BG.cfg
if Theme=Black Fade
FileAppend , Background\Capture1.png, %A_MyDocuments%\IDTE_Data\BG.cfg,
if Theme= Dark Knight
FileAppend , Background\Capture2.png, %A_MyDocuments%\IDTE_Data\BG.cfg,
if Theme= Lame
FileAppend , Background\Capture3.png,%A_MyDocuments%\IDTE_Data\BG.cfg,
if Theme= Old IDTE
FileAppend , Background\Capture4.png,%A_MyDocuments%\IDTE_Data\BG.cfg,
if Theme= Fade Colors
FileAppend , Background\Capture5.png,%A_MyDocuments%\IDTE_Data\BG.cfg,
if Theme= Black Fever
FileAppend , Background\Capture6.png,%A_MyDocuments%\IDTE_Data\BG.cfg,
if Theme= White Clean
FileAppend , Background\Capture7.png,%A_MyDocuments%\IDTE_Data\BG.cfg,
if Theme= Blue
FileAppend , Background\Capture8.png,%A_MyDocuments%\IDTE_Data\BG.cfg,
if Theme= OpenSuse Colors
FileAppend , Background\Capture9.png,%A_MyDocuments%\IDTE_Data\BG.cfg,
if Theme= Ubuntu Colors
FileAppend , Background\Capture10.png,%A_MyDocuments%\IDTE_Data\BG.cfg,
if Theme=
{
FileAppend , Background\Capture1.png, %A_MyDocuments%\IDTE_Data\BG.cfg,
ExitApp
}
MsgBox , 64, Theme Set, Restart Application To View Changes 

ChangeGuiClose:
Gui, Change:destroy
return