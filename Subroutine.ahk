;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : Subroutine.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================


ShowPic: ;show the coverart on double click
if A_GUIEvent = DoubleClick
{
    goto ,ContextArt
      return
}
return

MyListView:
CallSubroutine: ;----------------JUST A LABEL

if A_GUIEvent = ColClick
    return

if Folder=
   {
      if ChooseFile=
         {
            return
         }
   }

if A_GUIEvent = DoubleClick
{
      goto , force_play
      return
}

if A_GUIEvent = I
{
   ValueRow:= LV_GetCount("S") ; Get Currently selected file Rownumber 
   if(ValueRow>2 and Multi_Sel=1)
   {
      return
   }
   GuiControl , focus , Mylistview
   goto , contextHighlight
}

FileDelete ,taginfo.txt
FileDelete ,taginfo2.txt
return


mute:
   if flagM=1
   {
      SoundSetWaveVolume , %VolumePrev%
      flagM=0
      GuiControl , , mutetext ,
      AddGraphicButton("mute", vol_ico, "x800 y190 w25 h25 gmute", 20, 20)
      return
   }
SoundGetWaveVolume , VolumePrev
SoundSetWaveVolume , 0
GuiControl , , mutetext , Muted
mvol_ico=%A_WorkingDir%\GUI\icons\volm.bmp
AddGraphicButton("mute", mvol_ico, "x800 y190 w25 h25 gmute", 20, 20)
flagM=1
return

play:
goto , playBass
return



Mus_ico:
Critical , on
Flag_CUE_Play=
Nexttrack=

Loop , %FileDir%\%Filename%
      mp3FileA := A_LoopFileFullPath
DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", str,mp3FileA )
ifinstring ,IsCUE , CUE
   {
      LV_GetText(Play_Title,FocusedRowNumber,3)
      LV_GetText(track_NO,FocusedRowNumber,2)
      Include=0
      FileEncoding ,  
      Loop , %FileDir%\*.cue
      {
         Loop, read, %A_LoopFileFullPath%
         {
            IfInString , A_loopreadline , FILE
            {
               Stringreplace , FLname , A_LoopReadLine , FILE , ,All
               Stringreplace , FLname , FLname , WAVE , ,All
               Stringreplace , FLname , FLname , " , ,All
               IfInString , FLname, %Filename%
                  {
                     Include =1
                     break
                  }
            }
         }
         If Include=1
         {
            CUEFL = %A_LoopFileFullPath%
            break
         }
      }

      loop , read , %CUEFL%
      {
         IfInString , A_loopreadline,TRACK %track_NO% AUDIO
            {
               Flag_CUE_Play=1
            }

         IfInString , A_loopreadline,TRACK %Nexttrack% AUDIO
            {
               Flag_CUE_Play=2
            }

         IfInString ,A_LoopReadLine ,INDEX 01
            {
               if Flag_CUE_Play=1
                  {
                     StringRight , Line, A_LoopReadLine , 8
                     StringtrimRight , Min, Line , 6
                     StringRight , Sec, Line , 5
                     StringtrimRight , Sec, Sec , 3
                     StringRight , MSec, Line, 2 

                     Milliseconds := Min*60*1000 + Sec*1000 + Msec
                     percent := ((Milliseconds/Total_Len))*BASS_GETLEN
                     DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelSetPosition", UInt,hMedia, Uint64,percent ,Int,32768) ;What is 32768 --> This Will Allow The Bass To Get Arguments in Bytes i.e. BASS_POS_BYTES
                     CURR_START := DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelGetPosition", UInt,hMedia, Int, 0 ,int )
                     Nexttrack := track_NO + 1
                     if Nexttrack in 1,2,3,4,5,6,7,8,9
                     Nexttrack = 0%Nexttrack%
                  }
               else if Flag_CUE_Play=2
                  {
                     StringRight , Line, A_LoopReadLine , 8
                     StringtrimRight , Min, Line , 6
                     StringRight , Sec, Line , 5
                     StringtrimRight , Sec, Sec , 3
                     StringRight , MSec, Line, 2 
                     Millisecond := Min*60*1000 + Sec*1000 + Msec
                     percent := ((Millisecond/Total_Len))*BASS_GETLEN
                     DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelSetPosition", UInt,hMedia, Uint64,percent ,Int,32768) ;What is 32768 --> This Will Allow The Bass To Get Arguments in Bytes i.e. BASS_POS_BYTES
                     Millisecond := Millisecond- Milliseconds
                     TrkLen:= FormatMs(Millisecond)
                     CURR_END := DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelGetPosition", UInt,hMedia, Int, 0 ,int )
                     percent := ((Milliseconds/Total_Len))*BASS_GETLEN
                     DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelSetPosition", UInt,hMedia, Uint64,percent ,Int,32768) ;What is 32768 --> This Will Allow The Bass To Get Arguments in Bytes i.e. BASS_POS_BYTES
                     SoundSetWaveVolume , %VolumePrev%
                     TOTAL := CURR_END-CURR_START  
                     break
                  }
            }
      }
      SoundGetWaveVolume , VolumePrev
      LV_GetText(Play_Art,FocusedRowNumber,4)
      LV_GetText(Play_Album,FocusedRowNumber,5)
      FileEncoding ,  UTF-16
   }
   H_Z  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetBitrateW",int) 
   C_H :=   DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetChannelModeW",wstr)   
   S_R  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetSampleRateW",int) 
   L_S :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetTextFrameW", uint, 1431522388,wstr) 
    if L_S =
         L_S :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\LYRICSGetLyricsW",wstr)
    if L_S =
         L_S :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACGetUserItemW",wstr, "LYRICS", wstr) 
    if L_S =
         L_S :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4GetiTuneFrameW",wstr, "©lyr", wstr)
    if L_S =
         L_S := DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMAGetUserItemW",wstr, "WM/Lyrics", wstr)
    if L_S =
         L_S := DllCall(A_ScriptDir "\Plugins\AudioGenie3\APEGetUserItemW",wstr, "Lyrics", wstr)        
   if C_H = unknown
         C_H = Surround Sound
         if Play_Title=
            Play_Title= Unknown Title
         if Play_Art=
            Play_Art= Unknown Artist
         if Play_Album=
            Play_Album= Unknown Album
   GuiControl , , info ,Duration: %TrkLen%`nCurrently At: %time%
   GuiControl , , Clist ,Playing :`n%Play_Title%  `nBy %Play_Art% `nOn %Play_Album%`nAt %H_Z%kbps`,%S_R%Hz`,%C_H% Mode
   GuiControl , Mini:, PlayingStatus, Playing :`n%Play_Title%  `nBy %Play_Art% `nOn %Play_Album%
   Play_Str = Playing :`n%Play_Title%  `nBy %Play_Art% `nOn %Play_Album%
   GuiControl , , LRC2 , %L_S%

   FileDelete , %A_Temp%\PArt.png

      DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,mp3FileA )
      DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetPictureFileW", wstr , A_Temp "\PArt.png", uint, 01)
      DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACGetPictureFileW", wstr , A_Temp "\PArt.png", uint, 01)
      DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4GetPictureFileW", wstr , A_Temp "\PArt.png", uint, 01)
      DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMAGetPictureFileW", wstr , A_Temp "\PArt.png", uint, 01)

   if GUISELECT=2
      {
         IfExist ,  %A_Temp%\PArt.png
            {
               GuiControl,, Mus_ico, *w40 *h40 %A_Temp%\PArt.png
               GuiControl,Mini:, CoverAlb, *w50 *h50 %A_Temp%\PArt.png
            }
         IfNotExist , %A_Temp%\PArt.png
            {
               GuiControl , , Mus_ico, *w40 *h40 %A_WorkingDir%\GUI\music_icon40.png
               GuiControl,Mini:, CoverAlb, *w50 *h50 %A_WorkingDir%\GUI\music_icon40.png
            }
      }
      else
      {
         IfExist ,  %A_Temp%\PArt.png
            {
               GuiControl,, Mus_ico, *w100 *h100 %A_Temp%\PArt.png
               GuiControl,Mini:, CoverAlb, *w50 *h50 %A_Temp%\PArt.png
            }
         IfNotExist , %A_Temp%\PArt.png
            {
               GuiControl , , Mus_ico, *w100 *h100 %A_WorkingDir%\GUI\music_icon40.png
               GuiControl,Mini:, CoverAlb, *w50 *h50 %A_WorkingDir%\GUI\music_icon40.png
            }
      }


   IniRead , checker28,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Miscellaneous,Enable_Toaster
   IniRead , checker43,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Tost_Not,Tost_Not_ply
   IfWinNotActive , IDTE-ID`3 Tag Editor
   if (Checker43=1)
      {
         if (checker28=1)
            {
               IniRead , Time_pop, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Tost_Not,Tost_Time 
               IniRead , MsgFont, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Toaster, Message_Font
               IniRead , MsgSize, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Toaster,Message_Size
               IniRead , BGCol, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Toaster,Message_Col
               IniRead , TitleSize, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Toaster,Title_Size 
               IniRead , buttn_font, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Toaster,Tost_Font 
               IniRead ,checker7 ,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini, UI,Enable_Welcome_Note
               FileDelete , %A_Temp%\CArt.png
               DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetPictureFileW", wstr , A_Temp "\CArt.png", uint, 01)
               DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACGetPictureFileW", wstr , A_Temp "\CArt.png", uint, 01)
               DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4GetPictureFileW", wstr , A_Temp "\CArt.png", uint, 01)
               DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMAGetPictureFileW", wstr , A_Temp "\CArt.png", uint, 01)
               ifnotExist, %A_Temp%\CArt.png
                  FileCopy , %A_WorkingDir%\GUI\music_icon.png , %A_Temp%\CArt.png

               Message = Currently Playing : `n%Play_Title% `nBy %Play_Art% `nOn %Play_Album%
               Notify("","",0,"Wait=2")
               CArt = %A_Temp%\CArt.png
               Options = TS=12 TM=8 SI=400 SO=300 IW=90 IH=90 MF=%MsgFont% MS=%MsgSize% GC=%BGCol% TS=%TitleSize% TF=%buttn_font% GF=2 GL=3 Image=%CArt%
               Notify("IDTE-ID3 Tag Editor", Message, Time_pop,Options)

            }
      }
IniRead , checker35,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Tray_Not,Tray_Not_ply
   if(Checker35=1)
      {
         #Persistent
         TrayTip, IDTE-ID3 Tag Editor,Playing :`n%Play_Title% `nBy %Play_Art% `nOn %Play_Album%,1
         SetTimer, RemoveTrayTip, %Tray_Time%000
      }
   if(Set_Equaliser=1)
      {
         GuiControl , S:,Power, ON
         GuiControl , , Indicate, *w20 *h15 %A_WorkingDir%\Skin\interface\ON.png
         GuiControl , enable,Gain
         GuiControl , enable,Attack
         GuiControl , enable,Release
         GuiControl , enable,Threshold
         GuiControl , enable,ratio
         FX0:=DllCall(A_ScriptDir "\bass.dll\BASS_ChannelSetFX", uint, hMedia,uint ,7,Uint,0 )
         FX1:=DllCall(A_ScriptDir "\bass.dll\BASS_ChannelSetFX", uint, hMedia,uint ,7,Uint,0 )
         FX2:=DllCall(A_ScriptDir "\bass.dll\BASS_ChannelSetFX", uint, hMedia,uint ,7,Uint,0 )
         FX3:=DllCall(A_ScriptDir "\bass.dll\BASS_ChannelSetFX", uint, hMedia,uint ,7,Uint,0 )
         FX4:=DllCall(A_ScriptDir "\bass.dll\BASS_ChannelSetFX", uint, hMedia,uint ,7,Uint,0 )
         NumPut(Gain,Comp,8,"float")
         NumPut(125,Comp,0,"float")
         DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX0,"ptr" ,&Comp)
         NumPut(Attack,Comp,8,"float")
         NumPut(500,Comp,0,"float")
         DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX1,"ptr" ,&Comp)
         NumPut(Release,Comp,8,"float")
         NumPut(1000,Comp,0,"float")
         DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX2,"ptr" ,&Comp)
         NumPut(Threshold,Comp,8,"float")
         NumPut(5000,Comp,0,"float")
         DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX3,"ptr" ,&Comp)
         NumPut(Ratio,Comp,8,"float")
         NumPut(8000,Comp,0,"float")
         DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX4,"ptr" ,&Comp)
         Set_Equaliser=1
      }
   if Visualflag=  
          if min=
      SetTimer , Scroll , On
   Critical , off
