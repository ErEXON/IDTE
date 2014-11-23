;************************************************************************************************;
; Author : Rajat Kosh 
; Script Name : SearchMenu.ahk 
;====================================================================================================================================================================================================
;This File is a part of IDTE
;IDTE- ID3 Tag Editor by Rajat kosh
;Copyright (c) 2013-14 by Team IDTE
;IDTE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation`, either version 3 of the License`, or (at your option) any later version.
;IDTE is distributed in the hope that it will be useful`, but WITHOUT ANY WARRANTY`; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;details.You should have received a copy of the GNU General Public License along with IDTE .If not`, see <http://www.gnu.org/licenses/>
;====================================================================================================================================================================================================

;_______________________________________________________________________________SEARCH MENUBAR _________________________________________________________________________________;


SOG: ;Search On Google
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    IniRead , checker6,%A_MyDocuments%\IDTE_Configuration.ini ,Internet,Allow_Internet
    if (checker6=1)
        Run, http://www.google.com/search?q=%Artistinfo%-%Albuminfo%
    else
    {
        Gui,+OwnDialogs
        MsgBox , 16 , Unable To Connect , Internet Access is Not Allowed to IDTE
    }
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return


SCA: ;Search Cover Art
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    IniRead , checker6,%A_MyDocuments%\IDTE_Configuration.ini ,Internet,Allow_Internet
    if (checker6=1)
        run , http://www.albumart.org/index.php?skey=%Albuminfo%-%Artistinfo%&itempage=1&newsearch=1&searchindex=Music
    else
        {
            Gui,+OwnDialogs
            MsgBox , 16 , Unable To Connect , Internet Access is Not Allowed to IDTE
        }
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return


SLY: ;Search Lyrics
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    IniRead , checker6,%A_MyDocuments%\IDTE_Configuration.ini ,Internet,Allow_Internet
    if (checker6=1)
        run , http://lyrics.wikia.com/%Artistinfo%:%Titleinfo%
    else
        {
            Gui,+OwnDialogs
            MsgBox , 16 , Unable To Connect , Internet Access is Not Allowed to IDTE
        }
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return


SOMB: ;Search on Musicbrainz
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    IniRead , checker6,%A_MyDocuments%\IDTE_Configuration.ini ,Internet,Allow_Internet
    if (checker6=1)
    run ,http://musicbrainz.org/search?query=%Artistinfo%&type=freedb&limit=25&method=direct
    else
    {
        Gui,+OwnDialogs
        MsgBox , 16 , Unable To Connect , Internet Access is Not Allowed to IDTE
    }
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return


SOFDB: ;Search on Free DB
    SetTimer , Check_Progress , off 
    SetTimer , GETLEVEL , off
    IniRead , checker6,%A_MyDocuments%\IDTE_Configuration.ini ,Internet,Allow_Internet
    if (checker6=1)
        Run , http://www.freedb.org/freedb_search.php
    else
    {
        Gui,+OwnDialogs
        MsgBox , 16 , Unable To Connect , Internet Access is Not Allowed to IDTE
    }
    SetTimer , Check_Progress 
    if min=
        SetTimer , GETLEVEL , 50
    else 
        SetTimer , GETLEVEL , off
return
