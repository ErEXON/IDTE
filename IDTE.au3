#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Change2CUI=y
#AutoIt3Wrapper_Res_Comment=Created By Rajat Kosh Using ID3_v3.4.au3
#AutoIt3Wrapper_Res_Description=Command Line Tool For IDTE
#AutoIt3Wrapper_Res_Fileversion=1.0.3.0
#AutoIt3Wrapper_Res_Field=Made By|Rajat Kosh
#AutoIt3Wrapper_Res_Field=Made Using| ID3_v3.4.au3
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****


#include-once
#include <ID3_v3.4.au3>
#include <Array.au3>

; Script Made By -Rajat Kosh ; IDTE --> ID3 Tag Editior ;

if $Cmdline[0]=0 Then
	MsgBox (0,"Information", "IDTE - ID3 Tag Editor 1.0.3(Command Line) " & @CRLF &"Report your Bugs at rajatkosh2153@gmail.com" & @CRLF &"Help :-" & @CRLF &" IDTE_GET_INFO <Version> <filename> ---> Write all the Tag Information in Taginfo.txt and Cover.jpg/png in IDTE Bin Folder" & @CRLF &"IDTE_PIC_WRITE <filename> <Picture> [Picture Type] ---> Write Cover Art to File" & @CRLF &"IDTE_REMOVE_ALL <filename> ---> Remove all Tags" & @CRLF &"IDTE_REMOVE_V1 <filename> ---> Remove ID3v1 Tag" & @CRLF &"IDTE_REMOVE_V2 <filename> ---> Remove ID3v2 Tag" & @CRLF &"IDTE REMOVE APE <filename> ---> Remove APE Tag" & @CRLF)
	Exit


ElseIf $Cmdline[1]="IDTE_PIC_WRITE" then

	$Filename=$Cmdline[2]

	_ID3ReadTag($Filename,2) ;must read in existing tag first to ensure other fields are saved

	$PIC_Filename=$Cmdline[3]
	$Ctype=$Cmdline[4]
	IF Not @error Then

		Local $iAPIC_PictureType = $Ctype ;Cover (front), see _ID3Example_ReadID3v2APIC() for others
		Local $iAPIC_index = 1
		Local $sAPIC = $PIC_Filename & "|" & "" & "|" & String($iAPIC_PictureType) ;$sPictureFilename|$sDescription|$iPictureType ; see _h_ID3v2_CreateFrameAPIC()

		_ID3v2Frame_SetFields("APIC",$sAPIC,$iAPIC_index,"|") ; | is the delimiter

		_ID3WriteTag($Filename,2)
	EndIf


Elseif $Cmdline[1]="IDTE_GET_INFO" Then
	$type=$Cmdline[2]
$Filename=$Cmdline[3]

Switch ($type)
	Case 1
	_ID3ReadTag($Filename,1)
 $titl=_ID3GetTagField("Title")
 $trck=_ID3GetTagField("Track")
 $albm=_ID3GetTagField("Album")
 $arts=_ID3GetTagField("Artist")
 $cmnt=_ID3GetTagField("Comment")
 $year=_ID3GetTagField("Year")
 $genr=_ID3GetTagField("Genre")
Local $file = FileOpen("taginfov1.txt", 2)
If $file = -1 Then
    MsgBox(0, "Error", "Unable To Get Tags infomation (Possible Solution -> Run in Admin Mode).")
    Exit
EndIf

FileWrite($file, ""&$titl& @CRLF)
FileWrite($file, ""&$trck& @CRLF)
FileWrite($file, ""&$albm& @CRLF)
FileWrite($file, ""&$arts& @CRLF)
FileWrite($file, ""&$cmnt& @CRLF)
FileWrite($file, ""&$year& @CRLF)
FileWrite($file, ""&$genr& @CRLF)


