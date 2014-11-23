;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : OrganizeMenu.ahk 
;=============================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;============================================================================================================================================================================================

;--------------------------------------------------------------------------Convert Tags Into Filenames-----------------------------------------------------------------------------;

ContextFilename:
MDFT: ;Make Directory From Tag
   IniRead , checker31,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Prompt,Passwd_Protect
   if(Checker31=1)
    {
      IfExist , %Windir%\psswd.dat
       {
         InputBox , Confirm_pwrd , Enter Password, Enter Password To Save Tags, HIDE, 200,150
         if (Confirm_pwrd!=read_file)
           {
             MsgBox , 16, Error, You Do Not Have Sufficient Privilages To Convert Tags into Files 
             return
           }
       }
    }
   IniRead , checker33,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Default_Scheme,Enable_Scheme
   IniRead , Defalt_Schm,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Default_Scheme,Scheme_Defaults   
   if (Checker33=1)
     {
       scheme = %Defalt_Schm%
     }
  else
   {
     Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
     InputBox ,scheme, Enter Scheme,Enter Scheme e.g. `%Artist`%\`%Album`%\`%Track`%-`%Title`% `n`nWhere Tokens:-`nArtist = `%Artist`%`nAlbum = `%Album`%`nTrack No. = `%Track`%`nTitle = `%Title`%`nComment = `%Comment`%`nComposer = `%Composer`%`nGenre = `%Genre`% `nFilename = `%Filename`% `nDirectory = \, , 365,340
    if errorlevel   
       return
   }
 
  SetTimer , Check_Progress , off 
  SetTimer , GETLEVEL , off
  Progress , , Please Wait...., , Converting Tags..
  ControlGet, List, List, Selected, SysListView321, A
  ValueRow:= LV_GetCount("S")
  SingleTag=%ValueRow%
  Progress , M  Fm10 Fs10 WM400 H70 ZH11, Please wait.. , Working Please Wait.. ,Working.. , Arial
  ControlGet, List, List, Selected, SysListView321, A
  Loop, Parse, List, `n  ; Rows are delimited by linefeeds (`n).
   {
     percentage := (A_Index/ValueRow)*100
     Progress ,  %percentage%
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
                      mp3FileU := A_LoopFileFullPath
                      FileExt:= A_LoopFileExt
                      SplitPath , A_LoopFileFullPath , , , , Wext_filename
                   }
                 DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,mp3FileU ) 
                 Artist  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetArtistW",wstr)
                 Album  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetAlbumW",wstr)
                 Year  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetYearW",wstr)
                 Genre  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetGenreW",wstr)
                 Track  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetTrackW",wstr)
                 Title  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetTitleW",wstr)
                 Comment  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetCommentW",wstr)
                 Composer :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOGetComposerW",wstr)
                 if Artist=
                    Artist = No Artist
                 if Album=
                    Album = No Album
                 if Track=
                    Track = No Track
                 if Title=
                    Title = No Title
                 if Year=
                    Year = No Year
                 if Genre=
                    Genre = No Genre
                 if Composer=
                    Composer = No Composer
                 if Comment=
                    Comment = No Comment
                 StringReplace , Scheme1 , Scheme , `%Artist`% , %Artist% , All
                 StringReplace , Scheme1 , Scheme1 , `%Album`% , %Album% , All
                 StringReplace , Scheme1 , Scheme1 , `%Year`% , %Year% , All
                 StringReplace , Scheme1 , Scheme1 , `%Genre`% , %Genre% , All
                 StringReplace , Scheme1 , Scheme1 , `%Track`% , %Track% , All
                 StringReplace , Scheme1 , Scheme1 , `%Title`% , %Title% , All
                 StringReplace , Scheme1 , Scheme1 , `%Year`% , %Year% , All
                 StringReplace , Scheme1 , Scheme1 , `%Composer`% , %Composer% , All
                 StringReplace , Scheme1 , Scheme1 , `%Comment`% , %Comment% , All
                 StringReplace , Scheme1 , Scheme1 , `%Filename`% , %Wext_filename% , All 
                 FileCreateDir , %Folder%\%Scheme1%
                 FileMove , %Folder%\%Text% , %Folder%\%Scheme1%.%FileExt% 
                 if Errorlevel 
                   {
                       Gui +Owndialogs
                       MsgBox ,16, Error , OOPS! Something went wrong while processing %Folder%\%Text% `, maybe it's a wrong Scheme  type or maybe file is not accessible currently
                   }
                 FileRemoveDir , %Folder%\%Scheme1%
              }
         }
     SingleTag=%A_Index%
   }
  Progress , off
  GuiControl , , GUI_Text, Done
  SplashTextOff
  Progress , off
  SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return

