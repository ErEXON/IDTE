;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : ToolsMenu.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================

;__________________________________________________________CLEAR ALL FIELDS_______________________________________________________________________________________________________;
CAF:
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    GuiControl,, Title, 
    GuiControl,, Album, 
    GuiControl,, Artist, 
    GuiControl,, Year, 
    GuiControl,, Comments, 
    GuiControl,, Genre, 
    GuiControl,, Track,
    SetTimer , Check_Progress 
     if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return


;__________________________________________________________________ REPLACE IN FILENAMES ____________________________________________________________________;
Replace_char:
    StringCaseSense , On
    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
    InputBox , Source_Char, Source Character,Enter Source Character to Replace`ne.g. underscore`,symbol`,letters`,words`,hypens etc.
        if errorlevel
            return
    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
    InputBox , Dest_Char, Replace With ,Replace With ?
        if errorlevel
            return
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    SplashTextOn , , , Please Wait..
    ControlGet, List, List, Selected, SysListView321, A
    ValueRow:= LV_GetCount("S")
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
                            IfInString , Text, %Source_Char%
                            StringReplace , Temp_Text, Text , %Source_Char%, %Dest_Char%,All
                            FileMove , %Folder%\%Text%, %Folder%\%Temp_Text%
                        }
                }
        }

    GuiControl , , GUI_Progress, 0
    GuiControl , , GUI_Text, Done
    GuiControl , , milli, Text Replaced
    SplashTextOff
    SetTimer , Check_Progress 
     if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
    StringCaseSense , Off
return

RemZero:
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    SplashTextOn , , , Please Wait..
    ControlGet, List, List, Selected, SysListView321, A
    ValueRow:= LV_GetCount("S")
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
                            StringLeft , Lchar, Text, 1
                            if (Lchar=0)
                                {
                                    StringReplace , New_char,Text, 0, ,
                                    FileMove , %Folder%\%Text%, %Folder%\%New_char%
                                }
                        }
                }
        }
    FileDelete , %A_WorkingDir%\Covers\copy.png
    GuiControl , , GUI_Progress, 0
    GuiControl , , GUI_Text, Done
    SplashTextOff
    SetTimer , Check_Progress 
     if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return

AddZero:
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    SplashTextOn , , , Please Wait..
    ControlGet, List, List, Selected, SysListView321, A
    ValueRow:= LV_GetCount("S")
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
                            StringLeft , Lchar, Text, 1
                            if (Lchar!=0)
                                {
                                    FileMove , %Folder%\%Text%, %Folder%\0%Text%
                                }
                        }
                }
        }
    FileDelete , %A_WorkingDir%\Covers\copy.png
    GuiControl , , GUI_Progress, 0
    GuiControl , , GUI_Text, Done
    SplashTextOff
    SetTimer , Check_Progress 
     if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return

Cap_F:
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    SplashTextOn , , , Please Wait..
    ControlGet, List, List, Selected, SysListView321, A
    ValueRow:= LV_GetCount("S")
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
                                StringUpper , New_text, Text, T
                                FileMove , %Folder%\%Text%, %Folder%\%New_Text%
                            }
                    }
        }
    FileDelete , %A_WorkingDir%\Covers\copy.png
    GuiControl , , GUI_Progress, 0
    GuiControl , , GUI_Text, Done
    SplashTextOff
    SetTimer , Check_Progress 
     if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return

Uncap_F:
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    SplashTextOn , , , Please Wait..
    ControlGet, List, List, Selected, SysListView321, A
    ValueRow:= LV_GetCount("S")
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
                            StringLower , New_text, Text, T
                            FileMove , %Folder%\%Text%, %Folder%\%New_Text%
                        }
                }
        }
    FileDelete , %A_WorkingDir%\Covers\copy.png
    GuiControl , , GUI_Progress, 0
    GuiControl , , GUI_Text, Done
    SplashTextOff
    SetTimer , Check_Progress 
     if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return

All_UP:
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    SplashTextOn , , , Please Wait..
    ControlGet, List, List, Selected, SysListView321, A
    ValueRow:= LV_GetCount("S")
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
                            StringUpper , New_text, Text, 
                            FileMove , %Folder%\%Text%, %Folder%\%New_Text%
                        }
                }
        }
    FileDelete , %A_WorkingDir%\Covers\copy.png
    GuiControl , , GUI_Progress, 0
    GuiControl , , GUI_Text, Done
    SplashTextOff
    SetTimer , Check_Progress 
     if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return

ALL_DN:
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    SplashTextOn , , , Please Wait..
    ControlGet, List, List, Selected, SysListView321, A
    ValueRow:= LV_GetCount("S")
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
                            StringLower , New_text, Text, 
                            FileMove , %Folder%\%Text%, %Folder%\%New_Text%
                        }
                }
        }
    FileDelete , %A_WorkingDir%\Covers\copy.png
    GuiControl , , GUI_Progress, 0
    GuiControl , , GUI_Text, Done
    SplashTextOff
    SetTimer , Check_Progress 
 if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return

Tag_case:
    TempDB = %A_Temp%\LastDB
    fileTemp:=FileOpen(TempDB,"w")
    Gui +LastFound
    ControlGet, List, List, Selected, SysListView321, A
    ValueRow:= LV_GetCount("S")
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

    Gui, case:Add, Radio, x22 y29 w220 h20 vauc , All to Upper Case
    Gui, case:Add, Radio, x22 y49 w340 h20 valc , All to lower case
    Gui, case:Add, Radio, x22 y69 w340 h20 vufw , UpperCase only first letter of word
    Gui, case:Add, Radio, x22 y89 w340 h20 vlfw , Lowercase only first letter of word
    Gui, case:Add, Radio, x22 y109 w180 h20 vnun , None
    Gui, case:Add, GroupBox, x12 y9 w350 h120 , Operations
    Gui, case:Add, GroupBox, x12 y139 w350 h90 , Character or String Replacement
    Gui, case:Add, Text, x22 y159 w50 h20 , Replace :
    Gui, case:Add, Edit, x82 y159 w260 h20 vsorc, <None>
    Gui, case:Add, Text, x22 y189 w40 h20 , With :
    Gui, case:Add, Edit, x82 y189 w260 h20 vto, <None>
    Gui, case:Add, GroupBox, x12 y239 w350 h130 , Apply to
    Gui, case:Add, CheckBox, vChkArt x22 y269 w80 h20 , Artist
    Gui, case:Add, CheckBox, vChkAlb x22 y289 w110 h20 , Album
    Gui, case:Add, CheckBox, vChkTit x22 y309 w110 h20 , Title
    Gui, case:Add, CheckBox, vChkTra x22 y329 w110 h20 , Track
    Gui, case:Add, CheckBox, vChkyer x152 y269 w70 h20 , Year
    Gui, case:Add, CheckBox, vChkCom x152 y289 w70 h20 , Comment
    Gui, case:Add, CheckBox, vChkcmp x152 y309 w70 h20 , Composer
    Gui, case:Add, CheckBox, vChkgen x152 y329 w70 h20 , Genre
    Gui, case:Add, CheckBox, vChkpub x252 y269 w80 h20 , Publisher
    Gui, case:Add, CheckBox, vChkAar x252 y289 w90 h20 , Album Artist
    Gui, case:Add, CheckBox, gSelectevery vsevry x252 y329 w100 , Select / Deselect All
    Gui, case:Add, Button, x12 y379 w100 h30 , Apply
    Gui, case:Add, Button, x262 y379 w100 h30 , Close
    Gui, case:Show, w380 h422, Case Conversions
    WinSet , AlwaysOnTop , , Case Conversions
return

caseButtonClose:
caseGuiClose:
    gui ,case:destroy
return

caseButtonApply:
    Gui,case:submit , NoHide
    Progress , M  Fm10 Fs10 WM400 H70 ZH11, Please wait.. , Working Please Wait.. ,Working.. , Arial
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

    DllCall( "LoadLibrary", Str,A_ScriptDir "\Plugins\AudioGenie3.dll" )
    DllCall( "AudioGenie3\AUDIOAnalyzeFile", Str,Dummy ) ; Dummy Call for SplashText

    loop , %ValueRow%
    {
        FileReadLine , Directory,%A_Temp%\LastDB , A_Index
        percent := (A_index * 100)/ValueRow
        Progress , %percent%
        IfNotExist , %Directory%
            {
                MsgBox, 48, Dead File Detected, This file seems to be dead`, please reload the file
                return
            }
        Loop , %Directory%
            {
                mp3FileA := A_LoopFileFullPath
                filename := A_LoopFileFullPath
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
        SplitPath, mp3FileA,,, FileExt  ; Get Extension
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  GETTING INFO
        ADG_getinfo(mp3FileA,Trackinfo,Titleinfo,Artistinfo,Albuminfo,Genreinfo,Yearinfo,Bandinfo,Publisherinfo,Composerinfo,Commentinfo,Channelinfo,Lyrics)
        IfNotInString , sorc , <None>
            {
                IfNotInString, to, <None>
                    {
                        StringReplace , Artistinfo , Artistinfo , %sorc% , %to% , All 
                        StringReplace , Albuminfo , Albuminfo , %sorc% , %to% , All
                        StringReplace , Titleinfo , Titleinfo , %sorc% , %to% , All
                        StringReplace , Trackinfo , Trackinfo , %sorc% , %to% , All
                        StringReplace , Yearinfo , Yearinfo , %sorc% , %to% , All
                        StringReplace , Genreinfo , Genreinfo , %sorc% , %to% , All
                        StringReplace , Composerinfo , Composerinfo , %sorc% , %to% , All
                        StringReplace , Publisherinfo , Publisherinfo , %sorc% , %to% , All
                        StringReplace , Commentinfo , Commentinfo , %sorc% , %to% , All 
                        StringReplace , Bandinfo , Bandinfo , %sorc% , %to% , All     
                    }
            }
        if(auc=1)
            {
                    StringUpper , Artistinfo, Artistinfo
                    StringUpper , Albuminfo, Albuminfo
                    StringUpper , Trackinfo, Trackinfo
                    StringUpper , Titleinfo, Titleinfo
                    StringUpper , Trackinfo, Trackinfo
                    StringUpper , Yearinfo, Yearinfo
                    StringUpper , Genreinfo, Genreinfo
                    StringUpper , Publisherinfo, Publisherinfo
                    StringUpper , Commentinfo, Commentinfo
                    StringUpper , Bandinfo, Bandinfo
            }
        else if (alf=1)
            {     
                    StringLower , Artistinfo, Artistinfo
                    StringLower , Albuminfo, Albuminfo
                    StringLower , Trackinfo, Trackinfo
                    StringLower , Titleinfo, Titleinfo
                    StringLower , Trackinfo, Trackinfo
                    StringLower , Yearinfo, Yearinfo
                    StringLower , Genreinfo, Genreinfo
                    StringLower , Publisherinfo, Publisherinfo
                    StringLower , Commentinfo, Commentinfo
                    StringLower , Bandinfo, Bandinfo
            }
        else if (ufw=1)
            {     
                    StringUpper , Artistinfo, Artistinfo , T
                    StringUpper , Albuminfo, Albuminfo , T
                    StringUpper , Trackinfo, Trackinfo , T
                    StringUpper , Titleinfo, Titleinfo , T
                    StringUpper , Trackinfo, Trackinfo , T
                    StringUpper , Yearinfo, Yearinfo , T
                    StringUpper , Genreinfo, Genreinfo , T
                    StringUpper , Publisherinfo, Publisherinfo , T
                    StringUpper , Commentinfo, Commentinfo , T
                    StringUpper , Bandinfo, Bandinfo , T
            }
        else if(lfw=1)
            {     
                    StringLower , Artistinfo, Artistinfo , T
                    StringLower , Albuminfo, Albuminfo , T
                    StringLower , Trackinfo, Trackinfo , T
                    StringLower , Titleinfo, Titleinfo , T
                    StringLower , Trackinfo, Trackinfo , T
                    StringLower , Yearinfo, Yearinfo , T
                    StringLower , Genreinfo, Genreinfo , T
                    StringLower , Publisherinfo, Publisherinfo , T
                    StringLower , Commentinfo, Commentinfo , T
                    StringLower , Bandinfo, Bandinfo , T    
            }

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SETTING INFO
    if FileExt in MP3,AAC,MPP,TTA
        {
            DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
            DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetFormatAndEncodingW", uint, 0,uint,1)
            if(ChkTra=1)
                DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1414677323,wstr,Trackinfo) 
            if(ChkTit=1)
                DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1414091826,wstr,Titleinfo) 
            if(ChkArt=1)
                DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1414546737,wstr,Artistinfo)
            if(ChkAlb=1)
                DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1413565506,wstr,Albuminfo)
            if(Chkgen=1)
                DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1413697358,wstr,Genreinfo)
            if(Chkyer=1)
                DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1415136594,wstr,Yearinfo) 
            if(ChkAar=1)
                DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1414546738,wstr,Bandinfo) 
            if(Chkpub=1)
                DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint,1414550850,wstr,Publisherinfo)
            if(Chkcmp=1)
                DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SetTextFrameW", uint, 1413697357,wstr,Composerinfo) 

            lang :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetCommentLanguageW", uint, 1,wstr) 
            Desc :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetCommentDescriptionW", uint, 1,wstr) 
            if(ChkCom=1)
                Commentinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2AddCommentW", wstr,lang,wstr,Desc,wstr ,Commentinfo)
            errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2SaveChangesW")
        }
    else
        {
            if FileExt in OGG
            {
                if(ChkArt=1)
                    RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --artist "%Artistinfo%" "%Folder%\%Text%", , hide
                if(ChkAlb=1) 
                    RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --album "%Albuminfo%" "%Folder%\%Text%", , hide
                if(Chkyer=1)
                    RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --year "%Yearinfo%" "%Folder%\%Text%", , hide
                if(Chkgen=1)   
                    RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --genre "%Genreinfo%" "%Folder%\%Text%", , hide
                if(ChkTra=1)
                    RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --track "%Trackinfo%" "%Folder%\%Text%", , hide
                if(ChkTit=1)
                    RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --title "%Titleinfo%" "%Folder%\%Text%", , hide
                if(ChkCom=1)
                    RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --comment "%Commentsinfo%" "%Folder%\%Text%", , hide
            }
        else
            {
                DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
                if(ChkArt=1)
                    Artistinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetArtistW", wstr ,Artistinfo)
                if(ChkAlb=1)
                    Albuminfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetAlbumW", wstr ,Albuminfo)
                if(Chkyer=1)
                    Yearinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetYearW", wstr ,Yearinfo)
                if(Chkgen=1)
                    Genreinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetGenreW", wstr ,Genreinfo)
                if(ChkTra=1)
                    Trackinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetTrackW", wstr ,Trackinfo)
                if(ChkTit=1)
                    Titleinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetTitleW", wstr ,Titleinfo)
                if(ChkCom=1)
                    Commentinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetCommentW", wstr ,Commentinfo)
                if(Chkcmp=1)
                    Composerinfo :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetComposerW", wstr ,Composerinfo)
                    errorcode:=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSaveChangesW")
                if FileExt in FLAC
                        {
                            if(ChkAar=1)
                                DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACSetUserItemW",wstr, "ALBUMARTIST", wstr, Bandinfo)
                            if(Chkpub=1)
                                DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACSetUserItemW",wstr, "PUBLISHER", wstr, Publisherinfo)  
                            errorcode:= DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACSaveChangesW")
                        }    
                else if FileExt in M4A,MP4,M4B,AAC
                        {
                            if(ChkAar=1)
                                DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4SetiTuneFrameW",wstr, "aART", wstr, Bandinfo)
                            if(Chkpub=1)
                                DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4SetiTuneFrameW",wstr, "Copyright", wstr, Publisherinfo)
                            errorcode:=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4SaveChangesW")
                        }
                else if FileExt in WMA,ASF
                        {
                            if(ChkAar=1)
                                DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMASetUserItemW",wstr, "WM/AlbumArtist", wstr, Bandinfo)
                            if(Chkpub=1)
                                DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMASetUserItemW",wstr, "WM/Publisher", wstr, Publisherinfo)
                            errorcode:= DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMASaveChangesW")
                        }
                else if FileExt in APE,WV
                        {
                            if(ChkAar=1)
                                DllCall(A_ScriptDir "\Plugins\AudioGenie3\APESetUserItemW",wstr,"Album Artist", wstr, Bandinfo)
                            if(Chkpub=1)
                                DllCall(A_ScriptDir "\Plugins\AudioGenie3\APESetUserItemW",wstr,"Publisher", wstr, Publisherinfo)
                                errorcode:= DllCall(A_ScriptDir "\Plugins\AudioGenie3\APESaveChangesW")
                        }
            }
        }
    }
    Progress , off
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; DONE
    if(errorcode<>-1)
        Message = Error occured while applying Operation
    else
        Message = Operation Sucessful 

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
    MsgBox , 64, Information, Please Refresh the List in order to review Changes
return

Selectevery:
    if selevflag=
    {
        selevflag=1
        GuiControl , case: , ChkArt , 1
        GuiControl , case: , ChkAlb , 1
        GuiControl , case: , ChkTit , 1
        GuiControl , case: , ChkTra , 1
        GuiControl , case: , Chkyer , 1
        GuiControl , case: , ChkCom , 1
        GuiControl , case: , Chkcmp , 1
        GuiControl , case: , Chkgen , 1
        GuiControl , case: , Chkpub , 1
        GuiControl , case: , ChkAar , 1
    }
    else
    {
        selevflag=
        GuiControl , case: , ChkArt , 0
        GuiControl , case: , ChkAlb , 0
        GuiControl , case: , ChkTit , 0
        GuiControl , case: , ChkTra , 0
        GuiControl , case: , Chkyer , 0
        GuiControl , case: , ChkCom , 0
        GuiControl , case: , Chkcmp , 0
        GuiControl , case: , Chkgen , 0
        GuiControl , case: , Chkpub , 0
        GuiControl , case: , ChkAar , 0    
    }
return