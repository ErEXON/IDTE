;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : Music_Slider.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================

;*********************************************************************************************************************************************************************************
; This Script is Completely Modified Version of Pulover [Rodolfo U. Batista]  For Progress Slider as Volume Controller . 
; Orignal Author : Pulover [Rodolfo U. Batista] Orignal Script Name ::Progress Bar Slider:: 
; Email : rodolfoub@gmail.com
; Author URL: http://www.autohotkey.net/~Pulover/ProgressBarSlider.ahk
; Modified By : Rajat Kosh 
;Email - rajatkosh2153@gmail.com
;**********************************************************************************************************************************************************************************

WM_LBUTTONDOWN(wParam, lParam)
{
   global id
   MouseGetPos, mX,,, control
   If !InStr(control, "msctls_progress32")  ; If the click wasn't in the progress bar, do nothing.
      return
   id := SubStr(control, 18, 1)
   SetTimer, Time_ToolTip, 0
}

Time_ToolTip:
If !GetKeyState("LButton", "P")
{
   Tooltip
   SetTimer, Time_ToolTip, off
   MouseGetPos, mX  ; Gets mouse position relative to the Window.
   mX -= PrBar%id%X 
   X := floor(100/ (PrBar%id%W/mX)) 
   Tooltip, % PBar(X) -5 "%"
      if (id = 2)
         {
            ifnotinstring ,IsCUE , CUE
               {
                  seek:= % PBar(X) -5
                  percent := (Seek/100)*BASS_GETLEN
                  DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelSetPosition", UInt,hMedia, Uint64,percent ,Int,32768) ;What is 32768 --> This Will Allow The Bass To Get Arguments in Bytes i.e. BASS_POS_BYTES
               }
            else
               {
                  seek:= % PBar(X) -5
                  percent := ((CURR_START) + (Seek/100)*TOTAL)
                  DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelSetPosition", UInt,hMedia, Uint64,percent ,Int,32768) ;What is 32768 --> This Will Allow The Bass To Get Arguments in Bytes i.e. BASS_POS_BYTES  
               }
               ;BASS_ErrorGetCode6	:= DllCall(A_ScriptDir "\bass.dll\BASS_ErrorGetCode", Int) ;Shows error if Any
               ;if (BASS_ErrorGetCode6!=0)
               ;{
               ;	MsgBox , 64, Error,An Internal Error  Occured Error Code - %BASS_ErrorGetCode6%
               ;return
               ;}
         }
   return
}
   MouseGetPos, mX  ; Gets mouse position relative to the Window.
   mX -= PrBar%id%X 
   X := floor(100/ (PrBar%id%W/mX)) 
   Tooltip, % PBar(X) -5 "%"
   if (id =3)
      {
         volume := % PBar(X) 
         Vol_Bass := volume/100
         if Status_Playing=1 
               DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelSetAttribute", UInt,hMedia,Uint,2,float,Vol_Bass)
         GuiControl , , mutetext ,
         Vol = Volume - %volume%`% ; Set Volume Textual Information 
         SB_SetText(Vol , 3)
         GuiControl, , Vol_info , %Vol%
      }
   GuiControl,, PrBar%id%, % PBar(X) -5  ; Set*s progress bar to mouse position.
   GuiControl,Mini:, Bar%id%, % PBar(X) ; Set*s progress bar to mouse position.
return

PBar(X)
{
   global
   If X < 0
      return 5
   If (X > 100)
      return 105
   Else
      return X
}