case 2
	_ID3ReadTag($Filename,2)
 $titl=_ID3GetTagField("TIT2") ;title
 $trck=_ID3GetTagField("TRCK") ;track
 $albm=_ID3GetTagField("TALB") ;album
 $arts=_ID3GetTagField("TPE1") ;artist
 $cmnt=_ID3GetTagField("COMM") ;comment
 $year=_ID3GetTagField("TYER") ;year
 $genr=_ID3GetTagField("TCON") ;genre
  $pub=_ID3GetTagField("TPUB") ;publisher
 $orc=_ID3GetTagField("TPE2") ;orchestra
 $cmp=_ID3GetTagField("TCOM") ;composer
 $len=_ID3GetTagField("TLEN") ;length
 $cart=_ID3GetTagField("APIC") ;picture
 $lrc=_ID3GetTagField("USLT") ;lyrics

	Dim $sAPIC_PictureTypes = "Other|32x32 pixels 'file icon'|Other file icon|Cover (front)|Cover (back)|Leaflet page|"
	$sAPIC_PictureTypes &= "Media (e.g. lable side of CD)|Lead artist/lead performer/soloist|Artist/performer|Conductor|"
	$sAPIC_PictureTypes &= "Lyricist/text writer|Recording Location|During recording|During performance|Movie/video screen capture|"
	$sAPIC_PictureTypes &= "A bright coloured fish|Illustration|Band/artist logotype|Publisher/Studio logotype"
	Local $NumAPIC = @extended ;holds number of Pictures in tag
	Local $PicTypeIndex = StringInStr($cart,chr(0))
	Local $aAPIC_PictureTypes = StringSplit($sAPIC_PictureTypes,"|",2)
    Local $type = $aAPIC_PictureTypes[Number(StringMid($cart,$PicTypeIndex+1))]
Local $file = FileOpen("taginfov2.txt", 2)
If $file = -1 Then
    MsgBox(0, "Error", "Unable To Get Tags infomation (Possible Solution -> Run in Admin Mode).")
    Exit
EndIf
FileWrite($file, ""&$titl& @CRLF)
FileWrite($file, ""&$trck& @CRLF)
FileWrite($file, ""&$albm& @CRLF)
FileWrite($file, ""&$arts& @CRLF)
FileWrite($file, ""&$cmnt& @CRLF)
FileWrite($file, ""&$year& @CRLF)
FileWrite($file, ""&$genr& @CRLF)
FileWrite($file, ""&$pub& @CRLF)
FileWrite($file, ""&$orc& @CRLF)
FileWrite($file, ""&$cmp& @CRLF)
FileWrite($file, ""&$len& @CRLF)
FileWrite($file, ""&$cart& @CRLF)
FileWrite($file, ""&$NumAPIC& @CRLF)
FileWrite($file, ""&$type& @CRLF)
FileWrite($file, ""&$lrc& @CRLF)


case 3
	_ID3ReadTag($Filename,3)
  $titl=_ID3GetTagField("TIT2")
 $trck=_ID3GetTagField("TRCK")
 $albm=_ID3GetTagField("TALB")
 $arts=_ID3GetTagField("TPE1")
 $cmnt=_ID3GetTagField("COMM")
 $year=_ID3GetTagField("TYER")
 $genr=_ID3GetTagField("TCON")
 $len=_ID3GetTagField("TLEN")
 $cart=_ID3GetTagField("APIC")
 $lrc=_ID3GetTagField("USLT")
 $pub=_ID3GetTagField("TPUB")
 $orc=_ID3GetTagField("TPE2")
 $cmp=_ID3GetTagField("TCOM")

