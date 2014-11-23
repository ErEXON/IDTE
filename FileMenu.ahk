;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : FileMenu.ahk 
;==========================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;===========================================================================================================================================================================================

;______________________________________________________________________________OPEN FILE_________________________________________________________________________________________;
ContextFile:
openfile:
    XT=0    ;Cut Flag
    CT=0   ;Copy Flag
    PT=0  ; Paste Flag
    gui +owndialogs ; Forces User to dismiss
    ChooseFilePrev = %ChooseFile% ;
    FileSelectFile ,ChooseFile,M , , Select Your Music File(s) (Do Not Add Video Files for Tagging), All Supported Type (*.mp3;*.mp2;*.mp1;*.ogg;*.oga;*.wav;*.aif;*.aiff;*.aifc;*.mo3;*.xm;*.mod;*.s3m;*.it;*.mtm;*.umx;*.midi;*.mus;*.rmi;*.kar;*.flac;*.wma;*.wmv;*.wmp;*.asf;*.aac;*.mp4;*.m4a;*.m4b;*.m4p;*.wv;*.wvc;*.ape;*.mpc;*.mpp;*.mp+;*.ac3;*.spx;*.tta;*.opus;)
/*
Bass Built In(*.mp3;*.mp2;*.mp1;*.ogg;*.oga;*.wav;*.aif;*.aiff;*.aifc;)
Bass Modules built-in(*.mo3;*.xm;*.mod;*.s3m;*.it;*.mtm;*.umx;)
Free Lossless Audio Codec (*.flac;)
Windows Media Audio (*.wma;*.wmv;*.wmp;*.asf;)
Advance Audio Compression (*.aac;*.mp4;*.m4a;*.m4b;*.m4p;)
WavPack Audio Codec (*.wv;*.wvc;)|Monkey's Audio (*.ape;)
MusePack (*.mpc;*.mpp;*.mp+)
Doloby Digital Audio (*.ac3) 
Apple Lossless (*.mp4;*.m4a;*.m4b;*.m4p;)
Speex (*.spx)
The True Audio (*.tta;)
OptimFROG(*.ofr)
Opus Audio Codec (*.opus;)
*/
    if Choosefile=  ; IF no file is selected
        {
            ChooseFile = %ChooseFilePrev%   
            return
        }

