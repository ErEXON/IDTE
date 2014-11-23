;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : AboutMenu.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================

;_______________________________________________________________________________HELP TAB___________________________________________________________________________________________;

AHK:
	run , www.autohotkey.com
return

ATIT:
	run , http://www.autoitscript.com/site/autoit/
return

SF:
	run , www.sourceforge.com
return

Update:
	IniRead , checker6,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Internet,Allow_Internet
	if (checker6=1)
		{
			RunWait ,  %A_WorkingDir%\Bin\Updater.exe --ud
		}
	else
		{
			Gui,+OwnDialogs
			MsgBox , 16 , Unable To Connect , Internet Access is Not Allowed to IDTE
		}
return

FAQ:
	Run , %A_WorkingDir%\Help Manual\FAQs.txt
return

ContextAAP:
AApp:
	goto , AboutIDTE
return

ContextHelp:
HelpTopics:
	Run ,%A_WorkingDir%\Help Manual\Help.html
return

ContextConsole:
WCLP:
	run, %WinDir%\system32\cmd.exe
	WinWaitActive , %WinDir%\system32\cmd.exe
	IfWinExist , %WinDir%\system32\cmd.exe
		{
			Send , cd{space}Bin{Enter}
			sleep , 200
			Send , IDTE{Enter}
		}
return

RevIDTE:
	run , http://sourceforge.net/projects/idteid3tagedito/reviews/
return