Gui, Add, Edit, x12 y9 w340 h20 ReadOnly vfile_dir, 
Gui, Add, Button, x252 y39 w100 h20 , Browse
Gui, Add, Text, x12 y69 w40 h30 , Artist
Gui, Add, Text, x12 y99 w40 h30 , Album
Gui, Add, Text, x12 y129 w40 h30 , Track
Gui, Add, Text, x12 y159 w40 h30 , Title
Gui, Add, Text, x12 y189 w40 h30 , Year
Gui, Add, Text, x12 y219 w40 h30 , Genre
Gui, Add, Text, x12 y249 w40 h30 , Comm
Gui, Add, Edit, x52 y69 w290 h20 vArtist, 
Gui, Add, Edit, x52 y99 w290 h20 vAlbum, 
Gui, Add, Edit, x52 y129 w290 h20 vTrack,
Gui, Add, Edit, x52 y159 w290 h20 vTitle, 
Gui, Add, Edit, x52 y189 w290 h20 vYear, 
Gui, Add, Edit, x52 y219 w290 h20 vGenre, 
Gui, Add, Edit, x52 y249 w290 h20 vComments, 
Gui, Add, Button, x142 y389 w100 h30 , Save
Gui, Add, pic, x22 y295 w90 h90 vAlb_art,
Gui, Add, GroupBox, x12 y279 w110 h110 , Album Art
Gui, Add, Button, x132 y289 w110 h20 , Change Album Art
Gui, Add, Button, x132 y319 w110 h20 , Remove Album Art
Gui, Show, w364 h441, Tag (A Minimalistic Ver. of IDTE )

	library := DllCall( "LoadLibrary", Str,"AudioGenie3.dll" )
	DllCall( "AudioGenie3\AUDIOAnalyzeFileW", Str,Dummy ) ; Dummy Call
return

;################################################   OPEN FILE #################################################
ButtonBrowse: ;Prompt User For Opening the file
	FileSelectFile ,ChooseFile, , , Select Your Music File(s) (Do Not Add Video Files for Tagging), All Supported Type (*.mp3;*.mp2;*.mp1;*.ogg;*.oga;*.wav;*.aif;*.aiff;*.aifc;*.flac;*.wma;*.wmv;*.wmp;*.asf;*.aac;*.mp4;*.m4a;*.m4b;*.m4p;*.wv;*.wvc;*.ape;*.mpc;*.mpp;*.mp+;*.ac3;*.spx;*.tta;*.opus;)

	if Choosefile=  ; IF no file is selected
		return
	GuiControl , , file_dir , %ChooseFile%
	loop , %ChooseFile%
		DllCall("AudioGenie3.dll\AUDIOAnalyzeFileW", Str,A_LoopFileFullPath )
	SplitPath, Choosefile,,, FileExtn  ; Get Extension

	;Get Information in Fields According to file type 
	if FileExtn in MP3,AAC,MPP,TTA 
	{
			Trackinfo :=  DllCall("AudioGenie3\ID3V2GetTextFrameW", uint, 1414677323,wstr) 
			Titleinfo  :=  DllCall("AudioGenie3\ID3V2GetTextFrameW", uint, 1414091826,wstr) 
			Artistinfo :=  DllCall("AudioGenie3\ID3V2GetTextFrameW", uint, 1414546737,wstr) 
			Albuminfo  :=  DllCall("AudioGenie3\ID3V2GetTextFrameW", uint, 1413565506,wstr) 
			Genreinfo  :=  DllCall("AudioGenie3\ID3V2GetTextFrameW", uint, 1413697358,wstr) 
			Yearinfo  :=  DllCall("AudioGenie3\ID3V2GetTextFrameW", uint, 1415136594,wstr)  
			Composerinfo  :=  DllCall("AudioGenie3\ID3V2GetTextFrameW", uint, 1413697357,wstr) 
			Commentinfo  :=  DllCall("AudioGenie3\ID3V2GetTextFrameW", uint, 1129270605,wstr)
	} 
	else 
	{
			Artistinfo  :=  DllCall("AudioGenie3\AUDIOGetArtistW",wstr)
			Albuminfo  :=  DllCall("AudioGenie3\AUDIOGetAlbumW",wstr)
			Yearinfo  :=  DllCall("AudioGenie3\AUDIOGetYearW",wstr)
			Genreinfo  :=  DllCall("AudioGenie3\AUDIOGetGenreW",wstr)
			Trackinfo  :=  DllCall("AudioGenie3\AUDIOGetTrackW",wstr)
			Titleinfo  :=  DllCall("AudioGenie3\AUDIOGetTitleW" ,wstr)
			Commentinfo  :=  DllCall("AudioGenie3\AUDIOGetCommentW", wstr)
			Composerinfo :=  DllCall("AudioGenie3\AUDIOGetComposerW",wstr)
	}    

	;Set Data into the fields 
	GuiControl,, Title, %Titleinfo%
	GuiControl,, Artist, %Artistinfo%
	GuiControl,, Album, %Albuminfo%
	GuiControl,, Year, %Yearinfo%
	GuiControl,, Track, %Trackinfo%
	GuiControl,, Comments, %Commentinfo%
	GuiControl,, Genre, %Genreinfo%

	;Check for Cover Art in temp folder, Delete if already exists
	IfExist , %A_Temp%\AlbumArt.jpg
		FileDelete , %A_Temp%\AlbumArt.jpg
	IfExist , %A_Temp%\AlbumArt.jpg
		FileDelete , %A_Temp%\AlbumArt.png