;--------------------------------------------------------------------------Convert Filenames IntoTags  -----------------------------------------------------------------------------;
ConverTag: ;Make Directory From Tag
 IniRead , checker31,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Prompt,Passwd_Protect
 if(Checker31=1)
    {
          IfExist , %Windir%\psswd.dat
             {
                InputBox , Confirm_pwrd , Enter Password, Enter Password To Save Tags, HIDE, 200,150
                if (Confirm_pwrd!=read_file)
                     {
                       MsgBox , 16, Error, You Do Not Have Sufficient Privilages To Convert Filenames into Tags 
                        return
                     }    
             }
    }
    
 IniRead , checker33,%A_MyDocuments%\IDTE_Data\IDTE_Configuration.ini ,Default_Scheme,Enable_Scheme 
 {
    Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
    InputBox ,scheme, Enter Scheme,Enter Scheme e.g.   `%Track`%-`%Artist`%-`%Title`% `nwill be the scheme for :-`n                            01-Linkin Park-Powerless.mp3`nWhere Tokens:-`nArtist = `%Artist`%`nAlbum = `%Album`%`nTrack No. = `%Track`%`nTitle = `%Title`%`nComment = `%Comment`%`nComposer = `%Composer`%`nGenre = `%Genre`% and `nHyphen (-)  = For Seperation Purpose`nWarning - Only Hyphen is Supported , , 365,350 
    if errorlevel   
      return
 }

  SetTimer , Check_Progress , off 
  SetTimer , GETLEVEL , off
  ControlGet, List, List, Selected, SysListView321, A
  ValueRow:= LV_GetCount("S")
  Progress , M  Fm10 Fs10 WM400 H70 ZH11, Please wait.. , Working Please Wait.. ,Working.. , Arial
  SingleTag=%ValueRow%
  ControlGet, List, List, Selected, SysListView321, A
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
                 mp3FileU := A_LoopFileFullPath
                 FileExt:= A_LoopFileExt
                 SplitPath , A_LoopFileFullPath , , ,Wext_filename,Filename_parse
               }
             hypen_count = 0
             Index = 1
             Tag_Array%Index%=
             IfInString , scheme , -
                 {
                   loop, parse , scheme
                      {
                         IfInString , A_loopfield , -
                                   hypen_count1 += 1
                      }  
                   loop, parse, Filename_parse
                      {
                        IfInString , A_loopfield , -
                                  hypen_count2 += 1
                      }      
                   if(hypen_count1>Hypen_Count2)
                     {
                         SplashTextOff
                         Progress , off
                         MsgBox ,48, Error, Wrong Scheme Type , Please Enter the Scheme Again.`nRemember - Only Hyphen is Allowed For Distinguishing Fields
                         SetTimer , Check_Progress 
                         if min=
                             SetTimer , GETLEVEL , 50
                         else 
                             SetTimer , GETLEVEL , off
                       return
                     }
                   loop, parse, Filename_parse
                     {
                       ifinstring , A_Loopfield, -
                          {
                               Index := Index+1
                               Tag_Array%Index%=
                          }
                       else
                            Tag_Array%Index% := Tag_Array%Index% A_LoopField
                     }   
                 }
             else
                Tag_Array1 := Filename_parse
                loop , parse , scheme, -
                   {
                      IfInString , A_LoopField , `%Artist`%
                            Artist := Tag_Array%A_Index%
                      IfInString , A_LoopField , `%Album`%
                            Album := Tag_Array%A_Index%
                      IfInString , A_LoopField , `%Track`%
                           Track := Tag_Array%A_Index%
                      IfInString , A_LoopField , `%Title`%
                           Title := Tag_Array%A_Index%
                     IfInString , A_LoopField , `%Year`%
                           Year := Tag_Array%A_Index%
                     IfInString , A_LoopField , `%Genre`%
                           Genre := Tag_Array%A_Index%
                     IfInString , A_LoopField , `%Comment`%
                          Comment := Tag_Array%A_Index%
                     IfInString , A_LoopField , `%Composer`%
                         Composer := Tag_Array%A_Index%
                   }
                DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,mp3FileU ) 
                IfInString , scheme , `%Artist`%
                   Artistinfo  := DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetArtistW", wstr ,Artist)
                IfInString , scheme , `%Album`%     
                   Albuminfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetAlbumW", wstr ,Album)
                IfInString , scheme , `%Year`%
                   Yearinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetYearW", wstr ,Year)
                IfInString , scheme , `%Genre`%
                   Genreinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetGenreW", wstr ,Genre)
                IfInString , scheme , `%Track`%
                   Trackinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetTrackW", wstr ,Track)
                IfInString , scheme , `%Title`%
                   Titleinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetTitleW", wstr ,Title)
                IfInString , scheme , `%Comment`%
                   Commentinfo  :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetCommentW", wstr ,Comments)
                IfInString , scheme , `%Composer`%
                   Composerinfo :=  DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSetComposerW", wstr ,Composer)
                DllCall(A_ScriptDir "\Plugins\AudioGenie3\AUDIOSaveChangesW")
            }
       }
     SingleTag=%A_Index%
   }
   Progress , off
   SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
   goto , refresh
return

;-------------------------------------------------------------MEKE PLAYLIST FROM ALL FILE(s)---------------------------------------------------------------------------------------;
FAF:
   Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
   FileSelectFolder , MyFolder, ,2,Select Source Folder  (Recursive)`nPlaylist will be automatically Save in this Folder    
   if MyFolder=
      return
   InputBox , PLname, Playlist Name, Enter the Playlist Name
   if PLname=
      return
   DllCall( "LoadLibrary", Str,A_ScriptDir "\Plugins\AudioGenie3.dll" )
   DllCall( "AudioGenie3\AUDIOAnalyzeFileW", Str,Dummy ) ; Dummy Call
   SplashTextOn , , , Processing`, Please Wait...
   GuiControl , , milli , Please wait...
   FileEncoding , 
   File_new = %MyFolder%\%PLname%.m3u
   PLfile := FileOpen(File_new, "w")
   Progress , M  Fm10 Fs10 WM400 H70 ZH11, Please wait.. , Working Please Wait.. ,Working.. , Arial
   FileAppend ,#---------------------------------- Playlist Created By IDTE - ID3 Tag Editor -----------------------------------`n#EXTM3U`n, %MyFolder%\TagInfo.txt
   Loop, %MyFolder%\*.* , , 1
       {
         SplitPath , A_LoopFileFullPath , , , EXT
         if EXT in mp3,mp2,mp1,ogg,oga,wav,aif,aiff,aifc,mo3,xm,mod,s3m,it,mtm,umx,midi,mus,rmi,kar,flac,wma,wmv,wmp,asf,aac,mp4,m4a,m4b,m4p,wv,wvc,ape,mpc,mpp,mp+,ac3,spx,tta,opus
            {
              mp3FileA := A_LoopFileFullPath
              ADG_getinfo(mp3FileA,Trackinfo,Titleinfo,Artistinfo,Albuminfo,Genreinfo,Yearinfo,Bandinfo,Publisherinfo,Composerinfo,Commentinfo,Channelinfo,Lyrics)
              String = `r`n#EXTART:%Artistinfo%`r`n#EXTALB:%Albuminfo%`r`n#EXTFilename:%A_LoopFileName%`r`n%A_LoopFileFullPath%`r`n
              PLfile.write(String)
              Progress , %A_index%
            }
         }
   PLfile.Close
   SplashTextOff
   Progress , 100
   sleep , 200
   Progress , off
   GuiControl , , milli , Playlist Created Sucessfully
   SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
   FileEncoding , UTF-16
return
;-------------------------------------------------------------MEKE PLAYLIST FROM SELECTED FILE(s)---------------------------------------------------------------------------------;
FSF:
   FileSelectFolder , FILES , , 2, Select Folder To Save Playlist
   if FILES=
       return
   SplashTexton , , ,Please Wait...
   ControlGet, List, List, Selected, SysListView321, A
   ValueRow:= LV_GetCount("S")
   SingleTag=%ValueRow%
   FileEncoding , 
   FileAppend , #Playlist Created By IDTE `n#IDTE - ID3 Tag Editor (c) rEX_ON_FiRE 2013-14`n , %FILES%\IDTE-Playlist.m3u
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
                          FileAppend , %Folder%\%Text%`n , %FILES%\IDTE-Playlist.m3u
                        }   
               }
           SingleTag=%A_Index%
      }
   SplashTextOff    
   Progress , off
   GuiControl , , GUI_Text, Done
   GuiControl , , milli, Playlist Created 
   FileEncoding , UTF-16
return

;-------------------------------------------------------------MEKE PLAYLIST ONE PER DIRECTORY-------------------------------------------------------------------------------------;
OPD:
   Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
   FileSelectFolder , MyFolder, ,2,Select Source Folder  (Recursive)`nPlaylist will be automatically Saved in their respective Folders
   if MyFolder=
       return
   InputBox , PLname, Playlist Name, Enter the Playlist Name
   if PLname=
       return
   FileEncoding , 
   DllCall( "LoadLibrary", Str,A_ScriptDir "\Plugins\AudioGenie3.dll" )
   DllCall( "AudioGenie3\AUDIOAnalyzeFileW", Str,Dummy ) ; Dummy Call
   SplashTextOn , , , Processing`, Please Wait...
   Progress , M  Fm10 Fs10 WM400 H70 ZH11, Please wait.. , Working Please Wait.. ,Working.. , Arial
   GuiControl , , milli , Please wait.....
   Loop, %MyFolder%\*.* , , 1
     {
        SplitPath , A_LoopFileFullPath , , , EXT
        if EXT in mp3,mp2,mp1,ogg,oga,wav,aif,aiff,aifc,mo3,xm,mod,s3m,it,mtm,umx,midi,mus,rmi,kar,flac,wma,wmv,wmp,asf,aac,mp4,m4a,m4b,m4p,wv,wvc,ape,mpc,mpp,mp+,ac3,spx,tta,opus
         {
            mp3FileU := A_LoopFileFullPath
           ADG_getinfo(mp3FileU,Trackinfo,Titleinfo,Artistinfo,Albuminfo,Genreinfo,Yearinfo,Bandinfo,Publisherinfo,Composerinfo,Commentinfo,Channelinfo,Lyrics)
           FileAppend , #EXTM3U`n#EXT SOURCE : IDTE - ID3 Tag Editor`n#EXTART:%Artistinfo%`n#EXTALB:%Albuminfo%`n#EXTFolder:%A_LoopFileDir%`n%A_LoopFileName%`n , %A_LoopFileDir%\%PLName%.m3u
           Progress , %A_index%  
         }
     }
   SplashTextOff
   Progress , 100
   sleep , 200
   Progress , off
   GuiControl , , GUI_Text , Done
   GuiControl , , milli , Playlist Created Sucessfully
   SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
   FileEncoding , UTF-16