Dim $sAPIC_PictureTypes = "Other|32x32 pixels 'file icon'|Other file icon|Cover (front)|Cover (back)|Leaflet page|"
$sAPIC_PictureTypes &= "Media (e.g. lable side of CD)|Lead artist/lead performer/soloist|Artist/performer|Conductor|"
$sAPIC_PictureTypes &= "Lyricist/text writer|Recording Location|During recording|During performance|Movie/video screen capture|"
$sAPIC_PictureTypes &= "A bright coloured fish|Illustration|Band/artist logotype|Publisher/Studio logotype"
Local $NumAPIC = @extended ;holds number of Pictures in tag
Local $PicTypeIndex = StringInStr($cart,chr(0))
Local $aAPIC_PictureTypes = StringSplit($sAPIC_PictureTypes,"|",2)
Local $type = $aAPIC_PictureTypes[Number(StringMid($cart,$PicTypeIndex+1))]
Local $file = FileOpen("taginfov3.txt", 2)
If $file = -1 Then
    MsgBox(0, "Error", "Unable To Get Tags infomation (Possible Solution -> Run in Admin Mode).")
    Exit
EndIf
FileWrite($file, ""&$titl& @CRLF)
FileWrite($file, ""&$trck& @CRLF)
FileWrite($file, ""&$albm& @CRLF)
FileWrite($file, ""&$arts& @CRLF)
FileWrite($file, ""&$cmnt& @CRLF)
FileWrite($file, ""&$year& @CRLF)
FileWrite($file, ""&$genr& @CRLF)
FileWrite($file, ""&$pub& @CRLF)
FileWrite($file, ""&$orc& @CRLF)
FileWrite($file, ""&$cmp& @CRLF)
FileWrite($file, ""&$len& @CRLF)
FileWrite($file, ""&$cart& @CRLF)
FileWrite($file, ""&$NumAPIC& @CRLF)
FileWrite($file, ""&$type& @CRLF)
FileWrite($file, ""&$lrc& @CRLF)

case Else
Exit
EndSwitch


ElseIf $Cmdline[1]="IDTE_SAVE_SINGLE" Then
	$type=$Cmdline[2]
	$Filename=$Cmdline[3]
Switch($type)

case 1
	_ID3ReadTag($Filename,3)
	_ID3SetTagField("Title",""&$Cmdline[4])
	_ID3SetTagField("Track",""&$Cmdline[5])
	_ID3SetTagField("Album", ""&$Cmdline[6])
	_ID3SetTagField("Artist", ""&$Cmdline[7])
	_ID3SetTagField("Comment", ""&$Cmdline[8])
	_ID3SetTagField("Year", ""&$Cmdline[9])
	_ID3SetTagField("Genre", ""&$Cmdline[10])
	_ID3WriteTag($Filename,1)

case 2
	_ID3ReadTag($Filename,3)
	_ID3SetTagField("TIT2",""&$Cmdline[4]);title
	_ID3SetTagField("TRCK",""&$Cmdline[5]) ;track
	_ID3SetTagField("TALB", ""&$Cmdline[6]) ;album
	_ID3SetTagField("TPE1", ""&$Cmdline[7]) ;artist
	_ID3SetTagField("COMM", ""&$Cmdline[8]);comment
	_ID3SetTagField("TYER", ""&$Cmdline[9]) ;year
	_ID3SetTagField("TCON", ""&$Cmdline[10]);genre
	_ID3SetTagField("TPUB",""&$Cmdline[11]) ;publisher
    _ID3SetTagField("TPE2", ""&$Cmdline[12]);orchestra
    _ID3SetTagField("TCOM", ""&$Cmdline[13]) ;Composer
    _ID3WriteTag($Filename,2)
case 3
	_ID3ReadTag($Filename,3)
	_ID3SetTagField("TIT2",""&$Cmdline[4]);title
	_ID3SetTagField("TRCK",""&$Cmdline[5]) ;track
	_ID3SetTagField("TALB", ""&$Cmdline[6]) ;album
	_ID3SetTagField("TPE1", ""&$Cmdline[7]) ;artist
	_ID3SetTagField("COMM", ""&$Cmdline[8]);comment
	_ID3SetTagField("TYER", ""&$Cmdline[9]) ;year
	_ID3SetTagField("TCON", ""&$Cmdline[10]);genre
	_ID3SetTagField("TPUB",""&$Cmdline[11]) ;publisher
    _ID3SetTagField("TPE2", ""&$Cmdline[12]);orchestra
    _ID3SetTagField("TCOM", ""&$Cmdline[13]) ;Composer

