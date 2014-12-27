;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : ViewMenu.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================

;_____________________________________________________________REFRESH  TAG IN LIST _______________________________________________________________________________________________;
ContextRef:
refresh:
REF:
RefreshList:
    SetTimer , Check_Progress , off
    SetTimer , GETLEVEL , off
Progress , M  Fm10 Fs10 WM400 H70 ZH11, Don't Panic`, List will be available soon , Please Wait.. ,Refreshing Fields.. , Arial
    Gui +LastFound
    if ByType=
        ControlGet , List, List, ,SysListView321, A
    else
        {
            ControlGet , List, List, Selected,SysListView321, A
            ByType=
        }
    ALL:=LV_GetCount()
    Now := 0
    GuiControl, -Redraw, MyListView  
    GuiControl, Disable, MyListView  
    Loop, Parse, List, `n  ; Rows are delimited by linefeeds (`n).
        {
            Now++
            Loop, Parse, A_LoopField, %A_Tab% ; Fields (columns) in each row are delimited by tabs (A_Tab).
                {
                    if A_Index=8
                        Text=%A_LoopField%
                    else if A_Index=9
                        Folder=%A_LoopField%
                    else if A_Index=10
                        {
                            loop , %Folder%\%Text%
                                    filename := A_LoopFileFullPath
                            SplitPath , filename , , , FileExtn
                            IfNotExist , %Folder%\%Text%
                                {
                                    Trackinfo = DEAD
                                    Titleinfo = DEAD
                                    Artistinfo = DEAD
                                    Albuminfo  = DEAD
                                    Genreinfo  = DEAD
                                    Yearinfo  = DEAD
                                    Bandinfo  = DEAD
                                    Publisherinfo  = DEAD
                                    Composerinfo  = DEAD
                                    Commentinfo  = DEAD
                                    Channelinfo = DEAD
                                    goto , skiptohere
                                }
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
                            ADG_getinfo(filename,Trackinfo,Titleinfo,Artistinfo,Albuminfo,Genreinfo,Yearinfo,Bandinfo,Publisherinfo,Composerinfo,Commentinfo,Channelinfo,Lyrics)
                            Supp := "ID3V2/V1 Tags"
                            if FileEXtn in WAV
                                Supp := "WAV Chunks"
                            else if FileExtn in FLAC
                                Supp := "FLAC / Vorbis Comments"
                            else if FileExtn in M4A,MP4,M4B
                                Supp := "MP4 Atoms"
                            else if FileExtn in WMA,ASF,WMP,WMV
                                Supp := "WMA Tags"
                            else if FileExtn in OGG
                                Supp := "Vorbis Comments"
                            else if FileExtn in APE,WV
                                Supp := "APE Tags"
                            Channelinfo:= DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetChannelModeW",wstr) 
                            Bitrate  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetBitrateW",int) 
                            Dur := DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetDurationMillisW" )
                            Dur :=  FormatMs(Dur)
                            Sample :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetSampleRateW",int) 
                            FileGetSize, SizeMB ,%filename%,M  
                            skiptohere:
                                LV_Modify(Now,"Col2",Trackinfo, Titleinfo,Artistinfo,Albuminfo,Yearinfo,Genreinfo,Text, Folder,Bandinfo,Publisherinfo,Composerinfo,Commentinfo,SizeMB " MB ",FileExtn,Channelinfo,Sample " Hz",Bitrate " kbps",Dur,Supp)

                        }
                    percent := (Now/ALL)*100
                    Progress , %percent%
                }
        }
    IniRead , Checker9, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,UI,Auto_Adjust 
    if (checker9=1)
        LV_ModifyCol()  ; Auto-size each column to fit its contents.
    Progress , off
    GuiControl , , GUI_Progress, 0
    GuiControl , , GUI_Text, Done
    GuiControl , , GUI_Text, Ready
    GuiControl, +Redraw, MyListView  
    GuiControl, Enable, MyListView  
    GuiControl, Focus , MyListView
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return

;_________________________________________________________________________________________Tag Details______________________________________________________________________________;
TagDetails:
    Gui +OwnDialogs
    MsgBox ,64 ,  Tag Details ,-----------------Tag Info--------------`nTitle = %Titleinfo%`nArtist = %Artistinfo%`nAlbum = %Albuminfo%`nYear = %Yearinfo%`nTrack = %Trackinfo%`nGenre = %Genreinfo%`nComposer = %Composerinfo%`nComments = %Commentinfo%`nPublisher = %Publisherinfo%`nLyrics = %Lyrics%`n---------------Audio Info---------`nSample Rate = %SR% Hz`nChannel Mode = %CH%`nAverage Bitrate = %HZ%kbps`n`n---------------Extended Info-------------`nURL Included =%TXXX%`nURL Included =%TXXX2%`nURL Included =%TXXX3%`nURL Included =%TXXX4%`nURL Included =%TXXX5%`nUser Specified Field =%TXXX6%`nUser Specified Field =%TXXX7%`nUser Specified Field =%TXXX8%`nUser Specified Field =%TXXX9%`nUser Specified Field =%TXXX10%`n-----------------------------------`n
return


;__________________________________________________________________________COVER ART DETAILS_______________________________________________________________________________________;

ContextArt:
CoverDetails:
    IfExist , %A_Temp%\AlbumArt.png
        {
            run , %A_Temp%\AlbumArt.png
        }
    IfNotExist , %A_Temp%\AlbumArt.png
        {
            IfExist , %A_Temp%\AlbumArt.jpg
                {
                    run , %A_Temp%\AlbumArt.jpg
                }  
            else
                {
                    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
                    MsgBox , 64, No Album Art Found , No Cover Art Found
                }
        }
    return