;_____________________________________________________________________LABEL = TAGIT [For Tag Info in Listview] _____________________________________________________________________;
TAGIT:
    SetTimer , Check_Progress , off  ;Stop Timers
    SetTimer , GETLEVEL , off
    Folder=
    IniRead , checker4,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,List , Clear_List_Files ;Check if There is Need to clean up the files 
    if (Checker4=1)
        LV_Delete()  ; Clear the ListView
    FileDelete , %A_Temp%\AlbumArt.png ;Delete Cover Art  If any

    VarSetCapacity(Filename, 260) ;Create a Structure of 260 bytes
    sfi_size = 352
    VarSetCapacity(sfi, sfi_size)
    ; Gather a list of file names from the selected folder and append them to the ListView:
    ;GuiControl, -Redraw, MyListView  ; Improve performance by disabling redrawing during load.
    DllCall( "LoadLibrary", Str,A_ScriptDir "\Plugins\AudioGenie3.dll" )
    DllCall( "AudioGenie3\AUDIOAnalyzeFileW", Str,Dummy ) ; Dummy Call
    T1 := A_TickCount ;Current Time
    Loop, parse, ChooseFile, `n ;Parse The Multiple/Singe Song Selection By User
        {
            if A_LoopField =  ; A blank field marks the end of the list.
                break
            if A_index = 1 ; Copy Folder Location in Var Folder
                Folder=%A_LoopField%.
            else
                {
                    Text=%A_LoopField% ;Copy File Location in Var Folder
                    Loop, %Folder%\%Text% ;Loop Folder\Files in Order To retrieve Data into List View 
                        {
                            FileName := A_LoopFileFullPath  ; Must save it to a writable variable for use below.
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
                            SplitPath, FileName,,, FileExt  ; Get Extension
                            ADG_getinfo(FileName, Trackinfo, Titleinfo, Artistinfo, Albuminfo, Genreinfo, Yearinfo, Bandinfo,Publisherinfo,Composerinfo,Commentinfo,Channelinfo,Lyrics)
                            LV_Add("Icon", "",Trackinfo, Titleinfo,Artistinfo,Albuminfo,Yearinfo,Genreinfo,A_LoopFileName, A_LoopFileDir,Bandinfo,Publisherinfo,Composerinfo,Commentinfo, A_LoopFileSizeMB " MB",A_LoopFileExt,Channelinfo,Sample " hertz",Bitrate " Kbps",Dur,Supp)
                        }    
                }

        }
    T2 := A_TickCount ;Time After The Complete Retrieval Process
    IniRead , Checker9, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,UI,Auto_Adjust 
    if (checker9=1) 
        LV_ModifyCol()  ; Auto-size each column to fit its contents
time_t := T2-T1 ;Time Defference = total time required For The Above Complete Process

GuiControl , , milli, Last Tag retrived in %time_t% Milliseconds ;shows information of time required for this tag retrieval in GUI
GuiControl, Focus , MyListView ;Focus The List View
SetTimer , Check_Progress   ;Turn the Checker Back ON
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return
;____________________________________________________________________________________FILE OPENING ENDS HERE________________________________________________________________________;

;-----------------------------------------------------------------PLAYLIST--------------------------------------------------------------------------------------------------------;
openpl:
    FileSelectFile , PLlist, , , Select Your PlayList File , Supported Playlists (*.m3u;*.wpl;*.pls)
    if PLlist =
        return
PLHERE:
    FileEncoding , 
    SplitPath , PLlist, , Folder, PLExt
    ChooseFile = Something
    IniRead , checker4,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,List , Clear_List_Files 
    if (Checker4=1)
        LV_Delete()  ; Clear the ListView
    FileDelete , %A_Temp%\AlbumArt.png
    library := DllCall( "LoadLibrary", Str,A_ScriptDir "\Plugins\AudioGenie3.dll" )
    DllCall( "AudioGenie3\AUDIOAnalyzeFileW", Str,Dummy ) ; Dummy Call
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    T1 := A_TickCount
    If PLExt in M3U                 ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< M3U playlists
        {
            loop , read ,%PLlist%
                {
                    if A_LoopReadLine =  ; A blank field marks the end of the list.
                        break
                    IfInString , A_LoopReadLine ,#
                        goto , last
                    FileName = %A_LoopReadLine%
                    Loop , %Folder%\*.*
                        {
                            IfInString ,A_LoopFileFullPath , %Filename%
                                {
                                    mp3FileU := A_LoopFileFullPath
                                    ADG_getinfo(mp3FileU,Trackinfo,Titleinfo,Artistinfo,Albuminfo,Genreinfo,Yearinfo,Bandinfo,Publisherinfo,Composerinfo,Commentinfo,Channelinfo,Lyrics)
                                    Channelinfo:=DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetChannelModeW",wstr)
                                    Bitrate  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetBitrateW",int)
                                    Dur := DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetDurationMillisW" )    
                                    Dur :=  FormatMs(Dur)
                                    Sample := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetSampleRateW",int) 
                                    LV_Add("Icon", "",Trackinfo, Titleinfo,Artistinfo,Albuminfo,Yearinfo,Genreinfo,A_LoopFileName, A_LoopFileDir,Bandinfo,Publisherinfo,Composerinfo,Commentinfo, A_LoopFileSizeMB " MB",A_LoopFileExt,Channelinfo,Sample " hertz",Bitrate " Kbps",Dur)
                                }
                        }
                    last:
                }
        }
    else if PLExt in WPL                 ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< WPL Playlists
        {
            loop , read ,%PLlist%
                {
                    if A_LoopReadLine =  ; A blank field marks the end of the list.
                        break
                    IfInString , A_LoopReadLine , <media src=
                        {
                            StringSplit , File, A_LoopreadLine , "
                            Loop , %File2%
                                {
                                    FileName := A_LoopFileFullPath  ; Must save it to a writable variable for use below.
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
                                    FileU := A_LoopFileFullPath
                                    ADG_getinfo(FileU,Trackinfo,Titleinfo,Artistinfo,Albuminfo,Genreinfo,Yearinfo,Bandinfo,Publisherinfo,Composerinfo,Commentinfo,Channelinfo,Lyrics)
                                    Bitrate  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetBitrateW",int) 
                                    Dur := DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetDurationMillisW" )
                                    Dur :=  FormatMs(Dur)
                                    Sample := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetSampleRateW",int)

                                    LV_Add("Icon", "",Trackinfo, Titleinfo,Artistinfo,Albuminfo,Yearinfo,Genreinfo,A_LoopFileName, A_LoopFileDir,Bandinfo,Publisherinfo,Composerinfo,Commentinfo, A_LoopFileSizeMB " MB",A_LoopFileExt,Channelinfo,Sample " hertz",Bitrate " Kbps",Dur)
                                }
                        }
                }
        }
    else if PLExt in PLS                ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< PLS Playlists
        {
            Sum:= 1
            loop , read ,%PLlist%
                {
                    IfInString , A_LoopReadLine , File%Sum% 
                        {
                            StringSplit , File, A_LoopreadLine , =
                            Loop , %File2%
                                {
                                    FileName := A_LoopFileFullPath  ; Must save it to a writable variable for use below.
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
                                    FileU := A_LoopFileFullPath
                                    Supp =
                                    ADG_getinfo(FileU,Trackinfo,Titleinfo,Artistinfo,Albuminfo,Genreinfo,Yearinfo,Bandinfo,Publisherinfo,Composerinfo,Commentinfo,Channelinfo, Lyrics)
                                    Bitrate  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetBitrateW",int) 
                                    Dur := DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetDurationMillisW")
                                    Dur :=  FormatMs(Dur)
                                    Sample :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetSampleRateW",int) 
                                    LV_Add("Icon", "",Trackinfo, Titleinfo,Artistinfo,Albuminfo,Yearinfo,Genreinfo,A_LoopFileName, A_LoopFileDir,Bandinfo,Publisherinfo,Composerinfo,Commentinfo, A_LoopFileSizeMB " MB",A_LoopFileExt,Channelinfo,Sample " hertz",Bitrate " Kbps",Dur)
                                }
                            Sum := Sum +1
                        }
                }
        }
    if PLExt not in WPL,M3U,PLS
    {
        gui +OwnDialogs
        MsgBox , 48 , Invalid File , It Appears To Be Malfunctioned Playlist File
    }
    IniRead , Checker9, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,UI,Auto_Adjust 
    if (checker9=1)
        LV_ModifyCol()  ; Auto-size each column to fit its contents.
    FileEncoding ,  UTF-16
    T2 := A_TickCount 
    GuiControl, Focus , MyListView
    SetTimer , Check_Progress 
        if min=
            SetTimer , GETLEVEL , 50
        else 
            SetTimer , GETLEVEL , off
    return

;-------------------------------------------------------------------------------------------------------------------------CUE FILE SUPPORT --------------------------------;
CUE:    
    FileSelectFile , CUEFL, , , Select Your PlayList File , CUE File(*.cue)
    if CUEFL =
        return

CUESET:
    FileEncoding ,  
    Flag_CUE =0 ;To Indicate The Album Name
    SplitPath , CUEFL, , Folder,testExt
    IniRead , checker4,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,List , Clear_List_Files 
    if (Checker4=1)
        LV_Delete()  ; Clear the ListView
    T1 := A_TickCount
    if testExt in CUE
        {
            loop , read , %CUEFL%
                {
                    IfInString , A_loopreadline , FILE
                        {
                            Stringreplace , Filename , A_LoopReadLine , FILE , ,All
                            Stringreplace , Filename , Filename , WAVE , ,All
                            Stringreplace , Filename , Filename , " , ,All
                            loop %Folder%\*.*
                                {
                                    IfInString ,A_LoopFileName , %Filename%
                                    Filename = %A_LoopFileName%
                                }
                        }
                    IfInString , A_loopreadline , REM GENRE
                        {
                            Stringreplace , Genreinfo , A_LoopReadLine , REM GENRE , ,All
                            Stringreplace , Genreinfo , Genreinfo , " , ,All
                        }
                    IfInString , A_loopreadline , REM COMMENT
                        {
                            Stringreplace , Commentinfo , A_LoopReadLine , REM COMMENT , ,All
                            Stringreplace , Commentinfo , Commentinfo , " , ,All
                        }
                    IfInString , A_loopreadline , REM DATE
                        {
                            Stringreplace , Yearinfo , A_LoopReadLine , REM DATE , ,All
                            Stringreplace , Yearinfo , Yearinfo , " , ,All
                        }
                    IfInString ,A_LoopReadLine ,INDEX 01
                        {
                            StringRight , Line, A_LoopReadLine , 8
                            StringtrimRight , Min, Line , 6
                            StringRight , Sec, Line , 5
                            StringtrimRight , Sec, Sec , 3
                            StringRight , MSec, Line, 2 
                            Milliseconds := Min*60*1000 + Sec*1000 + Msec
                            OPT:= FormatMs(Milliseconds)
                        }
                    IfInString , A_loopreadline , TRACK
                        {
                            Stringreplace , Trackinfo , A_LoopReadLine , TRACK , ,All
                            Stringreplace , Trackinfo , Trackinfo , AUDIO , ,All
                        }
                    IfInString , A_loopreadline , TITLE
                        {
                            if (Flag_CUE=0)
                                {
                                    Stringreplace , Albuminfo , A_LoopReadLine , TITLE , ,All
                                    Stringreplace , Albuminfo , Albuminfo , " , ,All   
                                    Flag_CUE =1 ;To Indicate The Album Name
                                }
                            else
                                {
                                    Stringreplace , Titleinfo , A_LoopReadLine , TITLE , ,All
                                    Stringreplace , Titleinfo , Titleinfo , " , ,All
                                }
                        }
                    IfInString , A_loopreadline , PERFORMER
                        {
                            Stringreplace , Artistinfo , A_LoopReadLine , PERFORMER , ,All
                            Stringreplace , Artistinfo , Artistinfo , " , ,All  
                        }     
                    IfInString , A_loopreadline , INDEX 01
                        {
                            FileAppend , ""|%Trackinfo%|%Titleinfo%|%Artistinfo%|%Albuminfo%|%Yearinfo%|%Genreinfo%|%FileName%|%Folder%|%Bandinfo%|%Publisherinfo%|%Artistinfo%|%Commentinfo%|NA|CUE|%Channelinfo%`n , %A_MyDocuments%\IDTE_Data\LastDB.txt   
                        }
                }
            Loop, read, %A_MyDocuments%\IDTE_Data\LastDB.txt
                {
                    Loop, parse, A_LoopReadLine, |
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
                                    Channel=%A_LoopField%
                            else if (A_Index=17)
                                    Sample=%A_LoopField%
                            else if (A_Index=18)
                                    Bitrate=%A_LoopField%
                            else if (A_Index=19)
                                    Dur=%A_LoopField%
                        }
                    LV_Add("Icon", "",Trackinfo, Titleinfo,Artistinfo,Albuminfo,Yearinfo,Genreinfo,FileName,FileDir,Bandinfo,Publisherinfo,Composerinfo,Commentinfo,FileSizeMB,Fileext,Channel,Sample,Bitrate,Dur)
                }
            FileDelete , %A_MyDocuments%\IDTE_Data\LastDB.txt
        }
        else
        {
            gui +OwnDialogs
            MsgBox , 48 , Invalid File , It Appears To Be Malfunctioned CUE File
        }
    T2 := A_TickCount 
    IniRead , Checker9, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,UI,Auto_Adjust 
    if (checker9=1)
        LV_ModifyCol()  ; Auto-size each column to fit its contents.
    GuiControl, Focus , MyListView
    FileEncoding ,  UTF-16
