;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : GUI1.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================
FileEncoding , UTF-16
if GUISELECT=1
{
margin :=1
IniRead ,tg_Font,%A_MyDocuments%\IDTE_Configuration.ini,Tag_Panel,Tag_Font
IniRead ,tg_FontSize,%A_MyDocuments%\IDTE_Configuration.ini,Tag_Panel,Tag_FontSize
IniRead ,tg_Col,%A_MyDocuments%\IDTE_Configuration.ini,Tag_Panel,Tag_Col
IniRead ,Checker20,%A_MyDocuments%\IDTE_Configuration.ini,Tag_Panel,Tag_Bold
IniRead ,Checker21,%A_MyDocuments%\IDTE_Configuration.ini,Tag_Panel,Tag_Italic
IniRead ,Checker22,%A_MyDocuments%\IDTE_Configuration.ini,Tag_Panel,Tag_Underline
IniRead ,lst_Font,%A_MyDocuments%\IDTE_Configuration.ini,List_Font,List_Font
IniRead ,lst_FontSize,%A_MyDocuments%\IDTE_Configuration.ini,List_Font,List_FontSize
IniRead ,lst_Col,%A_MyDocuments%\IDTE_Configuration.ini,List_Font,List_Col
IniRead ,Checker14,%A_MyDocuments%\IDTE_Configuration.ini,List_Font,List_Bold
IniRead ,Checker15,%A_MyDocuments%\IDTE_Configuration.ini,List_Font,List_Italic
IniRead ,Checker16,%A_MyDocuments%\IDTE_Configuration.ini,List_Font,List_Underline
IniRead ,Is_Grid,%A_MyDocuments%\IDTE_Configuration.ini,Miscellaneous,Enable_Grid
FileRead , BackGround , %A_MyDocuments%\IDTE_Data\BG.cfg
Gui, Add, Picture, x310 y650 w763 h80 vBottomMost, %A_WorkingDir%\GUI\%BackGround%
Gui, Add, Picture, x0 y0 w313 h699 , %A_WorkingDir%\GUI\%BackGround% ; Set Picture As A Background
Gui, Add, Picture, x300 y0 w762 h26 vTopMost, %A_WorkingDir%\GUI\%BackGround%
Gui, Add, Picture, x1052 y0 w410 h699 vRightMost, %A_WorkingDir%\GUI\%BackGround% ; Sets Font to WST_ENG1 
Gui, Color ,white
Gui, Font, s8 cblack bold , Arial
if(Checker21=1)
Gui, Font, italic
if(Checker22=1)
Gui, Font, underline
Gui, Add, Text, x22 y20 w80 h20 +Center Border, Artist
Gui, Add, Text, x22 y80 w80 h20 +Center Border, Title
Gui, Add, Text, x22 y140 w80 h20 +Center Border, Album
Gui, Add, Text, x22 y200 w80 h20 +Center Border, Genre
Gui, Add, Text, x22 y260 w80 h20 +Center Border,Track No.
Gui, Add, Text, x22 y320 w80 h20 +Center Border, Year
Gui, Add, Text, x22 y380 w80 h20 +Center Border, Comments
Gui, Add, Text, x22 y440 w80 h20 +Center Border, Composer
Gui, Add, Text, x22 y500 w80 h20 +Center Border, Publisher
Gui, Add, Text, x22 y560 w200 h20 +Center Border, Band/Orchestra/Accompaniment
Gui, Add, Text, x22 y650 w270 h20 +Center Border,
Gui, Add, Edit, x22 y50 w270 h20 vArtist,Artist
Gui, Add, Edit, x22 y110 w270 h20 vTitle, Title
Gui, Add, Edit, x22 y170 w270 h20 vAlbum, Album
Gui, Add, Edit, x22 y230 w270 h20 vGenre,  Genre
Gui, Add, Edit, x22 y290 w270 h20 vTrack,   Track
Gui, Add, Edit, x22 y350 w270 h20 vYear,  Year
Gui, Add, Edit, x22 y410 w270 h20 vComments, Add Comments
Gui, Add, Edit, x22 y470 w270 h20 vComposer,Composer
Gui, Add, Edit, x22 y530 w270 h20 vpublisher, publisher
Gui, Add, Edit, x22 y590 w270 h20 vBand, Band/Orchestra/Album Artist
Gui , Add, Edit, x1070  y210 w290 h130 vLRC, Lyrics 
Gui , Add, Button,x1270 y350, Done
Gui,Add,Button, x1165 y350 vfa,Fetch Cover Art
Gui , Add, Button,x1090 y350, Fetch
Gui,Add,Button, x1135 y350 w20 vLRCOPT, >>
Gui, Add, GroupBox, x12 y2 w290 h630 +Center, Tag Panel - Customize Your Tags
;Gui, Add, GroupBox, x15 y505 w285 h165 +Center, ;Preview Music
Gui, Add, GroupBox, x1065 y5 w300 h170 +Center , Music ;Detailed Information
Gui, Add, GroupBox, x1065 y180 w300 h210 +Center , Lyrics ;Detailed Information
Gui, Add, GroupBox, x1065 y400 w300 h280 +Center , Album Art ;Detailed Information
;Gui, Font,  ,
;Gui, Font, S%lst_FontSize% C%lst_Col%, %lst_Font%
if(Checker14=1)
Gui, Font, Bold
if(Checker15=1)
Gui, Font, italic
if(Checker16=1)
Gui, Font, underline
Gui, Add, ListView, x312 y26 w740 h624 AltSubmit vMyListView gMyListView Grid LV0x20 LV0x10, |#|Title|Artist|Album|Year|Genre|Name|In Folder|Band\Orchestra|Publisher|Composer|Comment|Size(MB)|Type|Channels|Sample Rate(Hz)|Bit Rate(Kbps)|Duration
LV_ModifyCol(2,"Integer")
LV_ModifyCol(6,"Integer")
LV_ModifyCol(14,"Integer")
LV_ModifyCol(17,"Integer")
LV_ModifyCol(18,"Integer")
LV_ModifyCol(19,"Integer")
Gui, Font,
Gui, Font, S8 bold, Tahoma 
Gui, Add, Text, x22 y653 w60 h15 vInfo
Gui, Add, Text, x240 y653 w40 h15 vInfo2 +Right
Gui, Add, Pic,  x1070 y20 w100 h100 vMus_ico ,%A_WorkingDir%\GUI\music_icon.png
Gui ,Add, Text, x1175 y30 w180 h90 vClist , Currently No File Is Playing
MaxRange1 :=100
margin := 1 
Gui, Add, Progress,w0 h0 x0 y0 cgray BackgroundSilver vPrBar1  Range0-%MaxRange1%,
Gui, Add, Progress,  x1070 y155 w285 h10 c808080 BackgroundSilver vPrBar2 Range0-%MaxRange1%, 20
Gui, Add, Progress, AltSubmit w100 h13 x1255 y133 cBlack BackgroundSilver vPrBar3 Range0-%MaxRange1%, %Volume%
OnMessage(0x201, "WM_LBUTTONDOWN")  ; Monitors Left Clicks on Gui.
Loop , 3
GuiControlGet, PrBar%A_Index%, Pos
Gui ,font
Gui, Font, S10 , WST_Engl ; Sets Font to WST_ENG1 
LV_ModifyCol(1, "Integer") ; For sorting, indicate that the Size column is an integer.
LV_ModifyCol(9, "Integer") ; For sorting, indicate that the Size column is an integer.
; Create an ImageList so that the ListView can display some icons:
ImageListID1 := IL_Create(10)
ImageListID2 := IL_Create(10, 10, true)  ; A list of large icons to go with the small ones.

;__________________________________________________________________________________________________________________________________________________________________________________;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    GUI    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Gui, Font,
Gui,Add, Picture,  x1085 y430   ,%A_WorkingDir%\GUI\CDCASE.png
Gui, Add, Pic,x1111 y432 vPic gShowPic

Gui, Add, Progress, x215 y650 w5 h20 AltSubmit cBlack Backgroundwhite vertical vRIGHT, 
Gui, Add, Progress, x220 y655 w5 h15 AltSubmit cBlack Backgroundwhite vertical vRIGT, 
Gui, Add, Progress, x225 y660 w5 h10 AltSubmit cBlack Backgroundwhite vertical vRIT, 
Gui, Add, Progress, x210 y650 w5 h20 AltSubmit cBlack Backgroundwhite vertical vLEFT, 
Gui, Add, Progress, x205 y655 w5 h15 AltSubmit cBlack Backgroundwhite vertical vLET, 
Gui, Add, Progress, x200 y660 w5 h10 AltSubmit cBlack Backgroundwhite vertical vLT,

Gui, Add, Progress, x80 y652 w10 h18  c454545 Backgroundwhite vL5, 
Gui, Add, Progress, x90 y653 w8 h16  c585858  Backgroundwhite vL4, 
Gui, Add, Progress, x98 y654 w6 h14  c6c6c6c  Backgroundwhite vL3, 
Gui, Add, Progress, x104 y655 w4 h12  c858585 Backgroundwhite vL2, 
Gui, Add, Progress, x108 y656 w4 h10  c9a9a9a Backgroundwhite vL1,

Gui, Add, Progress, x134 y652 w10 h18  c454545 Backgroundwhite vR5,
Gui, Add, Progress, x126 y653 w8 h16  c585858 Backgroundwhite vR4, 
Gui, Add, Progress, x120 y654 w6 h14  c6c6c6c Backgroundwhite vR3, 
Gui, Add, Progress, x116 y655 w4 h12  c858585 Backgroundwhite vR2, 
Gui, Add, Progress, x112 y656 w4 h10  c9a9a9a Backgroundwhite vR1,

Gui, Font, S8 bold, Tahoma 
;Gui, Add, Text, x312 y655 w500 h20 +Center vStatusInfo, IDTE- ID3 Tag Editor By - Rajat Kosh. rajatkosh2153@gmail.com (c) rEX_ON_FiRE 2013 -14 
Gui, Add, progress,  x312 y655 w580 h15 vGUI_Progress , 0 
Gui, Add, Text, x892 y655 h15 w160 vGUI_Text,
Gui, Font,
Gui, Add, Button, Hidden Default, OK
Save_Tool_TT := "Save The Tag of Current Selected File(s)"
vol_ico=%A_WorkingDir%\GUI\icons\vol.bmp
AddGraphicButton("mute", vol_ico, "x1230 y132 w17 h17 gmute", 15, 15)

pause_ico=%A_WorkingDir%\GUI\icons\pus.bmp
AddGraphicButton("Pause", pause_ico, "x1150 y130 w20 h20 gPause", 18, 18)
play_ico=%A_WorkingDir%\GUI\icons\ply.bmp
AddGraphicButton("Play", play_ico, "x1130 y130 w20 h20 gPlay", 18, 18)
stop_ico=%A_WorkingDir%\GUI\icons\stop.bmp
AddGraphicButton("Stop", stop_ico, "x1110 y130 w20 h20 gStop", 18, 18)
nxt_ico=%A_WorkingDir%\GUI\icons\nxt.bmp
AddGraphicButton("FastFwd", nxt_ico, "x1170 y130 w20 h20 gBassNext", 18, 18)
pre_ico=%A_WorkingDir%\GUI\icons\pre.bmp
AddGraphicButton("Rewind", pre_ico, "x1090 y130 w20 h20 gBassPrev", 18, 18)
fwd_ico=%A_WorkingDir%\GUI\icons\fwd.bmp
AddGraphicButton("fwd", fwd_ico, "x1190 y130 w20 h20 gfwd", 18, 18)
rev_ico=%A_WorkingDir%\GUI\icons\rev.bmp
AddGraphicButton("rev", rev_ico, "x1070 y130 w20 h20 grev", 18, 18)
fwd_TT:="Forward 2%"
rev_TT:="Rewind 2%"
Pause_TT:="Pause Currently Playing Track"
Play_TT:="Restart/Resume Currently Playing/Paused Track"
mute_TT:="Mute Audio"
Stop_TT:="Stop Current Track"
FastFwd_TT:="Next Track"
Rewind_TT:="Prev Track"
PrBar2_TT:="Seek To Specific Location"
PrBar3_TT:="Volume"
save_ico=%A_WorkingDir%\GUI\icons\save.bmp
AddGraphicButton("ContextSave", save_ico, "x315 y3 w22 h22 gContextsave", 20, 20)
ContextSave_TT:= "Save The Tag of Current Selected File(s)"
Fold_ico=%A_WorkingDir%\GUI\icons\foldr.bmp
AddGraphicButton("R", Fold_ico, "x340 y3 w22 h22 gContextFold", 20, 20)
R_TT:="Add Folder"
File_ico=%A_WorkingDir%\GUI\icons\file.bmp
AddGraphicButton("Re", File_ico, "x365 y3 w22 h22 gContextFile", 20, 20)
Re_TT :="Add File(s)"
playagain_ico=%A_WorkingDir%\GUI\icons\play.bmp
AddGraphicButton("Rew", playagain_ico, "x390 y3 w22 h22 gForce_play", 20, 20)
Rew_TT:="Play/Preview Currently Focused File"
ref_ico=%A_WorkingDir%\GUI\icons\ref.bmp
AddGraphicButton("Rewi", ref_ico, "x415 y3 w22 h22 grefresh", 20, 20)
Rewi_TT:="Refresh Everything"
cut_ico=%A_WorkingDir%\GUI\icons\cut.bmp
AddGraphicButton("Rewin", cut_ico, "x440 y3 w22 h22 gCutTag", 20, 20)
Rewin_TT:="Cut Current Tag information"
copy_ico=%A_WorkingDir%\GUI\icons\copy.bmp
AddGraphicButton("Copt", copy_ico, "x465 y3 w22 h22 gCopyTag", 20, 20)
Copt_TT:="Copy Current Tag Imformation"
Paste_ico=%A_WorkingDir%\GUI\icons\paste.bmp
AddGraphicButton("past", paste_ico, "x490 y3 w22 h22 gPasteTag", 20, 20)
Past_TT:= "Paste Tag Information on Current File(s)"
rem_ico=%A_WorkingDir%\GUI\icons\rem.bmp
AddGraphicButton("Rem", rem_ico, "x515 y3 w22 h22 gContextClearRows", 20, 20)
Rem_TT:="Remove Selected Items From List View"
Qck_ico=%A_WorkingDir%\GUI\icons\Quick.bmp
AddGraphicButton("Quick", Qck_ico, "x540 y3 w22 h22 gFastMode", 20, 20)
hlp_ico=%A_WorkingDir%\GUI\icons\help.bmp
AddGraphicButton("helo", hlp_ico, "x565 y3 w22 h22 ghelpTag", 20, 20)
helo_TT:="Tagging Inforamation"
Quick_TT:="Quick Tag Editing Mode"
Gui, Font, S10 Italic , Arial
GuiControl,, Pic , *w240 *h235 %A_WorkingDir%\GUI\CD Inside.png
if A_ScreenWidth >=1360
{
if (A_ScreenHeight >=760 and A_ScreenHeight <770)
{
Gui, Show , w1360 h695 Maximize, IDTE-ID`3 Tag Editor v2.5
}
else
Gui, Show , w1360 h695, IDTE-ID`3 Tag Editor v2.5
}
else if A_ScreenWidth < 1360
{
flag_resolution=1
	Gui, Show , w1360 h695 Maximize, IDTE-ID`3 Tag Editor v2.5
}
else if A_ScreenHeight < 760
{
flag_resolution=1
Gui, Show , w1360 h695 Maximize, IDTE-ID`3 Tag Editor v2.5
}

XT=0
CT=0
OnMessage(0x200, "WM_MOUSEMOVE")
OnMessage(0x205, "WM_MOUSELEFT")
OnMessage(0x204, "WM_MOUSELEFTART")
Gui, +Resize
GuiControl , Hide,Info
GuiControl , Hide,Info2
DllCall("ChangeWindowMessageFilter", uint, 0x49, uint, 1)
DllCall("ChangeWindowMessageFilter", uint, 0x233, uint, 1)
;_________________________________________________________________________________END OF GUI+Player________________________________________________________________________________;
}
