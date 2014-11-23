;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : RemoveMenu.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================

;______________________________________________________REMOVE ALBUM ART___________________________________________________________________________________________________________;
RAA:

    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
    MsgBox ,36, Wait..,Are You Sure?`n
    IfMsgBox , No
        return
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    SplashTextOn , , , Please Wait..
REMOVEFROMHERE:
    ControlGet, List, List, Selected, SysListView321, A
    ValueRow:= LV_GetCount("S")
    ALL:=LV_GetCount("S")
    if (ALL = 0)
        {   
            SplashTextOff
            MsgBox , 64 , Error , No file(s) found for the required operation`, First select the files from the listview     
            SetTimer , Check_Progress 
            if min=
                SetTimer , GETLEVEL , 50
            else 
                SetTimer , GETLEVEL , off
            return
        }
    else if (ALL > 1)
        UpDown := 1
        SingleTag=%ValueRow%
        Progress , B2  Fm10 Fs10 WM400 H70 ZH11, Please wait.. , Working Please Wait.. ,Working.. , Arial
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
                                IfNotExist , %Folder%\%Text%
                                        goto , endofcoverloop
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
                                SplitPath , filename , , , FileExtn
                                if FileExtn in MP3,AAC,MPP,TTA
                                    {      
                                        DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2DeleteSelectedFrameW",uint,1095780675,uint,Updown)
                                        errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSaveChangesW") 
                                    }
                                else if FileExtn in FLAC
                                    {
                                        DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACDeletePictureW",Uint,Updown)
                                        errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSaveChangesW")
                                    }
                                else if FileExtn in MP4,M4A,M4B,M4P
                                    {
                                        DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4DeletePictureW",Uint,Updown)
                                        errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSaveChangesW")
                                    }
                                else if FileExtn in WMA,WMV,WMP,ASF
                                    {
                                        DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMADeletePictureW",Uint,Updown)
                                        errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSaveChangesW")
                                    }
                    endofcoverloop:
                            }
                    }
            }
    Progress , off
    GuiControl , , GUI_Text, Done
    SB_SetText("Cover art ",4)
    SplashTextOff
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off

    if(errorcode<>-1)
        {
            Message = An Error is encountered while Removing Album Art`nEither the file is not supported or the file is currently playing.
                error := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetLastErrorTextW",wstr)
            MsgBox , 16 , Error , Error Occured While Processing Tag `n%error%
        }
    else
        Message = Album Art Removed Sucessfully

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
                    Title = IDTE - ID3 Tag Editor
                    Lifespan = %timet_toast%000 ;ms
                    Notify("","",0,"Wait=50")
                    Notify("IDTE-ID3 Tag Editor", Message, 2,"TS=12 TM=8 TF=Times New Roman SI_=400 GF=2 GL=3")
                }
        }
    return
