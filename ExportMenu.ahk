;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : ExportMenu.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================

;___________________________________________________EXPORT TO TXT________________________________________________________________________________________________________________;
ETT:
Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
    FileSelectFile ,TXTOutput , S8, , Save Your Text File, Text File(*.txt)
    if TXTOutput=
        return
    else
        SetTimer , Check_Progress , off 
        SetTimer , GETLEVEL , off
    ControlGet , List, List, Selected,SysListView321, A
    ALL:=LV_GetCount("S")
    if (ALL=0)
        {
            SplashTextOff
            MsgBox , 64 , Error , No file(s) found for the required operation`, First select the files from the listview     
            SetTimer , Check_Progress 
            if min=
                SetTimer , GETLEVEL , 1
            else 
                SetTimer , GETLEVEL , off
            return
        }

    OutputFile = %TXTOutput%.txt
    fileOUT:=FileOpen(OutputFile,"w")
    fileOUT.write("--------------------------------------Tag Information Generated By IDTE - ID3 Tag Editor--------------------------------------`r`n")
    Gui +LastFound
    if (ALL!=0)
    Loop, Parse, List, `n  ; Rows are delimited by linefeeds (`n).
    {
        Guicontrol , , GUI_Progress, %percent%
        Loop, Parse, A_LoopField, %A_Tab%  ; Fields (columns) in each row are delimited by tabs (A_Tab).
        {
            if (A_Index=2)
                TrackInfo=%A_LoopField%
            else if (A_Index=3)
                Titleinfo=%A_LoopField%
            else if (A_Index=4)
                ArtistInfo=%A_LoopField%
            else if (A_Index=5)
                Albuminfo=%A_LoopField%
            else if (A_Index=6)
                YearInfo=%A_LoopField%
            else if (A_Index=7)
                Genreinfo=%A_LoopField%
            else if (A_Index=8)
                FileName=%A_LoopField%
            else if (A_Index=9)
                FileDir=%A_LoopField%
            else if (A_Index=10)
                BandInfo=%A_LoopField%
            else if (A_Index=11)
                PublisherInfo=%A_LoopField%
            else if (A_Index=12)
                ComposerInfo=%A_LoopField%
            else if (A_Index=13)
                Commentinfo=%A_LoopField%
            else if (A_Index=14)
                FileSizeMB=%A_LoopField%
            else if (A_Index=15)
                FileExt=%A_LoopField%
            else if (A_Index=16)
                Channelinfo=%A_LoopField%
            else if (A_Index=17)
                Sample=%A_LoopField%
            else if (A_Index=18)
                Bitrate=%A_LoopField%
            else if (A_Index=19)
                Dur=%A_LoopField%
        }
        String =  Filename = %FIledir%\%Filename%`r`nTrack = %Trackinfo%`r`nTitle = %Titleinfo%`r`nArtist = %Artistinfo%`r`nAlbum = %Albuminfo%`r`nYear = %Yearinfo%`r`nGenre = %Genreinfo%`r`nBand\Orchestra = %Bandinfo%`r`nPublisher = %Publisherinfo%`r`nComposer = %Composerinfo%`r`nComments = %Commentinfo%`r`nFileSize = %FileSizeMB%`r`nFileType = %FileExt%`r`nChannels = %Channelinfo%`r`nSample Rate = %SAmple%`r`nAverage Bitrate = %Bitrate%`r`nDuration = %Dur%`r`n`r`n---------------------------------------------------------------`r`n
    fileOUT.write(String)
    Now++
    Percent := (Now/ALL)*100
    }
    fileOUT.close()
    Guicontrol , , GUI_Progress, 100
    Guicontrol , , GUI_Progress, 0
    GuiControl , , GUI_Text , Exported Sucessfully
    GuiControl , , milli, Exported Sucessfully
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 1
    else 
        SetTimer , GETLEVEL , off
MsgBox , 64, Export , Tag Information Exported Sucessfully
return

;_________________________________________________________EXPORT TO NFO____________________________________________________________________________________________________________;
ETNF:
Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
    FileSelectFile ,TXTOutput ,S8 , , Save Your NFO File, NFO(*.nfo)
    if TXTOutput=
        return
    else
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    ControlGet , List, List, Selected,SysListView321, A
    ALL:=LV_GetCount("S")
    if (ALL=0)
        {
            SplashTextOff
            MsgBox , 64 , Error , No file(s) found for the required operation`, First select the files from the listview     
            SetTimer , Check_Progress 
            if min=
                SetTimer , GETLEVEL , 1
            else 
                SetTimer , GETLEVEL , off
            return
        }       
    OutputFile = %TXTOutput%.nfo
    fileOUT:=FileOpen(OutputFile,"w")
    fileOUT.write("--------------------------------------NFO Template--------------------------------------`r`n")
    fileOUT.write("//Ripped Date: `r`n//Ripped By :`r`n//Encoded Using:`r`n//Copyright :`r`n//Place:`r`n")
    fileOUT.write("--------------------------------------Information--------------------------------------`r`n")
    Gui +LastFound
    if (ALL!=0)
    Loop, Parse, List, `n  ; Rows are delimited by linefeeds (`n).
        {
            Guicontrol , , GUI_Progress, %percent%
            Loop, Parse, A_LoopField, %A_Tab%  ; Fields (columns) in each row are delimited by tabs (A_Tab).
                {
                    StringReplace ,  A_Field, A_LoopField , %A_Space%,., All 
            if (A_Index=2)
                TrackInfo=%A_Field%
            else if (A_Index=3)
                Titleinfo=%A_Field%
            else if (A_Index=4)
                ArtistInfo=%A_Field%
            else if (A_Index=5)
                Albuminfo=%A_Field%
            else if (A_Index=6)
                YearInfo=%A_Field%
            else if (A_Index=7)
                Genreinfo=%A_Field%
            else if (A_Index=8)
                FileName=%A_Field%
            else if (A_Index=9)
                FileDir=%A_Field%
            else if (A_Index=10)
                BandInfo=%A_Field%
            else if (A_Index=11)
                PublisherInfo=%A_Field%
            else if (A_Index=12)
                ComposerInfo=%A_Field%
            else if (A_Index=13)
                Commentinfo=%A_Field%
            else if (A_Index=14)
                FileSizeMB=%A_Field%
            else if (A_Index=15)
                FileExt=%A_Field%
            else if (A_Index=16)
                Channelinfo=%A_Field%
            else if (A_Index=17)
                Sample=%A_Field%
            else if (A_Index=18)
                Bitrate=%A_Field%
            else if (A_Index=19)
                Dur=%A_Field%

        }
    String =  begin.file:// `r`n//Name.of.file //%FIledir%\%Filename%`r`n//Track  //%Trackinfo%`r`n//Title.of.the.song //%Titleinfo%`r`n//Performed.by//%Artistinfo%`r`n//Album.of.the.song //%Albuminfo%`r`n//Year.of.Song.released//%Yearinfo%`r`n//Band\Orchestra  //%Bandinfo%`r`n//Publisher.of.the.song //%Publisherinfo%`r`n//Song.Composed.By //%Composerinfo%`r`n//Complete.FileSize //%FileSizeMB%`r`n//Ripped.Output //%FileExt% Formatr`n//Sample.Rate.of.song // %Sample%r`n//Average.Bitrate.of.the.song// %Bitrate%`r`n//Duration.of.the.song// %Dur%r`n//Information.Created.By.IDTE`r`n---------------------------------------------------------------`r`n
    fileOUT.write(String)
    Now++
    Percent := (Now/ALL)*100
}
    fileOUT.close()
    Guicontrol , , GUI_Progress, 100
    Guicontrol , , GUI_Progress, 0
    GuiControl , , GUI_Text , Exported Sucessfully
    GuiControl , , milli, Exported Sucessfully
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 1
    else 
        SetTimer , GETLEVEL , off
    MsgBox , 64, Export , NFO Template Exported Sucessfully 
