;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : GUI3.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================

if GUISELECT=0
{
	Gui, Font, S5
	Symbollft := Chr(9664)
	Symbolrit := Chr(9654)
	Gui, Add, button , x1312 y3 w17 h17 vprcov gupdwn ,%Symbollft%
	Gui, Add, button , xp+17 y3 w17 h17 vnxcov gupupn ,%Symbolrit%
	Gui, Font,
	IniRead ,lst_Font,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,List_Font,List_Font
	IniRead ,lst_FontSize,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,List_Font,List_FontSize
	IniRead ,lst_Col,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,List_Font,List_Col	
	IniRead ,Checker14,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,List_Font,List_Bold
	IniRead ,Checker15,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,List_Font,List_Italic	
	IniRead ,Checker16,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,List_Font,List_Underline
	IniRead ,Is_Grid,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Miscellaneous,Enable_Grid
	if(Is_Grid=1)
		Enable_grid = Grid
	else
		Enable_grid =
	Gui, Font, S%lst_FontSize% C%lst_Col% , %lst_Font%
	if(Checker14=1)
		Gui, Font, Bold
	if(Checker15=1)
		Gui, Font, italic
	if(Checker16=1)
		Gui, Font, underline
		Gui, Add, ListView, x12 y280 w1335 h380 AltSubmit vMyListView gMyListView %Enable_grid% hwndHLV cBlack LV0x20 LV0x10, |#|Title|Artist|Album|Year|Genre|Name|In Folder|Band\Orchestra|Publisher|Composer|Comment|Size(MB)|Type|Channels|Sample Rate(Hz)|Bit Rate(Kbps)|Duration|Tags Supported
	LV_ModifyCol(2,"Integer")
	LV_ModifyCol(6,"Integer")
	LV_ModifyCol(14,"Integer")
	LV_ModifyCol(17,"Integer")
	LV_ModifyCol(18,"Integer")
	LV_ModifyCol(19,"Integer")
	Gui , Font ,
	Gui, Add, Picture, x1072 y30  , %A_WorkingDir%\GUI\CDCASE.png
	Gui, Add, Pic,x1098 y32  vPic gShowPic
	Gui, Add, GroupBox, x692 y25 w365 h240 +Center,
	margin := 1 
	MaxRange1 :=100
	Gui, Add, Progress,w0 h0 x0 y0 cgray BackgroundSilver vPrBar1  Range0-%MaxRange1%, ;Just To Avoid Infringment
	Gui, Add, Progress, w190 h14 x810 y80 cgray BackgroundSilver vPrBar2  Range0-%MaxRange1%, 50
	Gui, Add, Progress, x835 y195 h15 w160 cBlack BackgroundSilver vPrBar3  Range0-%MaxRange1%, 20
	OnMessage(0x201, "WM_LBUTTONDOWN")  ; Monitors Left Clicks on Gui.
	Loop , 3
		GuiControlGet, PrBar%A_Index%, Pos
	Gui, Font,
	Gui, +resize
	Gui, Add, Pic,  x700 y40 w100 h100 vMus_ico ,%A_WorkingDir%\GUI\music_icon.png
	PrBar2_TT:="Seek To Specific Location"
	PrBar3_TT:="Volume"

{
	pause_ico=%A_WorkingDir%\GUI\icons\pus2.bmp
	AddGraphicButton("Pause", pause_ico, "x915 y50 w26 h26 gPause", 20, 20)
	play_ico=%A_WorkingDir%\GUI\icons\ply2.bmp
	AddGraphicButton("Play", play_ico, "x890 y50 w26 h26 gPlay", 20, 20)
	stop_ico=%A_WorkingDir%\GUI\icons\stop2.bmp
	AddGraphicButton("Stop", stop_ico, "x865 y50 w26 h26 gstop", 20, 20)
	nxt_ico=%A_WorkingDir%\GUI\icons\nxt2.bmp
	AddGraphicButton("FastFwd", nxt_ico, "x940 y50 w26 h26 gBassNext", 20, 20)
	pre_ico=%A_WorkingDir%\GUI\icons\pre2.bmp
	AddGraphicButton("Rewind", pre_ico, "x840 y50 w26 h26 gBassPrev", 20, 20)
	fwd_ico=%A_WorkingDir%\GUI\icons\fwd2.bmp
	AddGraphicButton("fwd", fwd_ico, "x965 y50 w26 h26 gfwd", 20, 20)
	rev_ico=%A_WorkingDir%\GUI\icons\rev2.bmp
	AddGraphicButton("rev", rev_ico, "x815 y50 w26 h26 grev", 20, 20)

	vol_ico=%A_WorkingDir%\GUI\icons\vol.bmp
	AddGraphicButton("mute", vol_ico, "x800 y190 w25 h25 gmute", 20, 20)
	Gui,Add, Groupbox, x705 y213 w260 h33,

	save_ico=%A_WorkingDir%\GUI\icons\save.bmp
	AddGraphicButton("ContextSave", save_ico, "x700 y220 w24 h24 gContextsave", 20, 20)
	ContextSave_TT:= "Save The Tag of Current Selected File(s)"
	Fold_ico=%A_WorkingDir%\GUI\icons\foldr.bmp
	AddGraphicButton("R", Fold_ico, "x725 y220 w24 h24 gContextFold", 20, 20)
	R_TT:="Add Folder"
	File_ico=%A_WorkingDir%\GUI\icons\file.bmp
	AddGraphicButton("Re", File_ico, "x750 y220 w24 h24 gContextFile", 20, 20)
	Re_TT :="Add File(s)"
	playagain_ico=%A_WorkingDir%\GUI\icons\play.bmp
	AddGraphicButton("Rew", playagain_ico, "x775 y220 w24 h24 gForce_play", 20, 20)
	Rew_TT:="Play/Preview Currently Focused File"
	ref_ico=%A_WorkingDir%\GUI\icons\ref.bmp
	AddGraphicButton("Rewi", ref_ico, "x800 y220 w24 h24 grefresh", 20, 20)
	Rewi_TT:="Refresh Everything"
	cut_ico=%A_WorkingDir%\GUI\icons\cut.bmp
	AddGraphicButton("Rewin", cut_ico, "x825 y220 w24 h24 gCutTag", 20, 20)
	Rewin_TT:="Cut Current Tag information"
	copy_ico=%A_WorkingDir%\GUI\icons\copy.bmp
	AddGraphicButton("Copt", copy_ico, "x850 y220 w24 h24 gCopyTag", 20, 20)
	Copt_TT:="Copy Current Tag Imformation"
	Paste_ico=%A_WorkingDir%\GUI\icons\paste.bmp
	AddGraphicButton("past", paste_ico, "x875 y220 w24 h24 gPasteTag", 20, 20)
	Past_TT:= "Paste Tag Information on Current File(s)"
	rem_ico=%A_WorkingDir%\GUI\icons\rem.bmp
	AddGraphicButton("Rem", rem_ico, "x900 y220 w24 h24 gContextClearRows", 20, 20)
	Rem_TT:="Remove Selected Items From List View"
	Qck_ico=%A_WorkingDir%\GUI\icons\Quick.bmp
	AddGraphicButton("Quick", Qck_ico, "x925 y220 w24 h24 gFastMode", 20, 20)
	hlp_ico=%A_WorkingDir%\GUI\icons\help.bmp
	AddGraphicButton("helo", hlp_ico, "x950 y220 w24 h24 ghelpTag", 20, 20)

	Quick_TT:="Quick Tag Editing Mode"
	fwd_TT:="Forward 2%"
	rev_TT:="Rewind 2%"
	helo_TT:="Help Contents"
	Pause_TT:="Pause Currently Playing Track"
	Play_TT:="Restart/Resume Currently Playing/Paused Track"
	mute_TT:="Mute Audio"
	Stop_TT:="Stop Current Track"
	FastFwd_TT:="Next Track"
	Rewind_TT:="Prev Track"
} 
	OnMessage(0x200, "WM_MOUSEMOVE")
	OnMessage(0x205, "WM_MOUSELEFT")
	OnMessage(0x204, "WM_MOUSELEFTART")
	GuiControl,, Pic , *w240 *h235 %A_WorkingDir%\GUI\CD Inside.png
	Gui, Font, S8 CDefault bold, Arial
	Gui,add,statusbar, vSbar,
	SB_SetParts(350,120,100,300,100) ; Make 3 different parts
	Gui ,add ,Text, x1122 y5 w170 h15 vcovertype,
	Gui, font , ,
	Gui, Font, S8 CDefault bold, Arial
	Gui, Add, Text, x1005 y90 w40 h15 vduration, 
	Gui, Add, Text, x700 y150 w80 h60 vInfo,
;Gui, Add, Link, x12 y670 w500 h15 vLNK gELink, IDTE- ID3 Tag Editor By - Rajat Kosh .<a href="rajatkosh2153@gmail.com">rajatkosh2153@gmail.com</a> (c) rEX_ON_FiRE 2013 -14 
;Gui, Add, Link,x100 y0 w400, <a href="rajatkosh2153@gmail.com">link</a>
	Gui, Add, Text, x745 y0 w150 h15 vmutetext,
	Gui, Add, Text, x810 y100 w240 h90  vClist, Currently No File is Playing

	Gui, Add, Progress, x1025 y190 w5 h20 AltSubmit cBlack vertical vRIGHT,
	Gui, Add, Progress, x1030 y195 w5 h15 AltSubmit cBlack vertical vRIGT,
	Gui, Add, Progress, x1035 y200 w5 h10 AltSubmit cBlack vertical vRIT,
	Gui, Add, Progress, x1020 y190 w5 h20 AltSubmit cBlack vertical vLEFT,
	Gui, Add, Progress, x1015 y195 w5 h15 AltSubmit cBlack vertical vLET,
	Gui, Add, Progress, x1010 y200 w5 h10 AltSubmit cBlack vertical vLT,
	Gui, Add, Progress, x980 y221 w10 h18  c454545  vL5, 
	Gui, Add, Progress, x990 y222 w8 h16  c585858  vL4,  
	Gui, Add, Progress, x998 y223 w6 h14  c6c6c6c  vL3,  
	Gui, Add, Progress, x1004 y224 w4 h12  c858585  vL2, 
	Gui, Add, Progress, x1008 y225 w4 h10  c9a9a9a  vL1,

	Gui, Add, Progress, x1034 y221 w10 h18  c454545  vR5,
	Gui, Add, Progress, x1026 y222 w8 h16  c585858  vR4, 
	Gui, Add, Progress, x1020 y223 w6 h14  c6c6c6c  vR3, 
	Gui, Add, Progress, x1016 y224 w4 h12  c858585  vR2, 
	Gui, Add, Progress, x1012 y225 w4 h10  c9a9a9a  vR1, 
;-------------------------------------------------------------------------------------------------------------------------
	Gui , Font ,
	Gui, Add, Tab2, x10 y0 w1340 h275 +Center -Theme, Tag Panel |Lyrics And More|Player Mode ;Add Tabs
	Gui , Font ,
	Gui, Add, Edit, x42 y50 w280 h20 vArtist, Artist
	Gui, Add, Edit, x42 y95 w280 h20 vAlbum, Album
	Gui, Add, Edit, x42 y145 w280 h20 vTitle, Title
	Gui, Add, Edit, x42 y195 w120 h20 vTrack, Track
	Gui, Add, Edit, x182 y195 w140 h20 vYear, Year
	Gui, Add, Edit, x42 y245 w280 h20 vGenre, Genre	
	Gui, Add, Edit, x362 y55 w280 h20 vComments, Comments
	Gui, Add, Edit, x362 y95 w280 h20 vPublisher, Publisher
	Gui, Add, Edit, x362 y145 w280 h20 vComposer, Composer
	Gui, Add, Edit, x362 y195 w280 h20 vBand, Band/Orchestra
	Gui,Add, Button, x462 y230 w80, Save
	Gui, Add, Button, Hidden Default, OK
	Gui, Font,
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
	Gui, Add, Text, x42 y30 w100 h20 , Artist
	Gui, Add, Text, x42 y75 w100 h20 , Album
	Gui, Add, Text, x42 y125 w100 h20 , Title
	Gui, Add, Text, x42 y175 w100 h20 , Track
	Gui, Add, Text, x42 y225 w100 h20 , Genre
	Gui, Add, Text, x182 y175 w100 h20 , Year
	Gui, Add, Text, x362 y35 w100 h20 , Comments
	Gui, Add, Text, x362 y75 w100 h20 , Publisher
	Gui, Add, Text, x362 y125 w100 h20 , Composer
	Gui, Add, Text, x362 y175 h20 , Band/Orchestra/Album Artist
	Gui, Font, 
	ImageListID1 := IL_Create(10)
	ImageListID2 := IL_Create(10, 10, true)  ; A list of large icons to go with the small ones.
	Gui , Tab , Lyrics And More
	Gui, Font, S8 CDefault bold, Arial
	Gui, Add, Text , x20 y25, Lyrics
	Gui, Add, Edit , x20 y45 w310 h195 vLRC,Lyrics
	Gui, Add, Edit , x340 y40 w300 h140 vSong_info readonly, Audio Infomation
	Gui, Add, Button , x60 y245, Done	
	Gui,Add,Button, x120 y245,Fetch
	Gui,Add,Button, x161 y245 w20 vLRCOPT, >>
	Gui,Add,Button, x190 y245 vfa,Fetch Cover Art
	Gui,Add, Groupbox, x340 y180 w300 h80, Add New Field
	Gui, Add, Text, x350 y200, Field Name 
	Gui, Add, Edit, x350 y220 w100 vFname,
	Gui, Add, Text, x460 y200, Field Text
	Gui, Add, Edit, xp y220  vFtext,
	Gui,Add, Button, x600 y220 , Add
	Gui , Tab , Player Mode
	Gui, Font, S8 CDefault bold italic, Comic Sans MS
	Gui, Add, Text , x20 y25, Auto Scroll Lyrics
	Gui, Add, Edit , x30 y45 w610 h195 +Center hwndGUI vLRC2 ReadOnly,
	Gui,Add,Button, x75 y245  ,Stop
	Gui,Add,Button, x125 y245  ,Continue	
	Gui,Add,Button, x195 y245  ,Slow
	Gui,Add,Button, x250 y245  ,Fast
	Gui, Add, Text, x305 y245 w250 vScroll_Rate
	Gui, Add, Button, xp+250 y245  , Custom
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

	if A_ScreenWidth >=1360
		{
			if (A_ScreenHeight >=760 and A_ScreenHeight <770)
				{
					Gui, Show , w1360 h695 Maximize, IDTE-ID`3 Tag Editor
				}
			else
					Gui, Show , w1360 h700, IDTE-ID`3 Tag Editor
		}
	else if A_ScreenWidth < 1366
	{
		GuiControl, Hide, SBar
		Guicontrol , Show, milli
		Guicontrol , Show, GUI_Text
		Guicontrol , Show, Completed
		Guicontrol , Show, Vol_info
		Guicontrol , Show, CPU
		flag_resolution=1
		Gui, Show , w1360 h695 Maximize, IDTE-ID`3 Tag Editor
	}
	else if A_ScreenHeight < 760
	{
		GuiControl, Hide, SBar
		Guicontrol , Show, milli
		Guicontrol , Show, GUI_Text
		Guicontrol , Show, Completed
		Guicontrol , Show, Vol_info
		Guicontrol , Show, CPU
		flag_resolution=1
		Gui, Show , w1360 h695 Maximize, IDTE-ID`3 Tag Editor
	}

	Done_TT:= "Save Lyrics To Selected File(s)"
	Fetch_TT:= "Fetch Lyrics From Internet"
	DX8_Chorus_TT:="Add Chorus Effect To Currently Playing Song"
	DX8_Compressor_TT:="Add Compressor Effect To Currently Playing Song"
	DX8_Distortion_TT:="Add Distortion"
	DX8_Echo_TT:="Add Echo Effect"
	DX8_Flanger_TT:="Add Flanger Effect"
	DX8_Gargle_TT:="Add Gargle Effect"
	DX8_3D_Reverb:="Add Interactive 3D Reverb Effect"
	DX8_Reverb:="Add Reverb Effect"
	None:="Remove Effect"
}
OnMessage(0x115, "OnScroll") ; WM_VSCROLL
OnMessage(0x114, "OnScroll") ; WM_HSCROLL
SB_SetText("         Ready ",1)
LRCOPT_TT:="Fetching Sources"

FetchCoverArt_TT:= "Fetch Cover Art From the Internet"
Gui, Add, Button, Hidden Default, OK