;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : Equalizer.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================

Equaliz:
if Set_Equaliser=
	{
		FX0:=DllCall(A_ScriptDir "\bass.dll\BASS_ChannelSetFX", uint, hMedia,uint ,7,Uint,0 )
		FX1:=DllCall(A_ScriptDir "\bass.dll\BASS_ChannelSetFX", uint, hMedia,uint ,7,Uint,0 )
		FX2:=DllCall(A_ScriptDir "\bass.dll\BASS_ChannelSetFX", uint, hMedia,uint ,7,Uint,0 )
		FX3:=DllCall(A_ScriptDir "\bass.dll\BASS_ChannelSetFX", uint, hMedia,uint ,7,Uint,0 )
		FX4:=DllCall(A_ScriptDir "\bass.dll\BASS_ChannelSetFX", uint, hMedia,uint ,7,Uint,0 )
	}

	Gui,S: New
	Gui,S: Color , White
	Gui,S: font, cBlack
	Gui,S: Add, GroupBox , x5 y2 w320 h267
	Gui,S: Add, GroupBox , x330 y2 w80 h267
	Gui,S: Add, Slider, x30 y10 w30 h200 vertical gGain  AltSubmit +Center noticks vGain, %GainS%
	gui,S: Add, Text , xp yp+200 , 125 Hz
	Gui,S: Add, Slider, xp+60 y10 w30 h200 vertical gAttack  AltSubmit +Center noticks vAttack, %AttackS%
	gui,S: Add, Text , xp yp+200 , 500 Hz
	Gui,S: Add, Slider, xp+60 yp-200 vertical w30 h200 gRelease  AltSubmit +Center noticks vRelease, %ReleaseS%
	gui,S: Add, Text , xp yp+200 , 1 KHz
	Gui,S: Add, Slider, xp+60 yp-200 vertical w30 h200  gThreshold  AltSubmit +Center noticks vThreshold, %ThresholdS%	
	gui,S: Add, Text , xp yp+200 , 5 KHz
	Gui,S: Add, Slider, xp+60 yp-200 vertical w30 h200 gRatio  AltSubmit +Center noticks vRatio, %RatioS%
	gui,S: Add, Text , xp yp+200 , 8 KHz
	Gui,S: Add, Slider, xp+90 yp-200 vertical w30 h200 gPredelay  AltSubmit +Center noticks vPredelay , 50
	gui,S: Add, Text , xp yp+200 , Reverb
	Gui,S: Add, GroupBox , x18 y228 w23 h23
	Gui,S:Add, pic, x20 y235 vIndicate gSButtonPower w20 h15,%A_WorkingDir%\GUI\ON.png
	Gui,S: font, cC0C0C0 S10
	Gui,S:Add, Text, x50 y235 vPow gPow_eq,Turn OFF
	Gui,S: font, cC0C0C0 S8
	Gui, +LastFound  +AlwaysOnTop
	;gui,S: Add, DropDownList , x150 y235 vPreset gPreset +Center, Laptop Mode|Headphones|Bass Only|Apollo Hypermix|Treble|Full Bass+Treble|Soft|Rock|Pop|Electro|Mids Only|Highs Only|Lows Only|%Default_pre%||

	Set_Equaliser=1
	; Generated using SmartGUI Creator for SciTE
	Gui,S: Show, w415 h279, Set Parametric Equalizer
	NumPut(18,Comp,4,"float")
	NumPut(0,Comp,8,"float")
	return

Gain:
	Gui ,S:Submit , Nohide
	GainS:=Gain
	Gain:=0-((Gain-50)/10)*3
	NumPut(Gain,Comp,8,"float")
	NumPut(125,Comp,0,"float")
	DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX0,"ptr" ,&Comp)
return

Attack:
	Gui ,S:Submit , Nohide
	AttackS:=Attack
	Attack:=0-((Attack-50)/10)*3
	NumPut(Attack,Comp,8,"float")
	NumPut(500,Comp,0,"float")
	DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX1,"ptr" ,&Comp)
return

Release:
	Gui ,S:Submit , Nohide
	ReleaseS:=Release
	Release:=0-((Release-50)/10)*3
	NumPut(Release,Comp,8,"float")
	NumPut(1000,Comp,0,"float")
	DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX2,"ptr" ,&Comp)
return

Threshold:
	Gui ,S:Submit , Nohide
	ThresholdS:=Threshold
	Threshold:=0-((Threshold-50)/10)*3
	NumPut(Threshold,Comp,8,"float")
	NumPut(5000,Comp,0,"float")
	DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX3,"ptr" ,&Comp)
return

Ratio:
	Gui ,S:Submit , Nohide
	RatioS:=Ratio
	Ratio:=0-((Ratio-50)/10)*3
	NumPut(Ratio,Comp,8,"float")
	NumPut(8000,Comp,0,"float")
	DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX4,"ptr" ,&Comp)