return
;__________________________________________________________________EXPORT TO USER SPECIFIED FORMAT_______________________________________________________________________________;
ETUSF:


    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
    FileSelectFile ,USFOutput ,S8 , , Please Also Specify the Name Of the Exported Format (Including Extension) 
    if USFOutput=
        return
    else
    if Errorlevel
        return
    SplashTextOn , , , Analysing Format..
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    sleep , 500
    SplashTexton , , , Exporting Format...
    ControlGet, List, List, Selected, SysListView321, A
    ValueRow:= LV_GetCount("S")
    ALL:=LV_GetCount("S")
    if (ALL=0)
        {
            SplashTextOff
            MsgBox , 64 , Error , No file(s) found for the required operation`, First select the files from the listview     
            SetTimer , Check_Progress 
            if min=
                SetTimer , GETLEVEL , 1
            else 
                SetTimer , GETLEVEL , off
            return
        }
    SingleTag=%ValueRow%
    FileAppend , `n------------------Information Created By IDTE - ID3 Tag Editor-------------------`n`n, %USFOutput%
    Loop, Parse, List, `n  ; Rows are delimited by linefeeds (`n).
        {
            percentage := (A_Index/ValueRow)*100
            GuiControl , , GUI_Progress, %percentage%
            GuiControl , , GUI_Text, %A_Index%/%ValueRow%
            Loop, Parse, A_LoopField, %A_Tab% ; Fields (columns) in each row are delimited by tabs (A_Tab).
                {
                    if A_Index=8
                        Text=%A_LoopField%
                    if A_Index=9
                        Folder=%A_LoopField%
                    if A_Index=10
                        {
                            loop , %Folder%\%Text%
                                {   
                                    filename := A_LoopFileFullPath
                                }
                            DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
                            ArtistMulti  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetArtistW",wstr)
                            AlbumMulti  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetAlbumW",wstr)
                            YearMulti  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetYearW",wstr)
                            GenreMulti  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetGenreW",wstr)
                            TrackMulti  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetTrackW",wstr)
                            TitleMulti  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetTitleW",wstr)
                            Bitrate  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetBitrateW",int) 
                            Dur := DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetDurationMillisW" )
                            Dur :=  FormatMs(Dur)
                            Sample := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetSampleRateW",int) 
                            Lyrics :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\LYRICSGetLyricsW",wstr)
                            if Lyrics=
                                Lyrics := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetTextFrameW", uint, 1431522388,wstr)
                            FileAppend , Song = %Folder%\%Text%`nTitle = %TitleMulti%`nArtist = %ArtistMulti%`nAlbum = %AlbumMulti%`nTrack = %TrackMulti%`nYear = %YearMulti%`nGenre = %GenreMulti%`nLyrics =%Lyrics%`nFileName =%Text%`nAverage Bitrate = %Bitrate%`nSample Rate = %Bitrate%`nDuration = %Dur%`n`n, %USFOutput%
                        }
                }
        }
    FileAppend , `nNote --> Retry In Case Of Incomplete/Blank Information, %USFOutput%
    SplashTextOff
    USFOutput=
    GuiControl , , GUI_Progress, 0
    GuiControl , , GUI_Text, Done
    GuiControl , , milli, Information Exported
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 1
    else 
        SetTimer , GETLEVEL , off
    MsgBox , 64, Export , Tag Information Exported Sucessfully
return

;_______________________________________________________________________EXTRACT COVER ART________________________________________________________________________________________;
ContextExtract:
ECA:
    FileDelete , %A_Temp%\AlbumArt.png
    FileDelete , %A_Temp%\AlbumArt.jpg
    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
    FileSelectFolder ,COutput , , , Select Directory For Saving Cover Art
    if COutput=
        return
    else
        SetTimer , Check_Progress , off 
        SetTimer , GETLEVEL , off
    ControlGet, List, List, Selected, SysListView321, A
    ValueRow:= LV_GetCount("S")
    SingleTag=%ValueRow%
    Progress , M  Fm10 Fs10 WM400 H70 ZH11, Please wait.. , Extracting Please Wait.. , , Arial
    Loop, Parse, List, `n  ; Rows are delimited by linefeeds (`n).
        {
            percentage := (A_Index/ValueRow)*100
            Progress , %percentage% , Processed %A_Index%/%ValueRow%
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
                            DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )

                            Mime := DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACGetPictureMimeW",uint, 01,wstr)
                            DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACGetPictureFileW", wstr , A_Temp "\AlbumArt.jpg", uint, 01)
                    IfInString , Mime , jpeg
                        {
                            FileMove , %A_Temp%\AlbumArt.jpg, %Coutput%\CoverArt%SingleTag%.jpg , 0
                        }
                    else    
                        {
                            FileMove , %A_Temp%\AlbumArt.jpg, %Coutput%\CoverArt%SingleTag%.png , 0
                        }
                    Mime := DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4GetPictureMimeW",uint, 01,wstr)
                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4GetPictureFileW", wstr , A_Temp "\AlbumArt.jpg", uint, 01)
                    IfInString , Mime , jpg
                        {
                            FileMove , %A_Temp%\AlbumArt.jpg, %Coutput%\CoverArt%SingleTag%.jpg , 0
                        }
                    else    
                        {
                            FileMove , %A_Temp%\AlbumArt.jpg, %Coutput%\CoverArt%SingleTag%.png , 0
                        }
                    Mime := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetPictureMimeW",uint, 01,wstr)
                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetPictureFileW", wstr , A_Temp "\AlbumArt.jpg", uint, 01)
                    IfInString , Mime , jpeg
                        {
                            FileMove , %A_Temp%\AlbumArt.jpg, %Coutput%\CoverArt%SingleTag%.jpg , 0
                        }
                    else
                        {
                            FileMove , %A_Temp%\AlbumArt.jpg, %Coutput%\CoverArt%SingleTag%.png , 0
                        }
                    Mime := DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMAGetPictureMimeW",uint, 01,wstr)
                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMAGetPictureFileW", wstr , A_Temp "\AlbumArt.jpg", uint, 01)
                    IfInString , Mime , jpg
                        {
                            FileMove , %A_Temp%\AlbumArt.jpg, %Coutput%\CoverArt%SingleTag%.jpg , 0
                        }
                    else    
                        {
                            FileMove , %A_Temp%\AlbumArt.jpg, %Coutput%\CoverArt%SingleTag%.png , 0
                        }
                }
            }
            SingleTag=%A_Index%
        }
    Progress , off
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 1
    else 
        SetTimer , GETLEVEL , off
    MsgBox , 64, Export , Cover Art Exported Sucessfully