;Retrieve the cover art from the file
;Check all possible cover art and extract them into the temp folder for showing onto GUI

;###########################  MP4   ########################
	Mime := DllCall("AudioGenie3\MP4GetPictureMimeW",uint, 01,wstr)
	IfInString , Mime , jpg
		DllCall("AudioGenie3\MP4GetPictureFileW", wstr , A_Temp "\AlbumArt.jpg", uint, 01)
	else 
		DllCall("AudioGenie3\MP4GetPictureFileW", wstr , A_Temp "\AlbumArt.png", uint, 01)

;###########################  FLAC   ########################
	Mime := DllCall("AudioGenie3\FLACGetPictureMimeW",uint, 01,wstr)
	IfInString , Mime, jpeg
		DllCall("AudioGenie3\FLACGetPictureFileW", wstr , A_Temp "\AlbumArt.jpg", uint, 01)
	else 
		DllCall("AudioGenie3\FLACGetPictureFileW", wstr , A_Temp "\AlbumArt.png", uint, 01)

;###########################  MP3   ########################
	Mime := DllCall("AudioGenie3\ID3V2GetPictureMimeW",uint, 01,wstr)
	IfInString , Mime, jpeg
		DllCall("AudioGenie3\ID3V2GetPictureFileW", wstr , A_Temp "\AlbumArt.jpg", uint, 01)
	else 
		DllCall("AudioGenie3\ID3V2GetPictureFileW", wstr , A_Temp "\AlbumArt.png", uint, 01)

;###########################  WMA   ########################
	Mime := DllCall("AudioGenie3\WMAGetPictureMimeW",uint, 01,wstr)
	if(Mime = jpg)
		DllCall("AudioGenie3\WMAGetPictureFileW", wstr , A_Temp "\AlbumArt.jpg", uint, 01)
	else
		DllCall("AudioGenie3\WMAGetPictureFileW", wstr , A_Temp "\AlbumArt.png", uint, 01)

; Set Extracted Cover Art onto the GUI

IfExist , %A_Temp%\AlbumArt.png 	; Check if PNG
 GuiControl,, Alb_art, *w90 *h90 %A_Temp%\AlbumArt.png
	IfNotExist , %A_Temp%\AlbumArt.png	;If not PNG
	{
		IfExist , %A_Temp%\AlbumArt.jpg	;Check JPG
			GuiControl,, Alb_art, *w90 *h90 %A_Temp%\AlbumArt.jpg
		else	;If not JPG then Set Empty
			GuiControl,, Alb_art, *w90 *h90 empty.png
	}
return

;########################################  Change Album Art ##############################################################

ButtonChangeAlbumArt:
	Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
	FileSelectFile , CoverFile , 3, , Choose Your Cover Art, Image Files(*.jpg;*.jpeg;*.png;) ; Select Cover File
	if CoverFile=	; IF Empty, then return
		return

	;Else Set Cover Art according to supproted format type
	; Note - A Random no. is required in order to create a unique ID because No two frames of cover Art (Multiple Art)
	; 		 Can have the same Description
	CoverType = 3 ; Default Index For Front Cover

	Random , uniq , 102 , 345622
	if FileExtn in MP3,AAC,MPP,TTA
		{
			CoverDes = Added Using IDTE - Id3 Tag Editor [Unique ID = %uniq%]  
			DllCall("AudioGenie3\ID3V2AddPictureFileW",str,Coverfile,str,CoverDes,Uint,CoverType,Int,0)
			errorcode := DllCall("AudioGenie3\AUDIOSaveChangesW") 
		}
	else if FileExtn in FLAC
		{
			CoverDes = Added Using IDTE - Id3 Tag Editor [Unique ID = %uniq%]  
			DllCall("AudioGenie3\FLACAddPictureFileW",str,Coverfile,str,CoverDes,Uint,CoverType,Int,0)
			errorcode := DllCall("AudioGenie3\AUDIOSaveChangesW")
		}
	else if FileExtn in MP4,M4A,M4B,M4P
		{
			DllCall("AudioGenie3\MP4AddPictureFileW",str,Coverfile)
			errorcode := DllCall("AudioGenie3\AUDIOSaveChangesW")
		}
	else if FileExtn in WMA,ASF
		{
			CoverDes = Added Using IDTE - Id3 Tag Editor [Unique ID = %uniq%]  
			DllCall("AudioGenie3\WMAAddPictureFileW",str,Coverfile,str,CoverDes,Uint,CoverType,Int,1)
			errorcode := DllCall("AudioGenie3\AUDIOSaveChangesW")
		}

	; Check if Added Sucessfully
	if(errorcode<>-1)
		MsgBox , An Error is encountered while adding Album Art
	else
		MsgBox , Album Art Added Sucessfully