return


;_______________________________________________________________________________________OPEN FOLDER TO TAG ________________________________________________________________________;
openfolderRec: ;Recursively open Folder
    rec=1 ;Flag For Recursive Call
ContextFold: ;Label For Context Menu
openfolder: ;Label For Non Recursive Call
    Critical , on
    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
    FileSelectFolder , Folder,*%Defalt_Dir%, 2, Select Your Music folder to Tag
        if not Folder  ; The user canceled the dialog.
            {   
                SetTimer , Check_Progress 
                if min=
                    SetTimer , GETLEVEL , 50
                else 
                    SetTimer , GETLEVEL , off
                Critical , off
                return
            }
GETIT:
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    FileDelete ,%A_WorkingDir%\taginfo.txt
    ChooseFile=
    IniRead , checker5,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,List , Clear_List_Folder 
    if (Checker5=1)
        LV_Delete()  ; Clear the ListView, but keep icon cache intact for simplicity.
    ; Check if the last character of the folder name is a backslash, which happens for root
    ; directories such as C:\. If it is, remove it to prevent a double-backslash later on.
    StringRight, LastChar, Folder, 1
    if LastChar = \
        StringTrimRight, Folder, Folder, 1  ; Remove the trailing backslash.
    ; Gather a list of file names from the selected folder and append them to the ListView:
    ;GuiControl, -Redraw, MyListView  ; Improve performance by disabling redrawing during load.
    DllCall( "LoadLibrary", Str,A_ScriptDir "\Plugins\AudioGenie3.dll" )
    DllCall( "AudioGenie3\AUDIOAnalyzeFile", Str,Dummy ) ; Dummy Call for SplashText
    GuiControl , , milli, Processing Files Please Wait... 
    Progress, M %Val%, ,Scanning Files.., Keep Calm..
    T1 := A_TickCount 
    Loop, %Folder%\*.*,0,%rec%
        {
            Val:= A_index/10
             Progress , %Val%
            if A_LoopFileExt in mp3,flac,m4a,mp2,mp1,ogg,oga,wav,aif,aiff,aifc,mo3,xm,mod,s3m,it,mtm,umx,midi,mus,rmi,kar,wma,wmv,wmp,asf,aac,mp4,m4b,m4p,wv,wvc,ape,mpc,mpp,mp+,ac3,spx,tta,opus
                {
                        LV_Add("Icon", "",Trackinfo, Titleinfo,Artistinfo,Albuminfo,Yearinfo,Genreinfo,A_LoopFileName, A_LoopFileDir,Bandinfo,Publisherinfo,Composerinfo,Commentinfo, A_LoopFileSizeMB " MB",A_LoopFileExt,Channelinfo,Sample " hertz",Bitrate " Kbps",Dur)
                }
        }
    goto , refresh
    IniRead , Checker9, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,UI,Auto_Adjust 
    if (checker9=1)
        LV_ModifyCol()  ; Auto-size each column to fit its contents.
    T2 := A_TickCount
    time_t := T2-T1
    GuiControl , , milli, Last Tag retrived in %time_t% Milliseconds 
    FileDelete , %A_WorkingDir%\Bin\AlbumArt.png
    GuiControl,, READFILE, Mark Any Item To Get Information of That File.
    rec=0
    GuiControl, Focus , MyListView
    Progress , off
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
    Critical , off
