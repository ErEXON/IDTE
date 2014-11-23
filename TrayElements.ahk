;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : TrayElement.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================

#Persistent
Menu , tray , Tip , IDTE - It's different tag editor
Menu , tray , Mainwindow 
Menu, tray, NoStandard
menu, tray, add, Restore, Res_IDTE 
menu, tray, add, Play Again , trayplay
menu, tray, add, Pause , pause
menu, tray, add, Play/Resume, PlayBass
menu, tray, add, Forward 2 Percent , fwd
menu, tray, add, Reverse 2 Percent ,rev
menu, tray, add, Next Track , BassNext
menu, tray, add, Previous Track ,BassPrev
menu, tray, add ; separator
menu, tray, add, Add File(s) , OpenFile
menu, tray, add, Add Folder ,OpenFolder
menu, tray, add ; separator
menu, tray, add, About IDTE , AApp
menu, tray, add, Exit , GuiClose