;__________________________________________________________________REMOVE ALL TAGS_________________________________________________________________________________________________;
RemoveAll:
SetTimer , Check_Progress , off 
SetTimer , GETLEVEL , off
if Folder=
    {
        if ChooseFile=
            {
                Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
                MsgBox , 16, Error , To Remove Select File(s) First
                return
            }
    }
Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
MsgBox , 68, Warning, This Will Remove Your All Tags From File(s). Continue?
IfMsgBox ,Yes
    {
        SetTimer , Check_Progress , off 
        SetTimer , GETLEVEL , off
        ControlGet, List, List, Selected, SysListView321, A
        ValueRow:= LV_GetCount("S")
        ALL:=LV_GetCount("S")
        if (ALL=0)
            {
                SplashTextOff
                MsgBox , 64 , Error , No file(s) found for the required operation`, First select the files from the listview     
                SetTimer , Check_Progress 
                if min=
                    SetTimer , GETLEVEL , 50
                else 
                    SetTimer , GETLEVEL , off
                return
            }
        Progress , M  Fm10 Fs10 WM400 H70 ZH11, Please wait.. , Working Please Wait.. ,Working.. , Arial
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
                                SplitPath , filename , , , FileExtn
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
                                GuiControl , , GUI_Text, Wait..
                                if FileExtn in MP3,AAC,MPP,TTA
                                    {
                                        DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
                                        errorcode :=DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2RemoveTagW" ) 
                                    }
                                else if FileExtn in APE,WV
                                    {
                                        DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
                                        errorcode:= DllCall(A_ScriptDir "\Plugins\AudioGenie3\APERemoveTagW") 
                                    }
                                else if FileExtn in OGG
                                    {
                                        RunWait , %WinDir%\system32\cmd.exe /c Bin\Tag.exe --remove "%Folder%\%Text%", , hide
                                    }
                                else
                                    {
                                        DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetArtistW", wstr ,"")
                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetAlbumW", wstr ,"")
                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetYearW", wstr ,"")
                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetGenreW", wstr ,"")
                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetTrackW", wstr ,"")
                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetTitleW", wstr ,"")
                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetCommentW", wstr ,"")
                                        DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetComposerW", wstr ,"")
                                        errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSaveChangesW")
                                        if FileExtn in FLAC
                                            {
                                                DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACSetUserItemW",wstr, "ALBUMARTIST", wstr, "")
                                                DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACSetUserItemW",wstr, "PUBLISHER", wstr, "")  
                                                DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACDeletePicturesW")
                                                errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACSaveChangesW")
                                            }   
                                        else if FileExtn in M4A,MP4,M4B
                                            {
                                                DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4SetiTuneFrameW",wstr, "aART", wstr, "")
                                                DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4SetiTuneFrameW",wstr, "Copyright", wstr, "")
                                                DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4DeletePicturesW")
                                                errorcode :=   DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4SaveChangesW")
                                            }
                                        else if FileExtn in WMA,ASF
                                            {
                                                DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMASetUserItemW",wstr, "WM/AlbumArtist", wstr, "")
                                                DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMASetUserItemW",wstr, "WM/Publisher", wstr, "")
                                                DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMADeletePicturesW")
                                                errorcode := DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMASaveChangesW")
                                            }

                                    }
                            }
                    }
                SingleTag=%A_Index%
            }
    GuiControl , , GUI_Progress, 0
    GuiControl , , GUI_Text, Done
    IniRead , checker41,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Tray_Not,Tray_Not_Sucess
    if(errorcode<>-1)
        {
            Message = Error occured while performing operation
            error := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetLastErrorTextW",wstr)
            MsgBox , 16 , Error , Error Occured While Processing Tags `n%error%
        }
    else
            Message = Tag(s) Removed Sucessfully    
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
    Progress , off
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
    goto , refresh
}
IfMsgBox ,No
    {
        SetTimer , Check_Progress 
            if min=
                SetTimer , GETLEVEL , 50
            else 
                SetTimer , GETLEVEL , off
    }
    return

;___________________________________________________REMOVE ID3V1______________________________________________________________________________________________________________;
RemoveID3V1:
    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
    MsgBox ,36, Wait..,Are You Sure?
        IfMsgBox , No
            return
        IfMsgBox , Yes
            SetTimer , Check_Progress , off 
            SetTimer , GETLEVEL , off
        SplashTextOn , , ,Removing ID3v1 Tag....
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
                            runwait , %WinDir%\system32\cmd.exe /c Bin\IDTE "IDTE_REMOVE_V1" "%Folder%\%Text%", , Hide
                    }
            }
    GuiControl , , GUI_Progress, 0
    GuiControl , , GUI_Text, Done
    GuiControl , , milli, ID3v1 Removed
    SplashTextOff
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return

;_____________________________________________________________REMOVE ID3V2______________________________________________________________________________________________________;
RemoveID3V2:

    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
    MsgBox ,36, Wait..,Are You Sure?
    IfMsgBox , No
        return
    IfMsgBox , Yes
        SetTimer , Check_Progress , off 
        SetTimer , GETLEVEL , off
    SplashTextOn , , ,Removing ID3v2 Tag....
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
                            runwait , %WinDir%\system32\cmd.exe /c Bin\IDTE "IDTE_REMOVE_V2" "%Folder%\%Text%", , Hide
                    }
        }
    GuiControl , , GUI_Progress, 0
    GuiControl , , GUI_Text, Done
    GuiControl , , milli, ID3v2 Removed
    SplashTextOff
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return
;___________________________________________________________________REMOVE Lyrics____________________________________________________________________________________________________;
RemoveLyrics:
    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
    MsgBox ,36, Wait..,Are You Sure?
    IfMsgBox , No
        return
    IfMsgBox , Yes
        SetTimer , Check_Progress , off 
        SetTimer , GETLEVEL , off
    SplashTextOn , , ,Removing Lyrics Tag....
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
                            Loop , %Folder%/%Text%
                                    filename:= A_LoopFileFullPath 
                            DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,filename )
                            DllCall(A_ScriptDir "\Plugins\AudioGenie3\ MP4DeleteEntriesW")
                        }
                }
        }
    GuiControl , , GUI_Text, Done
    GuiControl , , milli, Lyrics Removed
    SplashTextOff
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return