return
;----------------------------------------------------------------------------------------Folder Opening Ends Here------------------------------------------------------------------;

;____________________________________________________________________________SAVE ALL/SAVE TAG _________________________________________________________________________________;

ContextSave:
SaveAll:
ButtonSave:
    Critical , on
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
                        if (Confirm_pwrd!=read_file)
                            {
                                    MsgBox , 16, Error, You Do Not Have Sufficient Privilages To Modify Tags 
                                    return
                            }
                    }
            }

    GuiControl , , Statusinfo , Tip = Remember, Only Focused Files Are Gonna To Be Tagged
    if Folder=
        {
            if ChooseFile=
                {
                    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
                    msgbox ,16,  Error, Nothing To Save `,Select File(s) First
                    return
                }
        }

    Gui,submit ,NoHide
    IniRead , Checker51, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tag, Enable_Tag_Edit1
    if(checker51=1) ;Check For Writing ID Type (i.e. v1 or 2) and Set Flags Accordingly
        IDType=1
    IniRead , Checker52, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tag, Enable_Tag_Edit2
    if(checker52=1)
        IDType=2    
    IniRead , Checker53, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tag, Enable_Tag_Edit12
    if(checker53=1)
        IDType=3
    IniRead , Checker55, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,ID3, Enable_Tag_Force1
    if(checker55=1) ;Checks if Forcing A Tag is Allowed To File (i.e. v1 or 2) And Set Flags Accordingly
        Force=1
    IniRead , Checker56, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,ID3, Enable_Tag_Force2
    if(checker56=1)
        Force=2
    IniRead , Checker57, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,ID3, Enable_Tag_Force12
    if(checker57=1)
        Force=3
    GuiControl ,Disable, Mylistview
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    ControlGet, List, List, Selected, SysListView321, A
    ValueRow:= LV_GetCount("S")
    SingleTag=%ValueRow%
    Progress , M  Fm10 Fs10 WM400 H70 ZH11, Please wait.. , Working Please Wait.. ,Working.. , Arial
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
                                {
                                    filename := A_LoopFileFullPath
                                }
                            SplitPath , filename , , , FileExtn
                            IfNotExist , %Folder%\%Text%
                                goto , reachend
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
                            if FileExtn in M4A,MP4,M4B
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
                            if (singleTag=1)
                                {
                                    GuiControl , , GUI_Text, Wait..
                                    if FileExtn in MP3,AAC,MPP,TTA
                                        {
                                            DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
                                            protected := DllCall( A_ScriptDir "\Plugins\AudioGenie3\MPEGIsProtectedW",Int )
                                            if(protected <> 0)
                                                MsgBox, 16, Stop, This MPEG File %Text% is protected`, Therefore you do not have sufficient rights to modify it.
                                            if (IDType=1 or IDType=3)
                                                {
                                                    Trackinfo :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ ID3V1SetTrackW",wstr,Track) 
                                                    Titleinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ ID3V1SetTitleW",wstr,Title)
                                                    Artistinfo :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ ID3V1SetArtistW",wstr,Artist)
                                                    Albuminfo  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ ID3V1SetAlbumW",wstr,Album) 
                                                    Genreinfo  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ ID3V1SetGenreW",wstr,Genre) 
                                                    Yearinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ ID3V1SetYearW",wstr,Year) 
                                                    Commentinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ ID3V1SetCommentW",wstr ,Comments)
                                                    errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V1SaveChangesW")
                                                }
                                            if(IDType=2 or IDType=3)
                                                { 
                                                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetFormatAndEncodingW", uint, 0,uint,1)
                                                    Trackinfo :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1414677323,wstr,Track) 
                                                    Titleinfo  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1414091826,wstr,Title) 
                                                    Artistinfo :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1414546737,wstr,Artist) 
                                                    Albuminfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1413565506,wstr,Album) 
                                                    Genreinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1413697358,wstr,Genre) 
                                                    Yearinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1415136594,wstr,Year) 
                                                    Bandinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1414546738,wstr,Band) 
                                                    Publisherinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint,1414550850,wstr,Publisher) 
                                                    Composerinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1413697357,wstr,Composer) 
                                                    lang := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetCommentLanguageW", uint, 1,wstr) 
                                                    Desc := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetCommentDescriptionW", uint, 1,wstr) 
                                                    Commentinfo  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2AddCommentW", wstr,lang,wstr,Desc,wstr ,Comments)
                                                    errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SaveChangesW")
                                                }
                                        }
                                    else
                                        {
                                            if (Force=3)
                                                {
                                                    if FileExtn in OGG
                                                        {
                                                            RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --remove "%Folder%\%Text%", , hide
                                                            RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --artist "%Artist%" --album "%Album%" --track "%Track%" --title "%Title%" --year "%Year%" --genre "%Genre%" --comment "%Comments%" "%Folder%\%Text%", , hide
                                                        }
                                                    else
                                                        {
                                                            DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
                                                            Artistinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetArtistW", wstr ,Artist)
                                                            Albuminfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetAlbumW", wstr ,Album)
                                                            Yearinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetYearW", wstr ,Year)
                                                            Genreinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetGenreW", wstr ,Genre)
                                                            Trackinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetTrackW", wstr ,Track)
                                                            Titleinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetTitleW", wstr ,Title)
                                                            Commentinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetCommentW", wstr ,Comments)
                                                            Composerinfo := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetComposerW", wstr ,Composer)
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
                                                                    errorcode :=   DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4SaveChangesW")
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
                                                                    errorcode :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\APESaveChangesW")
                                                                }
                                                        }

                                                }
                                                else
                                                    {
                                                        MsgBox , 36, Information, Forcefully Apply ID3 Tag ?
                                                        IfMsgBox , Yes
                                                            runwait , %WinDir%\system32\cmd.exe /c Bin\IDTE "IDTE_SAVE_SINGLE" "%Force%" "%Folder%\%Text%" "%Title%" "%Track%" "%Album%" "%Artist%" "%Comments%" "%Year%" "%Genre%" "%publisher%" "%Band%" "%Composer%" , , Hide
                                                        IfMsgBox , No
                                                                break
                                                    }
                                        }
                                }
                            else
                                {
                                    if FileExtn in MP3,AAC,MPP,TTA
                                        {
                                            Trackinfo :=  
                                            Titleinfo  := 
                                            Albuminfo  :=
                                            Genreinfo  := 
                                            Yearinfo  := 
                                            Bandinfo  := 
                                            Publisherinfo  := 
                                            Composerinfo  := 
                                            DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
                                            IfNotInString , Artist , <keep>
                                                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1414546737,wstr,Artist) 
                                            IfNotInString , Album , <keep>  
                                                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1413565506,wstr,Album) 
                                            IfNotInString , Year , <keep>
                                                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1415136594,wstr,Year) 
                                            IfNotInString , Genre , <keep>   
                                                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1413697358,wstr,Genre)
                                            IfNotInString , Track , <keep>   
                                                {
                                                    IniRead , checker71,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Miscellaneous ,Batch_Edit
                                                    if (Checker71=1)
                                                        {
                                                            DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1414677323,wstr,Track) 
                                                            Track := Track+1
                                                        }
                                                    else
                                                            DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1414677323,wstr,Track) 
                                                }
                                            IfNotInString , Title , <keep>   
                                                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1414091826,wstr,Title) 
                                            IfNotInString ,Composer , <keep>   
                                                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1413697357,wstr,Composer)
                                            IfNotInString , Band , <keep>   
                                                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1414546738,wstr,Band) 
                                            IfNotInString , Publisher , <keep>   
                                                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint,1414550850,wstr,Publisher) 
                                            IfNotInString , Comments , <keep>   
                                                {
                                                    lang :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetCommentLanguageW", uint, 1,wstr) 
                                                    Desc :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetCommentDescriptionW", uint, 1,wstr) 
                                                    Commentinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2AddCommentW", wstr,lang,wstr,Desc,wstr ,Comments)
                                                }
                                            errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SaveChangesW")
                                        }
                                    else
                                        {  
                                            if (Force=3)
                                                {
                                                    DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
                                                    if FileExtn in OGG
                                                        {   
                                                            ArtistO  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetArtistW",wstr)
                                                            AlbumO  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetAlbumW",wstr)
                                                            YearO  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetYearW",wstr)
                                                            GenreO  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetGenreW",wstr)
                                                            TrackO  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetTrackW",wstr)
                                                            TitleO  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetTitleW",wstr)
                                                            CommentO  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetCommentW",wstr)
                                                            RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --remove "%Folder%\%Text%", , hide
                                                            RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --artist "%ArtistO%" --album "%AlbumO%" --track "%TrackO%" --title "%TitleO%" --year "%YearO%" --genre "%GenreO%" --comment "%CommentO%" "%Folder%\%Text%", , hide
                                                            IfNotInString , Artist , <keep>
                                                                    RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --artist "%Artist%" "%Folder%\%Text%", , hide
                                                            IfNotInString , Album , <keep>  
                                                                    RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --album "%Album%" "%Folder%\%Text%", , hide
                                                            IfNotInString , Year , <keep>
                                                                    RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --year "%Year%" "%Folder%\%Text%", , hide
                                                            IfNotInString , Genre , <keep>   
                                                                    RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --genre "%Genre%" "%Folder%\%Text%", , hide
                                                            IfNotInString , Track , <keep>   
                                                                {
                                                                    IniRead , checker71,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Miscellaneous ,Batch_Edit
                                                                    if (Checker71=1)
                                                                        {
                                                                            RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --track "%Track%" "%Folder%\%Text%", , hide
                                                                            Track := Track+1
                                                                        }
                                                                    else
                                                                            RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --track "%Track%" "%Folder%\%Text%", , hide
                                                                }
                                                            IfNotInString , Title , <keep>    
                                                                        RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --title "%Title%" "%Folder%\%Text%", , hide
                                                            IfNotInString , Comments , <keep>   
                                                                        RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --comment "%Comments%" "%Folder%\%Text%", , hide
                                                        }
                                                            IfNotInString , Artist , <keep>
                                                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetArtistW", wstr ,Artist)
                                                            IfNotInString , Album , <keep>  
                                                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetAlbumW", wstr ,Album)
                                                            IfNotInString , Year , <keep>
                                                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetYearW", wstr ,Year)
                                                            IfNotInString , Genre , <keep>   
                                                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetGenreW", wstr ,Genre)
                                                            IfNotInString , Track , <keep>   
                                                                    {
                                                                        IniRead , checker71,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Miscellaneous ,Batch_Edit
                                                                        if (Checker71=1)
                                                                            {
                                                                                DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetTrackW", wstr ,Track)
                                                                                Track := Track+1
                                                                            }
                                                                        else
                                                                                DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetTrackW", wstr ,Track)
                                                                    }
                                                            IfNotInString , Title , <keep>   
                                                                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetTitleW", wstr ,Title)
                                                            IfNotInString , Comments , <keep>   
                                                                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetCommentW", wstr ,Comments)
                                                            IfNotInString ,Composer , <keep>   
                                                                    DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetComposerW", wstr ,Composer)
                                                                    errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSaveChangesW")
                                                            if FileExtn in FLAC
                                                                {
                                                                    IfNotInString ,Band , <keep> 
                                                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACSetUserItemW",wstr, "ALBUMARTIST", wstr, Band)
                                                                    IfNotInString ,Publisher , <keep> 
                                                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACSetUserItemW",wstr, "PUBLISHER", wstr, Publisher)  
                                                                        errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACSaveChangesW")
                                                                } 
                                                            else if FileExtn in M4A,MP4,M4B
                                                                {
                                                                    IfNotInString ,Band , <keep> 
                                                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4SetiTuneFrameW",wstr, "aART", wstr, Band)
                                                                    IfNotInString ,Publisher , <keep> 
                                                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4SetiTuneFrameW",wstr, "Copyright", wstr, Publisher)
                                                                        errorcode :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4SaveChangesW")
                                                                }
                                                            else if FileExtn in WMA,ASF
                                                                {
                                                                    IfNotInString ,Band , <keep> 
                                                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMASetUserItemW",wstr, "WM/AlbumArtist", wstr, Band)
                                                                    IfNotInString ,Publisher , <keep> 
                                                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMASetUserItemW",wstr, "WM/Publisher", wstr, Publisher) 
                                                                        errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMASaveChangesW")
                                                                }
                                                            else if FileExtn in APE,WV
                                                                {
                                                                    IfNotInString ,Band , <keep> 
                                                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\APESetUserItemW",wstr,"Album Artist", wstr, Band)
                                                                    IfNotInString ,Publisher , <keep> 
                                                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\APESetUserItemW",wstr,"Publisher", wstr, Publisher)
                                                                        errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\APESaveChangesW")
                                                                }
                                                }
                                            else
                                                {
                                                    runwait , %WinDir%\system32\cmd.exe /c Bin\IDTE "IDTE_SAVE_MULTI" "%Force%" "%Folder%\%Text%" "%Title%" "%Track%" "%Album%" "%Artist%" "%Comments%" "%Year%" "%Genre%" "%publisher%" "%Band%" "%Composer%" , , Hide
                                                    IniRead , checker71,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Miscellaneous ,Batch_Edit
                                                    if (Checker71=1)
                                                        {   
                                                            IfNotInString , Track , <keep> 
                                                            Track := Track+1
                                                        }
                                                }
                                        }
                                }
                    reachend:
                        }
                }
        }
    GuiControl,Enable, Mylistview
    FRowNumber = 0  ; This causes the first loop iteration to start the search at the top of the list.

    ControlGet , List, List, Selected, SysListView321, A
    Loop, Parse, List, `n  ; Rows are delimited by linefeeds (`n).
    {
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
                    ADG_getinfo(filename,Trackinfo,Titleinfo,Artistinfo,Albuminfo,Genreinfo,Yearinfo,Bandinfo,Publisherinfo,Composerinfo,Commentinfo,Channelinfo, Lyrics)
                    Bitrate  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetBitrateW",int) 
                    Dur := DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetDurationMillisW" )
                    Dur :=  FormatMs(Dur)
                    Sample := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetSampleRateW",int)
                    FileGetSize, SizeMB ,%filename%,M  
                    FRowNumber := LV_GetNext(FRowNumber)  ; Resume the search at the row after that found by the previous iteration.
                    if not FRowNumber  ; The above returned zero, so there are no more selected rows.
                        break
                    LV_Modify(FRowNumber,"Col2",Trackinfo, Titleinfo,Artistinfo,Albuminfo,Yearinfo,Genreinfo,Text, Folder,Bandinfo,Publisherinfo,Composerinfo,Commentinfo,SizeMB,FileExtn,Channelinfo,Sample,Bitrate,Dur)
                }   
        }
    }
    IniRead , Checker9, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,UI,Auto_Adjust 
    if (checker9=1)
        LV_ModifyCol()  ; Auto-size each column to fit its contents.
    GuiControl, Focus , MyListView
    Progress , off
    if Show_flag=
        {
            if(errorcode<>-1)
                {
                    Message = One or More Error(s) encountered while applying Tag.
                    error := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetLastErrorTextW",wstr)
                    MsgBox , 16 , Error , Error Occured While Processing Tags `n%error%
                }
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
                    if (checker28!=0)
                        {
                            Title = IDTE - ID3 Tag Editor   
                            Lifespan = %timet_toast%000 ;ms
                            Notify("","",0,"Wait=50")
                            Notify("IDTE-ID3 Tag Editor", Message, 2,"TS=12 TM=8 TF=Times New Roman SI_=400 GF=2 GL=3")
                        }
                }
        }
    Show_flag=
    SplashTextOff
    GuiControl , , Statusinfo , Tip = Refresh Fields to View Applied Changes 
    GuiControl , , GUI_Text, Ready
    GuiControl, Focus , MyListView
    SetTimer , Check_Progress 
        if min=
            SetTimer , GETLEVEL , 50
        else 
            SetTimer , GETLEVEL , off
Critical , off
return

;_____________________________________________________________________________________Save Current File(s) To..____________________________________________________________________;
SaveTo:

if ChooseFile=
    {
        if folder=
        {
            Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
            msgbox ,16,  Error, No File(s) To Save `, Select Files First
            return
        }
    }