return

;-------------------------------------------------------------MEKE PLAYLIST ONE PER ALBUM---------------------------------------------------------------------------------------;
OPA:
   Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
   FileSelectFolder , MyFolder, ,2,Select Source Folder  (Recursive)`nPlaylist will be automatically Saved in this folder with their respective album names
   if MyFolder=
       return
   InputBox , PLname, Playlist Name, Enter the Playlist Initializing Name`nExample = My Playlist
   if PLname=
       return
   FileEncoding , 
   DllCall( "LoadLibrary", Str,A_ScriptDir "\Plugins\AudioGenie3.dll" )
   DllCall( "AudioGenie3\AUDIOAnalyzeFileW", Str,Dummy ) ; Dummy Call
   SplashTextOn , , , Processing`, Please Wait...
   GuiControl , , milli , Please wait.....
   Progress , M  Fm10 Fs10 WM400 H70 ZH11, Please wait.. , Working Please Wait.. ,Working.. , Arial
   Loop, %MyFolder%\*.* , , 1
      {
         SplitPath , A_LoopFileFullPath , , , EXT
         if EXT in mp3,mp2,mp1,ogg,oga,wav,aif,aiff,aifc,mo3,xm,mod,s3m,it,mtm,umx,midi,mus,rmi,kar,flac,wma,wmv,wmp,asf,aac,mp4,m4a,m4b,m4p,wv,wvc,ape,mpc,mpp,mp+,ac3,spx,tta,opus
            {
               mp3FileU := A_LoopFileFullPath
               ADG_getinfo(mp3FileU,Trackinfo,Titleinfo,Artistinfo,Albuminfo,Genreinfo,Yearinfo,Bandinfo,Publisherinfo,Composerinfo,Commentinfo,Channelinfo,Lyrics)
               FileAppend , #EXTM3U`n#EXT SOURCE : IDTE - ID3 Tag Editor`n#EXTART:%Artistinfo%`n#EXTALB:%Albuminfo%`n#EXTFolder:%A_LoopFileDir%`n%A_LoopFileFullPath%`n , %MyFolder%\%PLName%-%Albuminfo%.m3u
               Progress , %A_Index%
            }
      }
     SplashTextOff
     Progress , 100
     Progress , off
     GuiControl , , GUI_Text , Done
     GuiControl , , milli , Playlist Created Sucessfully
     SetTimer , Check_Progress 
     if min=
         SetTimer , GETLEVEL , 50
     else 
         SetTimer , GETLEVEL , off
     FileEncoding , UTF-16
 return