return

Stop:
   SetTimer , Scroll , Off
   SetTimer , Check_Progress , off 
   SetTimer , GETLEVEL , off
      DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelStop", UInt,hMedia) ;Clear its buffer
      DllCall(A_ScriptDir "\bass.dll\BASS_Pause") ; Free Bass Contents
      DllCall(A_ScriptDir "\bass.dll\BASS_Stop") ; Free Bass Contents
      DllCall(A_ScriptDir "\bass.dll\BASS_PluginFree", int, 0) ; Free Bassplugins Contents
      DllCall(A_ScriptDir "\bass.dll\BASS_Free") ; Free Bass Contents
      GuiControl , , Clist ,Stopped :`n%Play_Title%
      Play_Str = Stopped :`n%Play_Title%
      GuiControl , Mini:, PlayingStatus,  Stopped : %Play_Title%
      IniRead , checker43,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Tray_Not,Tray_Not_stp
      if (Checker36=1)
         {
            #Persistent
            TrayTip, IDTE-ID3 Tag Editor,Song Stopped :`n%Play_Title%,1
            SetTimer, RemoveTrayTip, %Tray_Time%000
         }
      IniRead , checker28,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Miscellaneous,Enable_Toaster
      IniRead , checker44,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Tost_Not,Tost_Not_stp
      IfWinNotActive , IDTE-ID`3 Tag Editor
         if (Checker44=1)
            {
               if (checker28=1)
                  {
                     Title = IDTE -ID3 Tag Editor
                     Message = Stopped :`n%Play_Title%
                     Notify("","",0,"Wait=2")
                     CArt = Image=%A_Temp%\CArt.png
                     NotifyID:= Notify("IDTE-ID3 Tag Editor", Message, Time_pop,CArt)
                  }
            }
      flag=0
      FlagStopped=1
return

Play_Pause:
   if(flag=1)
      goto , playBass
Pause:
   SetTimer , Scroll , Off
      LV_Modify(Save_Focus,"Icon" . 99999999)
      LV_Modify(Save_Focus,"Icon" . 2)
      DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelSlideAttribute", UInt,hMedia,Uint,2,float,0,Uint,1000) ;Fade Out Channel & Stops
      sleep , 1000
      DllCall(A_ScriptDir "\bass.dll\BASS_Pause") 
      GuiControl , , Clist ,Paused :`n%Play_Title% `nArtist: %Play_Art% `nAlbum: %Play_Album% 
      GuiControl , Mini:, PlayingStatus, Paused: `n%Play_Title%
      Play_Str =  Paused: `n%Play_Title%
      flag=1
      IniRead , checker28,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Miscellaneous,Enable_Toaster
      IniRead , checker47,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Tost_Not,Tost_Not_pus
         IfWinNotActive , IDTE-ID`3 Tag Editor
            if (Checker47=1)
            {
               if (checker28=1)
                  {
                     Message = Paused : `n%Play_Title% `nBy %Play_Art% `nOn %Play_Album%
                     Notify("","",0,"Wait=2") 
                     CArt = Image=%A_Temp%\CArt.png
                     Notify("IDTE-ID3 Tag Editor", Message, Time_pop,CArt )
                  }
            }

      IniRead , checker39,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Tray_Not,Tray_Not_pus
         if (Checker39=1)
            {
               #Persistent
               TrayTip, IDTE-ID3 Tag Editor,Paused :`n%Play_Title% `nBy %Play_Art% On %Play_Album% ,1 
               SetTimer, RemoveTrayTip, %Tray_Time%000
            }
return

RemoveTrayTip:
   SetTimer, RemoveTrayTip, Off
   TrayTip
return


helpTag:
   Run ,%A_WorkingDir%\Help Manual\Help.html
return

ContextConf:
   Runwait , %A_WorkingDir%\Bin\Configure.exe
return

FormatMs( Ms ) {
  Secs := Ms//1000, Time:=20000101
  Time += %Secs%, Seconds
  FormatTime, mmss, %Time%, mm:ss
  Return ((hh:=Round(Secs//3600)) > 0 ? hh ":" : "" ) mmss
}

Sec_To_Milli(Time_In){
   StringSplit , MyArr , Time_In , :
return ((MyArr[0]*60000)+(MyArr[1]*1000)+(MyArr[2])s) 
}

update(var1lo,var1hi,var2lo,var2hi,var3lo,var3hi,var4lo,var4hi,var5,var6,var7,var8,var9){
  progress,% (var2lo/var1lo) * 100,,% (var2lo/var1lo) * 100 " %",Processing File(s)...
  return 0
}


; Funtion Name - ADG_Getinfo()

ADG_getinfo(mp3fileA, ByRef Trackinfo, ByRef Titleinfo, ByRef Artistinfo, ByRef Albuminfo, ByRef Genreinfo, ByRef Yearinfo, ByRef Bandinfo, ByRef Publisherinfo, ByRef Composerinfo, ByRef Commentinfo, ByRef Channelinfo,ByRef Lyrics)
{
   
   SplitPath , mp3fileA,,, FileExt   
 if FileExt in MP3,AAC,MPP,TTA
      {
         DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,mp3FileA)
         Trackinfo :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetTextFrameW", uint, 1414677323,wstr) 
         Titleinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetTextFrameW", uint, 1414091826,wstr) 
         Artistinfo :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetTextFrameW", uint, 1414546737,wstr) 
         Albuminfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetTextFrameW", uint, 1413565506,wstr) 
         Genreinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetTextFrameW", uint, 1413697358,wstr) 
         Yearinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetTextFrameW", uint, 1415136594,wstr) 
         Bandinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetTextFrameW", uint, 1414546738,wstr) 
         Publisherinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetTextFrameW", uint,1414550850,wstr) 
         Composerinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetTextFrameW", uint, 1413697357,wstr) 
         Commentinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetTextFrameW", uint, 1129270605,wstr) 
         Channelinfo:= DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetChannelModeW",wstr)
         Lyrics :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetTextFrameW", uint, 1431522388,wstr) 
         if Lyrics =
               Lyrics :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\LYRICSGetLyricsW",wstr)
         Mime := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetPictureMimeW",uint, 01,wstr)
         IfInString , Mime, jpeg
               DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetPictureFileW", wstr , A_Temp "\AlbumArt.jpg", uint, 01)
         else 
               DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetPictureFileW", wstr , A_Temp "\AlbumArt.png", uint, 01)
      }
   else
      {
         DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,mp3FileA )
         Artistinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetArtistW",wstr)
         Albuminfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetAlbumW",wstr)
         Yearinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetYearW",wstr)
         Genreinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetGenreW",wstr)
         Trackinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetTrackW",wstr)
         Titleinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetTitleW",wstr)
         Commentinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetCommentW",wstr)
         Composerinfo :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetComposerW",wstr)
         Lyrics :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\LYRICSGetLyricsW",wstr)
         if Lyrics=
            Lyrics :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetTextFrameW", uint, 1431522388,wstr)
         if FileExt in FLAC
            {
               Bandinfo := DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACGetUserItemW",wstr, "ALBUMARTIST", wstr)
               Publisherinfo := DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACGetUserItemW",wstr, "PUBLISHER", wstr)   
               Lyrics :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACGetUserItemW",wstr, "LYRICS", wstr) 
            }
         else if FileExt in M4A,MP4,M4B
            {
               Bandinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4GetiTuneFrameW",wstr, "aART", wstr)
               Publisherinfo := DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4GetiTuneFrameW",wstr, "Copyright", wstr)
               Lyrics :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4GetiTuneFrameW",wstr, "©lyr", wstr) 
            }
         else if FileExt in WMA,ASF,WMP,WMV
            {
               Bandinfo := DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMAGetUserItemW",wstr, "WM/AlbumArtist", wstr)
               Publisherinfo := DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMAGetUserItemW",wstr, "WM/Publisher", wstr)  
               Lyrics := DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMAGetUserItemW",wstr, "WM/Lyrics", wstr) 
            }
         else if FileExt in OGG
            {
               GuiControl, disable , Composer
               GuiControl, disable , Band
               GuiControl, disable , Publisher
               Bandinfo := DllCall(A_ScriptDir "\Plugins\AudioGenie3\OGGGetUserItemW",wstr,"ALBUMARTIST", wstr)
               Publisherinfo := DllCall(A_ScriptDir "\Plugins\AudioGenie3\OGGGetOrganizationW",wstr)  
            }
         else if FileExt in APE,WV
            {
               Bandinfo := DllCall(A_ScriptDir "\Plugins\AudioGenie3\APEGetUserItemW",wstr,"Album Artist", wstr)
               Publisherinfo := DllCall(A_ScriptDir "\Plugins\AudioGenie3\APEGetUserItemW",wstr,"Publisher", wstr)
               Lyrics := DllCall(A_ScriptDir "\Plugins\AudioGenie3\APEGetUserItemW",wstr,"Lyrics", wstr)
            }
      }  
   return
}

;Function Name - ADG_GetCover()

ADG_getcover()
{

IfExist , %A_Temp%\AlbumArt.jpg
   FileDelete , %A_Temp%\AlbumArt.jpg
else IfExist , %A_Temp%\AlbumArt.png
   FileDelete, %A_Temp%\AlbumArt.png

Mime := DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4GetPictureMimeW",uint, 01,wstr)
   IfInString , Mime , jpg
      DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4GetPictureFileW", wstr , A_Temp "\AlbumArt.jpg", uint, 01)
   else 
      DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4GetPictureFileW", wstr , A_Temp "\AlbumArt.png", uint, 01)

Mime := DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACGetPictureMimeW",uint, 01,wstr)
   IfInString , Mime, jpeg
      DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACGetPictureFileW", wstr , A_Temp "\AlbumArt.jpg", uint, 01)
   else 
      DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACGetPictureFileW", wstr , A_Temp "\AlbumArt.png", uint, 01)

Mime := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetPictureMimeW",uint, 01,wstr)
   IfInString , Mime, jpeg
      DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetPictureFileW", wstr , A_Temp "\AlbumArt.jpg", uint, 01)
   else 
      DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetPictureFileW", wstr , A_Temp "\AlbumArt.png", uint, 01)

Mime := DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMAGetPictureMimeW",uint, 01,wstr)
   if(Mime = jpg)
      DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMAGetPictureFileW", wstr , A_Temp "\AlbumArt.jpg", uint, 01)
   else 
      DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMAGetPictureFileW", wstr , A_Temp "\AlbumArt.png", uint, 01)
return  
}

ADG_getcoverinfo(byref covertypeinfo, byref coversize, byref PicNum)
{
   covertypeinfo:= DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetPictureTypeTextW", uint, 1,wstr) 
   coverSize:=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetPictureSizeW", uint, 1) 
   PicNum := DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetFrameCountW", uint, 1095780675)

   if covertypeinfo=
      {
         Covertypeinfo:=DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACGetPictureTypeTextW",uint ,01,wstr)
         coverSize:=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACGetPictureSizeW", uint, 1) 
         Picnum := DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACGetPictureCountW", uint, 1, int)
           ;Hell := DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACGetPictureTypeTextW",uint ,03,wstr)
         if (Picnum > 1)
            {
               loop 
               {
                  Temp := DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACGetPictureTypeTextW",uint , A_index , wstr)
                   ;MsgBox , %Temp%
                  IfInString, Temp, \
                  {
                   Picnum := A_index - 1
                     break
                  }
                   
               }
               
            }
            if covertypeinfo=
               {
                     Covertypeinfo= No Description
                     coverSize:=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4GetPictureSizeW", uint, 1) 
                     Picnum := DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4GetPictureCountW", uint, 1)
                     if coverSize=
                     {
                        coverSize:=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMAGetPictureSizeW", uint, 1) 
                        Picnum := DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMAGetPictureCountW", uint, 1)
                     }
               }
      }  
}


ADG_getaudioinfo(ByRef HZ, byref CH, byref SR)
{
HZ  := ( DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetBitrateW",int) )
CH :=  ( DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetChannelModeW",wstr) )
SR  := ( DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetSampleRateW",int) ) 
 return
}