return

;_________________________________________________________EXPORT TO HTML__________________________________________________________________________________________________________;
ETHTM:
FileEncoding , 

SetTimer , Check_Progress , off 
SetTimer , GETLEVEL , off
SplashTextOn , , ,Preparing Format...
FileCopy , %A_WorkingDir%\Exporting Formats\IDTE.html , %A_Temp%\IDTE.html,1
ControlGet, List, List, Selected, SysListView321, A
ValueRow:= LV_GetCount("S")
ALL:=LV_GetCount("S")
if (ALL=0)
{
    SplashTextOff
    MsgBox , 64 , Error , No file(s) found for the required operation`, First select the files from the listview     
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 1
    else 
        SetTimer , GETLEVEL , off
return
}

SingleTag=%ValueRow%
Loop, Parse, List, `n  ; Rows are delimited by linefeeds (`n).
{
    percentage := (A_Index/ValueRow)*100    
    GuiControl , , GUI_Progress, %percentage%
    GuiControl , , GUI_Text, %A_Index%/%ValueRow%
    Loop, Parse, A_LoopField, %A_Tab% ; Fields (columns) in each row are delimited by tabs (A_Tab).
        {
            if A_Index=8
                Text=%A_LoopField%
            else if A_Index=9
                Folder=%A_LoopField%
            else if A_Index=10
                {
                    gui , submit , NoHide
                    loop , %Folder%\%Text%
                        filename := A_LoopFileFullPath
                    DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
                    ArtistMulti  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetArtistW",wstr)
                    AlbumMulti  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetAlbumW",wstr)
                    YearMulti  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetYearW",wstr)
                    GenreMulti  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetGenreW",wstr)
                    TrackMulti  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetTrackW",wstr)
                    TitleMulti  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetTitleW",wstr)
                    FileAppend , <tr>`n<td class="odd">%TitleMulti%</td>`n<td class="odd">%ArtistMulti% </td>`n<td class="odd">%AlbumMulti%</td>`n<td class="odd">%TrackMulti%</td>`n<td class="odd">%YearMulti%</td>`n<td class="odd">%GenreMulti%</td>`n<td class="odd">%Text%</td>`n</tr>`n, *%A_Temp%\IDTE.html
                }
        }
}
GuiControl , , GUI_Progress, 0
GuiControl , , GUI_Text, Done
GuiControl , , milli, HTML Created
FileAppend , </table>`n</body>`n</html>`n , *%A_Temp%\IDTE.html
SplashTextOff
gui,+OwnDialogs
FileSelectFile , OUTHTML , S8 , , Save Your HTML File , Hypertext markup language(*.html)
    if OUTHTML=
        {
            FileDelete ,%A_Temp%\IDTE.html
            SetTimer , Check_Progress 
            if min=
                SetTimer , GETLEVEL , 1
            else 
                SetTimer , GETLEVEL , off   
            return
        } 
    else
    FileCopy , %A_Temp%\IDTE.html , %OUTHTML%.html, 1
    FileDelete ,%A_Temp%\IDTE.html
    FileDelete ,%A_Temp%\taginfo3.txt
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 1
    else 
        SetTimer , GETLEVEL , off
    MsgBox , 64, Export , Tag Information Exported Sucessfully
    FileEncoding , UTF-16
return

;_______________________________________________________________________________SPIFF Shareable XML Playlist _________________________________________________________________________________;
EXML:
Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
FileSelectFolder ,XSFOutput , , , Select Directory For Saving XSPF 1.0 (spiff)
if XSFOutput=
    return
else
    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
InputBox , XSF, Specify Name, Specify Name Of the Exported File , UseErrorLevel
if Errorlevel
    return
SplashTextOn , , , Checking Template..
SetTimer , Check_Progress , off 
SetTimer , GETLEVEL , off
    sleep , 500
SplashTexton , , , Exporting XSPF v1.0 ...
ControlGet, List, List, Selected, SysListView321, A
ValueRow:= LV_GetCount("S")
ALL:=LV_GetCount("S")
if (ALL=0)
{
    SplashTextOff
    MsgBox , 64 , Error , No file(s) found for the required operation`, First select the files from the listview     
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 1
    else 
        SetTimer , GETLEVEL , off