;-------------------------------------------------------------MEKE PLAYLIST ONE PER ARTIST---------------------------------------------------------------------------------------;
OPART:
   Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
   FileSelectFolder , MyFolder, ,2,Select Source Folder  (Recursive)`nPlaylist will be automatically Saved in this folder with their respective Artist names
   if MyFolder=
      return
   InputBox , PLname, Playlist Name, Enter the Playlist Initializing Name`nExample = My Playlist
   if PLname=
       return
   FileEncoding , 
   DllCall( "LoadLibrary", Str,A_ScriptDir "\Plugins\AudioGenie3.dll" )
   DllCall( "AudioGenie3\AUDIOAnalyzeFileW", Str,Dummy ) ; Dummy Call
   GuiControl , , milli , Please wait.....
   Progress , M  Fm10 Fs10 WM400 H70 ZH11, Please wait.. , Working Please Wait.. ,Working.. , Arial
   Loop, %MyFolder%\*.* , , 1
     {
         SplitPath , A_LoopFileFullPath , , , EXT
         if EXT in mp3,mp2,mp1,ogg,oga,wav,aif,aiff,aifc,mo3,xm,mod,s3m,it,mtm,umx,midi,mus,rmi,kar,flac,wma,wmv,wmp,asf,aac,mp4,m4a,m4b,m4p,wv,wvc,ape,mpc,mpp,mp+,ac3,spx,tta,opus
            {
               mp3FileU := A_LoopFileFullPath
               ADG_getinfo(mp3FileU,Trackinfo,Titleinfo,Artistinfo,Albuminfo,Genreinfo,Yearinfo,Bandinfo,Publisherinfo,Composerinfo,Commentinfo,Channelinfo,Lyrics)
               FileAppend , #EXTM3U`n#EXT SOURCE : IDTE - ID3 Tag Editor`n#EXTART:%Artistinfo%`n#EXTALB:%Albuminfo%`n#EXTFolder:%A_LoopFileDir%`n%A_LoopFileFullPath%`n , %MyFolder%\%PLName%-%Artistinfo%.m3u
               Progress , %A_Index%
            }
     }
   SplashTextOff
   Progress, 100
   Progress, off
   GuiControl , , GUI_Text , Done
   GuiControl , , milli , Playlist Created Sucessfully
   SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
   FileEncoding , UTF-16
return