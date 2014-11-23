;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : IDTEFastMode.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================

FastMode:
    TempDB = %A_Temp%\LastDB
    fileTemp:=FileOpen(TempDB,"w")
    Gui +LastFound
    ControlGet, List, List, , SysListView321, A
    NowRowNumber:=LV_GetNext("F")
    totalrows:=LV_GetCount()
    Loop, Parse, List, `n  ; Rows are delimited by linefeeds (`n).
        {
            Loop, Parse, A_LoopField, %A_Tab%  ; Fields (columns) in each row are delimited by tabs (A_Tab).
                {
                    if (A_Index=8)
                        FileName=%A_LoopField%
                    if (A_Index=9)
                        FileDir=%A_LoopField%
                }
            String =  %FileDir%\%FileName%`r`n
            fileTemp.write(String)
        }
    fileTemp.close()

    Gui, Fast:Font, S8  Bold, Arial
    change_field=
    Gui,Fast:Add, GroupBox, x37 y6 w341 h319 +Center, Metadata
    Gui,Fast:Add, GroupBox, x392 y9 w200 h210 +Center, Album Art
    Gui,Fast:Add, Button, x392 y299 w80 h20 , Save
    Gui,Fast:Add, Button, x502 y299 w80 h20 , Close
    Gui,Fast:Add, Button,x602 y99 w30 h60 vNext_file , >>
    Gui,Fast:Add, Button,x2 y99 w30 h60 vPrev_file , <<

    Gui,Fast:Add, Text, x52 y29 w100 h20 , Artist
    Gui,Fast:Add, Text, x52 y59 w100 h20 , Album
    Gui,Fast:Add, Text, x52 y89 w100 h20 , Title
    Gui,Fast:Add, Text, x52 y119 w100 h20 , Track
    Gui,Fast:Add, Text, x52 y149 w100 h20 , Year
    Gui,Fast:Add, Text, x52 y179 w100 h20 , Genre
    Gui,Fast:Add, Text, x52 y209 w100 h20 , Composer
    Gui,Fast:Add, Text, x52 y239 w100 h20 , Publisher
    Gui,Fast:Add, Text, x52 y269 w100 h20 , Band/Orchestra
    Gui,Fast:Add, Text, x52 y299 w100 h20 , Comments
    Gui,Fast:Add, Text, x392 y229 w100 h20 , Lyrics:
    Gui,Fast:Add, Text,  x10 y330 w620 h40 cRed vDirect +Center Border, Current File = %Text%`n Current Folder = %Folder%  
    Gui, Fast:Font, cBlue, 
    Gui,Fast:Add, Pic, x412 y29 w160 h160 vCAFast , %A_WorkingDir%\GUI\music_icon.png
    Gui,Fast:Add, Edit, x142 y29 w210 h20 vArtistI, 
    Gui,Fast:Add, Edit, x142 y59 w210 h20 vAlbumI, 
    Gui,Fast:Add, Edit, x142 y89 w210 h20 vTitleI, 
    Gui,Fast:Add, Edit, x142 y119 w210 h20 vTrackI, 
    Gui,Fast:Add, Edit, x142 y149 w210 h20 vYearI, 
    Gui,Fast:Add, Edit, x142 y179 w210 h20 vGenreI, 
    Gui,Fast:Add, Edit, x142 y209 w210 h20 vComposerI, 
    Gui,Fast:Add, Edit, x142 y239 w210 h20 vPublisherI, 
    Gui,Fast:Add, Edit, x142 y269 w210 h20 vBandI, 
    Gui,Fast:Add, Edit,  x142 y299 w210 h20 vCommentsI, 
    Gui,Fast:Add, Button , x462 y190 w70, Change
    Gui,Fast:Add, Edit,  x392 y249 w200 h45 vlyricsI, 
    Gui, Fast:Font, S8 Bold, Arial
    Gui, Fast:Show, w639 h373, Quick Tag Editing Mode
    WinSet , AlwaysOnTop , , Quick Tag  Editing Mode
    OnMessage(0x205, "WM_MOUSELEFT")
    goto , Highlight_Specific
    return

    Next_file_TT:="Go to next file"
    Next_file_TT:="Go to previous file"

FastButtonClose:
FastGuiClose:
    Gui, Fast: Destroy
    if(change_field=1)
            MsgBox , 64, Information, Please Refresh the List in order to review Changes
    return

Highlight_Specific:
    SetTimer , Check_Progress, off 
    SetTimer , GETLEVEL , off
    if Folder=
        {
            if ChooseFile=
                {
                    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
                    msgbox ,16,  Error, No File(s) 
                    return
                }
        }
    if (NowRowNumber>totalrows)
            NowRowNumber:=1
    else if(NowRowNumber<1)
            NowRownumber:=totalrows
    FileDelete , %A_Temp%\AlbumArt.png
    FileDelete , %A_Temp%\AlbumArt.jpg
    DllCall( "LoadLibrary", Str,A_ScriptDir "\Plugins\AudioGenie3.dll" )
    DllCall( "AudioGenie3\AUDIOAnalyzeFile", Str,Dummy ) ; Dummy Call for SplashText
    FileReadLine , Directory,%A_Temp%\LastDB , %NowRowNumber%
	
    IfNotExist , %Directory%
        {
            MsgBox, 48, Dead File Detected, This file seems to be dead`, please reload the file
            return
        }
    Loop , %Directory%
            mp3FileA := A_LoopFileFullPath

    Trackinfo =
    Titleinfo = 
    Artistinfo =
    Albuminfo  =
    Genreinfo  =
    Yearinfo  =
    Bandinfo  =
    Publisherinfo  =
    Composerinfo  =
    Commentinfo  =
    Channelinfo =
    SplitPath, mp3FileA,,, FileExt  ; Get Extension
    ADG_getinfo(mp3fileA,Trackinfo,Titleinfo,Artistinfo,Albuminfo,Genreinfo,Yearinfo,Bandinfo,Publisherinfo,Composerinfo,Commentinfo,Channelinfo,Lyrics)
    ADG_getcover()
    ADG_getcoverinfo(covertypeinfo, coversize, PicNum)
    SplitPath , Directory , Filenam, OutDir
    if Lyrics=
        Lyrics = No Lyrics Found
    GuiControl,Fast:, TitleI, %Titleinfo%
    GuiControl,Fast:, ArtistI, %Artistinfo%
    GuiControl,Fast:, AlbumI, %Albuminfo%
    GuiControl,Fast:, YearI, %Yearinfo%
    GuiControl,Fast:, TrackI, %Trackinfo%
    GuiControl,Fast:, CommentsI, %Commentinfo%
    GuiControl,Fast:, GenreI, %Genreinfo%
    GuiControl,Fast:, BandI, %Bandinfo%
    GuiControl,Fast:, ComposerI, %Composerinfo%
    GuiControl,Fast:, PublisherI, %Publisherinfo%
    GuiControl,Fast:, LyricsI, %Lyrics%
    GuiControl,Fast:, covertypeI,%Covertypeinfo% - %coverSize% Bytes
    GuiControl,Fast:, Direct, Current File = %Filenam%`nCurrent Folder = %OutDir%
    IfExist , %A_Temp%\AlbumArt.png
        GuiControl,Fast:, CAFast, *w160 *h160 %A_Temp%\AlbumArt.png
    IfNotExist , %A_Temp%\AlbumArt.png
        IfExist , %A_Temp%\AlbumArt.jpg
        GuiControl,Fast:, CAFast, *w160 *h160 %A_Temp%\AlbumArt.jpg
        else
        GuiControl,Fast:, CAFast, *w160 *h160 %A_WorkingDir%\GUI\music_icon.png

    SetTimer , Check_Progress, on 
    SetTimer , GETLEVEL , on
return


FastButton>>:
    NowRowNumber++
    goto , Highlight_Specific
return


FastButton<<:
    NowRowNumber--
    goto , Highlight_Specific
return

FastButtonSave:
    Gui,Fast:submit , NoHide

    Loop , %Directory%
        filename := A_LoopFileFullPath

IniRead , checker31,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Prompt ,Prompt_Passwd_Edit
    if(Checker31=1)
        {
            IfExist , %Windir%\psswd.dat
                {
                    Gui +OwnDialogs
                    InputBox , Confirm_pwrd , Enter Password, Enter Password To Save Tags, HIDE, 200,150 , UseErrorLevel
                    if Errorlevel
                        {
                            MsgBox , 16, Error, You Do Not Have Sufficient Privilages To Modify Tags 
                            return   
                        }    
                    if(Confirm_pwrd!=read_file)
                        {
                            MsgBox , 16, Error, You Do Not Have Sufficient Privilages To Modify Tags 
                            return
                        }
                }
        }

SplitPath , Directory , , , FileExtn

if FileExtn in MP3,AAC,MPP,TTA
{
    DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
    DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetFormatAndEncodingW", uint, 0,uint,1)
    Trackinfo :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1414677323,wstr,TrackI)
    Titleinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1414091826,wstr,TitleI)
    Artistinfo :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1414546737,wstr,ArtistI)
    Albuminfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1413565506,wstr,AlbumI)
    Genreinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1413697358,wstr,GenreI)
    Yearinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1415136594,wstr,YearI) 
    Bandinfo  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1414546738,wstr,BandI) 
    Publisherinfo  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint,1414550850,wstr,PublisherI)
    Composerinfo  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1413697357,wstr,ComposerI) 
      lang := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetCommentLanguageW", uint, 1,wstr) 
    Desc := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetCommentDescriptionW", uint, 1,wstr) 
    Commentinfo  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2AddCommentW", wstr,lang,wstr,Desc,wstr ,CommentsI)
    errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SaveChangesW")
}
else
{
    if FileExtn in OGG
        {
            RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --remove "%Folder%\%Text%", , hide
            RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --artist "%Artist%" --album "%Album%" --track "%Track%" --title "%Title%" --year "%Year%" --genre "%Genre%" --comment "%Comments%" "%Folder%\%Text%", , hide
        }
    else
        {
            DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
            Artistinfo  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetArtistW", wstr ,ArtistI)
            Albuminfo  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetAlbumW", wstr ,AlbumI)
            Yearinfo  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetYearW", wstr ,YearI)
            Genreinfo  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetGenreW", wstr ,GenreI)
            Trackinfo  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetTrackW", wstr ,TrackI)
            Titleinfo  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetTitleW", wstr ,TitleI)
            Commentinfo  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetCommentW", wstr ,CommentsI)
            Composerinfo := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetComposerW", wstr ,ComposerI)
            errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSaveChangesW")
            if FileExtn in FLAC
                {
                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACSetUserItemW",wstr, "ALBUMARTIST", wstr, Band)
                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACSetUserItemW",wstr, "PUBLISHER", wstr, Publisher)  
                    errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACSaveChangesW")
                }  
            else if FileExtn in M4A,MP4,M4B
                {
                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4SetiTuneFrameW",wstr, "aART", wstr, Band)
                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4SetiTuneFrameW",wstr, "Copyright", wstr, Publisher)
                    errorcode :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4SaveChangesW")
                }
            else if FileExtn in WMA,ASF
                {
                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMASetUserItemW",wstr, "WM/AlbumArtist", wstr, Band)
                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMASetUserItemW",wstr, "WM/Publisher", wstr, Publisher)
                    errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMASaveChangesW")
                }
            else if FileExtn in APE,WV
                {
                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\APESetUserItemW",wstr,"Album Artist", wstr, Band)
                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\APESetUserItemW",wstr,"Publisher", wstr, Publisher)
                    errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\APESaveChangesW")
                }
        }
}


;Lyrics Check
    if FileExtn in MP3,AAC,MPP,TTA
        {
            DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
            DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2AddLyricW", wstr ,ENG , wstr, "Added Using IDTE- ID3 Tag Editor", wstr, LyricsI ) 
            errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SaveChangesW" ) 
        }
    else
        {
            DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
            if(playback_file = filename)
                {
                    DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelStop", UInt,hMedia) ;Clear its buffer
                    DllCall(A_ScriptDir "\bass.dll\BASS_Pause") ; Free Bass Contents
                    DllCall(A_ScriptDir "\bass.dll\BASS_Stop") ; Free Bass Contents
                    DllCall(A_ScriptDir "\bass.dll\BASS_PluginFree", int, 0) ; Free Bassplugins Contents
                    DllCall(A_ScriptDir "\bass.dll\BASS_Free") ; Free Bass Contents
                    GuiControl , , Clist ,Stopped :`n%Play_Title%
                    Play_Str = Stopped :`n%Play_Title%
                    flag=0
                    FlagStopped=1
                }
            if FileExtn in FLAC
                {
                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACSetUserItemW",wstr, "LYRICS", wstr , LyricsI) 
                        errorcode :=   DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACSaveChangesW")
                }
            else if FileExtn in M4A,MP4,M4B
                {
                        Progress , off
                        Gui +OwnDialogs
                        MsgBox, 52, Warning, Add Lyrics as an Itunes Frame (will be incompatible with the some of the media players) ?
                        IfMsgBox , Yes
                            {
                                Progress , M  Fm10 Fs10 WM400 H70 ZH11, Please wait.. , Working Please Wait.. ,Working.. , Arial
                                Progress , %percentage% , Processed %A_Index%/%ValueRow%
                                DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4SetiTuneFrameW",wstr,"©lyr", wstr , LyricsI) 
                                errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4SaveChangesW")
                            }
                } 
            else if FileExtn in APE,WV
                {
                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\APESetUserItemW",wstr,"Lyrics", wstr , LyricsI) 
                        errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\APESaveChangesW")
                } 
            else if FileExtn in WMA
                {
                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMASetUserItemW",wstr,"WM/Lyrics", wstr , LyricsI) 
                        errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMASaveChangesW")
                } 
            else
                {
                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\LYRICSSetLyricsW", wstr ,LyricsI) 
                        errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\LYRICSSaveChangesW" )
                }
        }
    change_field=1
    GuiControl , , GUI_Progress, 0
    GuiControl , , GUI_Text, Done

    if(errorcode<>-1)
            Message = Error occured while applying Tag
    else
            Message = Tag Applied Sucessfully

    IniRead , checker41,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Tray_Not,Tray_Not_Sucess
    if (checker41=1)
        {
            #Persistent
            TrayTip, %Message%, 
            SetTimer, RemoveTrayTip, %Tray_Time%000
        }
    IniRead , checker28,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Miscellaneous,Enable_Toaster
    IniRead , checker49,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Tost_Not,Tost_Not_Sucess
    if (Checker49=1)    
        {
        if  (checker28!=0)
            {
                Title = IDTE -ID3 Tag Editor
                Lifespan = %timet_toast%000 ;ms
                Notify("","",0,"Wait=50")
                Notify("IDTE-ID3 Tag Editor", Message, 2,"TS=12 TM=8 TF=Times New Roman SI_=400 GF=2 GL=3")
            }
        }
    GuiControl , , Statusinfo , Tip = Refresh Fields to View Applied Changes 
    GuiControl , , GUI_Text, Ready
return

FastButtonChange:   
    Gui,Fast:submit , NoHide

Loop , %Directory%
    filename := A_LoopFileFullPath

FileSelectFile , CoverFile , 3, , Choose Your Cover Art, Image Files(*.jpg;*.jpeg;*.png;)
    if CoverFile=
        return
    if CoverType =
        CoverType = 3
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    SplitPath , Directory , , , FileExtn
    if FileExtn in MP3,AAC,MPP,TTA  
            RunWait , %WinDir%\system32\cmd.exe /c Bin\IDTE "IDTE_PIC_WRITE" "%Folder%\%Text%" "%CoverFile%" "%CoverType%" , , hide 
    else if FileExtn in FLAC
        {
            CoverDes := "Added Using IDTE - Id3 Tag Editor"
            DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
            DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACAddPictureFileW",str,Coverfile,str,CoverDes,Uint,CoverType,Int,0)
            errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSaveChangesW")
        }
    else if FileExtn in MP4,M4A,M4B,M4P
        {
            DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
            DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4AddPictureFileW",str,Coverfile)
            errorcode:=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSaveChangesW")
        }
    else if FileExtn in WMA,WMV,WMP,ASF
        {
            CoverDes := "Added Using IDTE - Id3 Tag Editor"
            DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
            DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMAAddPictureFileW",str,Coverfile,str,CoverDes,Uint,CoverType,Int,1)
            errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSaveChangesW")
        }
    else
        {
            MsgBox , 36, Unsupported Picture Type , This file --> %Text% Seems to do not support the Picture Frame `,`nAnyWay Add ID3v2 Picture Frame Into It ?
            ifMsgBox , Yes
                    RunWait , %WinDir%\system32\cmd.exe /c Bin\IDTE "IDTE_PIC_WRITE" "%Folder%\%Text%" "%CoverFile%" "%CoverType%" , , hide 
            IfMsgBox , No
                    SplashTextOff
        }
    DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4GetPictureFileW", wstr , A_Temp "\AlbumArt.png", uint, 01)
    DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetPictureFileW", wstr , A_Temp "\AlbumArt.png", uint, 01)
    DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACGetPictureFileW", wstr , A_Temp "\AlbumArt.png", uint, 01)
    DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMAGetPictureFileW", wstr , A_Temp "\AlbumArt.png", uint, 01)
    IfExist , %A_Temp%\AlbumArt.png
        GuiControl,Fast:, CAFast, *w160 *h160 %A_Temp%\AlbumArt.png
    IfNotExist , %A_Temp%\AlbumArt.png
        GuiControl,Fast:, CAFast, *w160 *h160 %A_WorkingDir%\GUI\music_icon.png
 
    SB_SetText("Cover art added sucessfully",4)
    SplashTextOff
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
    goto , Highlight_Specific
return