return
}
FileAppend , <?xml version="1.0" encoding="UTF-8"?>`n<playlist version="1" xmlns="http://xspf.org/ns/0/" createdby = "IDTE - ID3 tag editor">`n<trackList>`n , %XSFOutput%\%XSF%.xspf , UTF-8
SingleTag=%ValueRow%
Loop, Parse, List, `n  ; Rows are delimited by linefeeds (`n).
{
    percentage := (A_Index/ValueRow)*100
    GuiControl , , GUI_Progress, %percentage%
    GuiControl , , GUI_Text, %A_Index%/%ValueRow%
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
                    DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
                    ArtistMulti  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetArtistW",wstr)
                    AlbumMulti  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetAlbumW",wstr)
                    TitleMulti  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetTitleW",wstr)
                    TimeMs := DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetDurationMillisW" )
                    FileAppend  , `n<track>`n<location>file:///%filename%</location>`n`n<!-- artist or band name -->`n <creator>%ArtistMulti%</creator>`n`n<!-- album title -->`n<album>%AlbumMulti%</album>`n`n<!-- name of the song -->`n<title>%TitleMulti%</title>`n`n <!-- song length`,in milliseconds -->`n<duration>%TimeMs%</duration>`n`n</track>, %XSFOutput%\%XSF%.xspf , UTF-8
                }
        }
}
    FileAppend , `n</tracklist>`n</playlist>`n`n, %XSFOutput%\%XSF%.xspf  , UTF-8
    SplashTextOff

    GuiControl , , GUI_Progress, 0
    GuiControl , , GUI_Text, Done
    GuiControl , , milli, Information Exported
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 1
    else 
        SetTimer , GETLEVEL , off
    MsgBox , 64, Export , XSPF v1.0 Created Sucessfully
return