_ID3WriteTag($Filename,2)
_ID3ReadTag($Filename,3)
    _ID3SetTagField("Title",""&$Cmdline[4])
	_ID3SetTagField("Track",""&$Cmdline[5])
	_ID3SetTagField("Album", ""&$Cmdline[6])
	_ID3SetTagField("Artist", ""&$Cmdline[7])
	_ID3SetTagField("Comment", ""&$Cmdline[8])
	_ID3SetTagField("Year", ""&$Cmdline[9])
	_ID3SetTagField("Genre", ""&$Cmdline[10])

_ID3WriteTag($Filename,1)
case Else
	Exit
EndSwitch



Elseif $Cmdline[1]="IDTE_SAVE_MULTI" Then
	$type=$Cmdline[2]
	$Filename=$Cmdline[3]
Switch($type)

case 1

		_ID3ReadTag($Filename,3)

	if $Cmdline[4]<> "<keep>" Then
	_ID3SetTagField("Title",""&$Cmdline[4])
EndIf

	if $Cmdline[5]<> "<keep>" Then
	_ID3SetTagField("Track",""&$Cmdline[5])
EndIf

	if $Cmdline[6]<> "<keep>" Then
	_ID3SetTagField("Album", ""&$Cmdline[6])
EndIf

	if $Cmdline[7]<> "<keep>" Then
	_ID3SetTagField("Artist", ""&$Cmdline[7])
EndIf

	if $Cmdline[8]<> "<keep>" Then
	_ID3SetTagField("Comment", ""&$Cmdline[8])
EndIf

	if $Cmdline[9]<> "<keep>" Then
	_ID3SetTagField("Year", ""&$Cmdline[9])
EndIf

	if $Cmdline[10]<> "<keep>" Then
	_ID3SetTagField("Genre", ""&$Cmdline[10])
EndIf

	_ID3WriteTag($Filename,1)
case 2
	_ID3ReadTag($Filename,3)

	if $Cmdline[4]<> "<keep>" Then
	_ID3SetTagField("TIT2",""&$Cmdline[4]);title
EndIf

	if $Cmdline[5]<> "<keep>" Then
	_ID3SetTagField("TRCK",""&$Cmdline[5]) ;track
EndIf

	if $Cmdline[6]<> "<keep>" Then
	_ID3SetTagField("TALB", ""&$Cmdline[6]) ;album
EndIf

	if $Cmdline[7]<> "<keep>" Then
	_ID3SetTagField("TPE1", ""&$Cmdline[7]) ;artist
EndIf

	if $Cmdline[8]<> "<keep>" Then
	_ID3SetTagField("COMM", ""&$Cmdline[8]);comment
EndIf

	if $Cmdline[9]<> "<keep>" Then
	_ID3SetTagField("TYER", ""&$Cmdline[9]) ;year
EndIf

	if $Cmdline[10]<> "<keep>" Then
	_ID3SetTagField("TCON", ""&$Cmdline[10]);genre
EndIf

	if $Cmdline[11]<> "<keep>" Then
	_ID3SetTagField("TPUB",""&$Cmdline[11]) ;publisher
EndIf

	if $Cmdline[12]<> "<keep>" Then
	_ID3SetTagField("TPE2", ""&$Cmdline[12]);orchestra
EndIf

	if $Cmdline[13]<> "<keep>" Then
	_ID3SetTagField("TCOM", ""&$Cmdline[13]) ;Composer
EndIf

	_ID3WriteTag($Filename,2)
case 3
	_ID3ReadTag($Filename,3)

	if $Cmdline[4]<> "<keep>" Then
	_ID3SetTagField("TIT2",""&$Cmdline[4]);title
EndIf

	if $Cmdline[5]<> "<keep>" Then
	_ID3SetTagField("TRCK",""&$Cmdline[5]) ;track
