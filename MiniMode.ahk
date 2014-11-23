IDTEMini:
    min = 1
    SetTimer , Scroll , Off 
    SetTimer , GETLEVEL , off
    WinHide , IDTE-ID`3 Tag Editor
    Gui,Mini: Add, Pic, x4 y7 w50 h50 vCoverAlb gClikq, %A_WorkingDir%\GUI\music_icon40.png
    Gui,Mini: Add, Picture, x72 y5  gPrev_Work vprev, %A_WorkingDir%\GUI\icons\Pre.png
    Gui,Mini: Add, Picture, xp+25 yp  grev vrev, %A_WorkingDir%\GUI\icons\rev.png
    Gui,Mini: Add, Picture, xp+25 yp gPlay vpl, %A_WorkingDir%\GUI\icons\ply.png
    Gui,Mini: Add, Picture, xp+25 yp gPause vps, %A_WorkingDir%\GUI\icons\pus.png
    Gui,Mini: Add, Picture, xp+25 yp  gfwd vfwd, %A_WorkingDir%\GUI\icons\fwd.png
    Gui,Mini: Add, Picture, xp+25 yp  gNext_Work vnxt, %A_WorkingDir%\GUI\icons\nxt.png
    Gui,Mini: Font, S8 cwhite, Arial
    Gui,Mini: color,Black
    Gui , Mini: Add, Text , xp+25 y0 w170 h30 gClikq vclk_bg,
    Gui, Mini:Add, Text , xp+10 y0 w160 h40 +Center vPlayingStatus, %PLay_Str%
    Gui , Mini: Add, Text , xp+155 y23 w70 h20 +center  vDuration_min,
    Gui,Mini: Add, Slider, x61 y35 w180 NoTicks ToolTip center  AltSubmit  TickInterval10 vBar2 Page10 gStatus_of_play, 25
    Gui,Mini: Add, Slider,  x250 y40 w130 h20 NoTicks ToolTip center AltSubmit  TickInterval100 Page10 gStatus_of_vol vBar3, %Volume%
    Gui,Mini: Add, Picture, x430 y0  gMiniGuiClose vClz, %A_WorkingDir%\GUI\icons\Toggle_view.bmp
    Gui,Mini: Add, CheckBox, x400 y40 h15 Checked vFlag_ontop gOnTop, On Top
    Loop , %FileDir%\%Filename%
        mp3FileA := A_LoopFileFullPath
    FileDelete , %A_Temp%\AlbumArt.png
    DllCall( A_ScriptDir "\Plugins\AudioGenie3\AUDIOAnalyzeFileW", Str,mp3FileA )
    DllCall(A_ScriptDir "\Plugins\AudioGenie3\ID3V2GetPictureFileW", wstr , A_Temp "\AlbumArt.png", uint, 01)
    DllCall(A_ScriptDir "\Plugins\AudioGenie3\FLACGetPictureFileW", wstr , A_Temp "\AlbumArt.png", uint, 01)
    DllCall(A_ScriptDir "\Plugins\AudioGenie3\MP4GetPictureFileW", wstr , A_Temp "\AlbumArt.png", uint, 01)
    DllCall(A_ScriptDir "\Plugins\AudioGenie3\WMAGetPictureFileW", wstr , A_Temp "\AlbumArt.png", uint, 01)
    IfExist ,  %A_Temp%\AlbumArt.png
            GuiControl,Mini:, CoverAlb, *w50 *h50 %A_Temp%\AlbumArt.png
    IfNotExist , %A_Temp%\AlbumArt.png
            GuiControl,Mini:, CoverAlb, *w50 *h50 %A_WorkingDir%\GUI\music_icon40.png
    Gui,Mini: Show, y2 w465 h50, Mini Mode 
    Gui,Mini: +LastFound  -ToolWindow -Caption +AlwaysOnTop +resize
    IID_ITaskbarList  := "{56FDF342-FD6D-11d0-958A-006097C9A090}"
    CLSID_TaskbarList := "{56FDF344-FD6D-11d0-958A-006097C9A090}"

    ; Create the TaskbarList object and store its address in tbl.
    tbl := ComObjCreate(CLSID_TaskbarList, IID_ITaskbarList)

    activeHwnd := WinExist("A")

    DllCall(vtable(tbl,3), "ptr", tbl)                     ; tbl.HrInit()
    DllCall(vtable(tbl,5), "ptr", tbl, "ptr", activeHwnd)  ; tbl.DeleteTab(activeHwnd)

vtable(ptr, n) {
    ; NumGet(ptr+0) returns the address of the object's virtual function
    ; table (vtable for short). The remainder of the expression retrieves
    ; the address of the nth function's address from the vtable.
    return NumGet(NumGet(ptr+0), n*A_PtrSize)
}
return

Clz_TT:="Close Mini Mode"

MiniGuiClose:
    DetectHiddenWindows , On
    min =
    critical , on
    SetTimer , Scroll , on 
    SetTimer , GETLEVEL , on
    Critical , off

    WinShow  ,IDTE-ID`3 Tag Editor
    Gui, Mini: destroy  
