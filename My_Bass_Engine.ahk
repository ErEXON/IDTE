;**********************************************************************************************************************************************************************************************************************************************************************************************
; Author : Rajat Kosh 
; Script Name : My_Bass_Engine.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================

#SingleInstance force
ButtonOK:
Force_play:
    if flag=1
        DllCall(A_ScriptDir "\bass.dll\BASS_Start") 
        flag=0
playBass:   
   Status_Playing=1 
   SetTimer , Check_Progress , off 
   SetTimer , GETLEVEL , off
   if FlagStopped=1
     {
         BASS_DLLCALL		:= DllCall("LoadLibrary","str",A_ScriptDir "\bass.dll") ; load Bass.dll
         BASS_Init			:= DllCall(A_ScriptDir . "\bass.dll\BASS_Init",Int,-1,UInt,44100,Int,0,UInt,0,UInt,0) ;initialise Bass
         BASS_start	:=DllCall(A_ScriptDir . "\bass.dll\BASS_Start", int) ;Start Bass
         DllCall(A_ScriptDir . "\bass.dll\BASS_PluginLoad", Astr, A_ScriptDir "\Plugins\bassflac.dll", Int,0 )
         DllCall(A_ScriptDir . "\bass.dll\BASS_PluginLoad", Astr, A_ScriptDir "\Plugins\bass_aac.dll", Int,0 )
         DllCall(A_ScriptDir . "\bass.dll\BASS_PluginLoad", Astr, A_ScriptDir "\Plugins\bass_ac3.dll", Int,0 )
         DllCall(A_ScriptDir . "\bass.dll\BASS_PluginLoad", Astr, A_ScriptDir "\Plugins\bass_alac.dll", Int,0 )
         DllCall(A_ScriptDir . "\bass.dll\BASS_PluginLoad", Astr, A_ScriptDir "\Plugins\bass_ape.dll", Int,0 )
         DllCall(A_ScriptDir . "\bass.dll\BASS_PluginLoad", Astr, A_ScriptDir "\Plugins\basswma.dll", Int,0 )
         DllCall(A_ScriptDir . "\bass.dll\BASS_PluginLoad", Astr, A_ScriptDir "\Plugins\basswv.dll", Int,0 )
         DllCall(A_ScriptDir . "\bass.dll\BASS_PluginLoad", Astr, A_ScriptDir "\Plugins\bass_spx.dll", Int,0 )
         DllCall(A_ScriptDir . "\bass.dll\BASS_PluginLoad", Astr, A_ScriptDir "\Plugins\bass_tta.dll", Int,0 )
         DllCall(A_ScriptDir . "\bass.dll\BASS_PluginLoad", Astr, A_ScriptDir "\Plugins\bassmidi.dll", Int,0 )
         DllCall(A_ScriptDir . "\bass.dll\BASS_PluginLoad", Astr, A_ScriptDir "\Plugins\bassfx.dll", Int,0 )
         DllCall(A_ScriptDir . "\bass.dll\BASS_PluginLoad", Astr, A_ScriptDir "\Plugins\bassopus.dll", Int,0 )
         DllCall(A_ScriptDir . "\bass.dll\BASS_PluginLoad", Astr, A_ScriptDir "\Plugins\bass_mpc.dll", Int,0 )
         DllCall(A_ScriptDir . "\bass.dll\BASS_PluginLoad", Astr, A_ScriptDir "\Plugins\bass_ofr.dll", Int,0 )
       FlagStopped=
     }
   if flag<>2
    {
       if flag=1
         {
            DllCall(A_ScriptDir . "\bass.dll\BASS_Start", Int) ;resumes playback
            DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelSlideAttribute", UInt,hMedia,Uint,2,float,Vol_Bass,Uint,1000) 
            GuiControl , , Clist ,Playing :`n%Play_Title%  `nBy %Play_Art% `nOn %Play_Album%`nAt %H_Z%kbps`,%S_R%Hz`,%C_H% Mode
            GuiControl , Mini:, PlayingStatus,Playing :`n%Play_Title%  `nBy %Play_Art% `n
            flag=2
            LV_Modify(Save_Focus,"Icon" . 1)
            PrevFocus = FocusedRowNumber
            IniRead , checker28,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Miscellaneous,Enable_Toaster
            IniRead , checker43,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Tost_Not,Tost_Not_ply
            Play_Str = Playing :`n%Play_Title%  `nBy %Play_Art% `nOn %Play_Album%

            IfWinNotActive , IDTE-ID`3 Tag Editor
                if (Checker43=1)
                   {
                      if (checker28=1)
                          {
                             Message = Resuming : `n%Play_Title% `nBy %Play_Art% `nOn %Play_Album%
                             Notify("","",0,"Wait=2")
                             CArt = Image=%A_Temp%\CArt.png
                             Notify("IDTE-ID3 Tag Editor", Message, Time_pop,CArt)
                          }    
                   }
            IniRead , checker35,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Tray_Not,Tray_Not_ply
            if(Checker35=1)
                {
                  #Persistent
                  TrayTip, IDTE-ID3 Tag Editor,Playing :`n%Play_Title% `nBy %Play_Art% `nOn %Play_Album%,1  
                  SetTimer, RemoveTrayTip, %Tray_Time%000
                }
            SetTimer , Check_Progress 
               if min=
                   SetTimer , GETLEVEL , 50
               else 
                   SetTimer , GETLEVEL , off
               if Visualflag=
                  if min=
                    SetTimer , Scroll , On
               return
         }
       FocusedRowNumber := LV_GetNext(0, "F")  ; Find the focused row.
       ControlGet, List, List, Selected, SysListView321, A
       Value_Row:= LV_GetCount()
       if not FocusedRowNumber  ; No row is focused.
           return
       LV_GetText(FileName, FocusedRowNumber, 8)
       LV_GetText(FileDir, FocusedRowNumber, 9)
       LV_GetText(IsCUE,FocusedRowNumber,15)
       FileDelete , %A_WorkingDir%\Covers\AlbumArt.jpg
       FileDelete , %A_WorkingDir%\Covers\AlbumArt.png
       DllCall( "LoadLibrary", Str,A_ScriptDir "\Plugins\AudioGenie3.dll" )
       DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,Dummy ) ; Dummy Call for SplashText
       IniRead , checker59,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Player,Mplayer2
        if (checker59=1)
         {
            Run , %FileDir%\%FileName%
            return
         }
        loop , %FileDir%\%FileName%
         {
           file := A_LoopFileFullPath
           playback_file := A_LoopFileFullPath
         }
        DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,file )
        TrkLenMs := DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetDurationMillisW" )
        Play_Title:=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetTitleW",wstr)
        Play_Art:=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetArtistW",wstr)
        Play_Album:= DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetAlbumW",wstr)
        Total_Len := TrkLenMs
        TrkLen   := FormatMs( TrkLenMs )
        DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelStop", UInt,hMedia) ;Clear its buffer
        hMedia:= DllCall("BASS\BASS_StreamCreateFile", UInt,FromMem:=0 , UInt,&file, UInt64,Offset:=0, UInt64,Length:=0, UInt,(A_IsUnicode ? 0x80000000 : 0x40000))
        BASS_ErrorGetCode5	:= DllCall(A_ScriptDir "\bass.dll\BASS_ErrorGetCode", Int) ;Shows error if Any
        if (BASS_ErrorGetCode5!=0)
                  return
        ifinstring ,IsCUE , CUE
           {
                SoundGetWaveVolume , VolumePrev
                SoundSetWaveVolume , 0 ;Set Volume To Zero
           }
       BASS_ChannelPlay	:=DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelPlay", UInt,hMedia, Int,1) ;Starts playback
       Vol_Bass := volume/100
       DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelSetAttribute", UInt,hMedia,Uint,2,float,Vol_Bass)
       BASS_GETLEN := DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelGetLength", UInt,hMedia, Uint,0 , Uint ) 
       LV_Modify(0,"Icon" . 99999999)
       LV_Modify(FocusedRowNumber,"Icon" . 1)
       PrevFocus = %FocusedRowNumber%
       Save_Focus = %PrevFocus%
       GuiControl , Show,Info
       GuiControl , Show,Info2
       flag=2
       again=
       SetTimer , Check_Progress 
         if min=
            SetTimer , GETLEVEL , 50
         else 
            SetTimer , GETLEVEL , off
       goto , Mus_ico
 return
}
else
{
    goto , Trayplay
    return
}

Trayplay:
 FocusedRowNumber--
 #IfWinActive , ahk_class AutoHotkeyGUI
   ^down::
BassNext:
   SetTimer , Check_Progress, off 
   SetTimer , GETLEVEL , off
   {
       FocusedRownumber++
       Value_Row:= LV_GetCount()
       if ( FocusedRowNumber > Value_Row)  
             FocusedRowNumber = 1
       LV_GetText(FileName, FocusedRowNumber, 8)
       LV_GetText(FileDir, FocusedRowNumber, 9)
       LV_GetText(IsCUE,FocusedRowNumber,15)
       IniRead , checker59,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Player,Mplayer2
       if (checker59=1)
           {
             Run , %FileDir%\%FileName%
             return
           }
       FileDelete , %A_WorkingDir%\Covers\AlbumArt.jpg
       DllCall( "LoadLibrary", Str,A_ScriptDir "\Plugins\AudioGenie3.dll" )
       DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,Dummy ) ; Dummy Call for SplashText
       loop , %FileDir%\%FileName%
          {  
              file := A_LoopFileFullPath
              playback_file := A_LoopFileFullPath
          }
       DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,file )
       Play_Title:=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetTitleW",wstr)
       Play_Art:=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetArtistW",wstr)
       Play_Album:= DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetAlbumW",wstr)
       TrkLenMs := DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetDurationMillisW" )
       Total_Len := TrkLenMs
       TrkLen   := FormatMs( TrkLenMs )
       DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelStop", UInt,hMedia) ;Clear its buffer
       hMedia:= DllCall("BASS\BASS_StreamCreateFile", UInt,FromMem:=0 , UInt,&file, UInt64,Offset:=0, UInt64,Length:=0, UInt,(A_IsUnicode ? 0x80000000 : 0x40000)) ; Create Stream or Buff in Memory 
       BASS_ErrorGetCode4	:= DllCall(A_ScriptDir "\bass.dll\BASS_ErrorGetCode", Int) ;Shows error if Any
         if (BASS_ErrorGetCode4!=0)
                return
       ;BASS_ErrorGetCode5	:= DllCall(A_ScriptDir "\bass.dll\BASS_ErrorGetCode", Int) ;Shows error if Any
       ;if (BASS_ErrorGetCode5!=0)  
       ;	MsgBox , 64, Error, An Error is Occured While Streaming (Possible Error - No Files)
        ifinstring ,IsCUE , CUE
          {
             SoundGetWaveVolume , VolumePrev
             SoundSetWaveVolume , 0 ;Set Volume To Zero
          }
       BASS_ChannelPlay	:=DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelPlay", UInt,hMedia, Int,1) ;Starts playback
       Vol_Bass := Volume/100
       DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelSetAttribute", UInt,hMedia,Uint,2,float,Vol_Bass)
       BASS_GETLEN := DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelGetLength", UInt,hMedia, Uint,0 , Uint )
       LV_Modify(0,"Icon" . 99999999)
       LV_Modify(FocusedRowNumber,"Icon" . 1)
       PrevFocus = %FocusedRowNumber%
       Save_Focus = %PrevFocus%
       flag=2
       again=
       SetTimer , Check_Progress 
        if min=
            SetTimer , GETLEVEL , 50
        else 
            SetTimer , GETLEVEL , off
     goto , Mus_ico
return
}

#IfWinActive , ahk_class AutoHotkeyGUI
^up::
BassPrev:
{
   SetTimer , Check_Progress , off 
   SetTimer , GETLEVEL , off
   FocusedRownumber--
   Value_Row:= LV_GetCount()
   if ( FocusedRowNumber = 0)  
        FocusedRowNumber = %Value_Row%
   LV_GetText(FileName, FocusedRowNumber, 8)
   LV_GetText(FileDir, FocusedRowNumber, 9)
   LV_GetText(IsCUE,FocusedRowNumber,15)
   IniRead , checker59,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Player,Mplayer2
   if (checker59=1)
      {
        Run , %FileDir%\%FileName%
        return
      }
   FileDelete , %A_WorkingDir%\Covers\AlbumArt.jpg
   DllCall( "LoadLibrary", Str,A_ScriptDir "\Plugins\AudioGenie3.dll" )
   DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,Dummy ) ; Dummy Call for SplashText
   loop , %FileDir%\%FileName%
       {
         file := A_LoopFileFullPath
         playback_file := A_LoopFileFullPath
       }
   DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,file )
   TrkLenMs := DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetDurationMillisW" )
   Play_Title:=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetTitleW",wstr)
   Play_Art:=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetArtistW",wstr)
   Play_Album:= DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetAlbumW",wstr)
   Total_Len := TrkLenMs
   TrkLen   := FormatMs( TrkLenMs )
        DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelStop", UInt,hMedia) ;Clear its buffer
   hMedia:= DllCall("BASS\BASS_StreamCreateFile", UInt,FromMem:=0 , UInt,&file, UInt64,Offset:=0, UInt64,Length:=0, UInt,(A_IsUnicode ? 0x80000000 : 0x40000)) ; Create Stream or Buff in Memory  Song=="C:/1.mp3"
   BASS_ErrorGetCode5	:= DllCall(A_ScriptDir "\bass.dll\BASS_ErrorGetCode", Int) ;Shows error if Any
   if (BASS_ErrorGetCode5!=0)   
       return
   ifinstring ,IsCUE , CUE
     {
         SoundGetWaveVolume , VolumePrev
         SoundSetWaveVolume , 0 ;Set Volume To Zero
     }
     BASS_ChannelPlay	:=DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelPlay", UInt,hMedia, Int,1) ;Starts playback
     Vol_Bass := Volume/100
     DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelSetAttribute", UInt,hMedia,Uint,2,float,Vol_Bass)
     BASS_GETLEN := DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelGetLength", UInt,hMedia, Uint,0 , Uint )
     LV_Modify(0,"Icon" . 99999999)
     LV_Modify(FocusedRowNumber,"Icon" . 1)
     PrevFocus = %FocusedRowNumber%
     Save_Focus = %PrevFocus%
     flag=2
     again=
     SetTimer , Check_Progress 
     if min=
          SetTimer , GETLEVEL , 50
     else 
          SetTimer , GETLEVEL , off
    goto , Mus_ico
}


#IfWinActive , ahk_class AutoHotkeyGUI
   ^right::
fwd:
   BASS_CURR := DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelGetPosition", UInt,hMedia, Int, 0 ,int ) 
   ifnotinstring ,IsCUE , CUE
        percent := BASS_CURR + ((1/50)*BASS_GETLEN)
    else
       {
         if( BASS_CURR > CURR_END )
                goto , BassNext
         percent := BASS_CURR + ((1/50)*TOTAL)
       }
   DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelSetPosition", UInt,hMedia, Uint64,percent ,Int,32768) ;What is 32768 --> This Will Allow The Bass To Get Arguments in Bytes i.e. BASS_POS_BYTES
   BASS_ErrorGetCode6	:= DllCall(A_ScriptDir "\bass.dll\BASS_ErrorGetCode", Int) ;Shows error if Any
   IniRead , checker37,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Tray_Not,Tray_Not_Fwd
   if(Checker37=1)
      {
         #Persistent
         TrayTip, IDTE-ID3 Tag Editor,Forwarded 2 Percent,1
         SetTimer, RemoveTrayTip, %Tray_Time%000
      }
   IniRead , checker28,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Miscellaneous,Enable_Toaster
   IniRead , checker45,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Tost_Not,Tost_Not_Fwd
   IfWinNotActive , IDTE-ID`3 Tag Editor   
      if (Checker45=1)
         {
           if  (checker28=1)
             {
                Title = IDTE -ID3 Tag Editor
                Message = Forwarded 2 Percent 
                Lifespan = %timet_toast%000 ;ms
                Notify("","",0,"Wait=2")
                Notify("IDTE-ID3 Tag Editor", Message, Time_pop)
             }
         } 
    goto , check_progress
    ;if (BASS_ErrorGetCode6!=0)
    ;{
    ;	MsgBox , 64, Error,An Internal Error  Occured Error Code - %BASS_ErrorGetCode6%
    ;return
    ;}
   return

#IfWinActive , ahk_class AutoHotkeyGUI
   ^left::
rev:
    BASS_CURR := DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelGetPosition", UInt,hMedia, Int, 0 ,int ) 
    ifnotinstring ,IsCUE , CUE
          percent := BASS_CURR - ((1/50)*BASS_GETLEN)
     else
        {
          if( BASS_CURR < CURR_START )
             goto , BassPrev
          percent := BASS_CURR - ((1/50)*TOTAL)
        }
    DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelSetPosition", UInt,hMedia, Uint64,percent ,Int,32768) ;What is 32768 --> This Will Allow The Bass To Get Arguments in Bytes i.e. BASS_POS_BYTES
    IniRead , checker38,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Tray_Not,Tray_Not_Rev
    if(Checker38=1)
       {
          #Persistent
          TrayTip, IDTE-ID3 Tag Editor,Rewinded 2 Percent,1
          SetTimer, RemoveTrayTip, %Tray_Time%000
       }
    IniRead , checker28,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Miscellaneous,Enable_Toaster
    IniRead , checker46,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Tost_Not,Tost_Not_Rev
    IfWinNotActive , IDTE-ID`3 Tag Editor
    if (Checker46=1)
       {
        if (checker28!=0)
           {
            Title = IDTE -ID3 Tag Editor
            Message = Rewinded 2 Percent 
            Lifespan = %timet_toast%000 ;ms
            Notify("","",0,"Wait=50")
            Notify("IDTE-ID3 Tag Editor", Message, Time_pop)
           }
       }    
goto , check_progress
    ;BASS_ErrorGetCode6	:= DllCall(A_ScriptDir "\bass.dll\BASS_ErrorGetCode", Int) ;Shows error if Any
    ;if (BASS_ErrorGetCode6!=0)
    ;{
    ;	MsgBox , 64, Error,An Internal Error  Occured Error Code - %BASS_ErrorGetCode6%
    ;return
    ;}
return

Check_Progress:
 ifnotinstring ,IsCUE , CUE
   {
      BASS_CURR := DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelGetPosition", UInt,hMedia, Int, 0 ,int )
      progress_curr := (BASS_CURR/BASS_GETLEN)*100
      GuiControl,, PrBar2, %progress_curr%
      GuiControl,Mini:, Bar2, %progress_curr%
      current := Round(progress_curr) 
      TrkLenMs := (BASS_CURR/BASS_GETLEN)*Total_Len
      TrkLenS   := FormatMs( TrkLenMs )
   }
  else
    {
       BASS_CURR := DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelGetPosition", UInt,hMedia, Int, 0 ,int )
       progress_curr := ((BASS_CURR-CURR_START)/TOTAL)*100
       GuiControl,, PrBar2, %progress_curr%
       GuiControl,Mini:, Bar2, %progress_curr%
       current := Round(progress_curr) 
       TrkLenMs := ((BASS_CURR-CURR_START)/TOTAL)*Millisecond
       TrkLenS   := FormatMs( TrkLenMs )
    }
  GuiControl , Mini:, Duration_min , %TrkLenS%/%TrkLen%
  if(GUISELECT =0)
       GuiControl , , info ,Duration: %TrkLen%`nCurrently At:`n%TrkLenS%
  if(GUISELECT =2 or GUISELECT =4)
     {
        GuiControl , , info ,%TrkLen%
        GuiControl , , info2 ,%TrkLenS%
     }
    String_Complete = Completed - %Current% `%
    SB_SetText(String_Complete , 2)
    GuiControl, , Completed, %String_Complete%
    GetCurr := DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelIsActive", Uint, hMedia,Uint)
   if (Flag=2)
     {
        IfInString , IsCUE,CUE
            {
             if (TrkLen = TrkLenS)
                  GetCurr=0
            }
        if (GetCurr=0)
            {
              SetTimer ,, Off
               {
                if(flagplay=3) ;repeat File
                    goto, trayplay
                if flagplay= ;Play List
                    {
                      Value_Row:= LV_GetCount()
                      if ( FocusedRowNumber = Value_Row)  
                            goto , stop
                      else
                           goto , BassNext
                    }
                 else if (flagplay=1)
                       goto , stop
                 else if(flagplay=2) ;repeat List (Default)
                       {
                          Value_Row:= LV_GetCount()
                          if ( FocusedRowNumber = Value_Row)
                               FocusedRowNumber =0
                          goto , BassNext
                       }
                 else if (flagplay=4)
                       {
                          Value_Row:= LV_GetCount()
                          Random , FocusedRowNumber, 0 , Value_row
                          goto , BassNext
                       }
                }
        return

      }
 }
GuiControl, , Vol_info , %Vol%
return


GETLEVEL:
if min<>
  SetTimer , GETLEVEL , off 
  LEVEL := DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelGetLevel", UInt,hMedia, Uint)
  CPU := DllCall(A_ScriptDir . "\bass.dll\BASS_GetCPU", float)
  SB_SetText("CPU " . CPU . "%",5)
  GuiControl , , CPU , CPU %CPU%`%
  Transform , LFT , BitAnd, %LEVEL%, 0xFFFF
  Transform , RIT , BitShiftRight, %LEVEL%, 16
  LFT :=Round ((LFT/32768)*100,0)
  RIT :=Round ((RIT/32768)*100,0)
  If Visualflag=1
       DllCall(A_ScriptDir . "\Bass_SFX.dll\BASS_SFX_PluginRender",Uint,SFX_Handle,Uint,hMedia,"Ptr",SFX_DC)
  if (Flag=2)
    {
       IniRead , checker70,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Visual,Enable_V
       if (Checker70=1)
           {
              GuiControl,, LEFT, %LFT%
              GuiControl,, RIGHT, %RIT%
              GuiControl,, LET, %LFT%
              GuiControl,, RIGT, %RIT%
              GuiControl,, LT, %LFT%
              GuiControl,, RIT, %RIT%
           }
       IniRead , checker69,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Visual,Enable_BT
       if (checker69=1)
           {
             if(LFT<50)
                    {
                       GuiControl , , L1,
                       GuiControl , , L2, 
                       GuiControl , , L3, 
                       GuiControl , , L4, 
                       GuiControl , , L5,
                    }
              else if(LFT<60)
                    {
                       GuiControl , , L1, 100
                       GuiControl , , L2, 
                       GuiControl , , L3, 
                       GuiControl , , L4, 
                       GuiControl , , L5,
                    }
              else if(LFT<70)
                    {
                       GuiControl , , L1, 100
                       GuiControl , , L2, 100 
                       GuiControl , , L3, 
                       GuiControl , , L4, 
                       GuiControl , , L5,
                    }
              else if(LFT<80)
                    {
                       GuiControl , , L1, 100
                       GuiControl , , L2, 100 
                       GuiControl , , L3, 100
                       GuiControl , , L4, 
                       GuiControl , , L5,
                    }    
              else if(LFT<98)
                    {
                       GuiControl , , L1, 100
                       GuiControl , , L2, 100 
                       GuiControl , , L3, 100
                       GuiControl , , L4, 100
                       GuiControl , , L5,
                    }
              else if(LFT<100)
                    {
                        GuiControl , , L1, 100
                        GuiControl , , L2, 100 
                        GuiControl , , L3, 100
                        GuiControl , , L4, 100
                        GuiControl , , L5, 100
                    }

                if(RIT<50)
                    {
                          GuiControl , , R1, 
                          GuiControl , , R2, 
                          GuiControl , , R3, 
                          GuiControl , , R4, 
                          GuiControl , , R5,
                    }
                else if(RIT<60)
                    {
                          GuiControl , , R1, 100
                          GuiControl , , R2, 
                          GuiControl , , R3, 
                          GuiControl , , R4, 
                          GuiControl , , R5,
                    }
               else if(RIT<70)
                    {
                          GuiControl , , R1, 100
                          GuiControl , , R2, 100 
                          GuiControl , , R3, 
                          GuiControl , , R4, 
                          GuiControl , , R5,
                    }
               else if(RIT<80)
                    {
                          GuiControl , , R1, 100
                          GuiControl , , R2, 100 
                          GuiControl , , R3, 100
                          GuiControl , , R4, 
                          GuiControl , , R5,
                    }    
               else if(RIT<98)
                    {
                          GuiControl , , R1, 100
                          GuiControl , , R2, 100 
                          GuiControl , , R3, 100
                          GuiControl , , R4, 100
                          GuiControl , , R5,
                    }
              else if(RIT<100)
                    {
                          GuiControl , , R1, 100
                          GuiControl , , R2, 100 
                          GuiControl , , R3, 100
                          GuiControl , , R4, 100
                          GuiControl , , R5, 100
                    }
           }

    return
 }
return