EndIf

	if $Cmdline[6]<> "<keep>" Then
	_ID3SetTagField("TALB", ""&$Cmdline[6]) ;album
EndIf

	if $Cmdline[7]<> "<keep>" Then
	_ID3SetTagField("TPE1", ""&$Cmdline[7]) ;artist
EndIf

	if $Cmdline[8]<> "<keep>" Then
	_ID3SetTagField("COMM", ""&$Cmdline[8]);comment
EndIf

	if $Cmdline[9]<> "<keep>" Then
	_ID3SetTagField("TYER", ""&$Cmdline[9]) ;year
EndIf

	if $Cmdline[10]<> "<keep>" Then
	_ID3SetTagField("TCON", ""&$Cmdline[10]);genre
EndIf

	if $Cmdline[11]<> "<keep>" Then
	_ID3SetTagField("TPUB",""&$Cmdline[11]) ;publisher
EndIf

	if $Cmdline[12]<> "<keep>" Then
	_ID3SetTagField("TPE2", ""&$Cmdline[12]);orchestra
EndIf

	if $Cmdline[13]<> "<keep>" Then
	_ID3SetTagField("TCOM", ""&$Cmdline[13]) ;Composer
EndIf

_ID3WriteTag($Filename,2)
_ID3ReadTag($Filename,3)

	if $Cmdline[4]<> "<keep>" Then
	_ID3SetTagField("Title",""&$Cmdline[4])
EndIf

	if $Cmdline[5]<> "<keep>" Then
	_ID3SetTagField("Track",""&$Cmdline[5])
EndIf

	if $Cmdline[6]<> "<keep>" Then
	_ID3SetTagField("Album", ""&$Cmdline[6])
EndIf

	if $Cmdline[7]<> "<keep>" Then
	_ID3SetTagField("Artist", ""&$Cmdline[7])
EndIf

	if $Cmdline[8]<> "<keep>" Then
	_ID3SetTagField("Comment", ""&$Cmdline[8])
EndIf

	if $Cmdline[9]<> "<keep>" Then
	_ID3SetTagField("Year", ""&$Cmdline[9])
EndIf

	if $Cmdline[10]<> "<keep>" Then
	_ID3SetTagField("Genre", ""&$Cmdline[10])
EndIf

	_ID3WriteTag($Filename,1)

_ID3WriteTag($Filename,1)
case Else
	Exit
EndSwitch



Elseif $Cmdline[1]="IDTE_REMOVE_ALL" Then

	$Filename=$Cmdline[2]
	_ID3v1Tag_RemoveTag($Filename)
	_ID3v2Tag_RemoveTag($Filename)
	_APEv2_RemoveTag($Filename)


Elseif $Cmdline[1]="IDTE_REMOVE_V1" Then

	$Filename=$Cmdline[2]
	 _ID3RemoveTag($Filename,1)

ElseIf $Cmdline[1]="IDTE_REMOVE_V2" Then

	$Filename=$Cmdline[2]
	 _ID3RemoveTag($Filename,2)

Elseif $Cmdline[1]="IDTE REMOVE APE" Then
$Filename=$Cmdline[2]
   _ID3RemoveTag($Filename,4)
ElseIf $Cmdline[1]="IDTE_PIC_REMOVE" Then
$Filename = $Cmdline[2]
$iAPIC_index=1
	_ID3ReadTag($Filename,2)
_ID3v2Tag_RemoveFrame("APIC",$iAPIC_index)
$iAPIC_index=2
_ID3v2Tag_RemoveFrame("APIC",$iAPIC_index)
$iAPIC_index=3
_ID3v2Tag_RemoveFrame("APIC",$iAPIC_index)


Else
	if $Cmdline[1]="IDTE_SAVE_LRC" Then
	$Filename = $Cmdline[2]
	Local $aArray
    _ID3ReadTag($Filename,3)
	_FileReadToArray("lyrics.txt", $aArray)
	_ID3SetTagField("USLT", ""&$aArray)
	_ID3WriteTag($Filename,2)
EndIf
EndIf