;_______________________________________________________________________________________COPY TAG INFORMATION_______________________________________________________________________;

CopyTag:

    if folder=
    {
        if ChooseFile=
            {
                Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
                MsgBox , 16, Error, Select File(s) First
                return
            }   
    }

    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    TitleCopy= %Titleinfo%
    ArtistCopy= %Artistinfo%
    AlbumCopy= %Albuminfo%
    YearCopy= %Yearinfo%
    TrackCopy= %Trackinfo%
    GenreCopy= %Genreinfo%
    CommentCopy= %Commentinfo%
    BandCopy= %Bandinfo%
    ComposerCopy= %Composerinfo%
    PublisherCopy= %Publisherinfo%
    PublisherCopy= %Publisherinfo%
    GuiControl, Focus , MyListView
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return
;_______________________________________________________________________________________CUT TAG INFORMATION________________________________________________________________________;

CutTag:

    if folder=
        {
            if ChooseFile=
                {
                    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
                    MsgBox , 16, Error, Select File(s) First
                    return
                }
        }
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    GuiControl,, Comments, 
    CommentCopy= %Commentinfo%
    GuiControl,, Genre, 
    GenreCopy= %Genreinfo%
    GuiControl,, Track, 
    TrackCopy= %Trackinfo%
    GuiControl,, Year, 
    YearCopy= %Yearinfo%
    GuiControl,, Album, 
    AlbumCopy= %Albuminfo%
    GuiControl,, Artist, 
    ArtistCopy= %Artistinfo%
    GuiControl,, Title, 
    TitleCopy= %Titleinfo%
    GuiControl,, Band, 
    BandCopy= %Bandinfo%
    GuiControl,, Composer, 
    ComposerCopy= %Composerinfo%
    GuiControl,, Publisher, 
    PublisherCopy= %Publisherinfo%
    GuiControl, Focus , MyListView
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return
;______________________________________________________________________________________PASTE TAG INFORMATION_______________________________________________________________________;

PasteTag:

    if folder=
        {
            if ChooseFile=
                {
                    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
                    MsgBox , 16, Error, Select File(s) First
                    return
                }
        }
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    GuiControl,, Comments, %CommentCopy%
    GuiControl,, Genre, %GenreCopy%
    GuiControl,, Track, %TrackCopy%
    GuiControl,, Year, %YearCopy%
    GuiControl,, Album, %AlbumCopy%
    GuiControl,, Title, %TitleCopy%
    GuiControl,, Artist,%ArtistCopy%
    GuiControl,, Composer, %ComposerCopy%
    GuiControl,, Band, %BandCopy%
    GuiControl,, Publisher, %PublisherCopy%
    GuiControl, Focus , MyListView
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return


;_________________________________________________________________VISUALIZATION ____________________________________________________________________________________________;

Visualisation:

    ArrayCount = 0
    Loop, %A_WorkingDir%\Visualisations\*.*
        {
            SplitPath , A_LoopFileFullPath, , , Exten
            if Exten in SVP,DLL,UVS
                {
                    ArrayCount += 1  ; Keep track of how many items are in the array.
                    Array%ArrayCount% := A_LoopFileFullPath  ; Store this line in the next array element.
                }
        }
    File_Consider:=1

    Gui , Z:New
    Gui,Z: Add, pic, y0 x0 h500 w540 vertical Backgroundblack  hwndVZN gVisual_4_All,
    ; Generated using SmartGUI Creator for SciTE
    Gui,Z: color , black
    Gui,Z: Show, w540 h505, IDTE Visualization Box
    Gui, Z:+Owner +LastFound  +ToolWindow +AlwaysOnTop +Resize
    Win_handle := WinExist("IDTE Visualization Box")
    Win_API:= DllCall("GetModuleHandle", "Ptr",0,"Ptr")
    SFX_DC:=DllCall("GetWindowDC","UInt",VZN,"Int")
    DllCall(A_ScriptDir . "\Bass_SFX.dll\BASS_SFX_Init", "Ptr",Win_API,"Ptr",Win_handle) ;Start BassSFXPlugin
    DllCall(A_ScriptDir . "\Bass_SFX.dll\BASS_SFX_PluginStart", Uint,SFX_Handle)
    DllCall(A_ScriptDir "\Bass_SFX.dll\BASS_SFX_PluginFree") ; Free Bass Contents
    SFX_Handle:=DllCall(A_ScriptDir . "\Bass_SFX.dll\BASS_SFX_PluginCreateW",wstr,A_ScriptDir "\Visualisations\corona.svp", UInt,VZN, int ,540, int ,500, Uint,0,Uint)
    DllCall(A_ScriptDir . "\Bass_SFX.dll\BASS_SFX_PluginStart", Uint,SFX_Handle)


Visual_4_All:
    DllCall(A_ScriptDir "\Bass_SFX.dll\BASS_SFX_PluginFree") ; Free BassSFX Contents
    File_Consider+=1
    if (File_Consider>ArrayCount)
            File_Consider = 1
    Element_Visual := Array%File_Consider%
    Loop , %Element_Visual%
            Visual_file:= A_LoopFileFullPath
    SFX_Handle:=DllCall(A_ScriptDir . "\Bass_SFX.dll\BASS_SFX_PluginCreateW",wstr,Visual_file, UInt,VZN, int ,540, int ,500, Uint,0,Uint)
    DllCall(A_ScriptDir . "\Bass_SFX.dll\BASS_SFX_PluginStart", Uint,SFX_Handle)
    Visualflag=1
return

ZGuiclose:
    Visualflag=0
    Gui, Z:destroy
return