goto , Copy
return

;______________________________________________________________________________________________Read Tag From Folder________________________________________________________________;
ReadTag: 
    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
    FileSelectFolder , MyFolder, ,2,Select Folder To Read Tag Info (Recursive)
    if MyFolder=
        return
    FileDelete , %MyFolder%\TagInfo.txt
    DllCall( "LoadLibrary", Str,A_ScriptDir "\Plugins\AudioGenie3.dll" )
    DllCall( "AudioGenie3\AUDIOAnalyzeFileW", Str,Dummy ) ; Dummy Call
    SplashTextOn , , , Processing`, Please Wait...
    FileAppend ,---------------------------------- Information Created By IDTE - ID3 Tag Editor -----------------------------------`n , %MyFolder%\TagInfo.txt
    Loop, %MyFolder%\*.* , , 1  
    {
        SplitPath , A_LoopFileFullPath , , , EXT
        if EXT in mp3,mp2,mp1,ogg,oga,wav,aif,aiff,aifc,mo3,xm,mod,s3m,it,mtm,umx,midi,mus,rmi,kar,flac,wma,wmv,wmp,asf,aac,mp4,m4a,m4b,m4p,wv,wvc,ape,mpc,mpp,mp+,ac3,spx,tta,opus
            {   
                mp3FileA := A_LoopFileFullPath
                ADG_getinfo(mp3FileA,Trackinfo,Titleinfo,Artistinfo,Albuminfo,Genreinfo,Yearinfo,Bandinfo,Publisherinfo,Composerinfo,Commentinfo,Channelinfo,Lyrics)
                FileAppend ,`n--------------------------------------------`nFilename = %A_LoopFileName%`nTrack No.= %Trackinfo%`nTitle = %Titleinfo%`nArtist = %Artistinfo%`nAlbum = %Albuminfo%`nYear = %Yearinfo%`nGenre = %Genreinfo%`nComposer = %Composerinfo%`nComments = %Commentinfo%`nFileSize = %A_LoopFileSizeMB%MB`nFile Type = %A_LoopFileExt%`nAudio Channels = %Channelinfo%`n , %MyFolder%\TagInfo.txt  
            }
    }
    FileAppend ,`nNote --> Retry in case of Incomplete/Blank Information`n , %MyFolder%\TagInfo.txt
    SplashTextOff
    RunWait , %MyFolder%\TagInfo.txt
return


;________________________________________________________________________CURRENT DIRECTORY ______________________________________________________________________;

OPENCURRENT:
    Loop, Parse, List, `n  ; Rows are delimited by linefeeds (`n).
        {
            Loop, Parse, A_LoopField, %A_Tab% ; Fields (columns) in each row are delimited by tabs (A_Tab).
                {
                    if A_Index=8
                        Text=%A_LoopField%
                    else if A_Index=9
                        Folder=%A_LoopField%
                    else if A_Index=10
                        { 
                            run, explore %Folder%
                            break
                        }
                }
        break
        }
return