return

Predelay:
	Gui ,S:Submit , Nohide
	Predelay:= Predelay-96
	NumPut(0,Rev,0,"float")
	NumPut(Predelay,Rev,4,"float")
	NumPut(1000,Rev,8,"float")
	NumPut(0.001,Rev,12,"float")
	DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX5,"ptr" ,&Rev)
return

Pow_eq:
SButtonPower:
	if Set_Equaliser=1
		{
			GuiControl , S:,Power, OFF
			GuiControl , S:,Pow, Turn ON
			GuiControl , , Indicate, *w20 *h15 %A_WorkingDir%\GUI\OFF.png
			GuiControl , disable,Gain
			GuiControl , disable,Attack
			GuiControl , disable,Release
			GuiControl , disable,Threshold
			GuiControl , disable,ratio
			DllCall(A_ScriptDir "\bass.dll\BASS_ChannelRemoveFX",uint, hMedia, uint,FX0)    
			DllCall(A_ScriptDir "\bass.dll\BASS_ChannelRemoveFX",uint, hMedia, uint,FX1)    
			DllCall(A_ScriptDir "\bass.dll\BASS_ChannelRemoveFX",uint, hMedia, uint,FX2)    
			DllCall(A_ScriptDir "\bass.dll\BASS_ChannelRemoveFX",uint, hMedia, uint,FX3)    
			DllCall(A_ScriptDir "\bass.dll\BASS_ChannelRemoveFX",uint, hMedia, uint,FX4)
			DllCall(A_ScriptDir "\bass.dll\BASS_ChannelRemoveFX",uint, hMedia, uint,FX5)
			DllCall(A_ScriptDir "\bass.dll\BASS_FXReset",uint, hMedia)
			Set_Equaliser=
		}
		else
		{
			Gui ,S:Submit , Nohide
			GuiControl , S:,Power, ON
			GuiControl , S:,Pow, Turn OFF
			GuiControl , , Indicate, *w20 *h15 %A_WorkingDir%\GUI\ON.png
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
			Gain:=0-((Gain-50)/10)*3
			NumPut(Gain,Comp,8,"float")
			NumPut(125,Comp,0,"float")
			DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX0,"ptr" ,&Comp)
			Attack:=0-((Attack-50)/10)*3
			NumPut(Attack,Comp,8,"float")
			NumPut(500,Comp,0,"float")
			DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX1,"ptr" ,&Comp)
			Release:=0-((Release-50)/10)*3
			NumPut(Release,Comp,8,"float")
			NumPut(1000,Comp,0,"float")
			DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX2,"ptr" ,&Comp)
			Threshold:=0-((Threshold-50)/10)*3
			NumPut(Threshold,Comp,8,"float")
			NumPut(5000,Comp,0,"float")
			DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX3,"ptr" ,&Comp)
			Ratio:=0-((Ratio-50)/10)*3
			NumPut(Ratio,Comp,8,"float")
			NumPut(8000,Comp,0,"float")
			DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX4,"ptr" ,&Comp)
			Set_Equaliser=1
	}
	return


	Gui ,S:Submit , Nohide
	GainS:=Gain
	Gain:=0-((Gain-50)/10)*3
	NumPut(Gain,Comp,8,"float")
	NumPut(125,Comp,0,"float")
	DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX0,"ptr" ,&Comp)
	AttackS:=Attack
	Attack:=0-((Attack-50)/10)*3
	NumPut(Attack,Comp,8,"float")
	NumPut(500,Comp,0,"float")
	DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX1,"ptr" ,&Comp)
	ReleaseS:=Release
	Release:=0-((Release-50)/10)*3
	NumPut(Release,Comp,8,"float")
	NumPut(1000,Comp,0,"float")
	DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX2,"ptr" ,&Comp)
	ThresholdS:=Threshold
	Threshold:=0-((Threshold-50)/10)*3
	NumPut(Threshold,Comp,8,"float")
	NumPut(5000,Comp,0,"float")
	DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX3,"ptr" ,&Comp)
	RatioS:=Ratio
	Ratio:=0-((Ratio-50)/10)*3
	NumPut(Ratio,Comp,8,"float")	
	NumPut(8000,Comp,0,"float")
	DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX4,"ptr" ,&Comp)
	Predelay:= Predelay-96
	NumPut(0,Rev,0,"float")
	NumPut(Predelay,Rev,4,"float")
	NumPut(1000,Rev,8,"float")
	NumPut(0.001,Rev,12,"float")
	DllCall(A_ScriptDir "\bass.dll\BASS_FXSetParameters", uint, FX5,"ptr" ,&Rev)	
	return

SGuiClose:
	gui , S:destroy 
return