return

Clikq:
; This Part of Script was included in Example EasyWindowDrag_(KDE).ahk I've just Trim It Down Just For the compatibility of My Script
; This is the setting that runs smoothest on my
; system. Depending on your video card and cpu
; power, you may want to raise or lower this value.
    SetWinDelay,2

    CoordMode,Mouse

    If DoubleAlt
        {
            MouseGetPos,,,KDE_id
            ; This message is mostly equivalent to WinMinimize,
            ; but it avoids a bug with PSPad.
            PostMessage,0x112,0xf020,,,ahk_id %KDE_id%
            DoubleAlt := false
            return
        }
    ; Get the initial mouse position and window id, and
    ; abort if the window is maximized.
    MouseGetPos,KDE_X1,KDE_Y1,KDE_id
    WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
    If KDE_Win
        return
    ; Get the initial window position.
    WinGetPos,KDE_WinX1,KDE_WinY1,,,ahk_id %KDE_id%
    Loop
        {
            GetKeyState,KDE_Button,LButton,P ; Break if button has been released.
            If KDE_Button = U
                break
            MouseGetPos,KDE_X2,KDE_Y2 ; Get the current mouse position.
            KDE_X2 -= KDE_X1 ; Obtain an offset from the initial mouse position.
            KDE_Y2 -= KDE_Y1
            KDE_WinX2 := (KDE_WinX1 + KDE_X2) ; Apply this offset to the window position.
            KDE_WinY2 := (KDE_WinY1 + KDE_Y2)
            WinMove,ahk_id %KDE_id%,,%KDE_WinX2%,%KDE_WinY2% ; Move the window to the new position.
        }
    return

OnTop:
    Gui, Mini:Submit, nohide
    if(Flag_ontop = 0)
            Gui,Mini: +LastFound  -ToolWindow -Caption -AlwaysOnTop
    else
        {
            Gui,Mini: , 
            Gui,Mini: +LastFound  -ToolWindow -Caption +AlwaysOnTop
        }
    return

Status_of_play:
    ifnotinstring ,IsCUE , CUE
        {
            percent := (Bar2/100)*BASS_GETLEN
            DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelSetPosition", UInt,hMedia, Uint64,percent ,Int,32768) ;What is 32768 --> This Will Allow The Bass To Get Arguments in Bytes i.e. BASS_POS_BYTES
        }
    else
        {
            percent := ((CURR_START) + (Bar2/100)*TOTAL)
            DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelSetPosition", UInt,hMedia, Uint64,percent ,Int,32768) ;What is 32768 --> This Will Allow The Bass To Get Arguments in Bytes i.e. BASS_POS_BYTES  
        }
    return

Next_Work:
    Send , {Media_Next}
return

Prev_Work:
    Send , {Media_Prev}
return

Status_of_vol:
    Vol_Bass := Bar3/100
    if Status_Playing=1 
        DllCall(A_ScriptDir . "\bass.dll\BASS_ChannelSetAttribute", UInt,hMedia,Uint,2,float,Vol_Bass)
    GuiControl , , mutetext ,
    Vol = Volume - %volume%`% ; Set Volume Textual Information 
    SB_SetText(Vol , 3)
    GuiControl, Mini:, Bar2 , %Vol%
return

MiniGuiSize:
return