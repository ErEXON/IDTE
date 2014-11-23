;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : MenuItems.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================

;_______________________________________________________________________________COMMON MENU BAR _________________________________________________________________________________;
{
;___________________________________________________FILE MENU______________________________________________________________________________________________________________________;
Menu, FileMenu, Add, &Add File(s)`tCtrl+O, openfile
Menu, FileMenu, Add, &Add Folder`tCtrl+F, openfolder
Menu, FileMenu, Add, &Add Folder(Recursively), openfolderRec
Menu, FileMenu, Add  ; Separator line.
Menu, FileMenu, Add, &Load Session, LoadSess
Menu, FileMenu, Add, &Load Playlist, openpl
Menu, FileMenu, Add, &Load Cue File\Sheet, CUE
Menu, FileMenu, Add  ; Separator line.
Menu, FileMenu, Add, &Read Tags, ReadTag
Menu, FileMenu, Add, &Save All`tCtrl+S, Saveall
Menu, FileMenu, Add, &Save This Session, SaveSess
Menu, FileMenu, Add, &Save To, SaveTo
Menu, FileMenu, Add, &Open Current File(s) Location, OPENCURRENT
Menu, FileMenu, Add  ; Separator line.
Menu, Filemenu, Add, &Exit`tAlt+F4, Exitnow

;_______________________________________________________________EDIT MENU__________________________________________________________________________________________________________;
Menu, EditMenu, Add, Move Selected , Cut
Menu, EditMenu, Add, Copy Selected , Copy
Menu, EditMenu, Add, 
Menu, EditMenu, Add, &Copy Tag`tCtrl+F1, CopyTag
Menu, EditMenu, Add, &Cut Tag`tCtrl+F2, CutTag
Menu, EditMenu, Add, &Paste Tag`tCtrl+F3, PasteTag
Menu, EditMenu, Add, &Rename Tag Files ,RenameTag
Menu, EditMenu, Add,
Menu, EditMenu, Add, &Select All , Selall
Menu, EditMenu, Add, &Deselect All`tCtrl+D, UnSelall
Menu, EditMenu, Add, &Invert Selection , UnSelall

;_________________________________________________________________VIEW MENU________________________________________________________________________________________________________;
Menu, ViewMenu, Add, &Tag Details , TagDetails
Menu, ViewMenu, Add, &Cover Art`tAlt+V, CoverDetails
Menu, ViewMenu, Add, 
Menu, ViewMenu, Add, &IDTE Command Line Mode  , WCLP 
Menu, ViewMenu, Add,
Menu, ViewMenu, Add, &Refresh`tF5, Refresh 
Menu, ViewMenu, Add, Visualization, Visualisation
Menu, ViewMenu, Add, Equalizer, Equaliz

;_____________________________________________________________________ORGANIZE MENU________________________________________________________________________________________________;
Menu, OrganiseMenu, Add, &Convert Selected Tags into FileNames ,MDFT
Menu, OrganiseMenu, Add, &Tag Files From Filename ,ConverTag
Menu, OrganiseMenu, Add,
Menu, OrganiseMenu, Add, &Make Playlist(One Per Artist) ,OPART
Menu, OrganiseMenu, Add, &Make Playlist(One Per Album)`tAlt+O, OPA
Menu, OrganiseMenu, Add, &Make Playlist(One Per Directory)`tAlt+D,OPD
Menu, OrganiseMenu, Add,
Menu, OrganiseMenu, Add, &Make Playlist(From All Files in Directory)`tAlt+A,FAF
Menu, OrganiseMenu, Add, &Make Playlist(From Selected Files)    ,FSF

;___________________________________________________________________________TOOLS MENU_____________________________________________________________________________________________;
Menu, ToolsMenu, Add, &Clear All Fields,CAF
Menu, ToolsMenu, Add, &Refresh All Fields`tAlt+E, REF
Menu, ToolsMenu, Add, &Quick Tag Editing Mode, FastMode
Menu, ToolsMenu, Add,
Menu, ToolsMenu, Add, &Mini Mode`tAlt+M, MiniMode
Menu, ToolsMenu, Add,
Menu, ToolsMenu, Add, &Configure IDTE, ContextConf
Menu, ToolsMenu, Add,
; Create another menu destined to become a submenu of the above menu.
Menu, Submenu1, Add, &Replace Character X by Character Y, Replace_char
Menu, Submenu1, Add, &Remove Leading Zero (if any),RemZero
Menu, Submenu1, Add, &Add Leading Zero ,AddZero
Menu, Submenu1, Add, &Uppercase Only First Letter of Word , Cap_F
Menu, Submenu1, Add, &Lowercase Only First Letter of Word , Uncap_F
Menu, Submenu1, Add, &Convert all letters into Uppercase, All_UP
Menu, Submenu1, Add, &Convert all letters into lowercase, All_DN

Menu, Submenu2, Add, &In Selected Filenames , :Submenu1
Menu, Submenu2, Add, &In Selected Tags , Tag_case
Menu, Submenu2, Color , ffffff [, Single]

Menu, ToolsMenu, Add, &Case Conversion, :Submenu2
Menu, Submenu1, Color , ffffff [, Single]

;________________________________________________________________________Play Mode_________________________________________________________________________________________________;
Menu, PlayM, Add, &Play List , playList
Menu, PlayM, Add, &Play File, playfile
Menu, PlayM, Add, 
Menu, PlayM, Add, &Repeat List, repeatlist
Menu, PlayM, Add, &Repeat File   , repeatfile 
Menu, PlayM, Add,
Menu, PlayM, Add, &Play Random ,Random

;__________________________________________________________________________________SFX MENU____________________________________________________________________________________;
Menu, SFX, Add, &Add Chorus Effect ,Chorus
Menu, SFX, Add, &Add Compressor Effect ,Compression
Menu, SFX, Add, &Add Distortion,Distortion
Menu, SFX, Add, &Add Echo Effect,Echo
Menu, SFX, Add, &Add Flanger Effect,Flanger
Menu, SFX, Add, &Add Gargle Effect,Gargle
Menu, SFX, Add, &Add Interactive 3D Reverb Effect,3Dreverb
Menu, SFX, Add, &Add Reverb Effect,reverb
Menu, SFX, Add, &No Effect,None

;______________________________________________________________________________SEARCH MENU_________________________________________________________________________________________;
Menu, SearchMenu, Add, &Search On Freedb`tAlt+Z, SOFDB
Menu, SearchMenu, Add, &Search On MusicBrainz`tAlt+x, SOMB
Menu, SearchMenu, Add,
Menu, SearchMenu, Add, &Search Cover Art`tAlt+N, SCA
Menu, SearchMenu, Add, &Search On Google`tAlt+K, SOG
Menu, SearchMenu, Add, &Search Lyrics`tAlt+L, SLY

;____________________________________________________________________________________REMOVE MENU___________________________________________________________________________________;
Menu, RemoveMenu, Add, &Remove All Tags,RemoveAll
IniRead , checker60, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Remove, Tag_RemovAPE
IniRead , checker61, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Remove, Tag_Remov1
IniRead , checker62, %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Remove, Tag_Remov2
Menu, RemoveMenu, Add,
if (Checker62=1)
	Menu, RemoveMenu, Add, &Remove ID3V2 Tag only, RemoveID3V2
if (Checker61=1)
	Menu, RemoveMenu, Add, &Remove ID3V1 Tag only, RemoveID3V1
Menu, RemoveMenu, Add,
Menu, RemoveMenu, Add, &Remove Lyrics, RemoveLyrics
Menu, RemoveMenu, Add,
Menu, RemoveMenu, Add, &Remove Album Art,RAA

;_____________________________________________________________________________________________EXPORT MENU__________________________________________________________________________;
Menu, ExportMenu, Add, &Export to XML Shareable Playlist Format (spiff),EXML
Menu, ExportMenu, Add,
Menu, ExportMenu, Add, &Export Tags to text format`tAlt+F5,ETT
Menu, ExportMenu, Add, &Export && Create NFO Template`tAlt+F6,ETNF
Menu, ExportMenu, Add, &Export Tags To User Specified Format`tAlt+F7,ETUSF
Menu, ExportMenu, Add, &Export To Html`tAlt+F8,ETHTM
Menu, ExportMenu, Add,
Menu, ExportMenu, Add, &Export Cover Art`tAlt+C,ECA

;_______________________________________________________________________________________________________________HELP MENU__________________________________________________________;
Menu, HelpMenu, Add, &Help Contents,HelpTopics
Menu, HelpMenu, Add,
Menu, HelpMenu, Add, &About IDTE, AApp
Menu, HelpMenu, Add,
Menu, HelpMenu, Add, &Check For Updates,Update
Menu, HelpMenu, Add, &Source Forge,SF
Menu, HelpMenu, Add, &About AutoHotKey,AHK
Menu, HelpMenu, Add, &About AutoIT,ATIT
Menu, HelpMenu, Add, &FAQ's ,FAQ
Menu, HelpMenu, Add, &What's New in this version,WHATNEW

;________________________________________________________________Create The Menu Bar And Attach Sub Menus To It___________________________________________________________________; 
; Create the menu bar by attaching the sub-menus to it:

Menu, MyMenuBar, Add, &File, :FileMenu
Menu, MyMenuBar, Add, &Edit, :EditMenu
Menu, MyMenuBar, Add, &View, :ViewMenu
Menu, MyMenuBar, Add, &Organise, :OrganiseMenu
Menu, MyMenuBar, Add, &Tools, :ToolsMenu
Menu, MyMenuBar, Add, &Play Mode, :PlayM
Menu, MyMenuBar, Add, &Add SFX, :SFX
Menu, MyMenuBar, Add, &Remove, :RemoveMenu
Menu, MyMenuBar, Add, &Search, :SearchMenu
Menu, MyMenuBar, Add, &Export, :ExportMenu
Menu, MyMenuBar, Add, &Help, :HelpMenu
Menu, MyMenuBar, Color , ffffff [, Single]

; Attach the menu bar to the window
Gui, Menu, MyMenuBar

;_________________________________________________________________CONTEXT MENU____________________________________________________________________________________________________;
Menu, MyContextMenu, Add, Tag Selected, ContextHighlight
Menu, MyContextMenu, Add,
Menu, MyContextMenu, Add, Play, ContextOpenFile
Menu, MyContextMenu, Add,Play Next,playnext
Menu, MyContextMenu, Add,
Menu, MyContextMenu, Add,Scan and Remove Dead Files,DeadFile
Menu, MyContextMenu, Add,

Menu, MyContextM, Add, File(s) to List, ContextFile
Menu, MyContextM, Add, Folder to List, ContextFold

Menu, MyContextMenu, Add, Add, :MyContextM
Menu, MyContextMenu, Add,
Menu, MyContextMenu, Add, Copy Selected.., ContextCopy
Menu, MyContextMenu, Add, Move Selected.., ContextMove
Menu, MyContextMenu, Add,
Menu, MyContextMenu, Add, Refresh, ContextRef
Menu, MyContextMenu, Add, Save EveryThing, ContextSave
Menu, MyContextMenu, Add, Clear from ListView, ContextClearRows
Menu, MyContextMenu, Add,
Menu, MyContextMenu, Add, Preview Album Art, ContextArt
Menu, MyContextMenu, Add, Show Console, ContextConsole
Menu, MyContextMenu, Add,

Menu, MyConvMenu, Add, Tag into Filename, ContextFilename
Menu, MyConvMenu, Add, Filename into Tag,ConverTag
Menu, MyConvMenu, Add,
Menu, MyConvMenu, Add, Case of Filenames, :Submenu1
Menu, MyConvMenu, Add, Case of Tags,Tag_case

Menu, MyContextMenu, Add, Convert , :MyConvMenu
Menu, MyConvMenu, Color , ffffff [, Single]

Menu, MyConArtMenu, Add, Add To File(s), ContextCoverArt
Menu, MyConArtMenu, Add, Extract From File(s) , ContextExtract

Menu, MyContextMenu, Add, Cover Art , :MyConArtMenu 
Menu, MyConArtMenu, Color , ffffff [, Single]
Menu, MyContextMenu, Add,
Menu, MyContextMenu, Add, Properties, ContextProperties
Menu, MyContextMenu, Add, Open File Location,OPENCURRENT
Menu, MyContextMenu, Default, Tag Selected ; Make "Mark & Load" a bold font to indicate that double-click does the same thing.
Menu, MyContextMenu, Color , ffffff [, Single]

;____________________________________________________________________RIGHT CLICK MENU____________________
Menu, RightCMenu, Add, Cut, Rmenu
Menu, RightCMenu, Add,
Menu, RightCMenu, Add, Copy, Rmenu
Menu, RightCMenu, Add,
Menu, RightCMenu, Add, Paste, Rmenu
Menu, RightCMenu, Add,
Menu, RightCMenu, Add, Delete, Rmenu

}

OnMessage(0x200, "MouseMove")
OnMessage(0x2A3, "MouseLeave")
OnMessage(0x202, "MouseLeave")
OnMessage(0x200, "WM_MOUSEMOVE")
DllCall("ChangeWindowMessageFilter", uint, 0x49, uint, 1)
DllCall("ChangeWindowMessageFilter", uint, 0x233, uint, 1)


Menu, Filemenu, Icon,&Add File(s)`tCtrl+O,%A_WorkingDir%\GUI\menu\file.ico,,17
Menu, Filemenu, Icon,&Add Folder`tCtrl+F,%A_WorkingDir%\GUI\menu\Oxy_Ico_18.ico,,17
Menu, Filemenu, Icon,&Add Folder(Recursively),%A_WorkingDir%\GUI\menu\Oxy_Ico_19.ico,,17
Menu, Filemenu, Icon,&Load Session,%A_WorkingDir%\GUI\menu\Oxy_Ico_37.ico,,17
Menu, Filemenu, Icon,&Load Playlist,%A_WorkingDir%\GUI\menu\Oxy_Ico_43.ico,,17
Menu, Filemenu, Icon,&Load Cue File\Sheet,%A_WorkingDir%\GUI\menu\Oxy_Ico_17.ico,,17
Menu, Filemenu, Icon,&Read Tags,%A_WorkingDir%\GUI\menu\Oxy_Ico_20.ico,,17
Menu, Filemenu, Icon,&Save All`tCtrl+S,%A_WorkingDir%\GUI\menu\Oxy_Ico_52.ico,,17 
Menu, Filemenu, Icon,&Save This Session,%A_WorkingDir%\GUI\menu\Oxy_Ico_10.ico,,17
Menu, Filemenu, Icon,&Save To,%A_WorkingDir%\GUI\menu\Oxy_Ico_31.ico,,17
Menu, Filemenu, Icon,&Open Current File(s) Location,%A_WorkingDir%\GUI\menu\Oxy_Ico_51.ico,,17
Menu, Filemenu, Icon,&Exit`tAlt+F4,%A_WorkingDir%\GUI\menu\Oxy_Ico_2.ico,,17

Menu, EditMenu,Icon,Move Selected,%A_WorkingDir%\GUI\menu\Oxy_Ico_4.ico,,17
Menu, EditMenu,Icon,Copy Selected,%A_WorkingDir%\GUI\menu\Oxy_Ico_56.ico,,17
Menu, EditMenu,Icon,&Copy Tag`tCtrl+F1,%A_WorkingDir%\GUI\menu\copy.ico,,17
Menu, EditMenu,Icon,&Cut Tag`tCtrl+F2,%A_WorkingDir%\GUI\menu\cut.ico,,17
Menu, EditMenu,Icon,&Paste Tag`tCtrl+F3,%A_WorkingDir%\GUI\menu\paste.ico,,17
Menu, EditMenu,Icon,&Rename Tag Files,%A_WorkingDir%\GUI\menu\Oxy_Ico_32.ico,,17

Menu, ViewMenu,Icon,&Tag Details,%A_WorkingDir%\GUI\menu\Oxy_Ico_43.ico,,17
Menu, ViewMenu,Icon,&Cover Art`tAlt+V,%A_WorkingDir%\GUI\menu\preview.ico,,17
Menu, ViewMenu,Icon,&Refresh`tF5,%A_WorkingDir%\GUI\menu\Oxy_Ico_58.ico,,17
Menu, ViewMenu,Icon,&IDTE Command Line Mode ,%A_WorkingDir%\GUI\menu\Oxy_Ico_26.ico,,17
Menu, ViewMenu,Icon,Visualization,%A_WorkingDir%\GUI\menu\Oxy_Ico_30.ico,,17
Menu, ViewMenu,Icon,Equalizer,%A_WorkingDir%\GUI\menu\EQ.ico,,17

Menu, OrganiseMenu,Icon,&Convert Selected Tags into FileNames,%A_WorkingDir%\GUI\menu\Oxy_Ico_59.ico,,17
Menu, OrganiseMenu,Icon,&Tag Files From Filename ,%A_WorkingDir%\GUI\menu\file_conv.ico,,17
Menu, OrganiseMenu,Icon,&Make Playlist(From All Files in Directory)`tAlt+A,%A_WorkingDir%\GUI\menu\Oxy_Ico_41.ico,,17
Menu, OrganiseMenu,Icon,&Make Playlist(One Per Album)`tAlt+O,%A_WorkingDir%\GUI\menu\Oxy_Ico_23.ico,,17
Menu, OrganiseMenu,Icon,&Make Playlist(One Per Directory)`tAlt+D,%A_WorkingDir%\GUI\menu\Oxy_Ico_53.ico,,17
Menu, OrganiseMenu,Icon,&Make Playlist(From Selected Files),%A_WorkingDir%\GUI\menu\Oxy_Ico_12.ico,,17
Menu, OrganiseMenu,Icon,&Make Playlist(One Per Artist) ,%A_WorkingDir%\GUI\menu\Oxy_Ico_50.ico,,17

Menu, ToolsMenu,Icon,&Clear All Fields,%A_WorkingDir%\GUI\menu\Oxy_Ico_48.ico,,17
Menu, ToolsMenu,Icon,&Refresh All Fields`tAlt+E,%A_WorkingDir%\GUI\menu\Oxy_Ico_58.ico,,17
Menu, ToolsMenu,Icon,&Configure IDTE,%A_WorkingDir%\GUI\menu\Oxy_Ico_27.ico,,17
Menu, ToolsMenu,Icon,&Quick Tag Editing Mode,%A_WorkingDir%\GUI\menu\quicktag.ico,,17
Menu, ToolsMenu,Icon,&Mini Mode`tAlt+M,%A_WorkingDir%\GUI\menu\MiniMode.ico,,17

Menu, SFX,Icon,&Add Chorus Effect,%A_WorkingDir%\GUI\menu\Oxy_Ico_21.ico,,17
Menu, SFX,Icon,&Add Compressor Effect,%A_WorkingDir%\GUI\menu\Oxy_Ico_21.ico,,17
Menu, SFX,Icon,&Add Distortion,%A_WorkingDir%\GUI\menu\Oxy_Ico_21.ico,,17
Menu, SFX,Icon,&Add Echo Effect,%A_WorkingDir%\GUI\menu\Oxy_Ico_21.ico,,17
Menu, SFX,Icon,&Add Flanger Effect,%A_WorkingDir%\GUI\menu\Oxy_Ico_21.ico,,17
Menu, SFX,Icon,&Add Gargle Effect,%A_WorkingDir%\GUI\menu\Oxy_Ico_21.ico,,17
Menu, SFX,Icon,&Add Interactive 3D Reverb Effect,%A_WorkingDir%\GUI\menu\Oxy_Ico_21.ico,,17
Menu, SFX,Icon,&Add Reverb Effect,%A_WorkingDir%\GUI\menu\Oxy_Ico_21.ico,,17

Menu, SearchMenu,Icon,&Search On Freedb`tAlt+Z,%A_WorkingDir%\GUI\menu\Search.ico,,17
Menu, SearchMenu,Icon,&Search On MusicBrainz`tAlt+x,%A_WorkingDir%\GUI\menu\Music_Brainz.png,,17
Menu, SearchMenu,Icon,&Search Cover Art`tAlt+N,%A_WorkingDir%\GUI\menu\Oxy_Ico_39.ico,,17
Menu, SearchMenu,Icon,&Search On Google`tAlt+K,%A_WorkingDir%\GUI\menu\Search.ico,,17
Menu, SearchMenu,Icon,&Search Lyrics`tAlt+L,%A_WorkingDir%\GUI\menu\Search3.ico,,17

Menu, RemoveMenu,Icon,&Remove All Tags,%A_WorkingDir%\GUI\menu\Oxy_Ico_28.ico,,17
Menu, RemoveMenu,Icon,&Remove ID3V2 Tag only,%A_WorkingDir%\GUI\menu\Oxy_Ico_29.ico,,17
Menu, RemoveMenu,Icon,&Remove ID3V1 Tag only,%A_WorkingDir%\GUI\menu\Oxy_Ico_29.ico,,17
Menu, RemoveMenu,Icon,&Remove Album Art,%A_WorkingDir%\GUI\menu\Oxy_Ico_33.ico,,17
Menu, RemoveMenu,Icon,&Remove Lyrics,%A_WorkingDir%\GUI\menu\Oxy_Ico_29.ico,,17

Menu, ExportMenu,Icon,&Export to XML Shareable Playlist Format (spiff),%A_WorkingDir%\GUI\menu\xml.ico,,17
Menu, ExportMenu,Icon,&Export Tags to text format`tAlt+F5,%A_WorkingDir%\GUI\menu\Oxy_Ico_49.ico,,17
Menu, ExportMenu,Icon,&Export && Create NFO Template`tAlt+F6,%A_WorkingDir%\GUI\menu\Oxy_Ico_44.ico,,17
Menu, ExportMenu,Icon,&Export Tags To User Specified Format`tAlt+F7,%A_WorkingDir%\GUI\menu\Oxy_Ico_50.ico,,17
Menu, ExportMenu,Icon,&Export To Html`tAlt+F8,%A_WorkingDir%\GUI\menu\Oxy_Ico_47.ico,,17
Menu, ExportMenu,Icon,&Export Cover Art`tAlt+C,%A_WorkingDir%\GUI\menu\Oxy_Ico_39.ico,,17

Menu, HelpMenu,Icon,&Help Contents,%A_WorkingDir%\GUI\menu\Oxy_Ico_24.ico,,17
Menu, HelpMenu,Icon,&Check For Updates,%A_WorkingDir%\GUI\menu\Oxy_Ico_46.ico,,17
Menu, HelpMenu,Icon,&FAQ's ,%A_WorkingDir%\GUI\menu\FAQ.ico,,17
Menu, HelpMenu,Icon,&Source Forge,%A_WorkingDir%\GUI\menu\SF.ico,,17
Menu, HelpMenu,Icon,&About IDTE,%A_WorkingDir%\IDTE.ico,,17
Menu, HelpMenu,Icon,&About AutoIT,%A_WorkingDir%\GUI\icons\au3.ico,,17
Menu, HelpMenu,Icon,&About AutoHotKey,%A_WorkingDir%\GUI\icons\ahk.png,,17
Menu, HelpMenu,Icon,&What's New in this version,%A_WorkingDir%\GUI\menu\hlp.ico,,17

Menu, MyContextMenu, Icon,Tag Selected,%A_WorkingDir%\GUI\menu\tag.ico,,17
Menu, MyContextMenu, Icon, Play Next,%A_WorkingDir%\GUI\menu\pnext.ico,,17
Menu, MyContextMenu, Icon,Play,%A_WorkingDir%\GUI\menu\Oxy_Ico_11.ico,,17
Menu, MyContextMenu, Icon,Scan and Remove Dead Files,%A_WorkingDir%\GUI\menu\Oxy_Ico_40.ico,,17
Menu, MyContextM, Icon,File(s) to List,%A_WorkingDir%\GUI\menu\file.ico,,17
Menu, MyContextM, Icon,Folder to List,%A_WorkingDir%\GUI\menu\Oxy_Ico_19.ico,,17
Menu, MyContextMenu, Icon,Copy Selected..,%A_WorkingDir%\GUI\menu\Oxy_Ico_56.ico,,17
Menu, MyContextMenu, Icon,Move Selected..,%A_WorkingDir%\GUI\menu\Oxy_Ico_4.ico,,17
Menu, MyContextMenu, Icon,Refresh,%A_WorkingDir%\GUI\menu\Oxy_Ico_58.ico,,17
Menu, MyContextMenu, Icon,Save EveryThing,%A_WorkingDir%\GUI\menu\Oxy_Ico_52.ico,,17
Menu, MyContextMenu, Icon,Clear from ListView,%A_WorkingDir%\GUI\menu\Oxy_Ico_28.ico,,17
Menu, MyContextMenu, Icon,Preview Album Art,%A_WorkingDir%\GUI\menu\preview.ico,,17
Menu, MyContextMenu, Icon,Show Console,%A_WorkingDir%\GUI\menu\Oxy_Ico_26.ico,,17
Menu, MyContextMenu, Icon,Convert,%A_WorkingDir%\GUI\menu\Oxy_Ico_41.ico,,17
Menu, MyContextMenu, Icon,Cover Art,%A_WorkingDir%\GUI\menu\Oxy_Ico_39.ico,,17
Menu, MyContextMenu, Icon,Properties,%A_WorkingDir%\GUI\menu\Properties.ico,,17
Menu, MyContextMenu, Icon,Open File Location,%A_WorkingDir%\GUI\menu\Oxy_Ico_53.ico,,17

Menu, MyConvMenu, Icon,Tag into Filename,%A_WorkingDir%\GUI\menu\Oxy_Ico_59.ico,,17
Menu, MyConvMenu, Icon, Filename into Tag,%A_WorkingDir%\GUI\menu\file_conv.ico,,17

Menu, MyConArtMenu, Icon,Add To File(s),%A_WorkingDir%\GUI\menu\CArt.ico,,17
Menu, MyConArtMenu, Icon,Extract From File(s),%A_WorkingDir%\GUI\menu\Oxy_Ico_36.ico,,17

Menu, CoverArtMenu, Add, Show Album Art, ContextArt

Menu, Desc , Add,  &Cover Front  (Default) , AC
Menu, Desc , Add,  &Cover Back , AC
Menu, Desc , Add,  &Leaflet Page, AC
Menu, Desc , Add,  &Media, AC
Menu, Desc , Add,  &Lead Artist/Performer , AC
Menu, Desc , Add,  &Artist, AC
Menu, Desc , Add,  &Band or Orchestra, AC
Menu, Desc , Add,  &Composer , AC
Menu, Desc , Add,  &Lyricst , AC
Menu, Desc , Add,  &Band Logo , AC
Menu, Desc , Add,  &Studio Logotype , AC
Menu, Desc , Add,  &File icon, AC
Menu, Desc , Add,  &Other, AC

Menu, CoverArtMenu, Add, &Set Cover Type , :Desc
Menu, CoverArtMenu, Add, Add Album Art , ContextCoverArt
Menu, CoverArtMenu, Add, Extract Album Art , ContextExtract
Menu, CoverArtMenu, Add,
Menu, CoverArtMenu, Add,Fetch Album Art , ButtonFetchCoverArt
Menu, CoverArtMenu, Add,
Menu, CoverArtMenu, Add, Copy  Album Art, CopyCoverArt
Menu, CoverArtMenu, Add, Paste Album Art,PasteCoverArt
Menu, CoverArtMenu, Add, 
Menu, CoverArtMenu, Add, Remove Album Art, RAA
Menu, CoverArtMenu, Default, Show Album Art


Menu, LyricsMenu, Add, &From A-Z lyrics, SetOption
Menu, LyricsMenu, Add,
Menu, LyricsMenu, Add, &From  lyrics.com, SetOption

Iniread , lrc_source , %A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Internet,Lyrics_Provider
   if lrc_source in A-Z
	{
		Lyricsprovider=A-Z
		Menu,LyricsMenu,check,&From A-Z lyrics
		Menu,LyricsMenu,uncheck,&From  lyrics.com
	}
	else
	{
		LyricsProvider=Lyricsdotcom
		IniWrite , Lyricsdotcom,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini,Internet,Lyrics_Provider
		Menu,LyricsMenu,check,&From  lyrics.com
		Menu,LyricsMenu,uncheck,&From A-Z lyrics
	}