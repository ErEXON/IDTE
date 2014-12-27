;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : GUI2.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================
if (GUISELECT=2)
{
	
	if(A_ScreenWidth >= 1360)
		XMAX := A_ScreenWidth
	else 
		XMAX := 1360
	if(A_ScreenHeight >= 760)
		YMAX := A_ScreenHeight
	else 
		YMAX := 760
	XTAB := XMAX - 350
	YTAB := YMAX - 110
	XEDIT := XMAX - 328
	XYER := XMAX - 228
	XGEN := XMAX - 128
	XPIC := XMAX - 302
	XPRC := XMAX - 88
	XNXC := XMAX - 71
	guicol = F0F0F0
	Gui, Font, S5
	Symbollft := Chr(9664)
	Symbolrit := Chr(9654)
	
	Gui, Add, button , x%XPRC% y638 w17 h17 vprcov gupdwn ,%Symbollft%
	Gui, Add, button , x%XNXC% y638 w17 h17 vnxcov gupupn ,%Symbolrit%
	Gui, Add, Picture, x%XEDIT% y397  vBGpic, %A_WorkingDir%\GUI\CDCASE.png
	Gui, Add, Pic,x%XPIC% y399  vPic gShowPic
	Gui, Font,
	IniRead ,lst_Font,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,List_Font,List_Font
	IniRead ,lst_FontSize,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,List_Font,List_FontSize
	IniRead ,lst_Col,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,List_Font,List_Col
	IniRead ,Checker14,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,List_Font,List_Bold
	IniRead ,Checker15,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,List_Font,List_Italic
	IniRead ,Checker16,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,List_Font,List_Underline
	IniRead ,Is_Grid,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Miscellaneous,Enable_Grid
	Gui, Font, S%lst_FontSize% C%lst_Col%, %lst_Font%
	if(Checker14=1)
		Gui, Font, Bold
	if(Checker15=1)
		Gui, Font, italic
	if(Checker16=1)
		Gui, Font, underline
	WLIST := XMAX - 368
	HLIST := YMAX - 156
	Gui, Add, ListView, x10 y46 w%WLIST% h%HLIST% AltSubmit vMyListView gMyListView %Enable_grid% cBlack hwndHLV LV0x10 LV0x100000, |#|Title|Artist|Album|Year|Genre|Name|In Folder|Band\Orchestra|Publisher|Composer|Comment|Size(MB)|Type|Channels|Sample Rate(Hz)|Bit Rate(Kbps)|Duration|Tags Supported
	LV_ModifyCol(2,"Integer")
	LV_ModifyCol(6,"Integer")
	LV_ModifyCol(14,"Integer")
	LV_ModifyCol(17,"Integer")
	LV_ModifyCol(18,"Integer")
	LV_ModifyCol(19,"Integer")
	Gui,Font,
	margin := 1 
	MaxRange1 :=100
	Gui, Add, Progress,w0 h0 x0 y0 cgray BackgroundSilver vPrBar1  Range0-%MaxRange1%,
	Gui, Add, Progress, w190 h10 x595 y30 c808080 BackgroundSilver vPrBar2 Range0-%MaxRange1%, 20
	Gui, Add, Progress, x855 y10 w150 h15 cBlack BackgroundSilver vPrBar3 Range0-%MaxRange1%, 20
	OnMessage(0x201, "WM_LBUTTONDOWN")  ; Monitors Left Clicks on Gui.
	Loop , 3
		GuiControlGet, PrBar%A_Index%, Pos
	Gui, Add, Pic,  x550 y2 w40 h40 vMus_ico  ,%A_WorkingDir%\GUI\music_icon40.png
	Gui, Font, s8 cblack bold , Arial
	Gui,add,statusbar, vSbar, 
	SB_SetParts(350,120,100,300,100) ; Make 3 different parts
	XCOV_ := XMAX - 298
	Gui ,add ,text, x%XCOV_% y637 w200 h15 vcovertype,
	Gui, Add, text, x335 y0 w160 h45 ReadOnly vClist +Center, Currently No File is Playing
	Gui, Add, Progress, x525 y0 w5 h20 AltSubmit cBlack Background%guicol% vertical vRIGHT, 
	Gui, Add, Progress, x530 y5 w5 h15 AltSubmit cBlack Background%guicol% vertical vRIGT, 
	Gui, Add, Progress, x535 y10 w5 h10 AltSubmit cBlack Background%guicol% vertical vRIT, 
	Gui, Add, Progress, x520 y0 w5 h20 AltSubmit cBlack Background%guicol% vertical vLEFT, 
	Gui, Add, Progress, x515 y5 w5 h15 AltSubmit cBlack Background%guicol% vertical vLET, 
	Gui, Add, Progress, x510 y10 w5 h10 AltSubmit cBlack Background%guicol% vertical vLT,
	Gui, Add, Progress, x880 y27 w10 h18  c454545 Background%guicol% vL5, 
	Gui, Add, Progress, x890 y28 w8 h16  c585858 Background%guicol% vL4, 
	Gui, Add, Progress, x898 y29 w6 h14  c6c6c6c Background%guicol% vL3, 
	Gui, Add, Progress, x904 y30 w4 h12  c858585 Background%guicol% vL2, 
	Gui, Add, Progress, x908 y31 w4 h10  c9a9a9a Background%guicol% vL1,

	Gui, Add, Progress, x934 y27 w10 h18  c454545 Background%guicol% vR5,
	Gui, Add, Progress, x926 y28 w8 h16  c585858 Background%guicol% vR4, 
	Gui, Add, Progress, x920 y29 w6 h14  c6c6c6c Background%guicol% vR3, 
	Gui, Add, Progress, x916 y30 w4 h12  c858585 Background%guicol% vR2, 
	Gui, Add, Progress, x912 y31 w4 h10  c9a9a9a Background%guicol% vR1,

	Gui, Add, Text, x960 y30 w40 h15 vmutetext, 
	SB_SetText("Welcome To IDTE",4)
	Gui, Add, Text, x505 y30 w40 h15 vInfo ,
	Gui, Add, Text, x790 y30 w40 h15 vInfo2,
	Gui, Font,
	Gui, Add, Button, Hidden Default, OK
	pause_ico=%A_WorkingDir%\GUI\icons\pus2.bmp
	AddGraphicButton("Pause", pause_ico, "x700 y0 w26 h26 gPause", 20, 20)
	play_ico=%A_WorkingDir%\GUI\icons\ply2.bmp
	AddGraphicButton("Play", play_ico, "x675 y0 w26 h26 gPlay", 20, 20)
	stop_ico=%A_WorkingDir%\GUI\icons\stop2.bmp
	AddGraphicButton("Stop", stop_ico, "x650 y0 w26 h26 gStop", 20, 20)
	nxt_ico=%A_WorkingDir%\GUI\icons\nxt2.bmp
	AddGraphicButton("FastFwd", nxt_ico, "x725 y0 w26 h26 gBassNext", 20, 20)
	pre_ico=%A_WorkingDir%\GUI\icons\pre2.bmp
	AddGraphicButton("Rewind", pre_ico, "x625 y0 w26 h26 gBassPrev", 20, 20)
	fwd_ico=%A_WorkingDir%\GUI\icons\fwd2.bmp
	AddGraphicButton("fwd", fwd_ico, "x750 y0 w26 h26 gfwd", 20, 20)
	rev_ico=%A_WorkingDir%\GUI\icons\rev2.bmp
	AddGraphicButton("rev", rev_ico, "x600 y0 w26 h26 grev", 20, 20)
	vol_ico=%A_WorkingDir%\GUI\icons\vol.bmp
	AddGraphicButton("mute", vol_ico, "x825 y5 w25 h25 gmute", 20, 20)
	save_ico=%A_WorkingDir%\GUI\icons\save.bmp
	AddGraphicButton("ContextSave", save_ico, "x10 y5 w24 h24 gContextsave", 20, 20)
	ContextSave_TT:= "Save The Tag of Current Selected File(s)"
	Fold_ico=%A_WorkingDir%\GUI\icons\foldr.bmp
	AddGraphicButton("R", Fold_ico, "x35 y5 w24 h24 gContextFold", 20, 20)
	R_TT:="Add Folder"
	File_ico=%A_WorkingDir%\GUI\icons\file.bmp
	AddGraphicButton("Re", File_ico, "x60 y5 w24 h24 gContextFile", 20, 20)
	Re_TT :="Add File(s)"
	playagain_ico=%A_WorkingDir%\GUI\icons\play.bmp
	AddGraphicButton("Rew", playagain_ico, "x85 y5 w24 h24 gForce_play", 20, 20)
	Rew_TT:="Play/Preview Currently Focused File"
	ref_ico=%A_WorkingDir%\GUI\icons\ref.bmp
	AddGraphicButton("Rewi", ref_ico, "x110 y5 w24 h24 gRefreshList", 20, 20)
	Rewi_TT:="Refresh Everything"
	cut_ico=%A_WorkingDir%\GUI\icons\cut.bmp
	AddGraphicButton("Rewin", cut_ico, "x135 y5 w24 h24 gCutTag", 20, 20)
	Rewin_TT:="Cut Current Tag information"
	copy_ico=%A_WorkingDir%\GUI\icons\copy.bmp
	AddGraphicButton("Copt", copy_ico, "x160 y5 w24 h24 gCopyTag", 20, 20)
	Copt_TT:="Copy Current Tag Imformation"
	Paste_ico=%A_WorkingDir%\GUI\icons\paste.bmp
	AddGraphicButton("past", paste_ico, "x185 y5 w24 h24 gPasteTag", 20, 20)
	Past_TT:= "Paste Tag Information on Current File(s)"
	rem_ico=%A_WorkingDir%\GUI\icons\rem.bmp
	AddGraphicButton("Rem", rem_ico, "x210 y5 w24 h24 gContextClearRows", 20, 20)
	Rem_TT:="Remove Selected Items From List View"
	Qck_ico=%A_WorkingDir%\GUI\icons\Quick.bmp
	AddGraphicButton("Quick", Qck_ico, "x235 y5 w24 h24 gFastMode", 20, 20)
	mode_ico=%A_WorkingDir%\GUI\icons\Minimode.bmp
	AddGraphicButton("MiniMode", mode_ico, "x260 y5 w24 h24 gMiniMode", 20, 20)
	eq_ico=%A_WorkingDir%\GUI\icons\equaliz.bmp
	AddGraphicButton("equalizer", eq_ico, "x285 y5 w24 h24 gEqualiz", 20, 20)
	hlp_ico=%A_WorkingDir%\GUI\icons\help.bmp
	AddGraphicButton("helo", hlp_ico, "x310 y5 w24 h24 ghelpTag", 20, 20)
	fwd_TT:="Forward 2%"
	rev_TT:="Rewind 2%"
	MiniMode_TT:="Switch to Mini Mode"
	equalizer_TT:= "Change Equalizer Settings"
	Quick_TT:="Quick Tag Editing Mode"
	helo_TT:="Help Contents"
	Pause_TT:="Pause Currently Playing Track"
	Play_TT:="Restart/Resume Currently Playing/Paused Track"
	mute_TT:="Mute Audio"
	Stop_TT:="Stop Current Track"
	FastFwd_TT:="Next Track"
	Rewind_TT:="Prev Track"
	PrBar2_TT:="Seek To Specific Location"
	PrBar3_TT:="Volume"
	GuiControl,, Pic , *w240 *h235 %A_WorkingDir%\GUI\CD Inside.png
	LV_ModifyCol(1, "Integer") ; For sorting, indicate that the Size column is an integer.
	LV_ModifyCol(9, "Integer") ; For sorting, indicate that the Size column is an integer.
; Create an ImageList so that the ListView can display some icons:
	ImageListID1 := IL_Create(10)
	ImageListID2 := IL_Create(10, 10, true)  ; A list of large icons to go with the small ones.
	
	Gui , Add,Tab2, x%XTAB% y5 w342 h%YTAB%, Tag Panel|Lyrics And More|Player Mode
	Gui, Add, Edit, x%XEDIT% y45 w300 h20 vArtist, Artist
	Gui, Add, Edit, x%XEDIT% y90 w300 h20 vAlbum, Album
	Gui, Add, Edit, x%XEDIT% y135 w300 h20 vTitle, Title
	Gui, Add, Edit, x%XEDIT% y180 w90 h20 vTrack, Track
	Gui, Add, Edit, x%XYER% y180 w90 h20 vYear, Year
	Gui, Add, Edit, x%XGEN% y180 w100 h20 vGenre, Genre
	Gui, Add, Edit, x%XEDIT% y225 w300 h20 vComposer, Composer
	Gui, Add, Edit, x%XEDIT% y270 w300 h20 vComments, Comments
	Gui, Add, Edit, x%XEDIT% y315 w300 h20 vPublisher, Publisher
	Gui, Add, Edit, x%XEDIT% y360 w300 h20 vBand, Orchestra/Album Artist

	IniRead ,tg_Font,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tag_Panel,Tag_Font
	IniRead ,tg_FontSize,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tag_Panel,Tag_FontSize
	IniRead ,tg_Col,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tag_Panel,Tag_Col
	IniRead ,Checker20,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tag_Panel,Tag_Bold
	IniRead ,Checker21,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tag_Panel,Tag_Italic
	IniRead ,Checker22,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tag_Panel,Tag_Underline
	Gui, Font, S%tg_FontSize% C%tg_Col%, %tg_Font%
	if(Checker20=1)
		Gui, Font, Bold
	if(Checker21=1)
		Gui, Font, italic
	if(Checker22=1)
		Gui, Font, underline
	Gui, Add, Text, x%XEDIT% y30 w130 h15 , Artist
	Gui, Add, Text, x%XEDIT% y75 w130 h15 , Album
	Gui, Add, Text, x%XEDIT% y120 w130 h15 , Title
	Gui, Add, Text, x%XEDIT% y165 w80 h15 , Track
	Gui, Add, Text, x%XYER% y165 w80 h15 , Year
	Gui, Add, Text, x%XGEN% y165 w80 h15 , Genre
	Gui, Add, Text, x%XEDIT% y210 w130 h15 , Composer
	Gui, Add, Text, x%XEDIT% y255 w80 h15 , Comments
	Gui, Add, Text, x%XEDIT% y300 w130 h15 , Publisher	
	Gui, Add, Text, x%XEDIT% y345  h15 , Band/Orchestra/Album Artist
	Gui, Add, Text, x600 y670 w300 h13 vmilli, Welcome To IDTE
	Gui, Add, Text , x10 y670  w350 vGUI_Text,
	Gui, Add, Text, x370 y670 w120 vCompleted,
	Gui, Add, Text, x490 y670 w100 vVol_info,
	Gui, Add, Text, x900 y670 w100 vCPU,
	Guicontrol , hide, milli
	Guicontrol , hide, GUI_Text
	Guicontrol , hide, Completed
	Guicontrol , hide, Vol_info
	Guicontrol , hide, CPU
	Gui , Tab , Lyrics And More
	Gui, Font, S8 CDefault bold, Arial
	XGBX := XEDIT - 10
	XTXT := XMAX - 218
	Gui, Add, GroupBox , x%XGBX% y155 h70 w315 ,Add Extended Field
	Gui, Add, Text, x%XGBX% y225 , Lyrics
	Gui, Add, Edit , x%XGBX% y245 w315 h115 vLRC , Lyrics
	Gui, Add, Text, x%XGBX% y30, Detailed Information	
	Gui, Add, Edit , x%XGBX% y50 w315 h100 vSong_info readonly, No Information Available
	Gui, Add, Text, x%XEDIT% y175 h15, Field Name 
	Gui, Add, Edit, x%XEDIT% y190 wp+30 vFname,
	Gui, Add, Text, x%XTXT% y175 h15, Field Text
	Gui, Add, Edit, x%XTXT% y190 w130 vFtext,
	XADD := XMAX - 76
	XFT := XMAX - 278
	XOPT := XMAX - 237
	XFART := XMAX - 208
	Gui,Add, Button, x%XADD% y185 , Add
	Gui, Add, Button , x%XEDIT% y365 , Done
	Gui,Add,Button, x%XFT% y365,Fetch 
	Gui,Add,Button, x%XOPT% y365 w20 vLRCOPT, >>
	Gui,Add,Button, x%XFART% y365 vfa,&Fetch Cover Art
	
	XCNT := XMAX - 300
	XSL := XMAX - 210
	XFST := XMAX - 160
	XCST := XMAX - 110
	Gui , Tab , Player Mode
	Gui, Font, S8 CDefault bold italic, Comic Sans MS
	Gui, Add, Text , x%XGBX% y30 vText_l3, Auto Scroll Lyrics
	Gui, Add, pic, x%XGBX% y50 w315 h260 vPict gAll hwndVZLN
	GuiControl , hide , Pict
	Gui, Add, Edit , x%XGBX% y50 w315 h260 +Center hwndGUI vLRC2 ReadOnly,
	Gui,Add,Button, x%XGBX% y320 vstp_but ,Stop
	Gui,Add,Button, x%XCNT% y320  vcnt_but ,Continue
	Gui,Add,Button, x%XSL% y320  vslw_but ,Slow
	Gui,Add,Button, x%XFST% y320  vfst_but ,Fast
	Gui,Add,Button, x%XCST% y320  vcus_but,Custom
	XVIS := XMAX-50
	Gui,Add,Pic,	x%XVIS% y320 w24 h24 vvis_tgl gVisual_Toggle , %A_WorkingDir%\GUI\icons\visual.bmp
	GuiControl , hide , Pict
	Gui, Add, Text, x%XGBX% y365 w300 vScroll_Rate

	Done_TT:= "Save Lyrics To Selected File(s)"
	Fetch_TT:= "Fetch Lyrics From Internet"
	Add_TT:="Add This Field Into Tag"
	Gui, +Resize

	if A_ScreenWidth >=1360
	{
		if (A_ScreenHeight >=760 and A_ScreenHeight <770)
		{
			Gui, Show , w1360 h695 Maximize, IDTE-ID`3 Tag Editor
		}
		else
			Gui, Show , w1360 h695, IDTE-ID`3 Tag Editor
	}
	else if A_ScreenWidth < 1360
	{
		flag_resolution=1
		GuiControl, Hide, SBar
		Guicontrol , Show, milli
		Guicontrol , Show, GUI_Text
		Guicontrol , Show, Completed
		Guicontrol , Show, Vol_info
		Guicontrol , Show, CPU
		Gui, Show , w1360 h695 Maximize, IDTE-ID`3 Tag Editor
	}
	else if A_ScreenHeight < 760
	{
		flag_resolution=1
		GuiControl, Hide, SBar
		GuiControl, Hide, SBar
		Guicontrol , Show, milli
		Guicontrol , Show, GUI_Text
		Guicontrol , Show, Completed
		Guicontrol , Show, Vol_info
		Guicontrol , Show, CPU
		Gui, Show , w1360 h695 Maximize, IDTE-ID`3 Tag Editor
	}
	Gui, +LastFound
	OnMessage(0x200, "WM_MOUSEMOVE")
	OnMessage(0x205, "WM_MOUSELEFT")
	OnMessage(0x204, "WM_MOUSELEFTART")
	DllCall("ChangeWindowMessageFilter", uint, 0x49, uint, 1)
	DllCall("ChangeWindowMessageFilter", uint, 0x233, uint, 1)
}