;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : InitializeBassModule.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================

;______________________________________________________________ LOADING BASS LIBRARY ___________________________________________________________________________________________;



  BASS_DLLCALL		:= DllCall("LoadLibrary",str,A_ScriptDir "\bass.dll") ; load Bass.dll
  BASS_Init			:= DllCall(A_ScriptDir . "\bass.dll\BASS_Init",Int,-1,Int,44100,Int,0,UInt,0,UInt,0) ;initialise Bass
  BASS_ErrorGetCode5	:= DllCall(A_ScriptDir "\bass.dll\BASS_ErrorGetCode", Int) ;Shows error if Any
  if (BASS_ErrorGetCode5!=0){
      MsgBox , 16,Error,Error Occured While Loading Bass Library `,Errorcode = 0x000%BASS_ErrorGetCode5%`nPlayback Might Not Work On Your System
    }
  BASS_start	:=DllCall(A_ScriptDir . "\bass.dll\BASS_Start", int) ;Start Bass
  BASS_ErrorGetCode5	:= DllCall(A_ScriptDir "\bass.dll\BASS_ErrorGetCode", Int) ;Shows error if Any
  if (BASS_ErrorGetCode5!=0){
      MsgBox , 16,Error,Error Occured While Loading Bass Library `,Errorcode = 0x000%BASS_ErrorGetCode5%`nPlayback Might Not Work On Your System
    }
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
  DllCall("LoadLibrary","str",A_ScriptDir "\Bass_SFX.dll") ; load Bass_SFX.dll

  DllCall( "LoadLibrary", Str,A_ScriptDir "\Plugins\AudioGenie3.dll" )
  DllCall( "AudioGenie3\AUDIOAnalyzeFile", Str,Dummy ) ; Dummy Call for SplashText
 
  DllCall( "AudioGenie3\SetLogFileW", Str,A_MyDocuments "\IDTE_Data\IDTE_Logs.log" ) 

  VarSetCapacity(Dist,28)
  VarSetCapacity(Echo_Eq,24)
  VarSetCapacity(Comp,28)
  VarSetCapacity(Chor,28)
  VarSetCapacity(Rev,28)

  Gain:=50
  Attack:=50
  Release:=50
  Threshold:=50
  ratio:=50

  GainS:=50
  AttackS:=50
  ReleaseS:=50
  ThresholdS:=50
  ratioS:=50

  if CMD_Recieved !=
  {
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
      Loop, parse, CMD_Recieved, `n
        {
            loop %A_LoopField%
              {
                FileU := A_LoopFileFullPath
                ADG_getinfo(FileU, Trackinfo, Titleinfo, Artistinfo, Albuminfo, Genreinfo, Yearinfo, Bandinfo,Publisherinfo,Composerinfo,Commentinfo,Channelinfo,Lyrics)
                Bitrate  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetBitrateW",int) 
                Dur := DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetDurationMillisW" )
                Dur :=  FormatMs(Dur)
                Sample := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetSampleRateW",int)

                LV_Add("Icon", "",Trackinfo, Titleinfo,Artistinfo,Albuminfo,Yearinfo,Genreinfo,A_LoopFileName, A_LoopFileDir,Bandinfo,Publisherinfo,Composerinfo,Commentinfo, A_LoopFileSizeMB " MB",A_LoopFileExt,Channelinfo,Sample " hertz",Bitrate " Kbps",Dur)

              }
        }
      T2 := A_TickCount ;Time After The Complete Retrieval Process
      IniRead , Checker9, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,UI,Auto_Adjust 
      if (checker9=1) 
        {
            LV_ModifyCol()  ; Auto-size each column to fit its contents
        }
      time_t := T2-T1 ;Time Defference = total time required For The Above Complete Process
      IniRead , checker3,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini , Album_Art, Show_Tme
      if (Checker3=1)
            GuiControl , , milli, Last Tag retrived in %time_t% Milliseconds ;shows information of time required for this tag retrieval in GUI
      GuiControl, Focus , MyListView ;Focus The List View
  }