return

;################################################ REMOVE ALBUM ART #######################################

ButtonRemoveAlbumArt:
    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
	MsgBox ,36, Wait..,Are You Sure?`n	;Prompt First
	IfMsgBox , No
		return

;Remove According to Supported Type
; Note - Only One Cover at a Time is removed therefore in case of multiple coverarts a repeatedly action 
;        Should be applied.

if FileExtn in MP3,AAC,MPP,TTA
{ 
  DllCall( "AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
  DllCall("AudioGenie3\ID3V2DeleteSelectedFrameW",uint,1095780675,uint,1)
  errorcode := DllCall("AudioGenie3\AUDIOSaveChangesW") 
}
else if FileExtn in FLAC
{
	DllCall( "AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
	DllCall("AudioGenie3\FLACDeletePictureW",Uint,1)
	errorcode := DllCall("AudioGenie3\AUDIOSaveChangesW")
}		
else if FileExtn in MP4,M4A,M4B,M4P
{
	DllCall( "AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
	DllCall("AudioGenie3\MP4DeletePictureW",Uint,1)
	errorcode := DllCall("AudioGenie3\AUDIOSaveChangesW")
}			
else if FileExtn in WMA,WMV,WMP,ASF
{
	DllCall( "AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
	DllCall("AudioGenie3\WMADeletePictureW",Uint,1)
	errorcode := DllCall("AudioGenie3\AUDIOSaveChangesW")
}

if(errorcode<>-1)
		MsgBox , 16 , Error , Error Occured While Processing Tag `n%error%
	else
		MsgBox , Album Art Removed Sucessfully
return

;#######################################################  Save Tag ###########################################

ButtonSave:

if FileExtn in MP3,AAC,MPP,TTA
{
	; Check whether file is protected or not
	 protected := DllCall( "AudioGenie3\MPEGIsProtectedW",Int )
  if(protected <> 0)	; if protected
MsgBox, 16, Stop, This MPEG File %Text% is protected`, Therefore you do not have sufficient rights to modify it.

; Else Set Encoding Information = Unicode
 DllCall("AudioGenie3\ID3V2SetFormatAndEncodingW", uint, 0,uint,1)
; Save Tag 
 Trackinfo :=  DllCall("AudioGenie3\ID3V2SetTextFrameW", uint, 1414677323,wstr,Track) 
   Titleinfo  := DllCall("AudioGenie3\ID3V2SetTextFrameW", uint, 1414091826,wstr,Title) 
   Artistinfo :=  DllCall("AudioGenie3\ID3V2SetTextFrameW", uint, 1414546737,wstr,Artist) 
   Albuminfo  :=  DllCall("AudioGenie3\ID3V2SetTextFrameW", uint, 1413565506,wstr,Album) 
   Genreinfo  :=  DllCall("AudioGenie3\ID3V2SetTextFrameW", uint, 1413697358,wstr,Genre) 
   Yearinfo  :=  DllCall("AudioGenie3\ID3V2SetTextFrameW", uint, 1415136594,wstr,Year) 
   
   ;Get Language and Description of Comment 
   ;Note - there can be multiple Comments frame but with different description.
   lang := DllCall("AudioGenie3\ID3V2GetCommentLanguageW", uint, 1,wstr) 
   Desc := DllCall("AudioGenie3\ID3V2GetCommentDescriptionW", uint, 1,wstr) 
   Commentinfo  := DllCall("AudioGenie3\ID3V2AddCommentW", wstr,lang,wstr,Desc,wstr ,Comments)
   
   ;Get Error info (if any)
   errorcode := DllCall("AudioGenie3\ID3V2SaveChangesW")
	
}else {
        Artistinfo  :=  DllCall("AudioGenie3\AUDIOSetArtistW", wstr ,Artist)
        Albuminfo  :=  DllCall("AudioGenie3\AUDIOSetAlbumW", wstr ,Album)
        Yearinfo  :=  DllCall("AudioGenie3\AUDIOSetYearW", wstr ,Year)
        Genreinfo  :=  DllCall("AudioGenie3\AUDIOSetGenreW", wstr ,Genre)
        Trackinfo  :=  DllCall("AudioGenie3\AUDIOSetTrackW", wstr ,Track)
        Titleinfo  :=  DllCall("AudioGenie3\AUDIOSetTitleW", wstr ,Title)
        Commentinfo  :=  DllCall("AudioGenie3\AUDIOSetCommentW", wstr ,Comments)
         errorcode := DllCall("AudioGenie3\AUDIOSaveChangesW")
	}
	
if(errorcode<>-1)
    MsgBox , 16 , Error , Error Occured While Processing Tags `n%error%
else
    MsgBox, Tag Applied Sucessfully

return

GuiClose:
ExitApp