;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : Configure.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================
;#NoTrayIcon
IfNotExist , %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini
{
    FileCopy , %A_WorkingDir%\Bin\IDTE_Configuration.ini, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini, UseErrorLevel
if Errorlevel	
	{
		MsgBox, 52, Crash Report, IDTE is unable to launch its configuration settings.`nDetails- Fatal Error :  Configuration File deleted or removed.`nError Code - 0x0000007F `nDo you want to recover configuration and report this error to IDTE Developers ?
        IfMsgBox ,No
				ExitApp
        IfMsgBox , Yes
				Progress , , Recovering Configuration, Please Wait...., IDTE Recovery Manager
				Progress , 50
				FileCopy , %A_WorkingDir%\Bin\%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini, UseErrorLevel
				RunWait , http://sourceforge.net/p/idteid3tagedito/discussion/general/
				Progress , 100
				if Errorlevel 
					{
						Progress , off
						MsgBox , 64, Unable To Recover Configuration
					}
				Exitapp
	}
}
IfNotExist , %A_MyDocuments%\IDTE_Data
    FileCreateDir , %A_MyDocuments%\IDTE_Data
IniRead , checker1 , %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini, Album_Art, Enable_AlbumArt
IniRead , checker2 , %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini, Album_Art, Player_Art
IniRead , checker3 , %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini, Album_Art, Show_Tme
IniRead , checker4 , %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini, List, Clear_List_Files
IniRead , checker5 , %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini, List, Clear_List_Folder
IniRead , checker6 , %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini, Internet, Allow_Internet
IniRead , checker64 , %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini, Start, Prompt
IniRead , Defalt_Dir , %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini, Start, Folder_Start
IniRead , checker7 , %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini, UI, Enable_Welcome_Note
IniRead , checker8 , %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini, UI, Enable_Drag
IniRead , checker9 , %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini, UI, Auto_Adjust
IniRead , checker10 , %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini, UI, Enable_Admin
IniRead , checker51, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tag, Enable_Tag_Edit1
IniRead , checker52, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tag, Enable_Tag_Edit2
IniRead , checker53, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tag, Enable_Tag_Edit12

IniRead , checker54, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tag, Enable_Flac
IniRead , checker55, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,ID3, Enable_Tag_Force1
IniRead , checker56, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,ID3, Enable_Tag_Force2
IniRead , checker57, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,ID3, Enable_Tag_Force12

IniRead , checker58, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Player, Mplayer1
IniRead , checker59, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Player, Mplayer2

IniRead , checker60, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Remove, Tag_RemovAPE
IniRead , checker61, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Remove, Tag_Remov1
IniRead , checker62, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Remove, Tag_Remov2
IniRead , lst_fontSize, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,List_Font, List_FontSize
IniRead , lst_font, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,List_Font, List_Font
IniRead , lst_Col, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,List_Font, List_Col
IniRead , Checker14, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,List_Font, List_Bold
IniRead , Checker15, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,List_Font, List_Italic
IniRead , Checker16, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,List_Font, List_Underline

IniRead , Tg_fontSize, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tag_Panel, Tag_FontSize
IniRead , Tg_font, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tag_Panel, Tag_Font
IniRead , Tg_Col, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tag_Panel, Tag_Colour
IniRead , Checker20, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tag_Panel, Tag_Bold
IniRead , Checker21, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tag_Panel, Tag_Italic
IniRead , Checker22, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tag_Panel, Tag_Underline

IniRead , buttn_font,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Toaster, Tost_Font
IniRead , TitleSize, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Toaster, Title_Size
IniRead , MsgSize, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Toaster, Message_Size
IniRead , Msgfont, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Toaster, Message_Font
IniRead , BGCol, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Toaster, Message_Col
IniRead , Checker24, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Toaster, Tost_Bold
IniRead , Checker25, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Toaster, Tost_Italic
IniRead , checker71, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Miscellaneous, Batch_Edit
IniRead , checker27, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Miscellaneous, Allow_Movement
IniRead , checker28, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Miscellaneous, Enable_Toaster
IniRead , checker29, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Miscellaneous, Enable_Grid
IniRead , checker31, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Prompt, Prompt_Passwd_Edit
IniRead , checker30, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Prompt, Prompt_Passwd_Start
IniRead , checker32, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Prompt, Passwd_Protect
IniRead , checker69, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Visual, Enable_BT
IniRead , checker70, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Visual, Enable_V
IniRead , checker33, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Default_Scheme, Enable_Scheme
IniRead , Defalt_Schm, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Default_Scheme, Scheme_Defaults

IniRead , checker35, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tray_Not, Tray_Not_ply
IniRead , checker36, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tray_Not, Tray_Not_stp
IniRead , checker37, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tray_Not, Tray_Not_Fwd
IniRead , checker38, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tray_Not, Tray_Not_Rev
IniRead , checker39, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tray_Not, Tray_Not_pus
IniRead , checker40, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tray_Not, Tray_Not_Sett
IniRead , checker41, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tray_Not, Tray_Not_Sucess
IniRead , Tray_Time, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tray_Not, Tray_Time
IniRead , Tost_Time, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tost_Not, Tost_Time

IniRead , checker43, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tost_Not, Tost_Not_ply
IniRead , checker44, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tost_Not, Tost_Not_stp
IniRead , checker45, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tost_Not, Tost_Not_Fwd
IniRead , checker46, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tost_Not, Tost_Not_Rev
IniRead , checker47, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tost_Not, Tost_Not_pus
IniRead , checker48, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tost_Not, Tost_Not_Sett
IniRead , checker49, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tost_Not, Tost_Not_Sucess
IniRead , GUI_Select, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,GUI, GUI_Select
IniRead , checker76 , %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini, List, Clear_List_Start
Loop , 76
{
	if(Checker%A_Index% = 1)
		Checker%A_Index% = Checked
}

#Include Notify.ahk
Gui, Add, Button, x16 y320 w100 h26 , &OK
Gui, Add, Button, x519 y318 w100 h26 , &Cancel
Gui, Add, Tab2, x12 y10 w610 h300 , General|Appearance|Themes|Other Settings|Notifications|Advance
Gui, Add, GroupBox, x19 y37 w281 h265 , General settings
Gui, Add, GroupBox, x305 y37 w302 h110 , Miscellaneous
Gui, Add, GroupBox, x302 y150 w300 h150 , Password Protect
Gui, Add, CheckBox, x32 y60 w200 h20 vClear_List_Start %checker76%, Clear list on startup
Gui, Add, CheckBox, x32 y80 w200 h20 vEnable_AlbumArt %checker1%, Enable Startup Tips
Gui, Add, CheckBox, x32 y100 w230 h20 vPlayer_Art %checker2%, Automatically check for updates on startup
Gui, Add, CheckBox, x32 y120 w220 h20 vShow_Tme %checker3%, Add IDTE entry in "Send to" menu
Gui, Add, CheckBox, x32 y140 w230 h20 vClear_List_Files %checker4%, Clear List Every Time I Add New File(s) 
Gui, Add, CheckBox, x32 y160 w230 h20 vClear_List_Folder %checker5%, Clear List Every Time I Add New Folder
Gui, Add, CheckBox, x32 y180 w230 h20 vAllow_Internet %checker6%, Allow IDTE To Connect To Internet
Gui, Add, Checkbox, x32 y200 w230 h20 vPrompt %checker64%, Never Prompt on Exit
Gui, Add, Text, x26 y280 w260 h20 , A Restart is recommended for Changes to Apply
Gui, Add, Edit, x32 y240 w260 h20 vFolder_To_Start, %Defalt_Dir%
Gui, Add, Button, x203 y260 w90 h20 , Browse
Gui, Add, Text, x32 y220 w170 h20 , Default Folder To Start From :
Gui, Add, CheckBox, x322 y60 w220 h20 vEnable_Welcome_Note %checker7%, Enable Welcome Note
Gui, Add, CheckBox, x322 y80 w210 h20 vEnable_Drag %checker8%, Enable Splash Screen
Gui, Add, CheckBox, x322 y100 w230 h20 vAuto_Adjust %checker9%, Auto Adjust Coloumns
Gui, Add, CheckBox, x322 y120 w200 h20 vEnable_Admin %checker10%, Enable Admin Privilages
Gui, Add, Button, x550 y120 w40 h20 , Why?
Gui, Add, Text, x312 y180 w50 h20 , Password
Gui, Add, Text, x312 y220 w50 h30 , Confirm Password
Gui, Add, Edit, x372 y180 w210 h20 Password  vpsswd, 
Gui, Add, Edit, x372 y230 w210 h20 Password vcnfpsswd, 
Gui, Add, Button, x462 y270 w120 h20 , &Set Password

Loop, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts, 0 ,0 ; For Fonts Availability in System
{
	StringGetPos, tempPos, A_LoopRegname, (
		If tempPos > 2
			StringLeft, LoopRegname, A_LoopRegname, % tempPos-1
		Else
			LoopRegname = %LoopRegname%
				AllFonts = %LoopRegname%|%AllFonts%
}



Gui, Tab, Appearance
{
Gui, Add, GroupBox, x15 y45 w170 h230 , List View
Gui, Add, GroupBox, x192 y45 w180 h230 , Tag Panel
Gui, Add, Text, x15 y275 w300 , You Can Specify The Field By Yourself `nExample --> Colour = Gray or 0x808080 
Gui, Add, GroupBox, x384 y35 w224 h260 , Toaster
Gui, Add, Text, x22 y60 w150 h20 , Font Name 
Gui, Add, Text, x22 y110 w150 h20 , Font Size
Gui, Add, Text, x22 y160 w150 h20 , Font Colour 
Gui, Add, CheckBox, x22 y210 w120 h20 vList_Bold %checker14%, Bold
Gui, Add, CheckBox, x22 y230 w100 h20 vList_Italic %checker15% , Italic
Gui, Add, CheckBox, x22 y250 w80 h20 vList_Underline %checker16%, underline
Gui, Add, ComboBox, x22 y80 w150  vlist_Font ,%AllFonts%|%lst_font%||
Gui, Add, Combobox, x22 y130 w150  vlist_FontSize, 8|9|10|11|12|14|16|18|20|24|36|48|%lst_fontSize%||
Gui, Add, Combobox, x22 y180 w150  vlist_Col,  Black|Blue|Red|White|Silver|Gray|Maroon|Purple|Fuchsia|Green|Lime|Olive|Yellow|Navy|Teal|Aqua|%lst_Col%||

Gui, Add, CheckBox, x212 y250 w80 h20 vTag_Underline %checker22%, Underline
Gui, Add, CheckBox, x212 y230 w100 h20 vTag_Italic %checker21%, Italic
Gui, Add, CheckBox, x212 y210 w120 h20 vTag_Bold %checker20%, Bold
Gui, Add, Text, x212 y60 w150 h20 , Font Name
Gui, Add, Combobox, x212 y80 w150  vTag_Font, %AllFonts%|%Tg_font%||
Gui, Add, Text, x212 y110 w150 h20 , Font Size
Gui, Add, Combobox, x212 y130 w150 vTag_FontSize, 8|9|10|11|12|14|16|18|20|24|36|48|%Tg_fontSize%||
Gui, Add, Text, x212 y160 w150 h20 , Font Colour
Gui, Add, Combobox, x212 y180 w150 vTag_Col,  Black|Blue|Red|White|Silver|Gray|Maroon|Purple|Fuchsia|Green|Lime|Olive|Yellow|Navy|Teal|Aqua|%Tg_Col%||

Gui, Add, Text, x393 y50 w200 h20 , Title Font 
Gui, Add, Combobox, x412 y70 w150 vTost_Font,%AllFonts% |%buttn_font%||
Gui, Add, CheckBox, x412 y90 w160 h20 vTost_Bold %checker24%, Bold (Not Implemented)
Gui, Add, CheckBox, x412 y110 w160 h20 vTost_Italic %checker25%, Italic (Not Implemented)
Gui, Add, Text, x393 y130 w200 h20 , Message Fonts 
Gui, Add, Text, x392 y170 w200 h20 , Toaster Message Size 
Gui, Add, Text, x393 y210 w200 h20 , BackGround Colour
Gui, Add, Combobox, x400 y150 w200 vMessage_Font, %AllFonts%|%Msgfont%||
Gui, Add, ComboBox, x400 y190 w200 vMessage_Size , 8|9|10|11|12|14|16|18|20|24|36|48|%MsgSize%||
Gui, Add, ComboBox, x400 y230 w200 vMessage_Col , Black|Blue|Red|White|Silver|Gray|Maroon|Purple|Fuchsia|Green|Lime|Olive|Yellow|Navy|Teal|Aqua|%BGCol%||
Gui, Add, Text, x393 y250 w200 h20 , Title Size 
Gui, Add, ComboBox, x400 y270 w200  vTitle_Size, 8|9|10|11|12|14|16|18|20|24|36|48|%TitleSize%||
}
Gui, Tab , Themes
{
Gui, Add, GroupBox, x52 y50 w530 h240 , Select Interface
Gui, Add, Picture, x92 y70 w175 h92 , %A_WorkingDir%\GUI\GUI2.jpg
Gui, Add, Picture, x350 y70 w170 h87 , %A_WorkingDir%\GUI\GUI3.jpg
Gui, Add, Text, x92 y170 w170 h90 , Professional :`n`nA Very Simple and clean tagging environment. 
Gui, Add, Button, x120 y260 w120 h20 , &Apply Professional
Gui, Add, Text, x350 y170 w170 h90 , Rigid :`n`nAllows Wide list view for tag editing with very detailed Song preview. 
Gui, Add, Button, x390 y260 w100 h20 , &Apply  Rigid
}

Gui, Tab, Other Settings
{
Gui, Add, GroupBox, x32 y40 w240 h250 , Miscellaneous
Gui, Add, GroupBox, x292 y50 w290 h240 , Scheme And NFO Layout
Gui, Add, CheckBox, x42 y60 w220 h20 vBatch_Enable %checker71%, Enable Batch Track Autonumbering
Gui, Add, CheckBox, x42 y80 w220 h20 vAllow_Movement %checker27%, Allow Fullscreen Interface
Gui, Add, CheckBox, x42 y100 w190 h20 vEnable_Toaster %checker28%, Enable Toaster Popups
Gui, Add, CheckBox, x42 y170 w220 h20 vPrompt_Passwd_Edit %checker30%, Prompt For Password On Startup
Gui, Add, CheckBox, x42 y140 w220 h30 vPrompt_Passwd_Start %checker31%, Prompt For Password on Editing/Modifying Tags
Gui, Add, CheckBox, x42 y190 w220 h30 vPasswd_Protect %checker32%, Enable Password Protection For File Conversion
Gui, Add, CheckBox, x42 y120 w210 h20 vEnable_Grid %checker29%, Enable Grid in List View
Gui, Add, CheckBox, x42 y220 w210  vEnable_BT %checker69%, Enable Beat Toggler
Gui, Add, CheckBox, x42 y240 w210  vEnable_V %checker70%, Enable Visualisation
Gui, Add, text, x42 y260 , *A Restart/Refresh is Recommended
Gui, Add, CheckBox, x302 y70 w250 h20 vEnable_Scheme %checker33%, Enable Default Scheme
Gui, Add, Edit, x302 y90 w270 h20 vScheme_Defaults, %Defalt_Schm%
Gui, Add, Text, x302 y110 w220 h150 , `nReference :-`nArtist = `%Artist`%`nAlbum = `%Album`%`nTrack No. = `%Track`%`nTitle = `%Title`%`nComment = `%Comment`%`nComposer = `%Composer`%`nGenre = `%Genre`% `nFilename = `%Filename`% `nDirectory = \
Gui, Add, Button, x302 y260 w70 h20 , &Show More
}


Gui, Tab,Notification
{
Gui, Add, GroupBox, x42 y50 w240 h230 , Tray Notifications
Gui, Add, GroupBox, x302 y50 w290 h230 , Toaster Popups
Gui, Add, CheckBox, x52 y80 w200 h20 vTray_Not_ply %checker35%, Notify On Playing tracks
Gui, Add, CheckBox, x52 y100 w200 h20 vTray_Not_Stp %checker36%, Notify On Stopping tracks
Gui, Add, CheckBox, x52 y120 w200 h20 vTray_Not_Fwd %checker37%, Notify On Forwarding Tracks
Gui, Add, CheckBox, x52 y140 w200 h20 vTray_Not_Rev %checker38%, Notify On Reversing tracks
Gui, Add, CheckBox, x52 y160 w200 h20 vTray_Not_Pus %checker39%, Notify On Pausing Tracks
Gui, Add, CheckBox, x52 y180 w200 h20 vTray_Not_Sett %checker40%, Notify On Errors
Gui, Add, CheckBox, x52 y200 w160 h20 vTray_Not_Sucess %checker41%, Notify On Sucessful Editing
Gui,Add , Text, x52 y223 w110 h20, Tray timeout (In Sec)
Gui, Add, Edit, x160 y223 w30 vTray_Time , %Tray_Time%
Gui, Add, CheckBox, x312 y80 w200 h20 vTost_Not_ply %checker43%, *Notify On Playing tracks
Gui, Add, CheckBox, x312 y100 w200 h20 vTost_Not_Stp %checker44%, *Notify On Stopping tracks
Gui, Add, CheckBox, x312 y120 w200 h20 vTost_Not_Fwd %checker45%, *Notify On Forwarding Tracks
Gui, Add, CheckBox, x312 y140 w200 h20 vTost_Not_Rev %checker46%, *Notify On Reversing tracks
Gui, Add, CheckBox, x312 y160 w200 h20 vTost_Not_Pus %checker47%, *Notify On Pausing Tracks
Gui, Add, CheckBox, x312 y180 w200 h20 vTost_Not_Sett %checker48%, *Notify On Errors
Gui, Add, CheckBox, x312 y200 w160 h20 vTost_Not_Sucess %checker49%, *Notify On Sucessful Editing
Gui,Add , Text, x312 y223 w140 h20, Toaster timeout (In Sec)
Gui, Add, Edit, x450 y223 w30  vTost_Time, %Tost_Time%
Gui, Add, Button, x162 y250 w100 h20 , &Preview Tray
Gui, Add, Text , x52 y280 w240 , Note - Holding Key Might Be Less Responsive (Due To Regular Toaster popups)
Gui, Add, Text , x310 y280 w240  , *Toaster Must Be Enabled on 'Other Settings' Tab
Gui, Add, Button, x482 y250 w100 h20 , &Preview Toast
}

Gui,Tab ,Advance
{
Gui, Add, Text, x42 y40   ,Note - A Restart is Required For Changes To Be Apply	
Gui, Add, GroupBox, x32 y60 w240 h120 , Editing ID3 Tags
Gui, Add, Radio, x42 y80 w210 h20 vEnable_Tag_Edit1 %checker51%, Save ID3v1 Tags Only
Gui, Add, Radio, x42 y100 w150 h20 vEnable_Tag_Edit2 %checker52%, Save ID3v2 Tags only
Gui, Add, Radio, x42 y120 w200 h20 vEnable_Tag_Edit12 %checker53%, Save Both ID3v1 And ID3v2 Tags
Gui, Add, CheckBox, x42 y145 w225  vEnable_Flac %checker54%, Prefer Reading ID3v2 Tags over ID3v1 Tags in MP3 files.

Gui, Add, GroupBox, x32 y180 w240 h90 , Forcing Tags
Gui, Add, Radio, x42 y195 w190 h30 vEnable_Tag_Force1 %checker55%, Force ID3v2 Tag Only
Gui, Add, Radio, x42 y225 w220 h20 vEnable_Tag_Force2 %checker56%, Force ID3v1 Tag only
Gui, Add, Radio, x42 y245 w210 h20 vEnable_Tag_Force12 %checker57%, Don't Force
Gui, Add, GroupBox, x282 y60 w300 h110 , Music Player options
Gui, Add, Radio, x292 y80 w270 h40 vMplayer1 %checker58%, Use Embeded Music Player of IDTE (Uses Bass library for Playback)
Gui, Add, Radio, x292 y120 w280 h30 vMplayer2 %checker59%, Use My default Media player Instead (Do not Recommended For linux Users)
Gui, Add, GroupBox, x282 y175 w300 h90 , Tags Removal
Gui, Add, Checkbox, x286 y190 w190 h30 vTag_RemovAPE %checker60%, Enable APEv2 Removal
Gui, Add, Checkbox, x286 y220 w220 h20 vTag_Remov1 %checker61%, Enable ID3v1 Removal
Gui, Add, Checkbox, x286 y240 w220 h20 vTag_Remov2 %checker62%, Enable ID3v2 Removal
Gui, Add, Text, x292 y265 w310 h37 ,*Some Formats Such as M4A,WAV etc Do Not Support ID3 Tags Therefore Forcing ID3 Might Leads To Unappropriate Behaviour of Your Music Files
Gui, Add, Text, x42 y280 w220 h27 ,Caution - Do Not Mess With Advance Settings Unless You Know About Tags
Gui, Show, w637 h357, Configure IDTE-ID3 Tag Editior
}
IID_ITaskbarList  := "{56FDF342-FD6D-11d0-958A-006097C9A090}"
CLSID_TaskbarList := "{56FDF344-FD6D-11d0-958A-006097C9A090}"

; Create the TaskbarList object and store its address in tbl.
tbl := ComObjCreate(CLSID_TaskbarList, IID_ITaskbarList)

activeHwnd := WinExist("A")

DllCall(vtable(tbl,3), "ptr", tbl)                     ; tbl.HrInit()
DllCall(vtable(tbl,5), "ptr", tbl, "ptr", activeHwnd)  ; tbl.DeleteTab(activeHwnd)

vtable(ptr, n) {
    ; NumGet(ptr+0) returns the address of the object's virtual function
    ; table (vtable for short). The remainder of the expression retrieves
    ; the address of the nth function's address from the vtable.
    return NumGet(NumGet(ptr+0), n*A_PtrSize)
}
return

;-------------------------------------------------------------------END OF GUI-----------------------------------------------------------------------------------------------------;
ButtonWhy?:
	MsgBox , 64 , Information ,`n Why Do I Allow Admin Rights ? `n1. If The IDTE is Unable to Tag Your Music Files. `n2. If IDTE is Unable to Read Your Folder `n3. If IDTE is Unable To Enter in Your Windows Directory `n4. If The IDTE is Unable to Show CoverArt Of Music Files`n5. If The IDTE is Unable to Save Its Previous Data `nQ - Is It Necessary ? `n No , In Case Your Software is Running Well 
return

ButtonApplyProfessional:
	GUI_Select=2
	MsgBox ,64 ,Theme Set, Theme Sucessfully Applied , Restart  to View Changes  
return

ButtonApplyRigid:
GUI_Select=0
MsgBox ,64 ,Theme Set, Theme Sucessfully Applied , Restart to View Changes 
return

ButtonShowMore:
MsgBox ,64, Information,Tokens are used whenever you want to change the filename conversion Rules`n----------------------------------`nTokens :-`nArtist = `%Artist`%`nAlbum = `%Album`%`nTrack No. = `%Track`%`nTitle = `%Title`%`nComment = `%Comment`%`nComposer = `%Composer`%`nGenre = `%Genre`% `nFilename = `%Filename`% `nDirectory = \`n----------------------------------`nE.g. Using Token `%Artist`%\`%Album`%\`%Track`%-`%Title`% `nwe have output => Linkin Park\Recharged\01-Light that Never Comes.mp3`n----------------------------------`nWhere:-`nArtist = Linkin Park`nAlbum = Recharged`nTrack No. = 01`nTitle = Light that Never Comes`n
return

ButtonPreviewTray:
TrayTip , Preview , This is A Preview , , 1
return

ButtonPreviewToast:

IniRead , Time_pop, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tost_Not,Tost_Time 
IniRead , MsgFont, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Toaster, Message_Font
IniRead , MsgSize, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Toaster,Message_Size
IniRead , BGCol, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Toaster,Message_Col
IniRead , TitleSize, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Toaster,Tost_Time 
IniRead , buttn_font, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Toaster,Tost_Font 
IniRead ,checker7 ,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini, UI,Enable_Welcome_Note

Options = TS=12 TM=8 TF=Times New Roman Image=IDTE.ico SI=400 SO=300 IW=50 IH=50 MF=%MsgFont% MS=%MsgSize% GC=%BGCol% TS=%TitleSize% TF=%buttn_font% GF=2 GL=3
NotifyID:= Notify("IDTE-ID3 Tag Editor", "This is a Preview",Time_pop ,Options)

return
	

ButtonOK:

IfExist , %Windir%\psswd.dat
{
FileRead , Prev_passwrd , %Windir%\psswd.dat
InputBox , Confirm_prev , Enter Password, Enter Password To Proceed, HIDE, 200 , 150
if(Confirm_prev!=Prev_passwrd)
{
MsgBox , 16, Error , Unable To Change Settings Due To Invalid Password 
return
}
}

FileDelete ,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini
gui , submit , NoHide

if list_Font=
list_Font=%lst_font% 
if list_FontSize=
list_FontSize=%lst_FontSize%
if List_Col=
list_Col=%lst_Col%
if Tag_Font=
	Tag_Font=%tg_font%
if Tag_FontSize=
	tag_FontSize=%tg_fontSize%
if Tag_Col=
	tag_Col=%tg_Col%
if Tost_Font=
	Tost_Font=%buttn_font%
if Message_Font=
	Message_Font=%msgfont%
if Message_Size=
	Message_Size=%msgSize%
if Message_Col=
	Message_Col=%BGCol%
if Title_Size=
	Title_Size=%titleSize%

if (Show_Tme=1)
FileCreateShortcut ,%A_WorkingDir%\IDTE.exe ,%A_AppData%\Microsoft\Windows\SendTo\IDTE - It's Different Tag Editor.lnk
else
	FileDelete , %A_AppData%\Microsoft\Windows\SendTo\IDTE - It's Different Tag Editor.lnk

FileAppend ,[Album_Art]`nEnable_AlbumArt=%Enable_AlbumArt%`nPlayer_Art=%Player_Art%`nShow_Tme=%Show_Tme%`n[List]`nClear_List_Files=%Clear_List_Files%`nClear_List_Folder=%Clear_List_Folder%`nClear_List_Start=%Clear_List_Start%`n[Internet]`nAllow_Internet=%Allow_Internet%`n[UI]`nEnable_Welcome_Note=%Enable_Welcome_Note%`nEnable_Drag=%Enable_Drag%`nAuto_Adjust=%Auto_Adjust%`nEnable_Admin=%Enable_Admin%`n[List_Font]`nList_Font=%List_Font%`nList_FontSize=%List_FontSize%`nList_Col=%List_Col%`nList_Bold=%List_Bold%`nList_Italic=%List_Italic%`nList_Underline=%List_Underline%`n[Tag_Panel]`nTag_Font=%Tag_Font%`nTag_FontSize=%Tag_FontSize%`nTag_Colour=%Tag_Col%`nTag_Bold=%Tag_Bold%`nTag_Italic=%Tag_Italic%`nTag_Underline=%Tag_Underline%`n[Toaster]`nTost_Font=%Tost_Font%`nTost_Bold=%Tost_Bold%`nTost_Italic=%Tost_Italic%`nMessage_Font=%Message_Font%`nMessage_Size=%Message_Size%`nMessage_Col=%Message_Col%`nTitle_Size=%Title_Size%`n[GUI]`nGUI_Select=%GUI_Select%`n[Miscellaneous]`nBatch_Edit=%Batch_Enable%`nAllow_Movement=%Allow_Movement%`nEnable_Toaster=%Enable_Toaster%`nEnable_Grid=%Enable_Grid%`n[Prompt]`nPrompt_Passwd_Edit=%Prompt_Passwd_Edit%`nPrompt_Passwd_Start=%Prompt_Passwd_Start%`nPasswd_Protect=%Passwd_Protect%`n[Default_Scheme]`nEnable_Scheme=%Enable_Scheme%`nScheme_Defaults=%Scheme_Defaults%`n[Tray_Not]`nTray_Not_ply=%Tray_Not_ply%`nTray_Not_Stp=%Tray_Not_Stp%`nTray_Not_Fwd=%Tray_Not_Fwd%`nTray_Not_Rev=%Tray_Not_Rev%`nTray_Not_Pus=%Tray_Not_Pus%`nTray_Not_Sett=%Tray_Not_Sett%`nTray_Not_Sucess=%Tray_Not_Sucess%`nTray_Time=%Tray_Time%`n[Tost_Not]`nTost_Not_ply=%Tost_Not_ply%`nTost_Not_Stp=%Tost_Not_Stp%`nTost_Not_Fwd=%Tost_Not_Fwd%`nTost_Not_Rev=%Tost_Not_Rev%`nTost_Not_Pus=%Tost_Not_Pus%`nTost_Not_Sett=%Tost_Not_Sett%`nTost_Not_Sucess=%Tost_Not_Sucess%`nTost_Time=%Tost_Time%`n[Tag]`nEnable_Tag_Edit1=%Enable_Tag_Edit1%`nEnable_Tag_Edit2=%Enable_Tag_Edit2%`nEnable_Tag_Edit12=%Enable_Tag_Edit12%`nEnable_Flac=%Enable_Flac%`n[ID3]`nEnable_Tag_Force1=%Enable_Tag_Force1%`nEnable_Tag_Force2=%Enable_Tag_Force2%`nEnable_Tag_Force12=%Enable_Tag_Force12%`n[Player]`nMplayer1=%Mplayer1%`nMplayer2=%Mplayer2%`n[Remove]`nTag_RemovAPE=%Tag_RemovAPE%`nTag_Remov1=%Tag_Remov1%`nTag_Remov2=%Tag_Remov2%`n[Start]`nFolder_Start=%Folder_to_Start%`nPrompt=%Prompt%`n[Visual]`nEnable_BT=%Enable_BT%`nEnable_V=%Enable_V%`n , %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini
ButtonCancel:
GuiClose:
DllCall(vtable(tbl,4), "ptr", tbl, "ptr", activeHwnd)  ; tbl.AddTab(activeHwnd)

; Non-dispatch objects must always be manually freed.
ObjRelease(tbl)
ExitApp

ButtonSetPassword:
IfExist , %Windir%\psswd.dat
{
FileRead , Prev_passwrd , %Windir%\psswd.dat
InputBox , Confirm_prev , Previous Password , Enter Previous Password , HIDE, 200 , 150
if(Confirm_prev!=Prev_passwrd)
{
MsgBox , 16, Error , Unable To Set Password - Invalid Password 
return
}
}
gui ,submit, NoHide
psswod := psswd 
StringLen, count_char, psswod
if (count_char<8)
{
	MsgBox ,64, Low Characters,Password Must be Atleast of Eight Character
return	
}
if (psswd = cnfpsswd)
{
ifexist , %Windir%\psswd.dat 
FileDelete , %Windir%\psswd.dat 
if Errorlevel
{
MsgBox , 16,Error, Unable To Set Password (Login in Admin Mode)
return
}
FileAppend , %psswd% , %Windir%\psswd.dat
if Errorlevel
{
MsgBox , 16,error ,Unable To Set Password (Login in Admin Mode)
return
}
MsgBox , 64, Password Set, Password Sucessfully Applied To IDTE `nCheck Out 'Other Settings' Tab For Password Prompts  
return
}
else
{
	MsgBox , 16, Error, Wrong Password (Password Do Not Match)
	return
}
ButtonBrowse:
FileSelectFolder , Folder_Start , , Select Folder , Select Default Folder To Start With
if Folder_Start=
	return
else
  GuiControl , ,Folder_to_Start , %Folder_Start% 
return
