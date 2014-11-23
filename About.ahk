AboutIDTE:
Gui, About:Font, S12 CDefault bold, Arial
Gui,About:Add,Picture, x10 y0 w50 h50, IDTE.ico 
Gui,About:Add,picture, x450 y5 ,   %A_WorkingDir%\GUI\icons\oxygen.png
Gui,About:Add,text, x70 y2 , IDTE - ID3 Tag Editor
Gui, About:Font, S8 CDefault bold, Tahoma
Gui,About:Add,text, x70 y22, Version 2.6 (Escalation) `nAuthor - Rajat kosh
Gui,About: Add, link,x0 y0 w0 h0  vlink,<a href="Deselect Mail">www.google.com</a> 
Gui, About:Add, link,x190 y35 gEmaillink vEmaillink,<a href="rajatkosh2153@gmail.com">rajatkosh2153@gmail.com</a> 

Gui, About:Font, S8 CDefault , Tahoma
Gui, About:Add, Button, x430 y290 w80 h20 , Close
Gui, About:Add, Tab2, x5 y55 w510 h230 , About|Thanks to|License
Gui, About:Font, S8 CDefault , Tahoma
Gui, About:Tab, About
Gui, About:Add, link,x10 y95 gWebsite vWebsite,IDTE Homepage <a href="http://sourceforge.net/projects/idteid3tagedito">http://sourceforge.net/projects/idteid3tagedito</a> 
Gui, About:Add, text, x10 y110 w490 h100 ,`nIDTE is a full featured Tag editor cum Music player`nIt supports a variety  of music formats for tag editing as well as for audio playback.`n`nIt's convenient user interface is targeted at all audiences, trying to be as simple as for novice users while also providing all features an advanced user might need.`n
Gui, About:Add,pic, x10 y210 w40 h40 ,  %A_WorkingDir%\GUI\icons\bug.png
Gui, About:Add, text,x55 y210 ,Report your bugs at: 
Gui, About:Add, link,x55 y230 gWebsite vWebst, <a href="http://sourceforge.net/p/idteid3tagedito/bugs/">http://sourceforge.net/p/idteid3tagedito/bugs/</a> 

Gui, About:Tab, License
Gui, About:Add, Edit, x10 y85 w490 h180 ReadOnly  vmyeditctr,IDTE- ID3 Tag Editor by Rajat kosh`nCopyright (c) 2013-14 Team IDTE`n`nIDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.`n`nIDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.`n`nYou should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>.`n`n----------------------------------------------------------------------------------`n`nBass.dll and Plugins`nBy UN4SEEN`nLicense:`nBASS is free for non-commercial use. If you are a non-commercial entity (eg. an individual) and you are not charging for your product`, and the product has no other commercial purpose`, then you can use BASS in it for free.`n`nThe full license is available from their website.`n----------------------------------------------------------------------------------`n`nIDTE is released under GNU GPL but some of the modules/libraries used in IDTE are not GPL.`nPlease check their licenses before Using/Modifying them`n----------------------------------------------------------------------------------`n
Gui, About:Tab, Thanks to
Gui, About:Add, Edit,x10 y85 w490 h180 ReadOnly +center vmyeditctrl,Ian Luck for BASS library and, BASS plugins developers `nCopyright (c) 1999-2013 Un4seen Developments Ltd. All rights reserved`nhttp://www.un4seen.com/`n-----------------------------------------------------------------------------------`n`n Oxygen Team`n All the icons (Oxygen icons) used in IDTE are developed by the Oxygen Team`nOxygen Icons are released under GNU LGPL License `n`n-----------------------------------------------------------------------------------`n`nStefan Töngi and  Ulrich Decker `n`nFor "AudioGenie tag  library"`nhttp://sourceforge.net/projects/audiogenie`nAudiogenie tagging library is  released under GNU LGPL License v2`n`n-----------------------------------------------------------------------------------`n`nWPClipart.com - CD Jewel Case `nhttp://www.wpclipart.com/computer/disks/CD_2/CD-RW_in_jewel_case.png.html`n-----------------------------------------------------------------------------------`n`nGwarble For Notify (Toaster Popups) v0.4991`nhttp://www.autohotkey.net/~gwarble/Notify/`n`n-----------------------------------------------------------------------------------`n`nCorrupt -- Graphic Button`nhttp://www.autohotkey.com/q=Graphic_button`n-----------------------------------------------------------------------------------`n`nIDTE uses "Tag" Command-line tool for OGG/Vorbis comment tagging`nSpecial Thanks to`nCase and Neil Popham`nhttp://www.synthetic-soul.co.uk/tag/`nCopyright (c)2002-2003 Case. Minor additions by Neil Popham`, 2004-2007 `nTag is Released Under LGPL v2.1`n`n-----------------------------------------------------------------------------------`n`n AutoIt Developer For ID3 UDF `n"http://www.autoitscript.com/forum/index.php?showtopic=43950&st=0"`n-----------------------------------------------------------------------------------`nSpecial thanks to  `nRohit Tripathi – The Creative WordPress Developer`n`nThe graphics,layouts and all the stuff used in help manual is provided by  http://rohitink.com/`n-----------------------------------------------------------------------------------`n`nSKAN`n For Unicode To Ansi And Ansi To Unicode Conversion `n-----------------------------------------------------------------------------------`nAll the authors of code snippets I've used from the AutoHotkey forums `n-----------------------------------------------------------------------------------`n

Gui, About:Show, w520 h320, About IDTE
WinSet , AlwaysOnTop , , About IDTE
return

Website:
	run ,http://sourceforge.net/projects/idteid3tagedito
return

ReportBug:
	run ,http://sourceforge.net/p/idteid3tagedito/discussion/general/
return

EmailLink:
	Run, mailto:rajatkosh2153@gmail.com?subject=Suggestions Toward IDTE&body=
return

AboutButtonClose:
AboutGuiClose:
	Gui, About:destroy
return

