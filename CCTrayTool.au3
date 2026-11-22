#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icons\TrayWhite.ico
#AutoIt3Wrapper_Res_Fileversion=2026.0.0.109
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_Description=CCTrayTool - KeepAwake, AlwaysOnTop and quick start tray tool
#AutoIt3Wrapper_Res_LegalCopyright=Copyright (C) 2026 Markus Debus - GPL-3.0-or-later
#AutoIt3Wrapper_Res_Icon_Add=icons\TrayWhite.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\TrayRed.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\TrayGreen.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\TrayBlue.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\RedBox.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\GreenBox.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\BlueBox.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\WhiteBox.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\RedBoxChecked.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\GreenBoxChecked.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\BlueBoxChecked.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\WhiteBoxChecked.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\About.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\Exit.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\Keyboard.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\Settings.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\GreenCheck.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\Empty.ico
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Run_Tidy=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

; ====================================================================================================
; CCTrayTool
;
; SPDX-License-Identifier: GPL-3.0-or-later
; SPDX-FileCopyrightText: 2026 Markus Debus
;
; Copyright (C) 2026 Markus Debus
;
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <https://www.gnu.org/licenses/>.
;
; Additional term under section 7(b) of the GNU General Public License, version 3:
; the copyright notice above and the attribution specified in the file NOTICE must be preserved,
; in the source code as well as in the Appropriate Legal Notices of every work that contains this
; program (for example the About dialog). See the files LICENSE and NOTICE.
; ====================================================================================================

#cs

## About This Project

CCTrayTool is a lightweight Windows tray utility that bundles three things
people often reach for separately: **KeepAwake** (instantly suppress display
and/or system sleep without touching your Windows power plan), an
**AlwaysOnTop** toggle with a global hotkey for pinning the active window, and a
fully **configurable tray menu** for launching frequently used tools and
folders. The tools are plain shortcuts (.lnk files) in a folder structure -
every sub folder becomes a sub menu - and everything else (hotkeys, icons,
language, limits) is kept in a plain INI file, so extending it doesn't
require touching the source.

### What makes this project more interesting than it looks

A few things under the hood turned out to be trickier than a typical "put an
icon in the tray" script:

- **Icons on individual menu items.** AutoIt's built-in tray functions don't
  offer a simple way to attach a full-color icon to a single menu entry.
  CCTrayTool extracts the icon via the Shell API and attaches it directly to the
  underlying Win32 popup menu handle, which is what actually lets every entry
  show its own bitmap instead of falling back to plain text.

- **Making those icons transparent.** Converting an icon to a bitmap the naive
  way loses alpha transparency or renders it with ugly color fringing. The fix
  is to read the raw pixel data back out, multiply each color channel by its own
  alpha value ("premultiplied alpha"), and write it back before handing the
  bitmap to the menu - a step most simple tray-icon snippets skip entirely.

- **Looking right on both Windows 10 and 11.** On Windows 10, a *checked* menu
  item that also carries a custom icon gets a colored highlight box drawn behind
  the icon - a side effect of how classic (non-owner-drawn) popup menus render
  the check state. Windows 11 doesn't have this quirk. Rather than fight the OS
  rendering, CCTrayTool never sets the native "checked" state at all: every
  stateful menu item (KeepAwake mode, AlwaysOnTop hotkey, logging, ...) instead
  swaps between two dedicated icon files to show "on" vs. "off", while the
  actual state lives in a handful of script variables. That sidesteps the
  platform difference completely and looks identical on both versions.

- **Switching icon size without restarting.** Toggling between small and large
  tray icons at runtime means tearing down the entire tray menu, releasing the
  old icon bitmaps, and rebuilding it from scratch with the new size - all while
  the script keeps running and every setting, hotkey, and state is re-applied
  from memory rather than requiring a restart.

- **Tools as a folder of shortcuts.** ToolTime is built from a folder tree:
  each sub folder becomes a sub menu, each .lnk file a menu entry, including its
  icon and its "run as administrator" flag. The folder is watched, so adding,
  renaming or removing a shortcut updates the tray menu on the fly. A native
  tray menu can only be scrolled with two small arrow buttons and a long menu
  pushes the other sections out of view, so the number of entries per menu is
  limited (15 by default, 10 - 20 configurable in the INI file). Entries beyond
  the limit are not silently dropped: the menu says how many are missing, the
  case is logged and a clickable "(!)" line lists the details.

- **Reloading the INI without restarting.** The "Edit settings file" menu entry
  opens the INI in Notepad; as soon as it's closed, CCTrayTool re-reads it and
  rebuilds the tray menu on the fly, so settings can be changed without closing
  and reopening the app.

- **A few other details:** built-in support for eight languages, auto-detected
  from the OS; a global AlwaysOnTop hotkey the user can redefine from a small
  in-app dialog; and careful cleanup of every GDI bitmap handle the script
  creates, to avoid leaking OS resources over a long uptime.

### AI assistance

Parts of this project were created with AI assistance: the tray icon artwork,
the translations into the supported languages, the README, this text, and
portions of the AutoIt source code (including debugging and cleanup work) were
produced or refined with the help of an AI assistant.

### ToBeDone
	- maybe add ToolTips to explain menu items

#ce

Opt("MustDeclareVars", 1)
Opt("TrayMenuMode", 3)

#include <Array.au3>
#include <GUIConstants.au3>
#include <GuiMenu.au3>
#include <WinAPI.au3>
#include <WinAPIShellEx.au3>
#include <WinAPIGdi.au3>
#include <TrayConstants.au3>
#include <Misc.au3>
#include <File.au3>
#include <AutoItConstants.au3>

; Translation and bitmap-handle lookups are implemented with Scripting.Dictionary COM objects
; (scrrun.dll) instead of AutoIt's native Map type. The COM error handler is registered here,
; before any COM object is created or used, so that an unexpected COM error is logged instead
; of silently aborting the script.
Global $oComErrorHandler = ObjEvent("AutoIt.Error", "_ComErrorHandler")

Global $sAppName = "CCTrayTool"
Global $sAppDataDir = @LocalAppDataDir & "\" & $sAppName
;Global $sAppDataDir = @AppDataCommonDir & "\" & $sAppName

If Not FileExists($sAppDataDir) Then DirCreate($sAppDataDir)

Global $iIconOffset = 197 ;the Autoit Icon numbering is not the same as the Win32 Icon Numbering, so we need an offset to use win32 functions

;Logfile
Global $bUseLogSetting = 0
If @Compiled Then
	Global $iLogLevel = 5
Else
	Global $iLogLevel = 9
EndIf
Global $sLogFile = $sAppDataDir & "\" & StringLeft(@ScriptName, StringLen(@ScriptName) - 4) & ".log"

;INI-File
Global $sIniFile = $sAppDataDir & "\" & StringLeft(@ScriptName, StringLen(@ScriptName) - 4) & ".ini"

;Icons
#cs Icons

201 Tray white / off					205 red
202 Tray red / Monitors					206 green
203 Tray green / Monitors and System	207 blue
204 Tray blue / System					208 white

209 red active							213 About
210 green active						214 Keyboard
211 blue active							215 Exit
212 white active						216 Settings

217 GreenCheck
218 Empty

#ce Icons

Global $iIconNumberSettings = 216
Global $iIconNumberExit = 214
Global $iIconNumberAbout = 213
Global $iIconnumberKeyboard = 215
Global $iIconnumberGreenCheck = 217
Global $iIconnumberEmpty = 218

;Translation
Global $sAppLanguage
Global $mEnglishToID = ObjCreate("Scripting.Dictionary")
Global $mIDToGerman = ObjCreate("Scripting.Dictionary")
Global $mIDToSpanish = ObjCreate("Scripting.Dictionary")
Global $mIDToItalian = ObjCreate("Scripting.Dictionary")
Global $mIDToFrench = ObjCreate("Scripting.Dictionary")
Global $mIDToPolish = ObjCreate("Scripting.Dictionary")
Global $mIDToHungarian = ObjCreate("Scripting.Dictionary")
Global $mIDToRussian = ObjCreate("Scripting.Dictionary")

CreateMapEnglishToID()

If StringInStr(@OSLang, "0407") Then
	$sAppLanguage = "German"
	CreateMapIDToGerman()
ElseIf StringInStr(@OSLang, "040A") Then
	$sAppLanguage = "Spanish"
	CreateMapIDToSpanish()
ElseIf StringInStr(@OSLang, "0410") Then
	$sAppLanguage = "Italian"
	CreateMapIDToItalian()
ElseIf StringInStr(@OSLang, "040C") Then
	$sAppLanguage = "French"
	CreateMapIDToFrench()
ElseIf StringInStr(@OSLang, "0415") Then
	$sAppLanguage = "Polish"
	CreateMapIDToPolish()
ElseIf StringInStr(@OSLang, "040E") Then
	$sAppLanguage = "Hungarian"
	CreateMapIDToHungarian()
ElseIf StringInStr(@OSLang, "0418") Then
	$sAppLanguage = "Russian"
	CreateMapIDToRussian()
Else
	$sAppLanguage = "English"
EndIf

;Script version
Global $sVersion = GetScriptVersion()

;ToolTime (built from a folder tree of shortcuts, see the ToolTime section further down)
Global $bToolTimeEnabledSetting = 1
Global Const $iToolTimeMaxEntriesMin = 10 ;limit of entries per menu: lowest value that can be set
Global Const $iToolTimeMaxEntriesMax = 20 ;limit of entries per menu: highest value that can be set
Global Const $iToolTimeMaxEntriesDefault = 15
Global Const $iToolTimeMaxDepth = 3 ;menu levels including the ToolTime menu itself
Global Const $iToolTimeMaxTotalItems = 400 ;AutoIt allows 505 tray items in total (including all other menu items)
Global Const $iToolTimeMaxReportLines = 25
Global $iToolTimeMaxEntriesSetting = $iToolTimeMaxEntriesDefault
Global $sToolTimeFolderSetting = "" ;"Folder" from the INI file, empty = default folder
Global $sToolTimeFolder = $sAppDataDir & "\ToolTime"
Global Const $sToolTimeInfoFileName = "ToolTime_Info.txt" ;written into a newly created ToolTime folder, always ignored when reading it
Global $oToolTimeActions = ObjCreate("Scripting.Dictionary") ;tray item ID -> path of the .lnk file
Global $aToolTimeIds[512] ;IDs of all tray items created for ToolTime, in creation order
Global $iToolTimeIdCount = 0
Global $iToolTimeTotalItems = 0
Global $iToolTimeLinks = 0
Global $iToolTimeFolders = 0
Global $iToolTimeHiddenByLimit = 0
Global $iToolTimeMissing = 0
Global $iToolTimeWarnings = 0
Global $sToolTimeReport = ""
Global $sToolTimeLastNotified = ""
Global $hToolTimeChange = 0 ;handle of the folder change notification
Global $hToolTimeChangePollTimer = TimerInit()
Global $hToolTimeChangeQuietTimer = TimerInit()
Global $bToolTimeChangePending = False

;KeepAwake
Global $bKeepAwakeEnabledSetting = 1
Global $iKeepAwakeStateSetting = 0
Global $iKeepAwakeLastState = 0
Global $bRestoreKeepAwakeStateSetting = 0

;Autostart
Global $bAutostartSetting = 0

;Big icons
Global $bUseBigIconsSetting = 0
Global $iBigIconsSize = 32
Global $iSmallIconsSize = 16
Global $iIconsSize = 16

;AlwaysOnTop
Global $bAlwaysOnTopEnabledSetting = 1
Global $bActivateAlwaysOnTopHotKey = 1
Global $sAlwaysOnTopHotKey = "+!t"
Global $bAlwaysOnTopShowToolTip = 1

; Global object used to store tray items and their hBitmaps
Global $mhBitmapStorage = ObjCreate("Scripting.Dictionary")

;Create the INI file with settings and default tools if it does not exist
If Not FileExists($sIniFile) Then CreateIni()

;Load settings from the INI file
LoadSettings()

;Call _Singleton this late because otherwise it is unclear whether a log file should be written
If _Singleton($sAppName, 1) = 0 Then
	Logfile($sAppName & " is already running, therefore this start is being aborted")
	Exit
EndIf

;start a fresh logfile on app start
FileDelete($sLogFile)

Logfile("Start")
Logfile("App language: " & $sAppLanguage)
Logfile("Version: " & $sVersion)
Logfile("INI file: " & $sIniFile)
Logfile("ToolTime enabled: " & $bToolTimeEnabledSetting, 6)
Logfile("ToolTime entries per menu: " & $iToolTimeMaxEntriesSetting, 6)
Logfile("KeepAwake enabled: " & $bKeepAwakeEnabledSetting, 6)
Logfile("Save KeepAwake status: " & $bRestoreKeepAwakeStateSetting, 6)
Logfile("Saved KeepAwake status: " & $iKeepAwakeStateSetting, 6)
Logfile("Autostart: " & $bAutostartSetting, 6)
Logfile("Use log file: " & $bUseLogSetting, 6)
Logfile("AlwaysOnTop enabled: " & $bAlwaysOnTopEnabledSetting, 6)
Logfile("Enable AlwaysOnTop hotkey: " & $bActivateAlwaysOnTopHotKey, 6)
Logfile("AlwaysOnTop hotkey: " & $sAlwaysOnTopHotKey, 6)
Logfile("Show AlwaysOnTop tooltip: " & $bAlwaysOnTopShowToolTip, 6)
Logfile("Use big icons: " & $bUseBigIconsSetting, 6)

;Do this this late because otherwise not all required variables are defined
OnAutoItExitRegister("OnExit") ;Not really necessary, but it does no harm :-)

;Set the icon size before creating the tray menu
If $bUseBigIconsSetting = 1 Then
	$iIconsSize = $iBigIconsSize
Else
	$iIconsSize = $iSmallIconsSize
EndIf

;Create the ToolTime folder (with the default tools) if it does not exist
ToolTimeInit()

;TrayMenu Variables
Global $hMenu
;ToolTime
Global $iTitleToolTime
Global $iSepToolTime
Global $iToolTimeReportTrayItem = 0
;KeepAwake
Global $iTitelKeepAwake
Global $iDisplaySystem
Global $iDisplay
Global $iSystem
Global $iDeactivated
Global $iKeepLastKeepAwakeState
Global $iSepKeepAwake
;AlwaysOnTop
Global $iTitelAlwaysOnTop
Global $iActivateAOTHotKeyTrayItem
Global $iMenuId_iActivateAOTHotKeyTrayItem ;used to set icon
Global $iSetAOTHotKeyTrayItem
Global $iAlwaysOnTopShowToolTipTrayItem
Global $iSepAlwaysOnTop
;CCTrayTool
Global $iTitelCCTrayTool
Global $iSettings
Global $iToolTimeEnabledTrayItem
Global $iOpenToolTimeFolderTrayItem = 0
Global $iReloadToolTimeTrayItem = 0
Global $iSepToolTimeEnabled
Global $iKeepAwakeEnabledTrayItem
Global $iSepKeepAwakeEnabled
Global $iAlwaysOnTopEnabledTrayItem
Global $iSepAlwaysOnTopEnabled
Global $iAutostart
Global $iSepAutoStart
Global $iUseBigIconsTrayItem
Global $iSepBigIcons
Global $iUseLogTrayItem
Global $iOpenLogTrayItem
Global $iSepLogFile
Global $iEditINI
Global $iAbout
Global $iSepAbout
Global $iExit

;Create TrayMenu
CreateTrayMenu()

;ApplyTraySettings
ApplyTrayMenuSettings()

;Set the icon and tooltip
SetIconTooltip()

;---

While 1
	Local $iMsg = TrayGetMsg()
	Switch $iMsg
		Case 0
			ToolTimeCheckChanges()
			Sleep(500)
			ContinueLoop

		Case $iDisplay
			SetKeepAwakeState(1)
			SetIconTooltip()

		Case $iSystem
			SetKeepAwakeState(2)
			SetIconTooltip()

		Case $iDisplaySystem
			SetKeepAwakeState(3)
			SetIconTooltip()

		Case $iDeactivated
			SetKeepAwakeState(0)
			SetIconTooltip()

		Case $iAutostart
			CheckAutostart()

		Case $iEditINI
			EditINI()

		Case $iUseLogTrayItem
			CheckUseLogTrayItem()

		Case $iOpenLogTrayItem
			OpenLog()

		Case $iKeepLastKeepAwakeState
			CheckKeepLastKeepAwakeState()

		Case $iToolTimeEnabledTrayItem
			CheckToolTimeEnabled()

		Case $iOpenToolTimeFolderTrayItem
			ToolTimeOpenFolder()

		Case $iReloadToolTimeTrayItem
			ReloadToolTime()

		Case $iToolTimeReportTrayItem
			ToolTimeShowReport()

		Case $iKeepAwakeEnabledTrayItem
			CheckKeepAwakeEnabled()

		Case $iAlwaysOnTopEnabledTrayItem
			CheckAlwaysOnTopEnabled()

		Case $iActivateAOTHotKeyTrayItem
			CheckAOTTrayItem()

		Case $iSetAOTHotKeyTrayItem
			SetAOTHotkey()

		Case $iAlwaysOnTopShowToolTipTrayItem
			CheckAOTShowToolTipTrayItem()

		Case $iUseBigIconsTrayItem
			CheckUseBigIcons()

		Case $iAbout
			Logfile($sAppName & ': "About" invoked', 6)
			Local $sAboutText = $sAppName & _(" Version: ") & $sVersion & @CRLF & @CRLF & _("A simple way to disable powersaving, an AlwaysOnTop tool and a fast way to start additional tools from the traymenu.") & @CRLF & @CRLF & "Markus Debus - info@markus-debus.de" & @CRLF & @CRLF & _
					"Copyright (C) 2026 Markus Debus" & @CRLF & _
					"License: GPL-3.0-or-later (see the LICENSE and NOTICE files)." & @CRLF & _
					"This program comes with ABSOLUTELY NO WARRANTY. It is free software, and you are welcome to redistribute it under certain conditions." & @CRLF & _
					"https://www.gnu.org/licenses/gpl-3.0.html"
			;Disable the tray menu while the MsgBox is shown: TrayGetMsg() is not being polled during
			;that time, so clicks on the tray menu would otherwise be generated but never processed
			Local $oTrayMenuStates = _TrayMenuDisableAll($hMenu)
			MsgBox(64, _("About ") & $sAppName, $sAboutText)
			_TrayMenuRestoreDisabled($hMenu, $oTrayMenuStates)
		Case $iExit
			Logfile("Enabling power saving before exit", 6)
			If _WinAPI_SetThreadExecutionState($ES_CONTINUOUS) = 0 Then Logfile("Error: _WinAPI_SetThreadExecutionState($ES_CONTINUOUS) could not be executed successfully")
			SaveSettings()
			Logfile("End")
			Exit

		Case Else
			;Entries of the ToolTime menu: the tray item ID leads to the shortcut that is started
			If $oToolTimeActions.Exists($iMsg) Then ToolTimeLaunch($oToolTimeActions.Item($iMsg))
	EndSwitch
WEnd

; ====================================================================================================
; Function: ApplyTrayMenuSettings
; Description: Applies the configured tray menu settings at application startup, including
;              KeepAwake, autostart, AlwaysOnTop, logging, state restoration, and icon size.
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func ApplyTrayMenuSettings()
	;The Check*() functions below toggle relative to the CURRENT value of their
	;setting variable (needed so a normal tray-menu click still works as a toggle).
	;At startup that variable is already loaded from the INI, i.e. already equal to
	;the target - so we briefly reset it to the "off" value right before calling,
	;which makes the function toggle it back to the correct (target) state.
	If $bUseLogSetting = 1 Then
		$bUseLogSetting = 0
		CheckUseLogTrayItem()
	EndIf

	;ToolTime enabled/disabled: like $bKeepAwakeEnabledSetting below, this setting's Check function
	;rebuilds the whole tray menu, so the checkbox icon is set directly instead of via
	;CheckToolTimeEnabled()
	If $bToolTimeEnabledSetting = 1 Then
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iToolTimeEnabledTrayItem, @ScriptFullPath, $iIconnumberGreenCheck - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iToolTimeEnabledTrayItem, @ScriptDir & "\icons\GreenCheck.ico", 0, $iIconsSize)
		EndIf
	EndIf

	;KeepAwake enabled/disabled: like $bUseBigIconsSetting below, this setting's Check function
	;rebuilds the whole tray menu (and would therefore call ApplyTrayMenuSettings() again if used
	;here), so the checkbox icon is set directly instead of via CheckKeepAwakeEnabled()
	If $bKeepAwakeEnabledSetting = 1 Then
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iKeepAwakeEnabledTrayItem, @ScriptFullPath, $iIconnumberGreenCheck - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iKeepAwakeEnabledTrayItem, @ScriptDir & "\icons\GreenCheck.ico", 0, $iIconsSize)
		EndIf

		Local $iTargetKeepAwakeState = $iKeepAwakeStateSetting
		$iKeepAwakeStateSetting = -1 ;sentinel value so the call below is never skipped
		SetKeepAwakeState($iTargetKeepAwakeState)

		If $bRestoreKeepAwakeStateSetting = 1 Then
			$bRestoreKeepAwakeStateSetting = 0
			CheckKeepLastKeepAwakeState()
		EndIf
	Else
		;KeepAwake is disabled entirely: make sure normal power management is in effect
		If _WinAPI_SetThreadExecutionState($ES_CONTINUOUS) = 0 Then Logfile("Error: _WinAPI_SetThreadExecutionState($ES_CONTINUOUS) could not be executed successfully")
	EndIf

	If $bAutostartSetting = 1 Then
		$bAutostartSetting = 0
		CheckAutostart()
	EndIf

	;AlwaysOnTop enabled/disabled: like $bKeepAwakeEnabledSetting above, this setting's Check
	;function rebuilds the whole tray menu, so the checkbox icon is set directly instead of via
	;CheckAlwaysOnTopEnabled()
	If $bAlwaysOnTopEnabledSetting = 1 Then
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iAlwaysOnTopEnabledTrayItem, @ScriptFullPath, $iIconnumberGreenCheck - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iAlwaysOnTopEnabledTrayItem, @ScriptDir & "\icons\GreenCheck.ico", 0, $iIconsSize)
		EndIf

		If $bActivateAlwaysOnTopHotKey = 1 Then
			$bActivateAlwaysOnTopHotKey = 0
			CheckAOTTrayItem()
		EndIf

		If $bAlwaysOnTopShowToolTip = 1 Then
			$bAlwaysOnTopShowToolTip = 0
			CheckAOTShowToolTipTrayItem()
		EndIf
	Else
		;AlwaysOnTop is disabled entirely: make sure the hotkey is not registered
		Logfile("AlwaysOnTop disabled, removing hotkey: " & $sAlwaysOnTopHotKey, 6)
		HotKeySet($sAlwaysOnTopHotKey)
	EndIf

	If $bUseBigIconsSetting = 1 Then
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iUseBigIconsTrayItem, @ScriptFullPath, $iIconnumberGreenCheck - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iUseBigIconsTrayItem, @ScriptDir & "\icons\GreenCheck.ico", 0, $iIconsSize)
		EndIf
		Logfile("Enabling big icons", 6)
		$iIconsSize = $iBigIconsSize
	EndIf
EndFunc   ;==>ApplyTrayMenuSettings

; ====================================================================================================
; Function: CreateIni
; Description: Creates the application's INI file and populates it with default settings. The
;              default tools are created as shortcuts in the ToolTime folder (see ToolTimeInit()).
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func CreateIni()
	IniWrite($sIniFile, "Main", "Autostart", "0")
	IniWrite($sIniFile, "Main", "UseBigIcons", "0")
	IniWrite($sIniFile, "Main", "UseLog", "0")
	FileWrite($sIniFile, @CRLF)

	IniWrite($sIniFile, "KeepAwake", "Enabled", "1")
	IniWrite($sIniFile, "KeepAwake", "KeepState", "1")
	IniWrite($sIniFile, "KeepAwake", "State", "0")
	FileWrite($sIniFile, @CRLF)

	IniWrite($sIniFile, "AlwaysOnTop", "Enabled", "1")
	IniWrite($sIniFile, "AlwaysOnTop", "Active", "1")
	IniWrite($sIniFile, "AlwaysOnTop", "HotKey", "+!t")
	IniWrite($sIniFile, "AlwaysOnTop", "ShowToolTip", "1")
	FileWrite($sIniFile, @CRLF)

	IniWrite($sIniFile, "ToolTime", "Enabled", "1")
	IniWrite($sIniFile, "ToolTime", "MaxEntries", $iToolTimeMaxEntriesDefault)
	IniWrite($sIniFile, "ToolTime", "Folder", "")
	FileWrite($sIniFile, @CRLF)

EndFunc   ;==>CreateIni

; ====================================================================================================
; Function: DeleteTrayMenu
; Description: Deletes the existing tray menu items and resets the menu-related resources.
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func DeleteTrayMenu()
	Logfile("DeleteTrayMenu() start", 6)

	;ToolTime: all entries that were created from the folder tree, then title and separator
	ToolTimeDeleteMenu()
	If $iTitleToolTime <> 0 Then TrayItemDelete($iTitleToolTime)
	If $iSepToolTime <> 0 Then TrayItemDelete($iSepToolTime)
	;Reset to 0 regardless of $bToolTimeEnabledSetting: if this section stays disabled, the next
	;CreateTrayMenu() call will skip recreating these items, and a leftover (stale) ID here could
	;otherwise coincidentally match a freshly created, unrelated item and intercept its clicks in
	;the Switch above (an earlier Case with a stale-but-matching ID wins over the real one)
	$iTitleToolTime = 0
	$iSepToolTime = 0

	;KeepAwake
	If $bKeepAwakeEnabledSetting = 1 Then
		TrayItemDelete($iTitelKeepAwake)
		TrayItemDelete($iDisplaySystem)
		TrayItemDelete($iDisplay)
		TrayItemDelete($iSystem)
		TrayItemDelete($iDeactivated)
		TrayItemDelete($iKeepLastKeepAwakeState)
		TrayItemDelete($iSepKeepAwake)
	EndIf
	;Reset to 0 regardless - see comment above
	$iTitelKeepAwake = 0
	$iDisplaySystem = 0
	$iDisplay = 0
	$iSystem = 0
	$iDeactivated = 0
	$iKeepLastKeepAwakeState = 0
	$iSepKeepAwake = 0

	;AlwaysOnTop
	$iMenuId_iActivateAOTHotKeyTrayItem = 0
	If $bAlwaysOnTopEnabledSetting = 1 Then
		TrayItemDelete($iTitelAlwaysOnTop)
		TrayItemDelete($iActivateAOTHotKeyTrayItem)
		TrayItemDelete($iSetAOTHotKeyTrayItem)
		TrayItemDelete($iAlwaysOnTopShowToolTipTrayItem)
		TrayItemDelete($iSepAlwaysOnTop)
	EndIf
	;Reset to 0 regardless - see comment above
	$iTitelAlwaysOnTop = 0
	$iActivateAOTHotKeyTrayItem = 0
	$iSetAOTHotKeyTrayItem = 0
	$iAlwaysOnTopShowToolTipTrayItem = 0
	$iSepAlwaysOnTop = 0

	TrayItemDelete($iTitelCCTrayTool)
	TrayItemDelete($iSettings) ;also deletes all items in submenu
	TrayItemDelete($iAbout)
	TrayItemDelete($iSepAbout)
	TrayItemDelete($iExit)
	Logfile("DeleteTrayMenu() end", 6)
EndFunc   ;==>DeleteTrayMenu

; ====================================================================================================
; ToolTime (folder based)
;
; The ToolTime menu is built from a folder tree. Default folder: %LocalAppData%\CCTrayTool\ToolTime
; (can be changed with "Folder" in the [ToolTime] section of the INI file).
;   sub folder -> sub menu   (icon from the folder's desktop.ini, otherwise the standard folder icon)
;   .lnk file  -> menu entry (text = file name, icon = icon of the shortcut or of its target)
;
; Rules:
;   - At most [ToolTime] MaxEntries entries (folders + shortcuts) per menu level: 15 by default,
;     configurable from 10 to 20. Reason: a native tray menu can only be scrolled with two small arrow
;     buttons (no mouse wheel) and a long menu pushes KeepAwake, AlwaysOnTop and the settings out of view.
;     Further entries are NOT shown. Instead an inactive hint line is added to the menu, the case is
;     logged, listed in the problem report ("(!)" menu line) and a notification is shown.
;   - At most 3 menu levels (ToolTime menu + 2 levels of sub menus). Deeper folders are ignored (reported).
;   - At most 400 tray items in total (AutoIt allows 505 tray items including all other menu items).
;   - Order: folders first, then shortcuts, each sorted alphabetically. A prefix of 2-3 digits and an
;     underscore ("01_Notepad.lnk") controls the order and is not shown.
;   - Hidden files/folders (this includes desktop.ini) and all files that are no .lnk files are ignored.
;     This includes the information file ToolTime_Info.txt that is written into a newly created ToolTime
;     folder (system language: limits and how to sort with a leading number). It is skipped without any log
;     entry or problem report.
;   - Shortcuts whose target does not exist are not shown (logged only). Unreadable shortcuts are
;     ignored (reported). Folders without any visible entry are not shown.
;   - "Run as administrator" is taken from the shortcut (Properties > Shortcut > Advanced).
;   - Changes in the folder tree are detected automatically, the menu is rebuilt afterwards.
; ====================================================================================================

; ====================================================================================================
; Function: ToolTimeInit
; Description: Makes sure the ToolTime folder exists. If it does not exist yet, it is created; with the
;              default folder the default tools are created in it as well. A short information file
;              is written into every newly created folder (see ToolTimeWriteInfoFile()).
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func ToolTimeInit()
	Logfile("ToolTimeInit() start", 6)
	Logfile("ToolTime folder: " & $sToolTimeFolder, 4)
	If FileExists($sToolTimeFolder) Then
		Logfile("ToolTimeInit() end, folder exists", 6)
		Return
	EndIf

	DirCreate($sToolTimeFolder)
	If Not FileExists($sToolTimeFolder) Then
		Logfile("ToolTime folder could not be created: " & $sToolTimeFolder, 0)
		Return
	EndIf

	If $sToolTimeFolderSetting = "" Then ToolTimeCreateDefaults() ;only the default folder gets the default tools
	ToolTimeWriteInfoFile()
	Logfile("ToolTimeInit() end", 6)
EndFunc   ;==>ToolTimeInit

; ====================================================================================================
; Function: ToolTimeWriteInfoFile
; Description: Writes a short information text in the system language into the (newly created) ToolTime
;              folder: what the folders and shortcuts become, the limits for the number of entries and
;              how a leading number sorts the entries. The file is only written if it does not exist yet.
;              It is a plain .txt file: ToolTimeReadDir() skips it silently, so it neither creates a menu
;              entry nor a log line or a problem report. The change detection is not triggered either,
;              because the file is written before the detection is started (ToolTimeBuildMenu()).
;              UTF-8 with BOM, so that every Notepad version shows umlauts and accents correctly.
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func ToolTimeWriteInfoFile()
	Local $sFile = $sToolTimeFolder & "\" & $sToolTimeInfoFileName
	If Not FileExists($sToolTimeFolder) Or FileExists($sFile) Then Return

	Local $sText = $sAppName & " - " & _("ToolTime") & @CRLF & @CRLF & _
			_ToolTimeWrapText(_("Every sub folder becomes a sub menu and every shortcut (.lnk file) becomes a menu entry. All other files, like this one, are ignored.")) & @CRLF & @CRLF & _
			_ToolTimeWrapText(_ToolTimeFormat(_("The maximum number of entries per menu is %1. It can be changed in the settings file ([ToolTime] MaxEntries, 10 - 20)."), $iToolTimeMaxEntriesSetting, "", "", "")) & @CRLF & @CRLF & _
			_ToolTimeWrapText(_ToolTimeFormat(_("At most %1 menu levels (the ToolTime menu and its sub menus) and at most %2 entries in total are shown. Entries above a limit are not shown, a note is added to the menu instead."), $iToolTimeMaxDepth, $iToolTimeMaxTotalItems, "", "")) & @CRLF & @CRLF & _
			_ToolTimeWrapText(_("Order: folders come first, then shortcuts, each sorted by name. A number with 2 or 3 digits and an underscore in front of the name sets the order; the number is not shown in the menu.")) & @CRLF & @CRLF & _
			_("Example:") & @CRLF & _
			"  01_Office\" & @CRLF & _
			"  02_Tools\" & @CRLF & _
			"  01_Notepad.lnk" & @CRLF & _
			"  02_Calculator.lnk" & @CRLF

	Local $hFile = FileOpen($sFile, 2 + 128) ;overwrite, UTF-8 with BOM
	If $hFile = -1 Then
		Logfile("ToolTime: the information file could not be written: " & $sFile, 4)
		Return
	EndIf
	FileWrite($hFile, $sText)
	FileClose($hFile)
	Logfile("ToolTime: information file written: " & $sFile, 4)
EndFunc   ;==>ToolTimeWriteInfoFile

; Breaks a text at spaces into lines of at most $iWidth characters (a word longer than that stays in one piece).
Func _ToolTimeWrapText($sText, $iWidth = 78)
	Local $aWords = StringSplit($sText, " ", 2)
	Local $sResult = "", $sLine = "", $i
	For $i = 0 To UBound($aWords) - 1
		If $sLine = "" Then
			$sLine = $aWords[$i]
		ElseIf StringLen($sLine) + 1 + StringLen($aWords[$i]) > $iWidth Then
			$sResult &= $sLine & @CRLF
			$sLine = $aWords[$i]
		Else
			$sLine &= " " & $aWords[$i]
		EndIf
	Next
	Return $sResult & $sLine
EndFunc   ;==>_ToolTimeWrapText

; ====================================================================================================
; Function: ToolTimeCreateDefaults
; Description: Creates the default tools as sub folders and shortcuts in the ToolTime folder. The names
;              are created in the language of the operating system.
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func ToolTimeCreateDefaults()
	Logfile("Creating the default tools in the ToolTime folder", 0)
	Local $sWin = @WindowsDir
	Local $sSys = @WindowsDir & "\System32"
	Local $sShell = "%SystemRoot%\System32\shell32.dll"
	Local $sSystemDir = $sToolTimeFolder & "\01_" & _ToolTimeSafeName(_("System"))
	Local $sOfficeDir = $sToolTimeFolder & "\02_Office"
	Local $iNo

	$iNo = 0
	ToolTimeMakeFolder($sSystemDir, $sShell, 21)
	_ToolTimeAddDefault($sSystemDir, $iNo, "Command Prompt", $sSys & "\cmd.exe", "", True)
	_ToolTimeAddDefault($sSystemDir, $iNo, "Registry Editor", $sWin & "\regedit.exe", "", True)
	_ToolTimeAddDefault($sSystemDir, $iNo, "Network Settings", $sSys & "\control.exe", "ncpa.cpl", False, $sSys & "\ncpa.cpl")
	_ToolTimeAddDefault($sSystemDir, $iNo, "Control Panel", $sSys & "\control.exe")
	_ToolTimeAddDefault($sSystemDir, $iNo, "Resource Monitor", $sSys & "\resmon.exe", "", True)
	_ToolTimeAddDefault($sSystemDir, $iNo, "Performance Monitor", $sSys & "\perfmon.exe", "", True)
	_ToolTimeAddDefault($sSystemDir, $iNo, "Manage Services", $sSys & "\services.msc", "", True, $sSys & "\filemgmt.dll")
	_ToolTimeAddDefault($sSystemDir, $iNo, "Disk Cleanup", $sSys & "\cleanmgr.exe", "", True)

	$iNo = 0
	ToolTimeMakeFolder($sOfficeDir, $sShell, 265)
	_ToolTimeAddDefault($sOfficeDir, $iNo, "Calculator", $sSys & "\calc.exe")
	_ToolTimeAddDefault($sOfficeDir, $iNo, "Notepad", $sSys & "\notepad.exe")

	$iNo = 0
	_ToolTimeAddDefault($sToolTimeFolder, $iNo, "Explorer", $sWin & "\explorer.exe")
EndFunc   ;==>ToolTimeCreateDefaults

; Creates "<dir>\<nn>_<translated name>.lnk" with a running number.
Func _ToolTimeAddDefault($sDir, ByRef $iNo, $sEnglishName, $sTarget, $sArgs = "", $bAdmin = False, $sIconFile = "", $iIconIndex = 0)
	$iNo += 1
	ToolTimeMakeLnk($sDir & "\" & StringFormat("%02d_%s.lnk", $iNo, _ToolTimeSafeName(_($sEnglishName))), $sTarget, $sArgs, $bAdmin, $sIconFile, $iIconIndex)
EndFunc   ;==>_ToolTimeAddDefault

; Creates a folder with a desktop.ini that sets the folder icon (the same thing Explorer does via
; Properties > Customize > Change Icon). Without an icon file only the folder is created.
Func ToolTimeMakeFolder($sDir, $sIconFile = "", $iIconIndex = 0)
	DirCreate($sDir)
	If $sIconFile = "" Then Return
	Local $sIni = $sDir & "\desktop.ini"
	IniWrite($sIni, ".ShellClassInfo", "IconResource", $sIconFile & "," & $iIconIndex)
	FileSetAttrib($sIni, "+SH")
	FileSetAttrib($sDir, "+R")
EndFunc   ;==>ToolTimeMakeFolder

; Creates a shortcut (optionally with "run as administrator"). Returns True on success.
Func ToolTimeMakeLnk($sLnk, $sTarget, $sArgs = "", $bAdmin = False, $sIconFile = "", $iIconIndex = 0)
	If Not FileExists($sTarget) Then
		Logfile("Shortcut not created, the target does not exist: " & $sTarget, 0)
		Return False
	EndIf
	DirCreate(StringLeft($sLnk, StringInStr($sLnk, "\", 0, -1) - 1))
	Local $sWorkDir = StringLeft($sTarget, StringInStr($sTarget, "\", 0, -1) - 1)
	If Not FileCreateShortcut($sTarget, $sLnk, $sWorkDir, $sArgs, "", $sIconFile, "", $iIconIndex) Then
		Logfile("Shortcut could not be created: " & $sLnk, 0)
		Return False
	EndIf
	If $bAdmin Then ToolTimeSetLnkAdminFlag($sLnk)
	Return True
EndFunc   ;==>ToolTimeMakeLnk

; Makes a string usable as a file name.
Func _ToolTimeSafeName($sName)
	Local $sResult = StringRegExpReplace($sName, '[\\/:*?"<>|]', "_")
	$sResult = StringStripWS($sResult, 3)
	While StringRight($sResult, 1) = "."
		$sResult = StringTrimRight($sResult, 1)
	WEnd
	If $sResult = "" Then $sResult = "_"
	Return $sResult
EndFunc   ;==>_ToolTimeSafeName

; ====================================================================================================
; Function: ToolTimeBuildMenu
; Description: Starts the change detection, scans the ToolTime folder and creates the tray menu entries
;              (sub menus and shortcuts) below the "ToolTime" title. If problems were found while reading
;              the folder, a clickable "(!)" line is added at the end.
; Parameters: None.
; Returns: The number of entries created in the ToolTime (root) menu.
; ====================================================================================================
Func ToolTimeBuildMenu()
	Local $hTimer = TimerInit()
	Local $iShown = 0

	;The folder may have been deleted while the program was running: create it again (with the default tools
	;if the default folder is used)
	If Not FileExists($sToolTimeFolder) Then
		Logfile("ToolTime: the folder does not exist, creating it", 4)
		ToolTimeInit()
	EndIf

	;Start the change detection BEFORE reading the folder, so that a change during the scan is not lost
	ToolTimeStartWatch()

	$iToolTimeWarnings = 0
	$sToolTimeReport = ""
	$iToolTimeLinks = 0
	$iToolTimeFolders = 0
	$iToolTimeHiddenByLimit = 0
	$iToolTimeMissing = 0
	$iToolTimeTotalItems = 0
	$iToolTimeIdCount = 0
	$iToolTimeReportTrayItem = 0
	$oToolTimeActions.RemoveAll()

	Logfile("ToolTime: reading " & $sToolTimeFolder & " (at most " & $iToolTimeMaxEntriesSetting & " entries per menu)", 4)

	If FileExists($sToolTimeFolder) Then
		$iShown = ToolTimeBuildLevel($sToolTimeFolder, 0, 1)
	Else
		_ToolTimeWarn("The ToolTime folder was not found and could not be created: %1", $sToolTimeFolder)
	EndIf

	If $iToolTimeWarnings > 0 Then
		$iToolTimeReportTrayItem = _ToolTimeNewItem(_("(!) ToolTime: problems found - click for details") & " (" & $iToolTimeWarnings & ")")
	EndIf

	Logfile(StringFormat("ToolTime: %d ms, %d shortcuts and %d folders shown, %d entries not shown (limit), %d shortcuts hidden (target missing), %d problems", _
			Int(TimerDiff($hTimer)), $iToolTimeLinks, $iToolTimeFolders, $iToolTimeHiddenByLimit, $iToolTimeMissing, $iToolTimeWarnings), 4)
	Return $iShown
EndFunc   ;==>ToolTimeBuildMenu

; ====================================================================================================
; Function: ToolTimeDeleteMenu
; Description: Deletes all tray items that were created for the ToolTime folder (children before
;              parents) and forgets them. The "ToolTime" title and the separator are handled by
;              DeleteTrayMenu().
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func ToolTimeDeleteMenu()
	Local $i
	For $i = $iToolTimeIdCount - 1 To 0 Step -1
		TrayItemDelete($aToolTimeIds[$i])
		$aToolTimeIds[$i] = 0
	Next
	$iToolTimeIdCount = 0
	$iToolTimeTotalItems = 0
	$iToolTimeReportTrayItem = 0
	$iToolTimeWarnings = 0
	$sToolTimeReport = ""
	$oToolTimeActions.RemoveAll()
EndFunc   ;==>ToolTimeDeleteMenu

; ====================================================================================================
; Function: ToolTimeBuildLevel
; Description: Creates the entries of ONE folder as menu entries below $idParent and recurses into the
;              sub folders. Applies the limit of entries per menu.
; Parameters:
;   $sDir      - Folder to read.
;   $idParent  - Tray menu ID of the parent menu (0 = ToolTime root menu).
;   $iDepth    - Menu level of this folder (root = 1).
; Returns: The number of entries created at this level (without the hint line).
; ====================================================================================================
Func ToolTimeBuildLevel($sDir, $idParent, $iDepth)
	Local $aList = ToolTimeReadDir($sDir, $iDepth)
	Local $iCount = UBound($aList)
	Local $iMax = $iToolTimeMaxEntriesSetting
	Local $iShow = $iCount
	Local $iCreated = 0
	Local $i, $aParts, $id, $idSub, $iSubCount, $sHidden

	If $iCount > $iMax Then
		$iShow = $iMax
		$sHidden = ""
		For $i = $iMax To $iCount - 1
			If $i - $iMax >= 8 Then
				$sHidden &= "..., "
				ExitLoop
			EndIf
			$aParts = StringSplit($aList[$i], "|", 2) ;2 = no count element
			$sHidden &= $aParts[1] & ", "
		Next
		$iToolTimeHiddenByLimit += $iCount - $iShow
		_ToolTimeWarn("Too many entries in '%1': %2 found, only %3 shown. Not shown: %4", _ToolTimeRelPath($sDir), $iCount, $iShow, StringTrimRight($sHidden, 2))
	EndIf

	For $i = 0 To $iShow - 1
		If $iToolTimeTotalItems >= $iToolTimeMaxTotalItems Then
			_ToolTimeWarn("Too many entries in total (limit %1): the remaining entries are not shown.", $iToolTimeMaxTotalItems)
			ExitLoop
		EndIf

		$aParts = StringSplit($aList[$i], "|", 2) ;0 = sort key, 1 = display name, 2 = path, 3 = type (D/L)
		If $aParts[3] = "D" Then
			$idSub = _ToolTimeNewMenu($aParts[1], $idParent)
			If $idSub > 0 Then
				$iSubCount = ToolTimeBuildLevel($aParts[2], $idSub, $iDepth + 1)
				If $iSubCount = 0 Then
					_ToolTimeRemoveLastItem($idSub)
					Logfile("ToolTime: folder without visible entries not shown: " & $aParts[2], 4)
				Else
					ToolTimeSetFolderIcon($idSub, $aParts[2])
					$iToolTimeFolders += 1
					$iCreated += 1
				EndIf
			EndIf
		Else
			$id = _ToolTimeNewItem($aParts[1], $idParent)
			If $id > 0 Then
				$oToolTimeActions.Item($id) = $aParts[2]
				ToolTimeSetLinkIcon($id, $aParts[2])
				$iToolTimeLinks += 1
				$iCreated += 1
			EndIf
		EndIf
	Next

	If $iCount > $iShow And $iCreated > 0 Then
		$id = _ToolTimeNewItem(StringReplace(StringReplace(_("... %1 more not shown (limit %2)"), "%1", $iCount - $iShow), "%2", $iMax), $idParent)
		If $id > 0 Then TrayItemSetState($id, $TRAY_DISABLE)
	EndIf

	Return $iCreated
EndFunc   ;==>ToolTimeBuildLevel

; ====================================================================================================
; Function: ToolTimeReadDir
; Description: Reads one folder and returns its valid entries sorted (folders first, then shortcuts).
;              The entry limit is applied by the caller.
; Parameters:
;   $sDir    - Folder to read.
;   $iDepth  - Menu level of this folder (root = 1).
; Returns: A sorted 1D array of "sortkey|display name|full path|type" strings (type D = folder,
;          L = shortcut). '|' cannot be part of a Windows file name, so it is a safe delimiter.
; ====================================================================================================
Func ToolTimeReadDir($sDir, $iDepth)
	Local $aList[0]
	Local $hSearch = FileFindFirstFile($sDir & "\*")
	If $hSearch = -1 Then Return $aList

	Local $sName, $sPath, $sAttr, $sBase, $aInfo, $sTarget

	While 1
		$sName = FileFindNextFile($hSearch)
		If @error Then ExitLoop

		$sPath = $sDir & "\" & $sName
		$sAttr = FileGetAttrib($sPath)
		If StringInStr($sAttr, "H") Then ContinueLoop ;hidden (this also skips desktop.ini)

		If StringInStr($sAttr, "D") Then
			If $iDepth >= $iToolTimeMaxDepth Then
				_ToolTimeWarn("Folder ignored (maximum of %1 menu levels exceeded): %2", $iToolTimeMaxDepth, _ToolTimeRelPath($sPath))
				ContinueLoop
			EndIf
			_ToolTimeListAdd($aList, "0" & StringLower($sName) & "|" & _ToolTimeDisplayName($sName) & "|" & $sPath & "|D")

		ElseIf StringLower(StringRight($sName, 4)) = ".lnk" Then
			$aInfo = FileGetShortcut($sPath)
			If @error Then
				_ToolTimeWarn("Shortcut could not be read and was ignored: %1", _ToolTimeRelPath($sPath))
				ContinueLoop
			EndIf
			$sTarget = ExpandEnvVars($aInfo[0])
			If $sTarget <> "" And Not FileExists($sTarget) Then
				$iToolTimeMissing += 1
				Logfile("ToolTime: target not found, shortcut not shown: " & $sPath & " -> " & $sTarget, 4)
				ContinueLoop
			EndIf
			$sBase = StringTrimRight($sName, 4)
			_ToolTimeListAdd($aList, "1" & StringLower($sBase) & "|" & _ToolTimeDisplayName($sBase) & "|" & $sPath & "|L")

		ElseIf $sName <> $sToolTimeInfoFileName Then ;the information file is skipped without any log line
			Logfile("ToolTime: ignored (not a .lnk file): " & $sPath, 4)
		EndIf
	WEnd
	FileClose($hSearch)

	If UBound($aList) > 1 Then _ArraySort($aList)
	Return $aList
EndFunc   ;==>ToolTimeReadDir

; Appends one string to a 1D array. _ArrayAdd() must NOT be used here: it splits the string at '|' into
; several array elements, which destroys the "sortkey|name|path|type" entries.
Func _ToolTimeListAdd(ByRef $aList, $sValue)
	Local $iNew = UBound($aList)
	ReDim $aList[$iNew + 1]
	$aList[$iNew] = $sValue
EndFunc   ;==>_ToolTimeListAdd

; "01_Notepad" -> "Notepad" (2-3 digits + underscore are only used for sorting)
Func _ToolTimeDisplayName($sName)
	Local $sResult = StringRegExpReplace($sName, "^\d{2,3}_", "")
	If $sResult = "" Then $sResult = $sName
	Return $sResult
EndFunc   ;==>_ToolTimeDisplayName

; Path relative to the ToolTime folder for messages: "ToolTime\Office\Tools".
Func _ToolTimeRelPath($sPath)
	Local $sRel = $sPath
	If StringLeft($sPath, StringLen($sToolTimeFolder)) = $sToolTimeFolder Then $sRel = StringTrimLeft($sPath, StringLen($sToolTimeFolder))
	Return _("ToolTime") & $sRel
EndFunc   ;==>_ToolTimeRelPath

; ====================================================================================================
; Tray item helpers: every item created for ToolTime is tracked, so that the whole menu can be deleted again
; ====================================================================================================
Func _ToolTimeTrack($id, $sText)
	If $id > 0 Then
		$iToolTimeTotalItems += 1
		If $iToolTimeIdCount < UBound($aToolTimeIds) Then
			$aToolTimeIds[$iToolTimeIdCount] = $id
			$iToolTimeIdCount += 1
		EndIf
	Else
		Logfile("ToolTime: tray item could not be created (tray item limit?): " & $sText, 0)
	EndIf
	Return $id
EndFunc   ;==>_ToolTimeTrack

Func _ToolTimeNewItem($sText, $idParent = 0)
	Local $id
	$sText = StringReplace($sText, "&", "&&") ;show ampersands literally instead of underlining the next letter
	If $idParent > 0 Then
		$id = TrayCreateItem($sText, $idParent)
	Else
		$id = TrayCreateItem($sText)
	EndIf
	Return _ToolTimeTrack($id, $sText)
EndFunc   ;==>_ToolTimeNewItem

Func _ToolTimeNewMenu($sText, $idParent = 0)
	Local $id
	$sText = StringReplace($sText, "&", "&&")
	If $idParent > 0 Then
		$id = TrayCreateMenu($sText, $idParent)
	Else
		$id = TrayCreateMenu($sText)
	EndIf
	Return _ToolTimeTrack($id, $sText)
EndFunc   ;==>_ToolTimeNewMenu

; Removes the item that was created last (used for sub menus that turned out to be empty).
Func _ToolTimeRemoveLastItem($id)
	TrayItemDelete($id)
	$iToolTimeTotalItems -= 1
	If $iToolTimeIdCount > 0 Then
		If $aToolTimeIds[$iToolTimeIdCount - 1] = $id Then
			$aToolTimeIds[$iToolTimeIdCount - 1] = 0
			$iToolTimeIdCount -= 1
		EndIf
	EndIf
EndFunc   ;==>_ToolTimeRemoveLastItem

; ====================================================================================================
; Icons
; ====================================================================================================

; Icon of a shortcut: its own icon location, otherwise the icon of its target.
Func ToolTimeSetLinkIcon($id, $sLnk)
	Local $aInfo = FileGetShortcut($sLnk)
	If @error Then Return
	Local $sIconFile = ExpandEnvVars($aInfo[4])
	Local $iIconIndex = Number($aInfo[5])
	If $sIconFile = "" Or Not FileExists($sIconFile) Then
		$sIconFile = ExpandEnvVars($aInfo[0])
		$iIconIndex = 0
	EndIf
	If $sIconFile = "" Or Not FileExists($sIconFile) Then
		Logfile("ToolTime: no icon source for shortcut: " & $sLnk, 4)
		Return
	EndIf
	If StringInStr(FileGetAttrib($sIconFile), "D") Then ;shortcut to a folder
		$sIconFile = @SystemDir & "\shell32.dll"
		$iIconIndex = 3
	EndIf
	If Not TrayItemSetIcon($hMenu, $id, $sIconFile, $iIconIndex, $iIconsSize) Then
		Logfile("ToolTime: icon could not be set for shortcut: " & $sLnk & " (" & $sIconFile & "," & $iIconIndex & ")", 4)
	EndIf
EndFunc   ;==>ToolTimeSetLinkIcon

; Icon of a folder: desktop.ini (IconResource or IconFile/IconIndex), otherwise the standard folder icon.
Func ToolTimeSetFolderIcon($id, $sDir)
	Local $sIni = $sDir & "\desktop.ini"
	Local $sFile = "", $iIndex = 0, $sRes, $iPos

	If FileExists($sIni) Then
		$sRes = IniRead($sIni, ".ShellClassInfo", "IconResource", "")
		If $sRes <> "" Then
			$iPos = StringInStr($sRes, ",", 0, -1)
			If $iPos > 0 Then
				$sFile = StringLeft($sRes, $iPos - 1)
				$iIndex = Number(StringMid($sRes, $iPos + 1))
			Else
				$sFile = $sRes
			EndIf
		Else
			$sFile = IniRead($sIni, ".ShellClassInfo", "IconFile", "")
			$iIndex = Number(IniRead($sIni, ".ShellClassInfo", "IconIndex", "0"))
		EndIf
		$sFile = ExpandEnvVars(StringReplace($sFile, '"', ""))
	EndIf

	If $sFile = "" Or Not FileExists($sFile) Then
		$sFile = @SystemDir & "\shell32.dll"
		$iIndex = 3 ;standard (closed) folder icon
	EndIf
	If Not TrayItemSetIcon($hMenu, $id, $sFile, $iIndex, $iIconsSize) Then
		Logfile("ToolTime: icon could not be set for folder: " & $sDir & " (" & $sFile & "," & $iIndex & ")", 4)
	EndIf
EndFunc   ;==>ToolTimeSetFolderIcon

; ====================================================================================================
; Function: ToolTimeLaunch
; Description: Starts a shortcut of the ToolTime folder. If the shortcut has the "run as administrator"
;              flag and this program is not elevated, the target is started explicitly with the "runas"
;              verb (UAC prompt). Otherwise the shortcut itself is handed to the shell.
; Parameters:
;   $sLnk - Full path of the .lnk file.
; Returns: None.
; ====================================================================================================
Func ToolTimeLaunch($sLnk)
	Logfile("ToolTimeLaunch() start: " & $sLnk, 6)
	Local $aInfo = FileGetShortcut($sLnk)
	If @error Then
		Logfile("Start failed, the shortcut could not be read: " & $sLnk, 0)
		TrayTip(_("Error"), $sLnk, 10, $TIP_ICONEXCLAMATION)
		Return
	EndIf

	Local $bAdmin = ToolTimeLnkRunsAsAdmin($sLnk)
	Local $sTarget = ExpandEnvVars($aInfo[0])
	Local $sWorkDir = ExpandEnvVars($aInfo[1])
	Local $iShow = Number($aInfo[6])
	If $iShow < 1 Then $iShow = @SW_SHOWNORMAL
	Local $iRet, $iErr

	If $bAdmin And Not IsAdmin() And $sTarget <> "" Then
		If $sWorkDir = "" Then $sWorkDir = StringLeft($sTarget, StringInStr($sTarget, "\", 0, -1) - 1)
		$iRet = ShellExecute($sTarget, $aInfo[2], $sWorkDir, "runas", $iShow)
		$iErr = @error
		Logfile('"' & $sTarget & " " & $aInfo[2] & '" was started via ShellExecute (UAC/runas) in folder ' & $sWorkDir & " (shortcut: " & $sLnk & ")")
	Else
		$iRet = ShellExecute($sLnk)
		$iErr = @error
		Logfile('Shortcut "' & $sLnk & '" was started')
	EndIf

	If Not $iRet Then
		Logfile("ShellExecute failed (@error " & $iErr & "): " & $sLnk, 0)
		TrayTip(_("Error"), $sLnk, 10, $TIP_ICONEXCLAMATION)
	EndIf
	Logfile("ToolTimeLaunch() end", 6)
EndFunc   ;==>ToolTimeLaunch

; Reads the "run as administrator" flag (SLDF_RUNAS_USER = bit 13 of LinkFlags at offset 0x14) from the
; header of a .lnk file ([MS-SHLLINK] 2.1). Returns True/False; @error is set if the file is no valid link.
Func ToolTimeLnkRunsAsAdmin($sLnk)
	Local $h = FileOpen($sLnk, 16)
	If $h = -1 Then Return SetError(1, 0, False)
	Local $bHead = FileRead($h, 22)
	FileClose($h)
	If BinaryLen($bHead) < 22 Then Return SetError(2, 0, False)

	Local $sHex = StringUpper(StringTrimLeft(String($bHead), 2)) ;hex string without "0x", 2 characters per byte
	If StringLeft($sHex, 8) <> "4C000000" Then Return SetError(3, 0, False) ;HeaderSize must be 0x4C
	Local $iByte = Dec(StringMid($sHex, 43, 2)) ;byte 22 (1-based) = offset 0x15 = LinkFlags bits 8-15
	Return BitAND($iByte, 0x20) <> 0
EndFunc   ;==>ToolTimeLnkRunsAsAdmin

; Sets the "run as administrator" flag in a .lnk file (used for the shortcuts created by ToolTimeInit()).
Func ToolTimeSetLnkAdminFlag($sLnk)
	Local $h = FileOpen($sLnk, 16)
	If $h = -1 Then Return False
	Local $bData = FileRead($h)
	FileClose($h)
	If BinaryLen($bData) < 22 Then Return False

	Local $sHex = StringUpper(StringTrimLeft(String($bData), 2))
	If StringLeft($sHex, 8) <> "4C000000" Then Return False
	Local $iByte = BitOR(Dec(StringMid($sHex, 43, 2)), 0x20)
	$sHex = StringLeft($sHex, 42) & Hex($iByte, 2) & StringMid($sHex, 45)

	$h = FileOpen($sLnk, 18) ;write + erase previous content + binary
	If $h = -1 Then Return False
	FileWrite($h, Binary("0x" & $sHex))
	FileClose($h)
	Return True
EndFunc   ;==>ToolTimeSetLnkAdminFlag

; ====================================================================================================
; Folder change detection: the menu is rebuilt automatically after the ToolTime folder was changed
; ====================================================================================================
Func ToolTimeStartWatch()
	ToolTimeStopWatch()
	$bToolTimeChangePending = False
	If Not FileExists($sToolTimeFolder) Then Return
	;FILE_NOTIFY_CHANGE_FILE_NAME (0x1) + DIR_NAME (0x2) + SIZE (0x8) + LAST_WRITE (0x10), including sub folders
	Local $aRet = DllCall("kernel32.dll", "handle", "FindFirstChangeNotificationW", "wstr", $sToolTimeFolder, "bool", True, "dword", 0x1B)
	If @error Or Not IsArray($aRet) Then
		Logfile("ToolTime: folder change detection not available (DllCall failed), use Settings > Reload tools", 0)
		Return
	EndIf
	If $aRet[0] = 0 Or $aRet[0] = Ptr(-1) Then
		Logfile("ToolTime: folder change detection not available (FindFirstChangeNotification failed for " & $sToolTimeFolder & "), use Settings > Reload tools", 0)
		Return
	EndIf
	$hToolTimeChange = $aRet[0]
	Logfile("ToolTime: folder change detection active", 6)
EndFunc   ;==>ToolTimeStartWatch

Func ToolTimeStopWatch()
	If $hToolTimeChange <> 0 Then
		DllCall("kernel32.dll", "bool", "FindCloseChangeNotification", "handle", $hToolTimeChange)
		$hToolTimeChange = 0
	EndIf
	$bToolTimeChangePending = False
EndFunc   ;==>ToolTimeStopWatch

; Called from the main loop. Polls the notification handle (non-blocking). The menu is rebuilt when no
; further change has been reported for 1.5 s (debounce, e.g. while many files are being copied).
Func ToolTimeCheckChanges()
	If $hToolTimeChange = 0 Then Return
	If Not $bToolTimeEnabledSetting Then Return
	If TimerDiff($hToolTimeChangePollTimer) < 400 Then Return
	$hToolTimeChangePollTimer = TimerInit()

	Local $aRet = DllCall("kernel32.dll", "dword", "WaitForSingleObject", "handle", $hToolTimeChange, "dword", 0)
	If Not @error And IsArray($aRet) And $aRet[0] = 0 Then
		DllCall("kernel32.dll", "bool", "FindNextChangeNotification", "handle", $hToolTimeChange) ;re-arm
		$hToolTimeChangeQuietTimer = TimerInit()
		$bToolTimeChangePending = True
	ElseIf $bToolTimeChangePending And TimerDiff($hToolTimeChangeQuietTimer) >= 1500 Then
		$bToolTimeChangePending = False
		Logfile("ToolTime: change in the folder detected, rebuilding the menu", 4)
		ReloadToolTime()
	EndIf
EndFunc   ;==>ToolTimeCheckChanges

; ====================================================================================================
; Problem report
; ====================================================================================================

; Registers a problem: it is logged (English), added to the report that is shown to the user (translated)
; and counted. %1 - %4 in the text are replaced by the parameters.
Func _ToolTimeWarn($sText, $s1 = "", $s2 = "", $s3 = "", $s4 = "")
	$iToolTimeWarnings += 1
	Logfile("ToolTime [WARN] " & _ToolTimeFormat($sText, $s1, $s2, $s3, $s4), 0)
	If $iToolTimeWarnings <= $iToolTimeMaxReportLines Then
		$sToolTimeReport &= "- " & _ToolTimeFormat(_($sText), $s1, $s2, $s3, $s4) & @CRLF
	ElseIf $iToolTimeWarnings = $iToolTimeMaxReportLines + 1 Then
		$sToolTimeReport &= "- ..." & @CRLF
	EndIf
EndFunc   ;==>_ToolTimeWarn

Func _ToolTimeFormat($sText, $s1, $s2, $s3, $s4)
	$sText = StringReplace($sText, "%1", $s1)
	$sText = StringReplace($sText, "%2", $s2)
	$sText = StringReplace($sText, "%3", $s3)
	$sText = StringReplace($sText, "%4", $s4)
	Return $sText
EndFunc   ;==>_ToolTimeFormat

; Shows the problem report. The tray menu is disabled while the MsgBox is open (see About).
Func ToolTimeShowReport()
	Logfile("ToolTimeShowReport() start", 6)
	Local $sText = _("Problems occurred while reading the ToolTime folder:") & @CRLF & @CRLF & _
			StringStripWS($sToolTimeReport, 2) & @CRLF & @CRLF & _
			$sToolTimeFolder & @CRLF & @CRLF & _
			StringReplace(_("The maximum number of entries per menu is %1. It can be changed in the settings file ([ToolTime] MaxEntries, 10 - 20)."), "%1", $iToolTimeMaxEntriesSetting)
	Local $oTrayMenuStates = _TrayMenuDisableAll($hMenu)
	MsgBox(48, _("ToolTime: problems found"), $sText)
	_TrayMenuRestoreDisabled($hMenu, $oTrayMenuStates)
	Logfile("ToolTimeShowReport() end", 6)
EndFunc   ;==>ToolTimeShowReport

; Shows a notification if the problem report is new (not when the menu is only rebuilt for other reasons).
Func ToolTimeNotify()
	If $iToolTimeWarnings = 0 Then
		$sToolTimeLastNotified = ""
		Return
	EndIf
	If $sToolTimeReport = $sToolTimeLastNotified Then Return
	$sToolTimeLastNotified = $sToolTimeReport
	TrayTip(_("ToolTime"), _("Problems were found while reading the ToolTime folder. Click the entry marked (!) in the menu for details."), 10, $TIP_ICONEXCLAMATION)
EndFunc   ;==>ToolTimeNotify

; ====================================================================================================
; Menu actions
; ====================================================================================================

; Opens the ToolTime folder in Explorer (creates it if it does not exist).
Func ToolTimeOpenFolder()
	Logfile("Opening the ToolTime folder: " & $sToolTimeFolder, 4)
	If Not FileExists($sToolTimeFolder) Then
		DirCreate($sToolTimeFolder)
		ToolTimeWriteInfoFile()
	EndIf
	ShellExecute($sToolTimeFolder)
EndFunc   ;==>ToolTimeOpenFolder

; Reads the ToolTime folder again: the complete tray menu is rebuilt (ToolTime is the first section of the
; menu, so it cannot be rebuilt on its own).
Func ReloadToolTime()
	Logfile("ReloadToolTime() start", 6)
	DeleteTrayMenu()
	DeleteAllhBitmaps()
	CreateTrayMenu()
	ApplyTrayMenuSettings()
	SetIconTooltip()
	Logfile("ReloadToolTime() end", 6)
EndFunc   ;==>ReloadToolTime

; ====================================================================================================
; Function: CreateTrayMenu
; Description: Creates the complete tray menu, including ToolTime (the folders and shortcuts of the
;              ToolTime folder), KeepAwake, AlwaysOnTop and the application settings.
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func CreateTrayMenu()
	Logfile("CreateTrayMenu() start", 6)
	$iTitleToolTime = TrayCreateItem(_("ToolTime")) ; Separator
	TrayItemSetState(-1, $TRAY_DISABLE)

	$hMenu = TrayItemGetHandle(0)
	Local $iToolTimeEntries = 0

	;The folders and shortcuts are only read if ToolTime is enabled; $hMenu above must still be
	;fetched unconditionally since every other section below relies on it for icon-setting
	If $bToolTimeEnabledSetting = 1 Then
		$iToolTimeEntries = ToolTimeBuildMenu()
	Else
		ToolTimeStopWatch()
	EndIf

	;If ToolTime is disabled entirely, or the folder holds no entries (and no problems to report)
	If $iToolTimeEntries = 0 And $iToolTimeReportTrayItem = 0 Then
		TrayItemDelete($iTitleToolTime)
		$iTitleToolTime = 0
	Else
		$iSepToolTime = TrayCreateItem("") ; Separator
	EndIf

	;KeepAwake
	If $bKeepAwakeEnabledSetting = 1 Then
		$iTitelKeepAwake = TrayCreateItem(_("KeepAwake")) ; Separator
		TrayItemSetState(-1, $TRAY_DISABLE)

		$iDisplaySystem = TrayCreateItem(_("Monitors and System"))
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iDisplaySystem, @ScriptFullPath, 206 - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iDisplaySystem, @ScriptDir & "\icons\GreenBox.ico", 0, $iIconsSize)
		EndIf

		$iDisplay = TrayCreateItem(_("Monitors"))
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iDisplay, @ScriptFullPath, 205 - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iDisplay, @ScriptDir & "\icons\RedBox.ico", 0, $iIconsSize)
		EndIf

		$iSystem = TrayCreateItem(_("System"))
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iSystem, @ScriptFullPath, 207 - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iSystem, @ScriptDir & "\icons\BlueBox.ico", 0, $iIconsSize)
		EndIf

		$iDeactivated = TrayCreateItem(_("Deactivated"))
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iDeactivated, @ScriptFullPath, 208 - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iDeactivated, @ScriptDir & "\icons\WhiteBox.ico", 0, $iIconsSize)
		EndIf

		$iKeepLastKeepAwakeState = TrayCreateItem(_("Save state"))
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iKeepLastKeepAwakeState, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iKeepLastKeepAwakeState, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
		EndIf
		$iSepKeepAwake = TrayCreateItem("") ; Separator
	EndIf

	;AlwaysOnTop
	If $bAlwaysOnTopEnabledSetting = 1 Then
		$iTitelAlwaysOnTop = TrayCreateItem(_("AlwaysOnTop")) ; Separator
		TrayItemSetState(-1, $TRAY_DISABLE)

		;Enable hotkey
		$iActivateAOTHotKeyTrayItem = TrayCreateItem(_("Hotkey active"))
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iActivateAOTHotKeyTrayItem, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iActivateAOTHotKeyTrayItem, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
		EndIf
		; Does not work:
		;TrayItemSetText($iActivateAOTHotKeyTrayItem, 'AlwaysOnTop Hotkey aktiv ( ' & _HotkeyToReadable($sAlwaysOnTopHotKey) & ' )')
		; Instead:
		$iMenuId_iActivateAOTHotKeyTrayItem = _GUICtrlMenu_GetItemID($hMenu, $iActivateAOTHotKeyTrayItem, False)
		_GUICtrlMenu_SetItemText($hMenu, $iMenuId_iActivateAOTHotKeyTrayItem, _("Hotkey active ( ") & HotkeyToReadable($sAlwaysOnTopHotKey) & " )", False)

		;Change hotkey
		$iSetAOTHotKeyTrayItem = TrayCreateItem(_('Change hotkey'))
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iSetAOTHotKeyTrayItem, @ScriptFullPath, $iIconnumberKeyboard - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iSetAOTHotKeyTrayItem, @ScriptDir & "\icons\Keyboard.ico", 0, $iIconsSize)
		EndIf

		;Enable or disable tooltip
		$iAlwaysOnTopShowToolTipTrayItem = TrayCreateItem(_('Show tooltip'))
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iAlwaysOnTopShowToolTipTrayItem, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iAlwaysOnTopShowToolTipTrayItem, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
		EndIf
		$iSepAlwaysOnTop = TrayCreateItem("") ; Separator
	EndIf

	;CCTrayTool
	$iTitelCCTrayTool = TrayCreateItem($sAppName) ; Separator
	TrayItemSetState(-1, $TRAY_DISABLE)

	;Settings
	$iSettings = TrayCreateMenu(_("Settings"))
	If @Compiled Then
		TrayItemSetIcon($hMenu, $iSettings, @ScriptFullPath, $iIconNumberSettings - $iIconOffset, $iIconsSize)
	Else
		TrayItemSetIcon($hMenu, $iSettings, @ScriptDir & "\icons\Settings.ico", 0, $iIconsSize)
	EndIf
	;Enable or disable ToolTime entirely
	$iToolTimeEnabledTrayItem = TrayCreateItem(_("Enable ToolTime"), $iSettings)
	If @Compiled Then
		TrayItemSetIcon($hMenu, $iToolTimeEnabledTrayItem, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
	Else
		TrayItemSetIcon($hMenu, $iToolTimeEnabledTrayItem, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
	EndIf
	;Open the ToolTime folder
	$iOpenToolTimeFolderTrayItem = TrayCreateItem(_("Open ToolTime folder"), $iSettings)
	If FileExists(@SystemDir & "\shell32.dll") Then
		TrayItemSetIcon($hMenu, $iOpenToolTimeFolderTrayItem, @SystemDir & "\shell32.dll", 4, $iIconsSize)
	ElseIf @Compiled Then
		TrayItemSetIcon($hMenu, $iOpenToolTimeFolderTrayItem, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
	Else
		TrayItemSetIcon($hMenu, $iOpenToolTimeFolderTrayItem, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
	EndIf
	;Read the ToolTime folder again
	$iReloadToolTimeTrayItem = TrayCreateItem(_("Reload tools"), $iSettings)
	If FileExists(@SystemDir & "\shell32.dll") Then
		TrayItemSetIcon($hMenu, $iReloadToolTimeTrayItem, @SystemDir & "\shell32.dll", 238, $iIconsSize)
	ElseIf @Compiled Then
		TrayItemSetIcon($hMenu, $iReloadToolTimeTrayItem, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
	Else
		TrayItemSetIcon($hMenu, $iReloadToolTimeTrayItem, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
	EndIf
	$iSepToolTimeEnabled = TrayCreateItem("", $iSettings) ; Separator

	;Enable or disable KeepAwake entirely
	$iKeepAwakeEnabledTrayItem = TrayCreateItem(_("Enable KeepAwake"), $iSettings)
	If @Compiled Then
		TrayItemSetIcon($hMenu, $iKeepAwakeEnabledTrayItem, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
	Else
		TrayItemSetIcon($hMenu, $iKeepAwakeEnabledTrayItem, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
	EndIf
	$iSepKeepAwakeEnabled = TrayCreateItem("", $iSettings) ; Separator

	;Enable or disable AlwaysOnTop entirely
	$iAlwaysOnTopEnabledTrayItem = TrayCreateItem(_("Enable AlwaysOnTop"), $iSettings)
	If @Compiled Then
		TrayItemSetIcon($hMenu, $iAlwaysOnTopEnabledTrayItem, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
	Else
		TrayItemSetIcon($hMenu, $iAlwaysOnTopEnabledTrayItem, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
	EndIf
	$iSepAlwaysOnTopEnabled = TrayCreateItem("", $iSettings) ; Separator

	;Autostart
	$iAutostart = TrayCreateItem(_("Start automatically"), $iSettings)
	If @Compiled Then
		TrayItemSetIcon($hMenu, $iAutostart, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
	Else
		TrayItemSetIcon($hMenu, $iAutostart, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
	EndIf
	$iSepAutoStart = TrayCreateItem("", $iSettings) ; Separator

	;Create log file
	$iUseLogTrayItem = TrayCreateItem(_("Create log file"), $iSettings)
	If @Compiled Then
		TrayItemSetIcon($hMenu, $iUseLogTrayItem, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
	Else
		TrayItemSetIcon($hMenu, $iUseLogTrayItem, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
	EndIf
	;Open log file
	$iOpenLogTrayItem = TrayCreateItem(_("View log file"), $iSettings)
	If FileExists(@SystemDir & "\notepad.exe") Then
		TrayItemSetIcon($hMenu, $iOpenLogTrayItem, @SystemDir & "\notepad.exe", 0, $iIconsSize)
	Else
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iOpenLogTrayItem, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iOpenLogTrayItem, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
		EndIf
	EndIf

	$iSepLogFile = TrayCreateItem("", $iSettings) ; Separator

	;Big icons
	$iUseBigIconsTrayItem = TrayCreateItem(_("Use big icons"), $iSettings)
	If @Compiled Then
		TrayItemSetIcon($hMenu, $iUseBigIconsTrayItem, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
	Else
		TrayItemSetIcon($hMenu, $iUseBigIconsTrayItem, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
	EndIf
	$iSepBigIcons = TrayCreateItem("", $iSettings) ; Separator

	;Edit settings / INI file
	$iEditINI = TrayCreateItem(_("Edit settings file"), $iSettings)
	If FileExists(@SystemDir & "\notepad.exe") Then
		TrayItemSetIcon($hMenu, $iEditINI, @SystemDir & "\notepad.exe", 0, $iIconsSize)
	Else
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iEditINI, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iEditINI, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
		EndIf
	EndIf

	;About
	$iAbout = TrayCreateItem(_("About"))
	If @Compiled Then
		TrayItemSetIcon($hMenu, $iAbout, @ScriptFullPath, $iIconNumberAbout - $iIconOffset, $iIconsSize)
	Else
		TrayItemSetIcon($hMenu, $iAbout, @ScriptDir & "\icons\About.ico", 0, $iIconsSize)
	EndIf
	$iSepAbout = TrayCreateItem("") ; Separator

	;Exit
	$iExit = TrayCreateItem(_("Exit"))
	If @Compiled Then
		TrayItemSetIcon($hMenu, $iExit, @ScriptFullPath, $iIconNumberExit - $iIconOffset, $iIconsSize)
	Else
		TrayItemSetIcon($hMenu, $iExit, @ScriptDir & "\icons\Exit.ico", 0, $iIconsSize)
	EndIf

	Logfile("CreateTrayMenu() end", 6)
EndFunc   ;==>CreateTrayMenu

; ====================================================================================================
; Function: _TrayMenuDisableAll
; Description: Recursively walks the tray popup menu (and any submenus, e.g. Settings or a tool
;              group) and disables every item, remembering each item's previous enabled/disabled
;              state so it can be restored afterwards with _TrayMenuRestoreDisabled. Used while a
;              blocking dialog (Set Hotkey, About) is open: the main TrayGetMsg() loop is not being
;              polled during that time, so a tray menu click would otherwise generate a message
;              that never gets processed instead of simply doing nothing.
; Parameters:
;   $hSubMenu    - Handle of the (sub)menu to walk; pass the global $hMenu on the initial call.
;   $oPrevStates - Scripting.Dictionary to collect the previous states into; omit on the initial
;                  call, it is created automatically and passed along on recursive calls.
; Returns: $oPrevStates, filled with one entry per menu item found (key: "<hSubMenu>_<position>").
; ====================================================================================================
Func _TrayMenuDisableAll($hSubMenu, $oPrevStates = 0)
	If Not IsObj($oPrevStates) Then $oPrevStates = ObjCreate("Scripting.Dictionary")
	Local $iCount = _GUICtrlMenu_GetItemCount($hSubMenu)
	Local $i
	For $i = 0 To $iCount - 1
		$oPrevStates.Item($hSubMenu & "_" & $i) = _GUICtrlMenu_GetItemDisabled($hSubMenu, $i)
		_GUICtrlMenu_SetItemDisabled($hSubMenu, $i, True)
		Local $hNestedMenu = _GUICtrlMenu_GetItemSubMenu($hSubMenu, $i)
		If $hNestedMenu <> 0 Then _TrayMenuDisableAll($hNestedMenu, $oPrevStates)
	Next
	Return $oPrevStates
EndFunc   ;==>_TrayMenuDisableAll

; ====================================================================================================
; Function: _TrayMenuRestoreDisabled
; Description: Counterpart to _TrayMenuDisableAll - recursively walks the tray popup menu (and any
;              submenus) again and restores each item's enabled/disabled state from $oPrevStates.
; Parameters:
;   $hSubMenu    - Handle of the (sub)menu to walk; pass the global $hMenu on the initial call.
;   $oPrevStates - Scripting.Dictionary previously returned by _TrayMenuDisableAll.
; Returns: None.
; ====================================================================================================
Func _TrayMenuRestoreDisabled($hSubMenu, $oPrevStates)
	Local $iCount = _GUICtrlMenu_GetItemCount($hSubMenu)
	Local $i
	For $i = 0 To $iCount - 1
		_GUICtrlMenu_SetItemDisabled($hSubMenu, $i, _DictGet($oPrevStates, $hSubMenu & "_" & $i))
		Local $hNestedMenu = _GUICtrlMenu_GetItemSubMenu($hSubMenu, $i)
		If $hNestedMenu <> 0 Then _TrayMenuRestoreDisabled($hNestedMenu, $oPrevStates)
	Next
EndFunc   ;==>_TrayMenuRestoreDisabled

; ====================================================================================================
; Function: OpenLog
; Description: Opens the application's current log file with the associated Windows application.
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func OpenLog()
	Logfile("OpenLog() start", 6)
	If FileExists(@SystemDir & "\notepad.exe") Then
		If FileExists($sLogFile) Then
			Logfile("Opening log file", 6)
			RunWait(@SystemDir & "\notepad.exe " & $sLogFile)
		Else
			Logfile("Log file not found: " & $sLogFile)
			MsgBox(48, _("Error"), _("Log file not found: ") & $sLogFile)
		EndIf
	Else
		Logfile("Error: notepad.exe not found: " & @SystemDir & "\notepad.exe")
		MsgBox(48, _("Error"), @SystemDir & _("\notepad.exe not found"))
	EndIf
	Logfile("OpenLog() end", 6)
EndFunc   ;==>OpenLog

; ====================================================================================================
; Function: EditINI
; Description: Opens the application's INI configuration file for editing and applies the changed settings
;              as soon as the editor is closed. The reload runs in this order:
;              1. Everything that was built from the OLD settings is taken down: tray menu, bitmaps and the
;                 AlwaysOnTop hotkey. This has to happen BEFORE LoadSettings(): DeleteTrayMenu() decides from
;                 the "Enabled" settings which menu sections exist, so they must still hold the values the
;                 items were created with. Otherwise sections that were switched off in the INI file would
;                 stay in the menu, and sections that were switched on would be "deleted" although they
;                 do not exist yet.
;              2. The INI file is read and the values that are derived from it are set (icon size,
;                 ToolTime folder, autostart entry).
;              3. The tray menu is built and the settings are applied, exactly like at program start.
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func EditINI()
	Logfile("EditINI() start", 6)
	;Hide the tray icon while the confirmation dialog and the INI editor are open: the main
	;TrayGetMsg() loop is not being polled during that time, so a tray menu click would otherwise
	;generate a message that never gets processed
	TraySetState(2)
	Local $iResult = MsgBox(36, _("Warning: Modify Configuration?"), _("Do you want to modify the extended INI file configuration ?") & @CRLF & @CRLF & _
			_("As soon as you close the Editor, ") & $sAppName & _(" will read and apply the new settings!"))
	If $iResult = 6 Then
		If FileExists(@SystemDir & "\notepad.exe") Then
			Logfile("Editing INI file", 6)
			SaveSettings()
			;SaveSettings() writes State=0 as long as "keep the last KeepAwake state" is switched off. Write the
			;live state instead, so that just opening and closing the editor does not switch KeepAwake off.
			;A state that is changed by hand in the editor is still applied after the reload.
			If $bKeepAwakeEnabledSetting = 1 And $bRestoreKeepAwakeStateSetting = 0 Then IniWrite($sIniFile, "KeepAwake", "State", $iKeepAwakeStateSetting)
			RunWait(@SystemDir & "\notepad.exe " & $sIniFile)
			Logfile("EditINI end", 6)

			;1. Take down everything that was built from the OLD settings (see the function description).
			;   The variables still describe the menu as it exists right now.
			DeleteTrayMenu()
			DeleteAllhBitmaps()
			;The old hotkey: the INI file may contain another one or switch it off, ApplyTrayMenuSettings()
			;registers the new one if it is active
			HotKeySet($sAlwaysOnTopHotKey)
			Local $bOldAutostart = $bAutostartSetting

			;2. Read the INI file and set the values that are derived from it
			LoadSettings()
			;Autostart was switched off in the INI file: ApplyTrayMenuSettings() can only add the entry
			If $bOldAutostart = 1 And $bAutostartSetting = 0 And @Compiled Then
				Logfile("Autostart was disabled in the INI file, removing autostart entry")
				RegDelete("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", $sAppName)
			EndIf
			;The icon size has to be known BEFORE the menu is created (like at program start)
			If $bUseBigIconsSetting = 1 Then
				$iIconsSize = $iBigIconsSize
			Else
				$iIconsSize = $iSmallIconsSize
			EndIf
			ToolTimeInit() ;the INI file may point to another ToolTime folder

			;3. Build the menu and apply the settings, like at program start
			CreateTrayMenu()
			ApplyTrayMenuSettings()
			SetIconTooltip()
			;CreateTrayMenu() rebuilds the tray icon from scratch, which shows it again
		Else
			MsgBox(48, _("Error"), @SystemDir & _("\notepad.exe not found"))
			;Show the tray icon again - no menu rebuild will happen in this branch
			TraySetState(1)
		EndIf
	Else
		;Show the tray icon again - the user cancelled, so no menu rebuild will happen
		TraySetState(1)
	EndIf
	Logfile("EditINI() end", 6)
EndFunc   ;==>EditINI

; ====================================================================================================
; Function: SetKeepAwakeState
; Description: Selects the given KeepAwake state, updates the Windows execution-state API
;              accordingly, and refreshes the four KeepAwake tray menu icons to reflect it.
;              Replaces the previous CheckDeactivated()/CheckDisplay()/CheckSystem()/
;              CheckDisplaySystem() functions.
; Parameters: $iState - Target KeepAwake state: 0 = deactivated, 1 = display only,
;             2 = system only, 3 = display and system.
; Returns: None.
; ====================================================================================================
Func SetKeepAwakeState($iState)
	;Defensive: the KeepAwake tray items do not exist while the feature is disabled entirely
	If Not $bKeepAwakeEnabledSetting Then Return
	If $iState < 0 Or $iState > 3 Then $iState = 0 ;defensive: keep $iState within the valid 0-3 range used below
	Logfile("SetKeepAwakeState() start" & " $iState: " & $iState, 6)
	If $iKeepAwakeStateSetting <> $iState Then
		Local $aLogMessages[4] = ["Disabling KeepAwake", "Disabling power saving (monitors)", "Disabling power saving (system)", "Disabling power saving (monitors and system)"]
		Logfile($aLogMessages[$iState], 6)
		$iKeepAwakeStateSetting = $iState

		;One entry per KeepAwake item, in state 0/1/2/3 order, with its "inactive" and "active" icon
		Local $aItems[4] = [$iDeactivated, $iDisplay, $iSystem, $iDisplaySystem]
		Local $aInactiveIconNumber[4] = [208, 205, 207, 206]
		Local $aActiveIconNumber[4] = [212, 209, 211, 210]
		Local $aInactiveIconFile[4] = ["WhiteBox.ico", "RedBox.ico", "BlueBox.ico", "GreenBox.ico"]
		Local $aActiveIconFile[4] = ["WhiteBoxChecked.ico", "RedBoxChecked.ico", "BlueBoxChecked.ico", "GreenBoxChecked.ico"]

		Local $i
		For $i = 0 To 3
			If $i = $iState Then
				If @Compiled Then
					TrayItemSetIcon($hMenu, $aItems[$i], @ScriptFullPath, $aActiveIconNumber[$i] - $iIconOffset, $iIconsSize)
				Else
					TrayItemSetIcon($hMenu, $aItems[$i], @ScriptDir & "\icons\" & $aActiveIconFile[$i], 0, $iIconsSize)
				EndIf
			Else
				If @Compiled Then
					TrayItemSetIcon($hMenu, $aItems[$i], @ScriptFullPath, $aInactiveIconNumber[$i] - $iIconOffset, $iIconsSize)
				Else
					TrayItemSetIcon($hMenu, $aItems[$i], @ScriptDir & "\icons\" & $aInactiveIconFile[$i], 0, $iIconsSize)
				EndIf
			EndIf
		Next

		;Windows execution-state flags per KeepAwake state
		Local $iExecutionState = $ES_CONTINUOUS
		If $iState = 1 Then
			$iExecutionState = BitOR($ES_CONTINUOUS, $ES_DISPLAY_REQUIRED)
		ElseIf $iState = 2 Then
			$iExecutionState = BitOR($ES_CONTINUOUS, $ES_SYSTEM_REQUIRED)
		ElseIf $iState = 3 Then
			$iExecutionState = BitOR($ES_CONTINUOUS, $ES_SYSTEM_REQUIRED, $ES_DISPLAY_REQUIRED)
		EndIf
		If _WinAPI_SetThreadExecutionState($iExecutionState) = 0 Then Logfile("Error: _WinAPI_SetThreadExecutionState() could not be executed successfully")
	EndIf
	Logfile("SetKeepAwakeState() end", 6)
EndFunc   ;==>SetKeepAwakeState

; ====================================================================================================
; Function: CheckAOTShowToolTipTrayItem
; Description: Toggles and updates the tray menu setting that controls whether the
;              AlwaysOnTop tooltip is displayed.
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func CheckAOTShowToolTipTrayItem()
	;Defensive: this tray item does not exist while AlwaysOnTop is disabled entirely
	If Not $bAlwaysOnTopEnabledSetting Then Return
	Logfile("CheckAOTShowToolTipTrayItem() start", 6)
	If Not $bAlwaysOnTopShowToolTip Then
		Logfile("Enabling AlwaysOnTopShowToolTip")
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iAlwaysOnTopShowToolTipTrayItem, @ScriptFullPath, $iIconnumberGreenCheck - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iAlwaysOnTopShowToolTipTrayItem, @ScriptDir & "\icons\GreenCheck.ico", 0, $iIconsSize)
		EndIf
		$bAlwaysOnTopShowToolTip = 1
	Else
		Logfile("Disabling AlwaysOnTopShowToolTip", 6)
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iAlwaysOnTopShowToolTipTrayItem, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iAlwaysOnTopShowToolTipTrayItem, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
		EndIf
		$bAlwaysOnTopShowToolTip = 0
	EndIf
	Logfile("CheckAOTShowToolTipTrayItem() end", 6)
EndFunc   ;==>CheckAOTShowToolTipTrayItem

; ====================================================================================================
; Function: CheckAOTTrayItem
; Description: Toggles and updates the tray menu setting that enables or disables the
;              AlwaysOnTop hotkey.
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func CheckAOTTrayItem()
	;Defensive: this tray item does not exist while AlwaysOnTop is disabled entirely
	If Not $bAlwaysOnTopEnabledSetting Then Return
	Logfile("CheckAOTTrayItem() start", 6)
	If Not $bActivateAlwaysOnTopHotKey Then
		Logfile("Enabling AlwaysOnTop hotkey")
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iActivateAOTHotKeyTrayItem, @ScriptFullPath, $iIconnumberGreenCheck - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iActivateAOTHotKeyTrayItem, @ScriptDir & "\icons\GreenCheck.ico", 0, $iIconsSize)
		EndIf
		$bActivateAlwaysOnTopHotKey = 1
		HotKeySet($sAlwaysOnTopHotKey, "ToggleAlwaysOnTop")
	Else
		Logfile("Disabling AlwaysOnTop hotkey", 6)
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iActivateAOTHotKeyTrayItem, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iActivateAOTHotKeyTrayItem, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
		EndIf
		$bActivateAlwaysOnTopHotKey = 0
		HotKeySet($sAlwaysOnTopHotKey)
	EndIf
	Logfile("CheckAOTTrayItem() end", 6)
EndFunc   ;==>CheckAOTTrayItem

; ====================================================================================================
; Function: CheckUseBigIcons
; Description: Toggles the use of large tray menu icons and updates the menu icons and settings.
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func CheckUseBigIcons()
	Logfile("CheckUseBigIcons() start", 6)
	If Not $bUseBigIconsSetting Then
		Logfile("Enabling big icons")
		$bUseBigIconsSetting = 1
		$iIconsSize = $iBigIconsSize
		SaveSettings()
		DeleteTrayMenu()
		DeleteAllhBitmaps()
		CreateTrayMenu()
		ApplyTrayMenuSettings()
		SetIconTooltip()
		Logfile("CheckUseBigIcons end", 6)
	Else
		Logfile("Disabling big icons", 6)
		$bUseBigIconsSetting = 0
		$iIconsSize = $iSmallIconsSize
		SaveSettings()
		DeleteTrayMenu()
		DeleteAllhBitmaps()
		CreateTrayMenu()
		ApplyTrayMenuSettings()
		SetIconTooltip()
		Logfile("CheckUseBigIcons() end", 6)
	EndIf
EndFunc   ;==>CheckUseBigIcons

; ====================================================================================================
; Function: CheckToolTimeEnabled
; Description: Toggles the ToolTime feature (tool groups and tools) as a whole on or off. When
;              switched off, its tray menu items are removed regardless of what is configured in the
;              INI file; when switched back on, the configured tool groups and tools reappear. This
;              changes which tray items exist, so - like CheckKeepAwakeEnabled() - it rebuilds the
;              whole tray menu, deleting it BEFORE the setting is flipped so DeleteTrayMenu() still
;              sees the state the items were actually created with.
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func CheckToolTimeEnabled()
	Logfile("CheckToolTimeEnabled() start", 6)
	If Not $bToolTimeEnabledSetting Then
		Logfile("Enabling ToolTime")
		DeleteTrayMenu()
		DeleteAllhBitmaps()
		$bToolTimeEnabledSetting = 1
		SaveSettings()
		CreateTrayMenu()
		ApplyTrayMenuSettings()
		SetIconTooltip()
		Logfile("CheckToolTimeEnabled() end", 6)
	Else
		Logfile("Disabling ToolTime", 6)
		DeleteTrayMenu()
		DeleteAllhBitmaps()
		$bToolTimeEnabledSetting = 0
		SaveSettings()
		CreateTrayMenu()
		ApplyTrayMenuSettings()
		SetIconTooltip()
		Logfile("CheckToolTimeEnabled() end", 6)
	EndIf
EndFunc   ;==>CheckToolTimeEnabled

; ====================================================================================================
; Function: CheckKeepAwakeEnabled
; Description: Toggles the KeepAwake feature as a whole on or off. When switched off, its tray menu
;              items are removed and normal Windows power management resumes; when switched back on,
;              the items reappear and the previously configured KeepAwake state (see "Save state") is
;              re-applied. This changes which tray items exist, so - like CheckUseBigIcons() - it
;              rebuilds the whole tray menu. Unlike CheckUseBigIcons(), the menu is deleted BEFORE the
;              setting is flipped, so DeleteTrayMenu() still sees the state the items were actually
;              created with.
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func CheckKeepAwakeEnabled()
	Logfile("CheckKeepAwakeEnabled() start", 6)
	If Not $bKeepAwakeEnabledSetting Then
		Logfile("Enabling KeepAwake")
		DeleteTrayMenu()
		DeleteAllhBitmaps()
		$bKeepAwakeEnabledSetting = 1
		SaveSettings()
		CreateTrayMenu()
		ApplyTrayMenuSettings()
		SetIconTooltip()
		Logfile("CheckKeepAwakeEnabled() end", 6)
	Else
		Logfile("Disabling KeepAwake", 6)
		DeleteTrayMenu()
		DeleteAllhBitmaps()
		$bKeepAwakeEnabledSetting = 0
		SaveSettings()
		CreateTrayMenu()
		ApplyTrayMenuSettings()
		SetIconTooltip()
		Logfile("CheckKeepAwakeEnabled() end", 6)
	EndIf
EndFunc   ;==>CheckKeepAwakeEnabled

; ====================================================================================================
; Function: CheckAlwaysOnTopEnabled
; Description: Toggles the AlwaysOnTop feature as a whole on or off. When switched off, its tray menu
;              items are removed and the hotkey is unregistered (via ApplyTrayMenuSettings()); when
;              switched back on, the items reappear and the hotkey is re-registered if the "Hotkey
;              active" setting calls for it. This changes which tray items exist, so - like
;              CheckKeepAwakeEnabled() - it rebuilds the whole tray menu, deleting it BEFORE the
;              setting is flipped so DeleteTrayMenu() still sees the state the items were actually
;              created with.
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func CheckAlwaysOnTopEnabled()
	Logfile("CheckAlwaysOnTopEnabled() start", 6)
	If Not $bAlwaysOnTopEnabledSetting Then
		Logfile("Enabling AlwaysOnTop")
		DeleteTrayMenu()
		DeleteAllhBitmaps()
		$bAlwaysOnTopEnabledSetting = 1
		SaveSettings()
		CreateTrayMenu()
		ApplyTrayMenuSettings()
		SetIconTooltip()
		Logfile("CheckAlwaysOnTopEnabled() end", 6)
	Else
		Logfile("Disabling AlwaysOnTop", 6)
		DeleteTrayMenu()
		DeleteAllhBitmaps()
		$bAlwaysOnTopEnabledSetting = 0
		SaveSettings()
		CreateTrayMenu()
		ApplyTrayMenuSettings()
		SetIconTooltip()
		Logfile("CheckAlwaysOnTopEnabled() end", 6)
	EndIf
EndFunc   ;==>CheckAlwaysOnTopEnabled

; ====================================================================================================
; Function: CheckUseLogTrayItem
; Description: Toggles logging through the tray menu and updates the corresponding menu state.
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func CheckUseLogTrayItem()
	Logfile("CheckUseLogTrayItem() start", 6)
	If Not $bUseLogSetting Then
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iUseLogTrayItem, @ScriptFullPath, $iIconnumberGreenCheck - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iUseLogTrayItem, @ScriptDir & "\icons\GreenCheck.ico", 0, $iIconsSize)
		EndIf
		$bUseLogSetting = 1
		Logfile("Enabling log file")
	Else
		Logfile("Disabling log file", 6)
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iUseLogTrayItem, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iUseLogTrayItem, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
		EndIf
		$bUseLogSetting = 0
	EndIf
	Logfile("CheckUseLogTrayItem() end", 6)
EndFunc   ;==>CheckUseLogTrayItem

; ====================================================================================================
; Function: CheckKeepLastKeepAwakeState
; Description: Toggles whether the current KeepAwake state is saved and restored on startup.
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func CheckKeepLastKeepAwakeState()
	Logfile("CheckKeepLastKeepAwakeState() start", 6)
	If Not $bRestoreKeepAwakeStateSetting Then
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iKeepLastKeepAwakeState, @ScriptFullPath, $iIconnumberGreenCheck - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iKeepLastKeepAwakeState, @ScriptDir & "\icons\GreenCheck.ico", 0, $iIconsSize)
		EndIf
		Logfile("Enabling storage of the last KeepAwake state")
		$bRestoreKeepAwakeStateSetting = 1
	Else
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iKeepLastKeepAwakeState, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iKeepLastKeepAwakeState, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
		EndIf
		Logfile("Disabling storage of the last KeepAwake state", 6)
		$bRestoreKeepAwakeStateSetting = 0
	EndIf
	Logfile("CheckKeepLastKeepAwakeState() end", 6)
EndFunc   ;==>CheckKeepLastKeepAwakeState

; ====================================================================================================
; Function: CheckAutostart
; Description: Toggles the application's Windows startup configuration and updates the tray menu.
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func CheckAutostart()
	Logfile("CheckAutostart() start", 6)
	If Not $bAutostartSetting Then
		Logfile("Enabling autostart")
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iAutostart, @ScriptFullPath, $iIconnumberGreenCheck - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iAutostart, @ScriptDir & "\icons\GreenCheck.ico", 0, $iIconsSize)
		EndIf
		$bAutostartSetting = 1
		If @Compiled Then
			Logfile("Setting autostart entry")
			RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", $sAppName, "REG_SZ", '"' & @ScriptFullPath & '"')
		Else
			Logfile("Script is not compiled, therefore the autostart entry cannot be used")
		EndIf
	Else
		Logfile("Disabling autostart", 6)
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iAutostart, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iAutostart, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
		EndIf
		$bAutostartSetting = 0
		If @Compiled Then
			Logfile("Removing autostart entry")
			RegDelete("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", $sAppName)
		Else
			Logfile("Script is not compiled, therefore the autostart entry cannot be used")
		EndIf
	EndIf
	Logfile("CheckAutostart() end", 6)
EndFunc   ;==>CheckAutostart

; ====================================================================================================
; Function: SetIconTooltip
; Description: Determines the current KeepAwake state and updates the tray icon and tooltip
;              to represent the active mode.
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func SetIconTooltip()
	Logfile("SetIconTooltip() start", 6)
	Local $sToolTip, $sIconFile
	If Not $bKeepAwakeEnabledSetting Then
		;KeepAwake is disabled entirely - show the same "deactivated" state as $iKeepAwakeStateSetting = 0,
		;regardless of which state is remembered internally for when it gets re-enabled
		$sToolTip = _("KeepAwake deactivated")
		If @Compiled Then
			$sIconFile = 201
		Else
			$sIconFile = @ScriptDir & "\icons\TrayWhite.ico"
		EndIf
	ElseIf $iKeepAwakeStateSetting = 0 Then
		$sToolTip = _("KeepAwake deactivated")
		If @Compiled Then
			$sIconFile = 201
		Else
			$sIconFile = @ScriptDir & "\icons\TrayWhite.ico"
		EndIf
	ElseIf $iKeepAwakeStateSetting = 3 Then
		$sToolTip = _("KeepAwake Monitors and System")
		If @Compiled Then
			$sIconFile = 203
		Else
			$sIconFile = @ScriptDir & "\icons\TrayGreen.ico"
		EndIf
	ElseIf $iKeepAwakeStateSetting = 1 Then
		$sToolTip = _("KeepAwake Monitors")
		If @Compiled Then
			$sIconFile = 202
		Else
			$sIconFile = @ScriptDir & "\icons\TrayRed.ico"
		EndIf
	ElseIf $iKeepAwakeStateSetting = 2 Then
		$sToolTip = _("KeepAwake System")
		If @Compiled Then
			$sIconFile = 204
		Else
			$sIconFile = @ScriptDir & "\icons\TrayBlue.ico"
		EndIf
	Else
		If @Compiled Then
			$sIconFile = 201
		Else
			$sIconFile = @ScriptFullPath
		EndIf
		$sToolTip = $sAppName
	EndIf

	Logfile("Setting tooltip: " & $sToolTip)
	TraySetToolTip($sToolTip)

	If @Compiled Then
		Logfile("Setting tray icon from script EXE: " & $sIconFile)
		TraySetIcon(@ScriptFullPath, $sIconFile)
	Else
		If FileExists($sIconFile) Then
			Logfile("Setting tray icon from icon file: " & $sIconFile)
			TraySetIcon($sIconFile, 1)
		Else
			Logfile('Setting tray icon to "Default" because icon file does not exist: ' & $sIconFile)
			TraySetIcon()
		EndIf
	EndIf

	;Every rebuild of the tray menu ends here: tell the user once if reading the ToolTime folder
	;caused problems (no repeated notifications as long as the report stays the same)
	ToolTimeNotify()
	Logfile("SetIconTooltip() end", 6)
EndFunc   ;==>SetIconTooltip

; ====================================================================================================
; Function: LoadSettings
; Description: Loads the application settings (including the ToolTime settings) and the AlwaysOnTop
;              configuration from the INI file and stores them in the corresponding global variables.
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func LoadSettings()
	Local $sUseLogValue
	Logfile("LoadSettings() start", 6)
	;Log file: only the value 1 switches it on. A missing key, an empty value and 0 switch it off. Anything
	;else (another number or text) is invalid and also switches it off.
	;Logfile() only writes to the file while $bUseLogSetting = 1. Therefore the messages that announce
	;"off" are written BEFORE the setting is switched off: a reload via EditINI() can still log them, at
	;program start the log file is still off here and they only reach the console of an uncompiled script.
	$sUseLogValue = StringStripWS(IniRead($sIniFile, "Main", "UseLog", ""), 3)
	If $sUseLogValue = "1" Then
		$bUseLogSetting = 1
		Logfile("Log file enabled")
	ElseIf $sUseLogValue = "" Or $sUseLogValue = "0" Then
		Logfile("Log file disabled")
		$bUseLogSetting = 0
	Else
		Logfile("Invalid value for UseLog in the INI file, using 0 (log file disabled)")
		$bUseLogSetting = 0
	EndIf

	;KeepAwake
	$bKeepAwakeEnabledSetting = Number(IniRead($sIniFile, "KeepAwake", "Enabled", 1))
	If $bKeepAwakeEnabledSetting <> 0 And $bKeepAwakeEnabledSetting <> 1 Then $bKeepAwakeEnabledSetting = 1

	$bRestoreKeepAwakeStateSetting = Number(IniRead($sIniFile, "KeepAwake", "KeepState", 1))
	If $bRestoreKeepAwakeStateSetting <> 0 And $bRestoreKeepAwakeStateSetting <> 1 Then $bRestoreKeepAwakeStateSetting = 1

	$iKeepAwakeStateSetting = Number(IniRead($sIniFile, "KeepAwake", "State", 0))
	If $iKeepAwakeStateSetting <> 0 And $iKeepAwakeStateSetting <> 1 And $iKeepAwakeStateSetting <> 2 And $iKeepAwakeStateSetting <> 3 Then $iKeepAwakeStateSetting = 0

	;Autostart
	$bAutostartSetting = Number(IniRead($sIniFile, "Main", "Autostart", 0))
	If $bAutostartSetting <> 0 And $bAutostartSetting <> 1 Then $bAutostartSetting = 0

	;Big icons
	$bUseBigIconsSetting = Number(IniRead($sIniFile, "Main", "UseBigIcons", 0))
	If $bUseBigIconsSetting <> 0 And $bUseBigIconsSetting <> 1 Then $bUseBigIconsSetting = 0

	;ToolTime
	$bToolTimeEnabledSetting = Number(IniRead($sIniFile, "ToolTime", "Enabled", 1))
	If $bToolTimeEnabledSetting <> 0 And $bToolTimeEnabledSetting <> 1 Then $bToolTimeEnabledSetting = 1

	;Maximum number of entries per ToolTime menu (10 - 20)
	$iToolTimeMaxEntriesSetting = Int(Number(IniRead($sIniFile, "ToolTime", "MaxEntries", $iToolTimeMaxEntriesDefault)))
	If $iToolTimeMaxEntriesSetting = 0 Then
		$iToolTimeMaxEntriesSetting = $iToolTimeMaxEntriesDefault ;missing or not a number
	ElseIf $iToolTimeMaxEntriesSetting < $iToolTimeMaxEntriesMin Then
		Logfile("ToolTime MaxEntries is too small (" & $iToolTimeMaxEntriesSetting & "), using " & $iToolTimeMaxEntriesMin)
		$iToolTimeMaxEntriesSetting = $iToolTimeMaxEntriesMin
	ElseIf $iToolTimeMaxEntriesSetting > $iToolTimeMaxEntriesMax Then
		Logfile("ToolTime MaxEntries is too large (" & $iToolTimeMaxEntriesSetting & "), using " & $iToolTimeMaxEntriesMax)
		$iToolTimeMaxEntriesSetting = $iToolTimeMaxEntriesMax
	EndIf

	;ToolTime folder (empty = default folder)
	$sToolTimeFolderSetting = StringStripWS(StringReplace(IniRead($sIniFile, "ToolTime", "Folder", ""), '"', ""), 3)
	If $sToolTimeFolderSetting = "" Then
		$sToolTimeFolder = $sAppDataDir & "\ToolTime"
	Else
		$sToolTimeFolder = ExpandEnvVars($sToolTimeFolderSetting)
		While StringLen($sToolTimeFolder) > 3 And StringRight($sToolTimeFolder, 1) = "\"
			$sToolTimeFolder = StringTrimRight($sToolTimeFolder, 1)
		WEnd
	EndIf

	;AlwaysOnTop
	$bAlwaysOnTopEnabledSetting = Number(IniRead($sIniFile, "AlwaysOnTop", "Enabled", 1))
	If $bAlwaysOnTopEnabledSetting <> 0 And $bAlwaysOnTopEnabledSetting <> 1 Then $bAlwaysOnTopEnabledSetting = 1
	$bActivateAlwaysOnTopHotKey = Number(IniRead($sIniFile, "AlwaysOnTop", "Active", 1))
	If $bActivateAlwaysOnTopHotKey <> 0 And $bActivateAlwaysOnTopHotKey <> 1 Then $bActivateAlwaysOnTopHotKey = 1
	$sAlwaysOnTopHotKey = StringStripWS(IniRead($sIniFile, "AlwaysOnTop", "HotKey", "+!t"), 8)
	If StringLen($sAlwaysOnTopHotKey) < 1 Or StringLen($sAlwaysOnTopHotKey) > 9 Then $sAlwaysOnTopHotKey = "+!t"
	$bAlwaysOnTopShowToolTip = Number(IniRead($sIniFile, "AlwaysOnTop", "ShowToolTip", "1"))
	If $bAlwaysOnTopShowToolTip <> 0 And $bAlwaysOnTopShowToolTip <> 1 Then $bAlwaysOnTopShowToolTip = 1

	Logfile("LoadSettings() end", 6)
EndFunc   ;==>LoadSettings

; ====================================================================================================
; Function: SaveSettings
; Description: Saves the current KeepAwake, autostart, icon, logging, and AlwaysOnTop settings
;              to the application's INI file.
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func SaveSettings()
	Logfile("SaveSettings() start", 6)
	;ToolTime
	IniWrite($sIniFile, "ToolTime", "Enabled", $bToolTimeEnabledSetting)
	IniWrite($sIniFile, "ToolTime", "MaxEntries", $iToolTimeMaxEntriesSetting)
	IniWrite($sIniFile, "ToolTime", "Folder", $sToolTimeFolderSetting)

	;KeepAwake
	IniWrite($sIniFile, "KeepAwake", "Enabled", $bKeepAwakeEnabledSetting)
	;KeepAwake state
	If $bRestoreKeepAwakeStateSetting Then
		IniWrite($sIniFile, "KeepAwake", "KeepState", 1)
		IniWrite($sIniFile, "KeepAwake", "State", $iKeepAwakeStateSetting)
	Else
		IniWrite($sIniFile, "KeepAwake", "KeepState", 0)
		IniWrite($sIniFile, "KeepAwake", "State", 0)
	EndIf

	;Autostart
	IniWrite($sIniFile, "Main", "Autostart", $bAutostartSetting)

	;Big icons
	IniWrite($sIniFile, "Main", "UseBigIcons", $bUseBigIconsSetting)

	;Use log
	IniWrite($sIniFile, "Main", "UseLog", $bUseLogSetting)

	;AlwaysOnTop
	IniWrite($sIniFile, "AlwaysOnTop", "Enabled", $bAlwaysOnTopEnabledSetting)
	IniWrite($sIniFile, "AlwaysOnTop", "Active", $bActivateAlwaysOnTopHotKey)
	IniWrite($sIniFile, "AlwaysOnTop", "HotKey", $sAlwaysOnTopHotKey)

	IniWrite($sIniFile, "AlwaysOnTop", "ShowToolTip", $bAlwaysOnTopShowToolTip)

	Logfile("SaveSettings() end", 6)
EndFunc   ;==>SaveSettings

; ====================================================================================================
; Function: GetScriptVersion
; Description: Returns the version of the compiled AutoIt executable, or a debug marker when
;              the script is not compiled.
; Parameters: None.
; Returns: The executable version string, "0.0" on version lookup failure, or
;          "uncompiled (Debug)" when running the source script.
; ====================================================================================================
Func GetScriptVersion()
	If @Compiled Then
		Local $sVersion = FileGetVersion(@AutoItExe)
		If @error Then
			Return "0.0" ;Error
		Else
			Return $sVersion
		EndIf
	Else
		Return _("uncompiled (Debug)") ;Not compiled
	EndIf
EndFunc   ;==>GetScriptVersion

; ====================================================================================================
; Function: Logfile
; Description: Writes a timestamped message to the configured log file when logging is enabled
;              and the message level meets the configured threshold. In debug mode it also writes
;              the message to the console.
; Parameters:
;   $slogtext       - Text to write to the log.
;   $iLevel         - Log level from 0 to 9; invalid values are normalized to 0.
;   $scustomlogfile - Log file path; defaults to the global log file path.
; Returns: None. If the log file cannot be opened, logging is disabled for the rest of the session.
; ====================================================================================================
Func Logfile($slogtext, $iLevel = 0, $scustomlogfile = $sLogFile)
	If $scustomlogfile <> "" Then
		If $iLevel < 0 Or $iLevel > 9 Then $iLevel = 0
		If $iLogLevel >= $iLevel Then ;I want to see everything with a level at least as high as $iLogLevel
			Local $slogline = @MDAY & "." & @MON & "." & @YEAR & "-" & @HOUR & ":" & @MIN & ":" & @SEC & ":" & @MSEC & ": " & $slogtext
			If $bUseLogSetting = 1 Then
				Local $hfile = FileOpen($scustomlogfile, 129) ;Append as UTF-8
				If $hfile = -1 Then
					$bUseLogSetting = 0
					MsgBox(0, _("Error"), _("LogFile could not be written to. Please check if ") & $sAppName & _(" has write permission for the file ") & $scustomlogfile & _(", or disable the LogFile in the INI Settings. Logging has been disabled; ") & $sAppName & _(" will continue running."))
				Else
					FileWriteLine($hfile, $slogline)
					FileClose($hfile)
				EndIf
			EndIf
			If Not @Compiled Then ConsoleWrite($slogline & @CRLF)
		EndIf
	EndIf
EndFunc   ;==>Logfile

; ====================================================================================================
; Function: _ComErrorHandler
; Description: Registered via ObjEvent("AutoIt.Error", ...) so that a COM error raised by one of the
;              Scripting.Dictionary objects (translation tables, bitmap-handle storage) is logged
;              instead of silently terminating the script.
; Parameters:
;   $oError - COM error object supplied automatically by AutoIt.
; Returns: None.
; ====================================================================================================
Func _ComErrorHandler($oError)
	Logfile("COM Error: " & $oError.description & " (0x" & Hex($oError.number, 8) & ") in " & $oError.scriptline, 3)
EndFunc   ;==>_ComErrorHandler

; ====================================================================================================
; Function: _DictGet
; Description: Safely reads a value from a Scripting.Dictionary COM object by key. Reading the
;              .Item property directly for a key that does not exist would silently create that
;              key with an empty value, so existence is checked first, mirroring how a missing
;              key behaves when reading an AutoIt Map.
; Parameters:
;   $oDict - Scripting.Dictionary COM object to read from.
;   $vKey  - Key to look up.
; Returns: The stored value if the key exists; otherwise an empty string with @error set to 1.
; ====================================================================================================
Func _DictGet($oDict, $vKey)
	If $oDict.Exists($vKey) Then
		Return $oDict.Item($vKey)
	EndIf
	Return SetError(1, 0, "")
EndFunc   ;==>_DictGet

; ====================================================================================================
; Function: ExpandEnvVars
; Description: Replaces Windows-style environment variable references such as %TEMP% in a string
;              with their current environment values.
; Parameters:
;   $sValue - Input string containing zero or more %VARIABLE% references.
; Returns: The string with environment variables expanded.
; ====================================================================================================
Func ExpandEnvVars($sValue)
	If StringStripWS($sValue, 8) = "" Then Return ""

	Local $aMatches = StringRegExp($sValue, '%([^%]+)%', 3)
	If @error Then Return $sValue

	Local $sResult = $sValue
	Local $i
	For $i = 0 To UBound($aMatches) - 1
		Local $sVarName = $aMatches[$i]
		Local $sEnv = EnvGet($sVarName)
		If $sEnv <> "" Then
			$sResult = StringReplace($sResult, "%" & $sVarName & "%", $sEnv)
		EndIf
	Next
	Return $sResult
EndFunc   ;==>ExpandEnvVars

; ====================================================================================================
; Function: TrayItemSetIcon
; Description: Extracts an icon from an icon file, converts it to a 32-bit bitmap with alpha,
;              assigns it to a tray menu item, and releases any previously stored bitmap for that item.
; Parameters:
;   $hMenu      - Handle of the tray menu.
;   $iMenuId    - Menu item ID that receives the bitmap.
;   $sIconFile  - Path to the file containing the icon.
;   $iIconIndex - Zero-based icon index to extract.
;   $iIconSize  - Width and height of the icon in pixels.
; Returns: 1 on success; 0 with @error set to 1 or 2 if icon extraction or bitmap creation fails.
;
; Known Issues:
;	As soon as a bitmap is assigned to an AutoIt tray item via _GUICtrlMenu_SetItemBmp(),
;	TrayItemGetText() and TrayItemSetText() no longer work reliably for that item
;	This can be worked around using the following construction:
;	$iCalcMenuId = _GUICtrlMenu_GetItemID($hMenu, $idCalc, False)
;	TrayItemSetIcon($hMenu, $iCalcMenuId, @SystemDir & "\calc.exe", 0)  or alternatively TrayItemSetIcon($hMenu, $idCalc, @SystemDir & "\calc.exe", 0)
;	_GUICtrlMenu_SetItemText($hMenu, $iCalcMenuId, "Test", False)
; ====================================================================================================
Func TrayItemSetIcon($hMenu, $iMenuId, $sIconFile, $iIconIndex = 0, $iIconSize = 16)
	Local $hIcon = _WinAPI_ShellExtractIcon($sIconFile, $iIconIndex, $iIconSize, $iIconSize)
	If @error Or $hIcon = 0 Then
		Logfile("Error: Icon #" & $iIconIndex & " from icon file " & $sIconFile & " could not be extracted")
		Return SetError(1, 0, 0)
	EndIf

	Local $hBitmap = _WinAPI_Create32BitHBITMAP($hIcon, True)
	If @error Or $hBitmap = 0 Then
		Logfile("Error: Bitmap could not be created")
		_WinAPI_DestroyIcon($hIcon)
		Return SetError(2, 0, 0)
	EndIf
	_WinAPI_DestroyIcon($hIcon)

	;we hand over the reference to $hBitmap and BitmapPremultiplyAlpha changes the content adressed by $hBitmap
	If Not BitmapPremultiplyAlpha($hBitmap, $iIconSize, $iIconSize) Then
		Logfile("Error: Premultiply failed, GetLastError=" & _WinAPI_GetLastError())
		; Do not abort: use the bitmap anyway
	EndIf

	_GUICtrlMenu_SetItemBmp($hMenu, $iMenuId, $hBitmap, False)
	Logfile("$iMenuId: " & $iMenuId, 6)
	Logfile("$sIconFile and $iIconIndex: " & $sIconFile & ":" & $iIconIndex, 6)
	If mhBitMapGetValue($iMenuId) <> "" Then
		Local $bResult = _WinAPI_DeleteObject(mhBitMapGetValue($iMenuId))
		If $bResult Then
			Logfile("Old $hBitmap successfully deleted", 6)
		Else
			Logfile("Error deleting the old $hBitmap $iMenuId: " & $iMenuId & " mhBitMapGetValue($iMenuId): " & mhBitMapGetValue($iMenuId), 6)
		EndIf
	Else
		Logfile("No $hBitmap stored for " & $iMenuId & ", therefore none can be deleted", 6)
	EndIf
	;save in dictionary to delete later when no longer needed
	$mhBitmapStorage.Item($iMenuId) = $hBitmap
	Return 1
EndFunc   ;==>TrayItemSetIcon

; ====================================================================================================
; Function: BitmapPremultiplyAlpha
; Description: Reads a 32-bit bitmap, premultiplies its RGB channels by the alpha channel,
;              and writes the adjusted pixel data back to the bitmap.
; Parameters:
;   $hBitmap - Handle of the 32-bit bitmap to process.
;   $iW      - Bitmap width in pixels.
;   $iH      - Bitmap height in pixels.
; Returns: True if the bitmap was processed successfully; otherwise False.
; ====================================================================================================
Func BitmapPremultiplyAlpha($hBitmap, $iW, $iH)
	; BITMAPV5HEADER with BI_BITFIELDS -> alpha channel is preserved
	Local $tBIV5 = DllStructCreate($tagBITMAPV5HEADER)
	DllStructSetData($tBIV5, 'bV5Size', DllStructGetSize($tBIV5))
	DllStructSetData($tBIV5, 'bV5Width', $iW)
	DllStructSetData($tBIV5, 'bV5Height', $iH)       ; positive = bottom-up (more reliable with GetDIBits)
	DllStructSetData($tBIV5, 'bV5Planes', 1)
	DllStructSetData($tBIV5, 'bV5BitCount', 32)
	DllStructSetData($tBIV5, 'bV5Compression', $BI_BITFIELDS)
	DllStructSetData($tBIV5, 'bV5RedMask', 0x00FF0000)
	DllStructSetData($tBIV5, 'bV5GreenMask', 0x0000FF00)
	DllStructSetData($tBIV5, 'bV5BlueMask', 0x000000FF)
	DllStructSetData($tBIV5, 'bV5AlphaMask', 0xFF000000)

	Local $tPixels = DllStructCreate("byte[" & ($iW * $iH * 4) & "]")
	Local $hDC = _WinAPI_GetDC(0)

	Local $aRet = DllCall('gdi32.dll', 'int', 'GetDIBits', 'handle', $hDC, 'handle', $hBitmap, 'uint', 0, 'uint', $iH, 'struct*', $tPixels, 'struct*', $tBIV5, 'uint', 0)
	If @error Or Not $aRet[0] Then
		_WinAPI_ReleaseDC(0, $hDC)
		Return False
	EndIf

	; BGRA: alpha is located at byte offset +3
	Local $iSize = $iW * $iH * 4
	Local $i
	For $i = 1 To $iSize Step 4
		Local $iA = DllStructGetData($tPixels, 1, $i + 3)
		If $iA < 255 Then
			DllStructSetData($tPixels, 1, Int(DllStructGetData($tPixels, 1, $i) * $iA / 255), $i)
			DllStructSetData($tPixels, 1, Int(DllStructGetData($tPixels, 1, $i + 1) * $iA / 255), $i + 1)
			DllStructSetData($tPixels, 1, Int(DllStructGetData($tPixels, 1, $i + 2) * $iA / 255), $i + 2)
		EndIf
	Next

	Local $aSetRet = DllCall('gdi32.dll', 'int', 'SetDIBits', 'handle', $hDC, 'handle', $hBitmap, 'uint', 0, 'uint', $iH, 'struct*', $tPixels, 'struct*', $tBIV5, 'uint', 0)
	_WinAPI_ReleaseDC(0, $hDC)
	If @error Or Not $aSetRet[0] Then Return False

	Return True
EndFunc   ;==>BitmapPremultiplyAlpha

; ====================================================================================================
; Function: ToggleAlwaysOnTop
; Description: Toggles the AlwaysOnTop state of the currently active window, optionally showing
;              a tooltip at the current mouse position. The Windows desktop window is excluded.
; Parameters: None.
; Returns: None. The function returns early if the active window handle cannot be obtained
;          or its extended window style cannot be queried.
; ====================================================================================================
Func ToggleAlwaysOnTop()
	;Defensive: the hotkey should already be unregistered while AlwaysOnTop is disabled entirely
	If Not $bAlwaysOnTopEnabledSetting Then Return
	Logfile("ToggleAlwaysOnTop() start", 6)
	Local $hWnd = WinGetHandle("[ACTIVE]")
	If Not IsHWnd($hWnd) Then
		Logfile("The window handle could not be determined, therefore the operation is being aborted")
		Return
		;$hWnd = HWnd($hWnd)
	EndIf
	; Check whether WS_EX_TOPMOST is already set
	Local $aRet = DllCall("user32.dll", "long", "GetWindowLongW", "hwnd", $hWnd, "int", -20) ; GWL_EXSTYLE
	If @error Then
		Logfile("Always On Top: WS_EX_TOPMOST already set")
		Return
	EndIf
	Local $bIsTopMost = BitAND($aRet[0], 0x00000008) ; WS_EX_TOPMOST
	Local $sTitle = WinGetTitle($hWnd)
	;Logfile("Always On Top: $sTitle: " & $sTitle, 6)
	If $sTitle <> "Program Manager" Then
		Local $aMousePos = MouseGetPos()
		If $bIsTopMost Then
			WinSetOnTop($hWnd, "", 0)
			Logfile('AlwaysOnTop: "' & $sTitle & '" AlwaysOnTop not active', 6)
			If $bAlwaysOnTopShowToolTip = 1 Then
				ToolTip('AlwaysOnTop: "' & $sTitle & _('" AlwaysOnTop not active'), $aMousePos[0], $aMousePos[1])
				Sleep(1000)
				ToolTip("")
			EndIf
		ElseIf Not $bIsTopMost Then
			WinSetOnTop($hWnd, "", 1)
			Logfile('AlwaysOnTop "' & $sTitle & '" AlwaysOnTop active', 6)
			If $bAlwaysOnTopShowToolTip = 1 Then
				ToolTip(_('AlwaysOnTop "') & $sTitle & _('" AlwaysOnTop active'), $aMousePos[0], $aMousePos[1])
				Sleep(1000)
				ToolTip("")
			EndIf
		EndIf
	Else
		Logfile('"Program Manager" cannot be set to AlwaysOnTop', 6)
	EndIf
	Logfile("ToggleAlwaysOnTop() end", 6)
EndFunc   ;==>ToggleAlwaysOnTop

; Converts an AutoIt Send()/HotKeySet() string into a human-readable form
; Example: "^!+a"  ->  "STRG/CTRL + ALT + SHIFT + a"
; Example: "#^{F5}" -> "WIN + STRG/CTRL + F5"
; ====================================================================================================
; Function: HotkeyToReadable
; Description: Converts an AutoIt Send()/HotKeySet() hotkey string into a human-readable form.
; Parameters:
;   $sHotkey - AutoIt hotkey string containing modifier and key characters.
; Returns: A readable string containing the detected modifiers and key.
; ====================================================================================================
Func HotkeyToReadable($sHotkey)
	Local $sReadable = ""

	If StringInStr($sHotkey, "^") Then $sReadable &= _("CTRL + ")
	If StringInStr($sHotkey, "!") Then $sReadable &= _("ALT + ")
	If StringInStr($sHotkey, "+") Then $sReadable &= _("SHIFT + ")
	If StringInStr($sHotkey, "#") Then $sReadable &= _("WIN + ")

	; Remove modifier characters; the remainder is the actual key
	Local $sTaste = StringReplace($sHotkey, "^", "")
	$sTaste = StringReplace($sTaste, "!", "")
	$sTaste = StringReplace($sTaste, "+", "")
	$sTaste = StringReplace($sTaste, "#", "")

	; Remove curly braces (function keys)
	$sTaste = StringReplace($sTaste, "{", "")
	$sTaste = StringReplace($sTaste, "}", "")

	$sReadable &= $sTaste
	Return $sReadable
EndFunc   ;==>HotkeyToReadable

; ====================================================================================================
; Function: HotkeyDialog
; Description: Displays a dialog for selecting an AlwaysOnTop hotkey and validates the selected
;              combination by temporarily registering it.
; Parameters:
;   $sCurrent - Optional current hotkey used to preselect the dialog controls.
; Returns: The selected AutoIt hotkey string, or an empty string with @error = 1 if cancelled.
; ====================================================================================================
Func HotkeyDialog($sCurrent = "")
	Local $hGui = GUICreate(_("Set HotKey"), 320, 310, -1, -1, _
			BitOR($GUI_SS_DEFAULT_GUI, $DS_MODALFRAME))

	If @Compiled Then
		GUISetIcon(@ScriptFullPath, 204)
	Else
		GUISetIcon(@ScriptDir & "\icons\TrayBlue.ico")
	EndIf

	GUICtrlCreateLabel(_("Modifier:"), 15, 15, 200, 20)

	Local $idCtrl = GUICtrlCreateCheckbox(_("CTRL"), 15, 45, 130, 20)
	Local $idAlt = GUICtrlCreateCheckbox(_("ALT"), 15, 70, 130, 20)
	Local $idShift = GUICtrlCreateCheckbox(_("SHIFT"), 15, 95, 130, 20)
	Local $idWin = GUICtrlCreateCheckbox(_("WIN"), 15, 120, 130, 20)

	GUICtrlCreateLabel(_("Letter / Key:"), 170, 15, 130, 20)

	Local $sTasten = ""
	Local $i
	For $i = 97 To 122         ; a-z
		$sTasten &= Chr($i) & "|"
	Next
	For $i = 48 To 57          ; 0-9
		$sTasten &= Chr($i) & "|"
	Next
	$sTasten &= "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12"
	Local $idCombo = GUICtrlCreateCombo("", 170, 45, 130, 25)
	GUICtrlSetData($idCombo, $sTasten, "a")

	;GUICtrlCreateLabel("AutoIt-String:", 15, 155, 80, 20)
	;Local $idPreview = GUICtrlCreateLabel("-", 100, 155, 200, 20)

	GUICtrlCreateLabel(_("HotKey:"), 15, 180, 80, 20)
	Local $idPreviewReadable = GUICtrlCreateLabel("-", 100, 180, 200, 20)

	GUICtrlCreateLabel(_("Note: Not all combinations are possible,") & @CRLF & _
			_("as some may be in use by the system or") & @CRLF & _
			_("other programs."), 15, 210, 290, 50)

	Local $idOK = GUICtrlCreateButton(_("OK"), 70, 270, 80, 25)
	Local $idCancel = GUICtrlCreateButton(_("Abort"), 170, 270, 80, 25)

	; Initialize the controls from the supplied hotkey
	Local $sLastPrev = ""
	If $sCurrent <> "" Then
		If StringInStr($sCurrent, "^") Then GUICtrlSetState($idCtrl, $GUI_CHECKED)
		If StringInStr($sCurrent, "!") Then GUICtrlSetState($idAlt, $GUI_CHECKED)
		If StringInStr($sCurrent, "+") Then GUICtrlSetState($idShift, $GUI_CHECKED)
		If StringInStr($sCurrent, "#") Then GUICtrlSetState($idWin, $GUI_CHECKED)

		; Extract the actual key
		Local $sPreset = $sCurrent
		$sPreset = StringReplace($sPreset, "^", "")
		$sPreset = StringReplace($sPreset, "!", "")
		$sPreset = StringReplace($sPreset, "+", "")
		$sPreset = StringReplace($sPreset, "#", "")
		$sPreset = StringReplace($sPreset, "{", "")
		$sPreset = StringReplace($sPreset, "}", "")
		GUICtrlSetData($idCombo, $sPreset)

		; Set the preview immediately
		$sLastPrev = $sCurrent
		;GUICtrlSetData($idPreview, $sCurrent)
		GUICtrlSetData($idPreviewReadable, HotkeyToReadable($sCurrent))
	EndIf

	GUISetState(@SW_SHOW, $hGui)

	While 1
		Local $iMsg = GUIGetMsg()
		Switch $iMsg
			Case $GUI_EVENT_CLOSE, $idCancel
				GUIDelete($hGui)
				Return SetError(1, 0, "")

			Case $idOK
				Local $sResult = ""
				If BitAND(GUICtrlRead($idCtrl), $GUI_CHECKED) Then $sResult &= "^"
				If BitAND(GUICtrlRead($idAlt), $GUI_CHECKED) Then $sResult &= "!"
				If BitAND(GUICtrlRead($idShift), $GUI_CHECKED) Then $sResult &= "+"
				If BitAND(GUICtrlRead($idWin), $GUI_CHECKED) Then $sResult &= "#"

				Local $sTaste = GUICtrlRead($idCombo)
				If StringLen($sTaste) > 1 Then
					$sResult &= "{" & $sTaste & "}"
				Else
					$sResult &= $sTaste
				EndIf

				If $sTaste = "" Then ContinueLoop

				If HotKeySet($sResult, "HotkeyDialog") = 0 Then
					HotKeySet($sResult) ;test HotKey entfernen !
					MsgBox($MB_ICONWARNING, _("Already in use"), _
							_("This combination is already in use or invalid.") & @CRLF & _
							_("Please choose a different hotkey."), 0, $hGui)
					ContinueLoop
				Else
					HotKeySet($sResult) ;test HotKey entfernen !
					GUIDelete($hGui)
					Return $sResult
				EndIf

			Case $idCtrl, $idAlt, $idShift, $idWin, $idCombo
				Local $sPrev = ""
				If BitAND(GUICtrlRead($idCtrl), $GUI_CHECKED) Then $sPrev &= "^"
				If BitAND(GUICtrlRead($idAlt), $GUI_CHECKED) Then $sPrev &= "!"
				If BitAND(GUICtrlRead($idShift), $GUI_CHECKED) Then $sPrev &= "+"
				If BitAND(GUICtrlRead($idWin), $GUI_CHECKED) Then $sPrev &= "#"
				$sPrev &= GUICtrlRead($idCombo)

				If $sPrev <> $sLastPrev Then
					;GUICtrlSetData($idPreview, $sPrev)
					GUICtrlSetData($idPreviewReadable, HotkeyToReadable($sPrev))
					$sLastPrev = $sPrev
				EndIf
		EndSwitch
	WEnd
EndFunc   ;==>HotkeyDialog

; ====================================================================================================
; Function: SetAOTHotkey
; Description: Opens the hotkey selection dialog, replaces the current AlwaysOnTop hotkey when
;              a new valid value is selected, and registers the new hotkey.
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func SetAOTHotkey()
	;Disable every tray menu item while the dialog is open: the main TrayGetMsg() loop is not being
	;polled during that time, so a tray menu click would otherwise generate a message that never
	;gets processed
	Local $oTrayMenuStates = _TrayMenuDisableAll($hMenu)
	Local $sHotkey = HotkeyDialog($sAlwaysOnTopHotKey)
	Local $bError = @error
	;Re-enable the tray menu items now that the dialog is closed
	_TrayMenuRestoreDisabled($hMenu, $oTrayMenuStates)
	If Not $bError And $sHotkey <> $sAlwaysOnTopHotKey Then
		Logfile("New hotkey: " & $sHotkey, 6)
		;Disable the old hotkey
		HotKeySet($sAlwaysOnTopHotKey)
		$sAlwaysOnTopHotKey = $sHotkey
		;does not work - TrayItemSetText($iActivateAOTHotKeyTrayItem, 'AlwaysOnTop Hotkey aktiv ( ' & _HotkeyToReadable($sAlwaysOnTopHotKey) & ' )')
		_GUICtrlMenu_SetItemText($hMenu, $iMenuId_iActivateAOTHotKeyTrayItem, _("Hotkey active ( ") & HotkeyToReadable($sAlwaysOnTopHotKey) & " )", False)
		;Set the new hotkey
		HotKeySet($sAlwaysOnTopHotKey, "ToggleAlwaysOnTop")
	Else
		Logfile("HotkeyDialog without selection", 6)
	EndIf
EndFunc   ;==>SetAOTHotkey

; ====================================================================================================
; Function: mhBitMapGetValue
; Description: Retrieves a value from the global bitmap handle map by name.
; Parameters:
;   $sName - Name/key of the value to retrieve.
; Returns: The stored value if found; otherwise an empty string with @error = 1.
; ====================================================================================================
Func mhBitMapGetValue($sName)
	Return _DictGet($mhBitmapStorage, $sName)
EndFunc   ;==>mhBitMapGetValue

; ====================================================================================================
; Function: DeleteAllhBitmaps
; Description: Releases all stored GDI bitmap handles with _WinAPI_DeleteObject.
; Parameters: None.
; Returns: None. If the map contains no entries, the function returns without performing cleanup.
; ====================================================================================================
Func DeleteAllhBitmaps()
	;Logfile("DeleteAllhBitmaps() start", 6)
	If $mhBitmapStorage.Count = 0 Then
		Logfile("There are no entries in the hBitmap storage", 6)
		Return
	EndIf
	Local $aKeys = $mhBitmapStorage.Keys()
	Local $sKey, $bResult
	For $sKey In $aKeys
		Local $iValue = $mhBitmapStorage.Item($sKey)
		Logfile("Deleting: " & $sKey & ": " & $iValue, 6)
		$bResult = _WinAPI_DeleteObject($iValue)
		If $bResult Then
			Logfile("Old $hBitmap successfully deleted", 6)
		Else
			Logfile("Error deleting the old $hBitmap for $sKey: " & $sKey)
		EndIf
	Next
	;Reset the dictionary itself so stale entries (now pointing to already-deleted handles) do not
	;accumulate across repeated menu rebuilds (e.g. toggling big icons, reloading the INI)
	$mhBitmapStorage.RemoveAll()
	;Logfile("DeleteAllhBitmaps() end", 6)
EndFunc   ;==>DeleteAllhBitmaps

;TBD Debug - remove when no longer needed
Func NoTranslationExists($sText)
	Global $bNoTranslationExistsFileDeleted
	Global $sNoTranslationExistsFile = @ScriptDir & "\no_translation_exists.ini"
	;only delete once during run
	If $bNoTranslationExistsFileDeleted <> 1 Then
		FileDelete($sNoTranslationExistsFile)
		$bNoTranslationExistsFileDeleted = 1
	EndIf

	If Not StringInStr($sText, "$") And Not StringInStr($sText, "()") Then ;no variable or debug text
		IniWrite($sNoTranslationExistsFile, "English", '"' & $sText & '"', "")
	EndIf
EndFunc   ;==>NoTranslationExists

; ====================================================================================================
; Function: _() ;very short on purpose
; Description: Searches for the correct translation and returns the translatet text
; Parameters:
;	$sText = Text in english
; Returns:
;	Text in the detected systemlangage if available or in english if not
; ====================================================================================================
Func _($sText)
	;Translate based on systemlanguage, return original (english) if no translation is available
	Local $sTranslated
	If $sAppLanguage = "German" Then
		$sTranslated = _DictGet($mIDToGerman, _DictGet($mEnglishToID, $sText))
		If StringStripWS($sTranslated, 3) <> "" Then
			Return $sTranslated
		Else
			;NoTranslationExists($sText)
			Return $sText
		EndIf
	ElseIf $sAppLanguage = "Spanish" Then
		$sTranslated = _DictGet($mIDToSpanish, _DictGet($mEnglishToID, $sText))
		If StringStripWS($sTranslated, 3) <> "" Then
			Return $sTranslated
		Else
			Return $sText
		EndIf
	ElseIf $sAppLanguage = "Italian" Then
		$sTranslated = _DictGet($mIDToItalian, _DictGet($mEnglishToID, $sText))
		If StringStripWS($sTranslated, 3) <> "" Then
			Return $sTranslated
		Else
			Return $sText
		EndIf
	ElseIf $sAppLanguage = "French" Then
		$sTranslated = _DictGet($mIDToFrench, _DictGet($mEnglishToID, $sText))
		If StringStripWS($sTranslated, 3) <> "" Then
			Return $sTranslated
		Else
			Return $sText
		EndIf
	ElseIf $sAppLanguage = "Polish" Then
		$sTranslated = _DictGet($mIDToPolish, _DictGet($mEnglishToID, $sText))
		If StringStripWS($sTranslated, 3) <> "" Then
			Return $sTranslated
		Else
			Return $sText
		EndIf
	ElseIf $sAppLanguage = "Hungarian" Then
		$sTranslated = _DictGet($mIDToHungarian, _DictGet($mEnglishToID, $sText))
		If StringStripWS($sTranslated, 3) <> "" Then
			Return $sTranslated
		Else
			Return $sText
		EndIf
	ElseIf $sAppLanguage = "Russian" Then
		$sTranslated = _DictGet($mIDToRussian, _DictGet($mEnglishToID, $sText))
		If StringStripWS($sTranslated, 3) <> "" Then
			Return $sTranslated
		Else
			Return $sText
		EndIf
	Else
		Return $sText
	EndIf
EndFunc   ;==>_

Func CreateMapEnglishToID()
	$mEnglishToID.Item("uncompiled (Debug)") = 100
	$mEnglishToID.Item("Monitors and System") = 101
	$mEnglishToID.Item("Monitors") = 102
	$mEnglishToID.Item("System") = 103
	$mEnglishToID.Item("Deactivated") = 104
	$mEnglishToID.Item("Save state") = 105
	$mEnglishToID.Item("Hotkey active ( ") = 106
	$mEnglishToID.Item("ALT + ") = 107
	$mEnglishToID.Item("SHIFT + ") = 108
	$mEnglishToID.Item("Change hotkey") = 109
	$mEnglishToID.Item("Show tooltip") = 110
	$mEnglishToID.Item("Settings") = 111
	$mEnglishToID.Item("Start automatically") = 112
	$mEnglishToID.Item("Create log file") = 113
	$mEnglishToID.Item("View log file") = 114
	$mEnglishToID.Item("Use big icons") = 115
	$mEnglishToID.Item("Edit settings file") = 116
	$mEnglishToID.Item("About") = 117
	$mEnglishToID.Item("Exit") = 118
	$mEnglishToID.Item("Enabling log file") = 119
	$mEnglishToID.Item("Disabling KeepAwake") = 120
	$mEnglishToID.Item("Set HotKey") = 121
	$mEnglishToID.Item("Modifier:") = 122
	$mEnglishToID.Item("CTRL") = 123
	$mEnglishToID.Item("ALT") = 124
	$mEnglishToID.Item("SHIFT") = 125
	$mEnglishToID.Item("WIN") = 126
	$mEnglishToID.Item("Letter / Key:") = 127
	$mEnglishToID.Item("HotKey:") = 128
	$mEnglishToID.Item("Note: Not all combinations are possible,") = 129
	$mEnglishToID.Item("as some may be in use by the system or") = 130
	$mEnglishToID.Item("other programs.") = 131
	$mEnglishToID.Item("OK") = 132
	$mEnglishToID.Item("Abort") = 133
	$mEnglishToID.Item("New hotkey: ") = 134
	$mEnglishToID.Item("CTRL + ") = 135
	$mEnglishToID.Item("About ") = 136
	$mEnglishToID.Item("A simple way to disable powersaving, an AlwaysOnTop tool and a fast way to start additional tools from the traymenu.") = 137
	$mEnglishToID.Item("Warning: Modify Configuration?") = 138
	$mEnglishToID.Item("Do you want to modify the extended INI file configuration ?") = 139
	$mEnglishToID.Item("As soon as you close the Editor, ") = 140
	$mEnglishToID.Item(" will read and apply the new settings!") = 141
	$mEnglishToID.Item("Command Prompt") = 142
	$mEnglishToID.Item("Registry Editor") = 143
	$mEnglishToID.Item("Network Settings") = 144
	$mEnglishToID.Item("Control Panel") = 145
	$mEnglishToID.Item("Resource Monitor") = 146
	$mEnglishToID.Item("Performance Monitor") = 147
	$mEnglishToID.Item("Manage Services") = 148
	$mEnglishToID.Item("Disk Cleanup") = 149
	$mEnglishToID.Item("Calculator") = 150
	$mEnglishToID.Item("KeepAwake deactivated") = 151
	$mEnglishToID.Item("KeepAwake System") = 152
	$mEnglishToID.Item("KeepAwake Monitors") = 153
	$mEnglishToID.Item("KeepAwake Monitors and System") = 154
	$mEnglishToID.Item("ToolTime") = 155
	$mEnglishToID.Item("KeepAwake") = 156
	$mEnglishToID.Item("AlwaysOnTop") = 157
	$mEnglishToID.Item('" AlwaysOnTop active') = 158
	$mEnglishToID.Item('" AlwaysOnTop not active') = 159
	$mEnglishToID.Item("Log file not found: ") = 162
	$mEnglishToID.Item("Already in use") = 163
	$mEnglishToID.Item("This combination is already in use or invalid.") = 164
	$mEnglishToID.Item("Please choose a different hotkey.") = 165
	$mEnglishToID.Item("Error") = 166
	$mEnglishToID.Item("LogFile could not be written to. Please check if ") = 167
	$mEnglishToID.Item(" has write permission for the file ") = 168
	$mEnglishToID.Item(", or disable the LogFile in the INI Settings. Logging has been disabled; ") = 169
	$mEnglishToID.Item(" will continue running.") = 170
	$mEnglishToID.Item("Hotkey active") = 171
	$mEnglishToID.Item("WIN + ") = 172
	$mEnglishToID.Item(" Version: ") = 173
	$mEnglishToID.Item("Enable KeepAwake") = 174
	$mEnglishToID.Item("Enable AlwaysOnTop") = 175
	$mEnglishToID.Item("Enable ToolTime") = 176
	$mEnglishToID.Item("Open ToolTime folder") = 177
	$mEnglishToID.Item("Reload tools") = 178
	$mEnglishToID.Item("(!) ToolTime: problems found - click for details") = 179
	$mEnglishToID.Item("... %1 more not shown (limit %2)") = 180
	$mEnglishToID.Item("ToolTime: problems found") = 181
	$mEnglishToID.Item("Problems occurred while reading the ToolTime folder:") = 182
	$mEnglishToID.Item("Too many entries in '%1': %2 found, only %3 shown. Not shown: %4") = 183
	$mEnglishToID.Item("Folder ignored (maximum of %1 menu levels exceeded): %2") = 184
	$mEnglishToID.Item("Shortcut could not be read and was ignored: %1") = 185
	$mEnglishToID.Item("Too many entries in total (limit %1): the remaining entries are not shown.") = 186
	$mEnglishToID.Item("The maximum number of entries per menu is %1. It can be changed in the settings file ([ToolTime] MaxEntries, 10 - 20).") = 187
	$mEnglishToID.Item("Problems were found while reading the ToolTime folder. Click the entry marked (!) in the menu for details.") = 188
	$mEnglishToID.Item("The ToolTime folder was not found and could not be created: %1") = 189
	$mEnglishToID.Item("Every sub folder becomes a sub menu and every shortcut (.lnk file) becomes a menu entry. All other files, like this one, are ignored.") = 190
	$mEnglishToID.Item("At most %1 menu levels (the ToolTime menu and its sub menus) and at most %2 entries in total are shown. Entries above a limit are not shown, a note is added to the menu instead.") = 191
	$mEnglishToID.Item("Order: folders come first, then shortcuts, each sorted by name. A number with 2 or 3 digits and an underscore in front of the name sets the order; the number is not shown in the menu.") = 192
	$mEnglishToID.Item("Example:") = 193

EndFunc   ;==>CreateMapEnglishToID

Func CreateMapIDToGerman()
	$mIDToGerman.Item(100) = "unkompiliert (Debug)"
	$mIDToGerman.Item(101) = "Monitore und System"
	$mIDToGerman.Item(102) = "Monitore"
	$mIDToGerman.Item(103) = "System"
	$mIDToGerman.Item(104) = "Deaktiviert"
	$mIDToGerman.Item(105) = "Zustand speichern"
	$mIDToGerman.Item(106) = "Hotkey aktiv ( "
	$mIDToGerman.Item(107) = "ALT + "
	$mIDToGerman.Item(108) = "UMSCHALT + "
	$mIDToGerman.Item(109) = "Hotkey ändern"
	$mIDToGerman.Item(110) = "Tooltip anzeigen"
	$mIDToGerman.Item(111) = "Einstellungen"
	$mIDToGerman.Item(112) = "Automatisch starten"
	$mIDToGerman.Item(113) = "Log-Datei erstellen"
	$mIDToGerman.Item(114) = "Log-Datei anzeigen"
	$mIDToGerman.Item(115) = "Große Symbole verwenden"
	$mIDToGerman.Item(116) = "Einstellungsdatei bearbeiten"
	$mIDToGerman.Item(117) = "Über"
	$mIDToGerman.Item(118) = "Beenden"
	$mIDToGerman.Item(119) = "Log-Datei wird aktiviert"
	$mIDToGerman.Item(120) = "KeepAwake wird deaktiviert"
	$mIDToGerman.Item(121) = "Hotkey festlegen"
	$mIDToGerman.Item(122) = "Modifikator:"
	$mIDToGerman.Item(123) = "STRG"
	$mIDToGerman.Item(124) = "ALT"
	$mIDToGerman.Item(125) = "UMSCHALT"
	$mIDToGerman.Item(126) = "WIN"
	$mIDToGerman.Item(127) = "Buchstabe / Taste:"
	$mIDToGerman.Item(128) = "Hotkey:"
	$mIDToGerman.Item(129) = "Hinweis: Nicht alle Kombinationen sind möglich,"
	$mIDToGerman.Item(130) = "da einige eventuell vom System oder"
	$mIDToGerman.Item(131) = "anderen Programmen verwendet werden."
	$mIDToGerman.Item(132) = "OK"
	$mIDToGerman.Item(133) = "Abbrechen"
	$mIDToGerman.Item(134) = "Neuer Hotkey: "
	$mIDToGerman.Item(135) = "STRG + "
	$mIDToGerman.Item(136) = "Über "
	$mIDToGerman.Item(137) = "Eine einfache Möglichkeit, das Energiesparen zu deaktivieren, ein AlwaysOnTop-Tool und ein schneller Weg, um zusätzliche Tools über das Traymenü zu starten."
	$mIDToGerman.Item(138) = "Warnung: Konfiguration ändern?"
	$mIDToGerman.Item(139) = "Möchten Sie die erweiterte INI-Dateikonfiguration ändern?"
	$mIDToGerman.Item(140) = "Sobald Sie den Editor schließen, wird "
	$mIDToGerman.Item(141) = " die neuen Einstellungen lesen und anwenden !"
	$mIDToGerman.Item(142) = "Eingabeaufforderung"
	$mIDToGerman.Item(143) = "Registrierungs-Editor"
	$mIDToGerman.Item(144) = "Netzwerkeinstellungen"
	$mIDToGerman.Item(145) = "Systemsteuerung"
	$mIDToGerman.Item(146) = "Ressourcenmonitor"
	$mIDToGerman.Item(147) = "Leistungsüberwachung"
	$mIDToGerman.Item(148) = "Dienste verwalten"
	$mIDToGerman.Item(149) = "Datenträgerbereinigung"
	$mIDToGerman.Item(150) = "Rechner"
	$mIDToGerman.Item(151) = "KeepAwake deaktiviert"
	$mIDToGerman.Item(152) = "KeepAwake System"
	$mIDToGerman.Item(153) = "KeepAwake Monitore"
	$mIDToGerman.Item(154) = "KeepAwake Monitore und System"
	$mIDToGerman.Item(155) = "ToolTime"
	$mIDToGerman.Item(156) = "KeepAwake"
	$mIDToGerman.Item(157) = "AlwaysOnTop"
	$mIDToGerman.Item(158) = '" AlwaysOnTop aktiv'
	$mIDToGerman.Item(159) = '" AlwaysOnTop nicht aktiv'
	$mIDToGerman.Item(162) = "Logfile nicht gefunden: "
	$mIDToGerman.Item(163) = "Belegt"
	$mIDToGerman.Item(164) = "Diese Kombination ist bereits belegt oder ungültig."
	$mIDToGerman.Item(165) = "Bitte wähle einen anderen HotKey."
	$mIDToGerman.Item(166) = "Fehler"
	$mIDToGerman.Item(167) = "Die Logdatei konnte nicht geschrieben werden. Bitte prüfe, ob "
	$mIDToGerman.Item(168) = " Schreibrechte für die Datei "
	$mIDToGerman.Item(169) = " hat, oder deaktiviere das Logfile in den INI-Einstellungen. Die Protokollierung wurde deaktiviert; "
	$mIDToGerman.Item(170) = " läuft weiter."
	$mIDToGerman.Item(171) = "Hotkey aktiv"
	$mIDToGerman.Item(172) = "WIN + "
	$mIDToGerman.Item(173) = " Version: "
	$mIDToGerman.Item(174) = "KeepAwake aktivieren"
	$mIDToGerman.Item(175) = "AlwaysOnTop aktivieren"
	$mIDToGerman.Item(176) = "ToolTime aktivieren"
	$mIDToGerman.Item(177) = "ToolTime-Ordner öffnen"
	$mIDToGerman.Item(178) = "Tools neu laden"
	$mIDToGerman.Item(179) = "(!) ToolTime: Probleme gefunden - zum Anzeigen der Details klicken"
	$mIDToGerman.Item(180) = "... %1 weitere nicht angezeigt (Limit %2)"
	$mIDToGerman.Item(181) = "ToolTime: Probleme gefunden"
	$mIDToGerman.Item(182) = "Beim Einlesen des ToolTime-Ordners sind Probleme aufgetreten:"
	$mIDToGerman.Item(183) = "Zu viele Einträge in '%1': %2 gefunden, nur %3 angezeigt. Nicht angezeigt: %4"
	$mIDToGerman.Item(184) = "Ordner ignoriert (maximal %1 Menüebenen überschritten): %2"
	$mIDToGerman.Item(185) = "Verknüpfung konnte nicht gelesen werden und wurde ignoriert: %1"
	$mIDToGerman.Item(186) = "Insgesamt zu viele Einträge (Limit %1): die übrigen Einträge werden nicht angezeigt."
	$mIDToGerman.Item(187) = "Die maximale Anzahl der Einträge pro Menü beträgt %1. Sie kann in der Einstellungsdatei geändert werden ([ToolTime] MaxEntries, 10 - 20)."
	$mIDToGerman.Item(188) = "Beim Einlesen des ToolTime-Ordners wurden Probleme gefunden. Klicken Sie im Menü auf den mit (!) markierten Eintrag, um Details anzuzeigen."
	$mIDToGerman.Item(189) = "Der ToolTime-Ordner wurde nicht gefunden und konnte nicht angelegt werden: %1"
	$mIDToGerman.Item(190) = "Jeder Unterordner wird zu einem Untermenü und jede Verknüpfung (.lnk-Datei) zu einem Menüeintrag. Alle anderen Dateien, wie diese, werden ignoriert."
	$mIDToGerman.Item(191) = "Es werden höchstens %1 Menüebenen (das ToolTime-Menü und seine Untermenüs) und höchstens %2 Einträge insgesamt angezeigt. Einträge über einem Limit werden nicht angezeigt, stattdessen wird ein Hinweis im Menü eingefügt."
	$mIDToGerman.Item(192) = "Reihenfolge: Zuerst kommen die Ordner, dann die Verknüpfungen, jeweils nach Namen sortiert. Eine zwei- oder dreistellige Zahl mit Unterstrich vor dem Namen legt die Reihenfolge fest; die Zahl wird im Menü nicht angezeigt."
	$mIDToGerman.Item(193) = "Beispiel:"

EndFunc   ;==>CreateMapIDToGerman

Func CreateMapIDToSpanish()
	$mIDToSpanish.Item(100) = "sin compilar (Debug)"
	$mIDToSpanish.Item(101) = "Monitores y Sistema"
	$mIDToSpanish.Item(102) = "Monitores"
	$mIDToSpanish.Item(103) = "Sistema"
	$mIDToSpanish.Item(104) = "Desactivado"
	$mIDToSpanish.Item(105) = "Guardar estado"
	$mIDToSpanish.Item(106) = "Hotkey activa ( "
	$mIDToSpanish.Item(107) = "ALT + "
	$mIDToSpanish.Item(108) = "MAYÚS + "
	$mIDToSpanish.Item(109) = "Cambiar hotkey"
	$mIDToSpanish.Item(110) = "Mostrar tooltip"
	$mIDToSpanish.Item(111) = "Configuración"
	$mIDToSpanish.Item(112) = "Iniciar automáticamente"
	$mIDToSpanish.Item(113) = "Crear archivo de registro"
	$mIDToSpanish.Item(114) = "Ver archivo de registro"
	$mIDToSpanish.Item(115) = "Usar iconos grandes"
	$mIDToSpanish.Item(116) = "Editar archivo de configuración"
	$mIDToSpanish.Item(117) = "Acerca de"
	$mIDToSpanish.Item(118) = "Salir"
	$mIDToSpanish.Item(119) = "Activando archivo de registro"
	$mIDToSpanish.Item(120) = "Desactivando KeepAwake"
	$mIDToSpanish.Item(121) = "Establecer hotkey"
	$mIDToSpanish.Item(122) = "Modificador:"
	$mIDToSpanish.Item(123) = "CTRL"
	$mIDToSpanish.Item(124) = "ALT"
	$mIDToSpanish.Item(125) = "MAYÚS"
	$mIDToSpanish.Item(126) = "WIN"
	$mIDToSpanish.Item(127) = "Letra / Tecla:"
	$mIDToSpanish.Item(128) = "Hotkey:"
	$mIDToSpanish.Item(129) = "Nota: No todas las combinaciones son posibles,"
	$mIDToSpanish.Item(130) = "ya que algunas pueden estar en uso por el sistema u"
	$mIDToSpanish.Item(131) = "otros programas."
	$mIDToSpanish.Item(132) = "OK"
	$mIDToSpanish.Item(133) = "Cancelar"
	$mIDToSpanish.Item(134) = "Nueva hotkey: "
	$mIDToSpanish.Item(135) = "CTRL + "
	$mIDToSpanish.Item(136) = "Acerca de "
	$mIDToSpanish.Item(137) = "Una forma sencilla de desactivar el ahorro de energía, una herramienta AlwaysOnTop y una manera rápida de iniciar herramientas adicionales desde el menú de la bandeja."
	$mIDToSpanish.Item(138) = "Advertencia: ¿Modificar configuración?"
	$mIDToSpanish.Item(139) = "¿Desea modificar la configuración avanzada del archivo INI?"
	$mIDToSpanish.Item(140) = "En cuanto cierre el editor, "
	$mIDToSpanish.Item(141) = " leerá y aplicará los nuevos ajustes !"
	$mIDToSpanish.Item(142) = "Símbolo del sistema"
	$mIDToSpanish.Item(143) = "Editor del registro"
	$mIDToSpanish.Item(144) = "Configuración de red"
	$mIDToSpanish.Item(145) = "Panel de control"
	$mIDToSpanish.Item(146) = "Monitor de recursos"
	$mIDToSpanish.Item(147) = "Monitor de rendimiento"
	$mIDToSpanish.Item(148) = "Administrar servicios"
	$mIDToSpanish.Item(149) = "Liberador de espacio en disco"
	$mIDToSpanish.Item(150) = "Calculadora"
	$mIDToSpanish.Item(151) = "KeepAwake desactivado"
	$mIDToSpanish.Item(152) = "KeepAwake Sistema"
	$mIDToSpanish.Item(153) = "KeepAwake Monitores"
	$mIDToSpanish.Item(154) = "KeepAwake Monitores y Sistema"
	$mIDToSpanish.Item(155) = "ToolTime"
	$mIDToSpanish.Item(156) = "KeepAwake"
	$mIDToSpanish.Item(157) = "AlwaysOnTop"
	$mIDToSpanish.Item(158) = '" AlwaysOnTop activo'
	$mIDToSpanish.Item(159) = '" AlwaysOnTop no activo'
	$mIDToSpanish.Item(162) = "Archivo de registro no encontrado: "
	$mIDToSpanish.Item(163) = "En uso"
	$mIDToSpanish.Item(164) = "Esta combinación ya está en uso o no es válida."
	$mIDToSpanish.Item(165) = "Por favor, elige otra combinación de teclas."
	$mIDToSpanish.Item(166) = "Error"
	$mIDToSpanish.Item(167) = "No se pudo escribir en el archivo de registro. Comprueba si "
	$mIDToSpanish.Item(168) = " tiene permiso de escritura para el archivo "
	$mIDToSpanish.Item(169) = ", o desactiva el archivo de registro en la configuración del INI. El registro se ha desactivado; "
	$mIDToSpanish.Item(170) = " seguirá ejecutándose."
	$mIDToSpanish.Item(171) = "Hotkey activa"
	$mIDToSpanish.Item(172) = "WIN + "
	$mIDToSpanish.Item(173) = " Versión: "
	$mIDToSpanish.Item(174) = "Activar KeepAwake"
	$mIDToSpanish.Item(175) = "Activar AlwaysOnTop"
	$mIDToSpanish.Item(176) = "Activar ToolTime"
	$mIDToSpanish.Item(177) = "Abrir carpeta ToolTime"
	$mIDToSpanish.Item(178) = "Recargar herramientas"
	$mIDToSpanish.Item(179) = "(!) ToolTime: se encontraron problemas - haga clic para ver los detalles"
	$mIDToSpanish.Item(180) = "... %1 más no mostradas (límite %2)"
	$mIDToSpanish.Item(181) = "ToolTime: se encontraron problemas"
	$mIDToSpanish.Item(182) = "Se produjeron problemas al leer la carpeta ToolTime:"
	$mIDToSpanish.Item(183) = "Demasiadas entradas en '%1': %2 encontradas, solo se muestran %3. No mostradas: %4"
	$mIDToSpanish.Item(184) = "Carpeta ignorada (se superó el máximo de %1 niveles de menú): %2"
	$mIDToSpanish.Item(185) = "No se pudo leer el acceso directo y se ignoró: %1"
	$mIDToSpanish.Item(186) = "Demasiadas entradas en total (límite %1): las entradas restantes no se muestran."
	$mIDToSpanish.Item(187) = "El número máximo de entradas por menú es %1. Se puede cambiar en el archivo de configuración ([ToolTime] MaxEntries, 10 - 20)."
	$mIDToSpanish.Item(188) = "Se encontraron problemas al leer la carpeta ToolTime. Haga clic en la entrada marcada con (!) del menú para ver los detalles."
	$mIDToSpanish.Item(189) = "La carpeta ToolTime no se encontró y no se pudo crear: %1"
	$mIDToSpanish.Item(190) = "Cada subcarpeta se convierte en un submenú y cada acceso directo (archivo .lnk) en una entrada de menú. Todos los demás archivos, como este, se ignoran."
	$mIDToSpanish.Item(191) = "Se muestran como máximo %1 niveles de menú (el menú ToolTime y sus submenús) y como máximo %2 entradas en total. Las entradas que superan un límite no se muestran; en su lugar se añade una nota al menú."
	$mIDToSpanish.Item(192) = "Orden: primero van las carpetas y después los accesos directos, cada grupo ordenado por nombre. Un número de dos o tres cifras con guion bajo delante del nombre define el orden; el número no se muestra en el menú."
	$mIDToSpanish.Item(193) = "Ejemplo:"

EndFunc   ;==>CreateMapIDToSpanish

Func CreateMapIDToFrench()
	$mIDToFrench.Item(100) = "non compilé (Debug)"
	$mIDToFrench.Item(101) = "Moniteurs et Système"
	$mIDToFrench.Item(102) = "Moniteurs"
	$mIDToFrench.Item(103) = "Système"
	$mIDToFrench.Item(104) = "Désactivé"
	$mIDToFrench.Item(105) = "Enregistrer l'état"
	$mIDToFrench.Item(106) = "Raccourci actif ( "
	$mIDToFrench.Item(107) = "ALT + "
	$mIDToFrench.Item(108) = "MAJ + "
	$mIDToFrench.Item(109) = "Modifier le raccourci"
	$mIDToFrench.Item(110) = "Afficher l'infobulle"
	$mIDToFrench.Item(111) = "Paramètres"
	$mIDToFrench.Item(112) = "Démarrer automatiquement"
	$mIDToFrench.Item(113) = "Créer un fichier journal"
	$mIDToFrench.Item(114) = "Afficher le fichier journal"
	$mIDToFrench.Item(115) = "Utiliser de grandes icônes"
	$mIDToFrench.Item(116) = "Modifier le fichier de configuration"
	$mIDToFrench.Item(117) = "À propos"
	$mIDToFrench.Item(118) = "Quitter"
	$mIDToFrench.Item(119) = "Activation du fichier journal"
	$mIDToFrench.Item(120) = "Désactivation de KeepAwake"
	$mIDToFrench.Item(121) = "Définir le raccourci"
	$mIDToFrench.Item(122) = "Modificateur :"
	$mIDToFrench.Item(123) = "CTRL"
	$mIDToFrench.Item(124) = "ALT"
	$mIDToFrench.Item(125) = "MAJ"
	$mIDToFrench.Item(126) = "WIN"
	$mIDToFrench.Item(127) = "Lettre / Touche :"
	$mIDToFrench.Item(128) = "Raccourci :"
	$mIDToFrench.Item(129) = "Remarque : Toutes les combinaisons ne sont pas possibles,"
	$mIDToFrench.Item(130) = "car certaines peuvent déjà être utilisées par le système ou"
	$mIDToFrench.Item(131) = "par d'autres programmes."
	$mIDToFrench.Item(132) = "OK"
	$mIDToFrench.Item(133) = "Annuler"
	$mIDToFrench.Item(134) = "Nouveau raccourci : "
	$mIDToFrench.Item(135) = "CTRL + "
	$mIDToFrench.Item(136) = "À propos de "
	$mIDToFrench.Item(137) = "Un moyen simple de désactiver l'économie d'énergie, un outil AlwaysOnTop et un moyen rapide de lancer des outils supplémentaires depuis le menu de la barre d'état système."
	$mIDToFrench.Item(138) = "Avertissement : Modifier la configuration ?"
	$mIDToFrench.Item(139) = "Voulez-vous modifier la configuration étendue du fichier INI ?"
	$mIDToFrench.Item(140) = "Dès que vous fermerez l'éditeur, "
	$mIDToFrench.Item(141) = " lira et appliquera les nouveaux paramètres !"
	$mIDToFrench.Item(142) = "Invite de commandes"
	$mIDToFrench.Item(143) = "Éditeur du registre"
	$mIDToFrench.Item(144) = "Paramètres réseau"
	$mIDToFrench.Item(145) = "Panneau de configuration"
	$mIDToFrench.Item(146) = "Moniteur de ressources"
	$mIDToFrench.Item(147) = "Analyseur de performances"
	$mIDToFrench.Item(148) = "Gérer les services"
	$mIDToFrench.Item(149) = "Nettoyage de disque"
	$mIDToFrench.Item(150) = "Calculatrice"
	$mIDToFrench.Item(151) = "KeepAwake désactivé"
	$mIDToFrench.Item(152) = "KeepAwake Système"
	$mIDToFrench.Item(153) = "KeepAwake Moniteurs"
	$mIDToFrench.Item(154) = "KeepAwake Moniteurs et Système"
	$mIDToFrench.Item(155) = "ToolTime"
	$mIDToFrench.Item(156) = "KeepAwake"
	$mIDToFrench.Item(157) = "AlwaysOnTop"
	$mIDToFrench.Item(158) = '" AlwaysOnTop actif'
	$mIDToFrench.Item(159) = '" AlwaysOnTop non actif'
	$mIDToFrench.Item(162) = "Fichier journal introuvable : "
	$mIDToFrench.Item(163) = "Déjà utilisé"
	$mIDToFrench.Item(164) = "Cette combinaison est déjà utilisée ou n'est pas valide."
	$mIDToFrench.Item(165) = "Veuillez choisir une autre combinaison de touches."
	$mIDToFrench.Item(166) = "Erreur"
	$mIDToFrench.Item(167) = "Impossible d'écrire dans le fichier journal. Vérifiez si "
	$mIDToFrench.Item(168) = " dispose des droits d'écriture pour le fichier "
	$mIDToFrench.Item(169) = ", ou désactivez le fichier journal dans les paramètres INI. La journalisation a été désactivée ; "
	$mIDToFrench.Item(170) = " continuera de fonctionner."
	$mIDToFrench.Item(171) = "Raccourci actif"
	$mIDToFrench.Item(172) = "WIN + "
	$mIDToFrench.Item(173) = " Version : "
	$mIDToFrench.Item(174) = "Activer KeepAwake"
	$mIDToFrench.Item(175) = "Activer AlwaysOnTop"
	$mIDToFrench.Item(176) = "Activer ToolTime"
	$mIDToFrench.Item(177) = "Ouvrir le dossier ToolTime"
	$mIDToFrench.Item(178) = "Recharger les outils"
	$mIDToFrench.Item(179) = "(!) ToolTime : problèmes détectés - cliquer pour les détails"
	$mIDToFrench.Item(180) = "... %1 autres non affichés (limite %2)"
	$mIDToFrench.Item(181) = "ToolTime : problèmes détectés"
	$mIDToFrench.Item(182) = "Des problèmes sont survenus lors de la lecture du dossier ToolTime :"
	$mIDToFrench.Item(183) = "Trop d'entrées dans '%1' : %2 trouvées, seulement %3 affichées. Non affichées : %4"
	$mIDToFrench.Item(184) = "Dossier ignoré (maximum de %1 niveaux de menu dépassé) : %2"
	$mIDToFrench.Item(185) = "Le raccourci n'a pas pu être lu et a été ignoré : %1"
	$mIDToFrench.Item(186) = "Trop d'entrées au total (limite %1) : les entrées restantes ne sont pas affichées."
	$mIDToFrench.Item(187) = "Le nombre maximal d'entrées par menu est de %1. Il peut être modifié dans le fichier de configuration ([ToolTime] MaxEntries, 10 - 20)."
	$mIDToFrench.Item(188) = "Des problèmes ont été détectés lors de la lecture du dossier ToolTime. Cliquez sur l'entrée marquée (!) dans le menu pour les détails."
	$mIDToFrench.Item(189) = "Le dossier ToolTime est introuvable et n'a pas pu être créé : %1"
	$mIDToFrench.Item(190) = "Chaque sous-dossier devient un sous-menu et chaque raccourci (fichier .lnk) devient une entrée de menu. Tous les autres fichiers, comme celui-ci, sont ignorés."
	$mIDToFrench.Item(191) = "Au maximum %1 niveaux de menu (le menu ToolTime et ses sous-menus) et au maximum %2 entrées au total sont affichés. Les entrées au-delà d'une limite ne sont pas affichées ; une remarque est ajoutée au menu à la place."
	$mIDToFrench.Item(192) = "Ordre : d'abord les dossiers, puis les raccourcis, chaque groupe trié par nom. Un nombre de deux ou trois chiffres suivi d'un trait de soulignement devant le nom définit l'ordre ; le nombre n'est pas affiché dans le menu."
	$mIDToFrench.Item(193) = "Exemple :"

EndFunc   ;==>CreateMapIDToFrench

Func CreateMapIDToPolish()
	$mIDToPolish.Item(100) = "nieskompilowane (Debug)"
	$mIDToPolish.Item(101) = "Monitory i system"
	$mIDToPolish.Item(102) = "Monitory"
	$mIDToPolish.Item(103) = "System"
	$mIDToPolish.Item(104) = "Wyłączone"
	$mIDToPolish.Item(105) = "Zapisz stan"
	$mIDToPolish.Item(106) = "Skrót aktywny ( "
	$mIDToPolish.Item(107) = "ALT + "
	$mIDToPolish.Item(108) = "SHIFT + "
	$mIDToPolish.Item(109) = "Zmień skrót"
	$mIDToPolish.Item(110) = "Pokaż podpowiedź"
	$mIDToPolish.Item(111) = "Ustawienia"
	$mIDToPolish.Item(112) = "Uruchamiaj automatycznie"
	$mIDToPolish.Item(113) = "Utwórz plik dziennika"
	$mIDToPolish.Item(114) = "Pokaż plik dziennika"
	$mIDToPolish.Item(115) = "Użyj dużych ikon"
	$mIDToPolish.Item(116) = "Edytuj plik ustawień"
	$mIDToPolish.Item(117) = "O programie"
	$mIDToPolish.Item(118) = "Zakończ"
	$mIDToPolish.Item(119) = "Włączanie pliku dziennika"
	$mIDToPolish.Item(120) = "Wyłączanie KeepAwake"
	$mIDToPolish.Item(121) = "Ustaw skrót"
	$mIDToPolish.Item(122) = "Modyfikator:"
	$mIDToPolish.Item(123) = "CTRL"
	$mIDToPolish.Item(124) = "ALT"
	$mIDToPolish.Item(125) = "SHIFT"
	$mIDToPolish.Item(126) = "WIN"
	$mIDToPolish.Item(127) = "Litera / klawisz:"
	$mIDToPolish.Item(128) = "Skrót:"
	$mIDToPolish.Item(129) = "Uwaga: Nie wszystkie kombinacje są możliwe,"
	$mIDToPolish.Item(130) = "ponieważ niektóre mogą być używane przez system lub"
	$mIDToPolish.Item(131) = "inne programy."
	$mIDToPolish.Item(132) = "OK"
	$mIDToPolish.Item(133) = "Anuluj"
	$mIDToPolish.Item(134) = "Nowy skrót: "
	$mIDToPolish.Item(135) = "CTRL + "
	$mIDToPolish.Item(136) = "O programie "
	$mIDToPolish.Item(137) = "Prosty sposób na wyłączenie oszczędzania energii, narzędzie AlwaysOnTop oraz szybki sposób na uruchamianie dodatkowych narzędzi z menu zasobnika systemowego."
	$mIDToPolish.Item(138) = "Ostrzeżenie: Zmienić konfigurację?"
	$mIDToPolish.Item(139) = "Czy chcesz zmodyfikować rozszerzoną konfigurację pliku INI?"
	$mIDToPolish.Item(140) = "Zaraz po zamknięciu edytora "
	$mIDToPolish.Item(141) = " odczyta i zastosuje nowe ustawienia !"
	$mIDToPolish.Item(142) = "Wiersz poleceń"
	$mIDToPolish.Item(143) = "Edytor rejestru"
	$mIDToPolish.Item(144) = "Ustawienia sieciowe"
	$mIDToPolish.Item(145) = "Panel sterowania"
	$mIDToPolish.Item(146) = "Monitor zasobów"
	$mIDToPolish.Item(147) = "Monitor wydajności"
	$mIDToPolish.Item(148) = "Zarządzaj usługami"
	$mIDToPolish.Item(149) = "Oczyszczanie dysku"
	$mIDToPolish.Item(150) = "Kalkulator"
	$mIDToPolish.Item(151) = "KeepAwake wyłączone"
	$mIDToPolish.Item(152) = "KeepAwake System"
	$mIDToPolish.Item(153) = "KeepAwake Monitory"
	$mIDToPolish.Item(154) = "KeepAwake Monitory i system"
	$mIDToPolish.Item(155) = "ToolTime"
	$mIDToPolish.Item(156) = "KeepAwake"
	$mIDToPolish.Item(157) = "AlwaysOnTop"
	$mIDToPolish.Item(158) = '" AlwaysOnTop aktywny'
	$mIDToPolish.Item(159) = '" AlwaysOnTop nieaktywny'
	$mIDToPolish.Item(162) = "Nie znaleziono pliku dziennika: "
	$mIDToPolish.Item(163) = "Zajęte"
	$mIDToPolish.Item(164) = "Ta kombinacja jest już używana lub jest nieprawidłowa."
	$mIDToPolish.Item(165) = "Wybierz inny skrót klawiszowy."
	$mIDToPolish.Item(166) = "Błąd"
	$mIDToPolish.Item(167) = "Nie można zapisać do pliku dziennika. Sprawdź, czy "
	$mIDToPolish.Item(168) = " ma uprawnienia do zapisu w pliku "
	$mIDToPolish.Item(169) = ", albo wyłącz plik dziennika w ustawieniach INI. Rejestrowanie zostało wyłączone; "
	$mIDToPolish.Item(170) = " będzie działać dalej."
	$mIDToPolish.Item(171) = "Skrót aktywny"
	$mIDToPolish.Item(172) = "WIN + "
	$mIDToPolish.Item(173) = " Wersja: "
	$mIDToPolish.Item(174) = "Włącz KeepAwake"
	$mIDToPolish.Item(175) = "Włącz AlwaysOnTop"
	$mIDToPolish.Item(176) = "Włącz ToolTime"
	$mIDToPolish.Item(177) = "Otwórz folder ToolTime"
	$mIDToPolish.Item(178) = "Wczytaj narzędzia ponownie"
	$mIDToPolish.Item(179) = "(!) ToolTime: znaleziono problemy - kliknij, aby zobaczyć szczegóły"
	$mIDToPolish.Item(180) = "... %1 kolejnych nie wyświetlono (limit %2)"
	$mIDToPolish.Item(181) = "ToolTime: znaleziono problemy"
	$mIDToPolish.Item(182) = "Podczas odczytu folderu ToolTime wystąpiły problemy:"
	$mIDToPolish.Item(183) = "Zbyt wiele pozycji w '%1': znaleziono %2, wyświetlono tylko %3. Niewyświetlone: %4"
	$mIDToPolish.Item(184) = "Folder pominięty (przekroczono maksymalną liczbę %1 poziomów menu): %2"
	$mIDToPolish.Item(185) = "Nie można odczytać skrótu, został pominięty: %1"
	$mIDToPolish.Item(186) = "Zbyt wiele pozycji łącznie (limit %1): pozostałe pozycje nie są wyświetlane."
	$mIDToPolish.Item(187) = "Maksymalna liczba pozycji w jednym menu wynosi %1. Można ją zmienić w pliku ustawień ([ToolTime] MaxEntries, 10 - 20)."
	$mIDToPolish.Item(188) = "Podczas odczytu folderu ToolTime znaleziono problemy. Kliknij w menu pozycję oznaczoną (!), aby zobaczyć szczegóły."
	$mIDToPolish.Item(189) = "Nie znaleziono folderu ToolTime i nie udało się go utworzyć: %1"
	$mIDToPolish.Item(190) = "Każdy podfolder staje się podmenu, a każdy skrót (plik .lnk) pozycją menu. Wszystkie inne pliki, takie jak ten, są pomijane."
	$mIDToPolish.Item(191) = "Wyświetlane jest co najwyżej %1 poziomów menu (menu ToolTime i jego podmenu) oraz co najwyżej %2 pozycji łącznie. Pozycje ponad limit nie są wyświetlane, zamiast tego w menu dodawana jest informacja."
	$mIDToPolish.Item(192) = "Kolejność: najpierw foldery, potem skróty, każda grupa posortowana według nazwy. Dwu- lub trzycyfrowa liczba i podkreślenie przed nazwą określają kolejność; liczba nie jest wyświetlana w menu."
	$mIDToPolish.Item(193) = "Przykład:"

EndFunc   ;==>CreateMapIDToPolish

Func CreateMapIDToItalian()
	$mIDToItalian.Item(100) = "non compilato (Debug)"
	$mIDToItalian.Item(101) = "Monitor e sistema"
	$mIDToItalian.Item(102) = "Monitor"
	$mIDToItalian.Item(103) = "Sistema"
	$mIDToItalian.Item(104) = "Disattivato"
	$mIDToItalian.Item(105) = "Salva stato"
	$mIDToItalian.Item(106) = "Hotkey attivo ( "
	$mIDToItalian.Item(107) = "ALT + "
	$mIDToItalian.Item(108) = "MAIUSC + "
	$mIDToItalian.Item(109) = "Cambia hotkey"
	$mIDToItalian.Item(110) = "Mostra tooltip"
	$mIDToItalian.Item(111) = "Impostazioni"
	$mIDToItalian.Item(112) = "Avvia automaticamente"
	$mIDToItalian.Item(113) = "Crea file di registro"
	$mIDToItalian.Item(114) = "Visualizza file di registro"
	$mIDToItalian.Item(115) = "Usa icone grandi"
	$mIDToItalian.Item(116) = "Modifica file di impostazioni"
	$mIDToItalian.Item(117) = "Informazioni"
	$mIDToItalian.Item(118) = "Esci"
	$mIDToItalian.Item(119) = "Attivazione del file di registro"
	$mIDToItalian.Item(120) = "Disattivazione di KeepAwake"
	$mIDToItalian.Item(121) = "Imposta hotkey"
	$mIDToItalian.Item(122) = "Modificatore:"
	$mIDToItalian.Item(123) = "CTRL"
	$mIDToItalian.Item(124) = "ALT"
	$mIDToItalian.Item(125) = "MAIUSC"
	$mIDToItalian.Item(126) = "WIN"
	$mIDToItalian.Item(127) = "Lettera / Tasto:"
	$mIDToItalian.Item(128) = "Hotkey:"
	$mIDToItalian.Item(129) = "Nota: Non tutte le combinazioni sono possibili,"
	$mIDToItalian.Item(130) = "poiché alcune potrebbero essere in uso dal sistema o"
	$mIDToItalian.Item(131) = "da altri programmi."
	$mIDToItalian.Item(132) = "OK"
	$mIDToItalian.Item(133) = "Annulla"
	$mIDToItalian.Item(134) = "Nuovo hotkey: "
	$mIDToItalian.Item(135) = "CTRL + "
	$mIDToItalian.Item(136) = "Informazioni su "
	$mIDToItalian.Item(137) = "Un modo semplice per disattivare il risparmio energetico, uno strumento AlwaysOnTop e un modo rapido per avviare strumenti aggiuntivi dal menu della barra delle applicazioni."
	$mIDToItalian.Item(138) = "Avviso: Modificare la configurazione?"
	$mIDToItalian.Item(139) = "Vuoi modificare la configurazione estesa del file INI?"
	$mIDToItalian.Item(140) = "Non appena chiuderai l'editor, "
	$mIDToItalian.Item(141) = " leggerà e applicherà le nuove impostazioni !"
	$mIDToItalian.Item(142) = "Prompt dei comandi"
	$mIDToItalian.Item(143) = "Editor del Registro di sistema"
	$mIDToItalian.Item(144) = "Impostazioni di rete"
	$mIDToItalian.Item(145) = "Pannello di controllo"
	$mIDToItalian.Item(146) = "Monitor risorse"
	$mIDToItalian.Item(147) = "Monitor prestazioni"
	$mIDToItalian.Item(148) = "Gestisci servizi"
	$mIDToItalian.Item(149) = "Pulizia disco"
	$mIDToItalian.Item(150) = "Calcolatrice"
	$mIDToItalian.Item(151) = "KeepAwake disattivato"
	$mIDToItalian.Item(152) = "KeepAwake Sistema"
	$mIDToItalian.Item(153) = "KeepAwake Monitor"
	$mIDToItalian.Item(154) = "KeepAwake Monitor e sistema"
	$mIDToItalian.Item(155) = "ToolTime"
	$mIDToItalian.Item(156) = "KeepAwake"
	$mIDToItalian.Item(157) = "AlwaysOnTop"
	$mIDToItalian.Item(158) = '" AlwaysOnTop attivo'
	$mIDToItalian.Item(159) = '" AlwaysOnTop non attivo'
	$mIDToItalian.Item(162) = "File di registro non trovato: "
	$mIDToItalian.Item(163) = "Già in uso"
	$mIDToItalian.Item(164) = "Questa combinazione è già in uso o non valida."
	$mIDToItalian.Item(165) = "Scegli un'altra combinazione di tasti."
	$mIDToItalian.Item(166) = "Errore"
	$mIDToItalian.Item(167) = "Impossibile scrivere nel file di registro. Verifica se "
	$mIDToItalian.Item(168) = " ha i permessi di scrittura per il file "
	$mIDToItalian.Item(169) = ", oppure disattiva il file di registro nelle impostazioni INI. La registrazione è stata disattivata; "
	$mIDToItalian.Item(170) = " continuerà a funzionare."
	$mIDToItalian.Item(171) = "Hotkey attivo"
	$mIDToItalian.Item(172) = "WIN + "
	$mIDToItalian.Item(173) = " Versione: "
	$mIDToItalian.Item(174) = "Attiva KeepAwake"
	$mIDToItalian.Item(175) = "Attiva AlwaysOnTop"
	$mIDToItalian.Item(176) = "Attiva ToolTime"
	$mIDToItalian.Item(177) = "Apri cartella ToolTime"
	$mIDToItalian.Item(178) = "Ricarica strumenti"
	$mIDToItalian.Item(179) = "(!) ToolTime: rilevati problemi - fare clic per i dettagli"
	$mIDToItalian.Item(180) = "... altri %1 non visualizzati (limite %2)"
	$mIDToItalian.Item(181) = "ToolTime: rilevati problemi"
	$mIDToItalian.Item(182) = "Si sono verificati problemi durante la lettura della cartella ToolTime:"
	$mIDToItalian.Item(183) = "Troppe voci in '%1': trovate %2, ne vengono mostrate solo %3. Non mostrate: %4"
	$mIDToItalian.Item(184) = "Cartella ignorata (superato il massimo di %1 livelli di menu): %2"
	$mIDToItalian.Item(185) = "Impossibile leggere il collegamento, ignorato: %1"
	$mIDToItalian.Item(186) = "Troppe voci in totale (limite %1): le voci rimanenti non vengono mostrate."
	$mIDToItalian.Item(187) = "Il numero massimo di voci per menu è %1. Può essere modificato nel file di impostazioni ([ToolTime] MaxEntries, 10 - 20)."
	$mIDToItalian.Item(188) = "Sono stati rilevati problemi durante la lettura della cartella ToolTime. Fare clic sulla voce contrassegnata con (!) nel menu per i dettagli."
	$mIDToItalian.Item(189) = "La cartella ToolTime non è stata trovata e non è stato possibile crearla: %1"
	$mIDToItalian.Item(190) = "Ogni sottocartella diventa un sottomenu e ogni collegamento (file .lnk) diventa una voce di menu. Tutti gli altri file, come questo, vengono ignorati."
	$mIDToItalian.Item(191) = "Vengono mostrati al massimo %1 livelli di menu (il menu ToolTime e i suoi sottomenu) e al massimo %2 voci in totale. Le voci oltre un limite non vengono mostrate; al loro posto viene aggiunta una nota al menu."
	$mIDToItalian.Item(192) = "Ordine: prima le cartelle, poi i collegamenti, ciascun gruppo in ordine alfabetico. Un numero di due o tre cifre seguito da un carattere di sottolineatura davanti al nome definisce l'ordine; il numero non viene mostrato nel menu."
	$mIDToItalian.Item(193) = "Esempio:"

EndFunc   ;==>CreateMapIDToItalian

Func CreateMapIDToRussian()
	$mIDToRussian.Item(100) = "не скомпилировано (Debug)"
	$mIDToRussian.Item(101) = "Мониторы и система"
	$mIDToRussian.Item(102) = "Мониторы"
	$mIDToRussian.Item(103) = "Система"
	$mIDToRussian.Item(104) = "Отключено"
	$mIDToRussian.Item(105) = "Сохранить состояние"
	$mIDToRussian.Item(106) = "Горячая клавиша активна ( "
	$mIDToRussian.Item(107) = "ALT + "
	$mIDToRussian.Item(108) = "SHIFT + "
	$mIDToRussian.Item(109) = "Изменить горячую клавишу"
	$mIDToRussian.Item(110) = "Показывать подсказку"
	$mIDToRussian.Item(111) = "Настройки"
	$mIDToRussian.Item(112) = "Запускать автоматически"
	$mIDToRussian.Item(113) = "Создавать файл журнала"
	$mIDToRussian.Item(114) = "Просмотреть файл журнала"
	$mIDToRussian.Item(115) = "Использовать большие значки"
	$mIDToRussian.Item(116) = "Редактировать файл настроек"
	$mIDToRussian.Item(117) = "О программе"
	$mIDToRussian.Item(118) = "Выход"
	$mIDToRussian.Item(119) = "Включение файла журнала"
	$mIDToRussian.Item(120) = "Отключение KeepAwake"
	$mIDToRussian.Item(121) = "Задать горячую клавишу"
	$mIDToRussian.Item(122) = "Модификатор:"
	$mIDToRussian.Item(123) = "CTRL"
	$mIDToRussian.Item(124) = "ALT"
	$mIDToRussian.Item(125) = "SHIFT"
	$mIDToRussian.Item(126) = "WIN"
	$mIDToRussian.Item(127) = "Буква / клавиша:"
	$mIDToRussian.Item(128) = "Горячая клавиша:"
	$mIDToRussian.Item(129) = "Примечание: Не все комбинации возможны,"
	$mIDToRussian.Item(130) = "так как некоторые могут использоваться системой или"
	$mIDToRussian.Item(131) = "другими программами."
	$mIDToRussian.Item(132) = "ОК"
	$mIDToRussian.Item(133) = "Отмена"
	$mIDToRussian.Item(134) = "Новая горячая клавиша: "
	$mIDToRussian.Item(135) = "CTRL + "
	$mIDToRussian.Item(136) = "О программе "
	$mIDToRussian.Item(137) = "Простой способ отключить энергосбережение, инструмент AlwaysOnTop и быстрый способ запуска дополнительных инструментов из меню в трее."
	$mIDToRussian.Item(138) = "Предупреждение: Изменить конфигурацию?"
	$mIDToRussian.Item(139) = "Хотите изменить расширенную конфигурацию файла INI?"
	$mIDToRussian.Item(140) = "Как только вы закроете редактор, "
	$mIDToRussian.Item(141) = " прочитает и применит новые настройки !"
	$mIDToRussian.Item(142) = "Командная строка"
	$mIDToRussian.Item(143) = "Редактор реестра"
	$mIDToRussian.Item(144) = "Сетевые настройки"
	$mIDToRussian.Item(145) = "Панель управления"
	$mIDToRussian.Item(146) = "Монитор ресурсов"
	$mIDToRussian.Item(147) = "Монитор производительности"
	$mIDToRussian.Item(148) = "Управление службами"
	$mIDToRussian.Item(149) = "Очистка диска"
	$mIDToRussian.Item(150) = "Калькулятор"
	$mIDToRussian.Item(151) = "KeepAwake отключен"
	$mIDToRussian.Item(152) = "KeepAwake Система"
	$mIDToRussian.Item(153) = "KeepAwake Мониторы"
	$mIDToRussian.Item(154) = "KeepAwake Мониторы и система"
	$mIDToRussian.Item(155) = "ToolTime"
	$mIDToRussian.Item(156) = "KeepAwake"
	$mIDToRussian.Item(157) = "AlwaysOnTop"
	$mIDToRussian.Item(158) = '" AlwaysOnTop активен'
	$mIDToRussian.Item(159) = '" AlwaysOnTop не активен'
	$mIDToRussian.Item(162) = "Файл журнала не найден: "
	$mIDToRussian.Item(163) = "Занято"
	$mIDToRussian.Item(164) = "Эта комбинация уже используется или недействительна."
	$mIDToRussian.Item(165) = "Пожалуйста, выберите другую горячую клавишу."
	$mIDToRussian.Item(166) = "Ошибка"
	$mIDToRussian.Item(167) = "Не удалось записать в файл журнала. Проверьте, имеет ли "
	$mIDToRussian.Item(168) = " права на запись в файл "
	$mIDToRussian.Item(169) = ", либо отключите файл журнала в настройках INI. Ведение журнала отключено; "
	$mIDToRussian.Item(170) = " продолжит работу."
	$mIDToRussian.Item(171) = "Горячая клавиша активна"
	$mIDToRussian.Item(172) = "WIN + "
	$mIDToRussian.Item(173) = " Версия: "
	$mIDToRussian.Item(174) = "Включить KeepAwake"
	$mIDToRussian.Item(175) = "Включить AlwaysOnTop"
	$mIDToRussian.Item(176) = "Включить ToolTime"
	$mIDToRussian.Item(177) = "Открыть папку ToolTime"
	$mIDToRussian.Item(178) = "Перезагрузить инструменты"
	$mIDToRussian.Item(179) = "(!) ToolTime: обнаружены проблемы - щёлкните для подробностей"
	$mIDToRussian.Item(180) = "... ещё %1 не показано (лимит %2)"
	$mIDToRussian.Item(181) = "ToolTime: обнаружены проблемы"
	$mIDToRussian.Item(182) = "При чтении папки ToolTime возникли проблемы:"
	$mIDToRussian.Item(183) = "Слишком много элементов в '%1': найдено %2, показано только %3. Не показаны: %4"
	$mIDToRussian.Item(184) = "Папка пропущена (превышено максимальное число уровней меню: %1): %2"
	$mIDToRussian.Item(185) = "Не удалось прочитать ярлык, он пропущен: %1"
	$mIDToRussian.Item(186) = "Слишком много элементов в целом (лимит %1): остальные элементы не показываются."
	$mIDToRussian.Item(187) = "Максимальное число элементов в одном меню — %1. Его можно изменить в файле настроек ([ToolTime] MaxEntries, 10 - 20)."
	$mIDToRussian.Item(188) = "При чтении папки ToolTime обнаружены проблемы. Щёлкните в меню элемент, помеченный (!), чтобы увидеть подробности."
	$mIDToRussian.Item(189) = "Папка ToolTime не найдена и не может быть создана: %1"
	$mIDToRussian.Item(190) = "Каждая подпапка становится подменю, а каждый ярлык (файл .lnk) — пунктом меню. Все остальные файлы, как этот, игнорируются."
	$mIDToRussian.Item(191) = "Показывается не более %1 уровней меню (меню ToolTime и его подменю) и не более %2 элементов в целом. Элементы сверх лимита не показываются, вместо них в меню добавляется примечание."
	$mIDToRussian.Item(192) = "Порядок: сначала папки, затем ярлыки, каждая группа сортируется по имени. Число из двух или трёх цифр и знак подчёркивания перед именем задают порядок; число в меню не показывается."
	$mIDToRussian.Item(193) = "Пример:"
EndFunc   ;==>CreateMapIDToRussian

Func CreateMapIDToHungarian()
	$mIDToHungarian.Item(100) = "nem lefordítva (Debug)"
	$mIDToHungarian.Item(101) = "Monitorok és rendszer"
	$mIDToHungarian.Item(102) = "Monitorok"
	$mIDToHungarian.Item(103) = "Rendszer"
	$mIDToHungarian.Item(104) = "Letiltva"
	$mIDToHungarian.Item(105) = "Állapot mentése"
	$mIDToHungarian.Item(106) = "Gyorsbillentyű aktív ( "
	$mIDToHungarian.Item(107) = "ALT + "
	$mIDToHungarian.Item(108) = "SHIFT + "
	$mIDToHungarian.Item(109) = "Gyorsbillentyű módosítása"
	$mIDToHungarian.Item(110) = "Súgóbuborék megjelenítése"
	$mIDToHungarian.Item(111) = "Beállítások"
	$mIDToHungarian.Item(112) = "Automatikus indítás"
	$mIDToHungarian.Item(113) = "Naplófájl létrehozása"
	$mIDToHungarian.Item(114) = "Naplófájl megtekintése"
	$mIDToHungarian.Item(115) = "Nagy ikonok használata"
	$mIDToHungarian.Item(116) = "Beállítási fájl szerkesztése"
	$mIDToHungarian.Item(117) = "Névjegy"
	$mIDToHungarian.Item(118) = "Kilépés"
	$mIDToHungarian.Item(119) = "Naplófájl engedélyezése"
	$mIDToHungarian.Item(120) = "KeepAwake letiltása"
	$mIDToHungarian.Item(121) = "Gyorsbillentyű beállítása"
	$mIDToHungarian.Item(122) = "Módosító:"
	$mIDToHungarian.Item(123) = "CTRL"
	$mIDToHungarian.Item(124) = "ALT"
	$mIDToHungarian.Item(125) = "SHIFT"
	$mIDToHungarian.Item(126) = "WIN"
	$mIDToHungarian.Item(127) = "Betű / billentyű:"
	$mIDToHungarian.Item(128) = "Gyorsbillentyű:"
	$mIDToHungarian.Item(129) = "Megjegyzés: Nem minden kombináció lehetséges,"
	$mIDToHungarian.Item(130) = "mivel néhányat a rendszer vagy"
	$mIDToHungarian.Item(131) = "más programok már használnak."
	$mIDToHungarian.Item(132) = "OK"
	$mIDToHungarian.Item(133) = "Mégse"
	$mIDToHungarian.Item(134) = "Új gyorsbillentyű: "
	$mIDToHungarian.Item(135) = "CTRL + "
	$mIDToHungarian.Item(136) = "Névjegy: "
	$mIDToHungarian.Item(137) = "Egyszerű módja az energiatakarékosság kikapcsolásának, egy AlwaysOnTop eszköz, valamint gyors mód további eszközök indítására a tálca menüjéből."
	$mIDToHungarian.Item(138) = "Figyelmeztetés: Módosítja a konfigurációt?"
	$mIDToHungarian.Item(139) = "Szeretné módosítani a kibővített INI fájl konfigurációját?"
	$mIDToHungarian.Item(140) = "Amint bezárja a szerkesztőt, "
	$mIDToHungarian.Item(141) = " beolvassa és alkalmazza az új beállításokat !"
	$mIDToHungarian.Item(142) = "Parancssor"
	$mIDToHungarian.Item(143) = "Rendszerleíró adatbázis-szerkesztő"
	$mIDToHungarian.Item(144) = "Hálózati beállítások"
	$mIDToHungarian.Item(145) = "Vezérlőpult"
	$mIDToHungarian.Item(146) = "Erőforrás-figyelő"
	$mIDToHungarian.Item(147) = "Teljesítményfigyelő"
	$mIDToHungarian.Item(148) = "Szolgáltatások kezelése"
	$mIDToHungarian.Item(149) = "Lemezkarbantartó"
	$mIDToHungarian.Item(150) = "Számológép"
	$mIDToHungarian.Item(151) = "KeepAwake letiltva"
	$mIDToHungarian.Item(152) = "KeepAwake Rendszer"
	$mIDToHungarian.Item(153) = "KeepAwake Monitorok"
	$mIDToHungarian.Item(154) = "KeepAwake Monitorok és rendszer"
	$mIDToHungarian.Item(155) = "ToolTime"
	$mIDToHungarian.Item(156) = "KeepAwake"
	$mIDToHungarian.Item(157) = "AlwaysOnTop"
	$mIDToHungarian.Item(158) = '" AlwaysOnTop aktív'
	$mIDToHungarian.Item(159) = '" AlwaysOnTop nem aktív'
	$mIDToHungarian.Item(162) = "Naplófájl nem található: "
	$mIDToHungarian.Item(163) = "Foglalt"
	$mIDToHungarian.Item(164) = "Ez a kombináció már foglalt, vagy érvénytelen."
	$mIDToHungarian.Item(165) = "Válassz másik gyorsbillentyűt."
	$mIDToHungarian.Item(166) = "Hiba"
	$mIDToHungarian.Item(167) = "A naplófájlba nem sikerült írni. Ellenőrizd, hogy a "
	$mIDToHungarian.Item(168) = " rendelkezik-e írási jogosultsággal a "
	$mIDToHungarian.Item(169) = " fájlhoz, vagy tiltsd le a naplófájlt az INI-beállításokban. A naplózás letiltva; a "
	$mIDToHungarian.Item(170) = " folytatja a működést."
	$mIDToHungarian.Item(171) = "Gyorsbillentyű aktív"
	$mIDToHungarian.Item(172) = "WIN + "
	$mIDToHungarian.Item(173) = " Verzió: "
	$mIDToHungarian.Item(174) = "KeepAwake bekapcsolása"
	$mIDToHungarian.Item(175) = "AlwaysOnTop bekapcsolása"
	$mIDToHungarian.Item(176) = "ToolTime bekapcsolása"
	$mIDToHungarian.Item(177) = "ToolTime mappa megnyitása"
	$mIDToHungarian.Item(178) = "Eszközök újratöltése"
	$mIDToHungarian.Item(179) = "(!) ToolTime: problémák találhatók - kattintson a részletekért"
	$mIDToHungarian.Item(180) = "... további %1 nem jelenik meg (korlát: %2)"
	$mIDToHungarian.Item(181) = "ToolTime: problémák találhatók"
	$mIDToHungarian.Item(182) = "A ToolTime mappa beolvasása közben problémák léptek fel:"
	$mIDToHungarian.Item(183) = "Túl sok elem itt: '%1': %2 található, csak %3 jelenik meg. Nem jelenik meg: %4"
	$mIDToHungarian.Item(184) = "A mappa figyelmen kívül hagyva (a legfeljebb %1 menüszint túllépve): %2"
	$mIDToHungarian.Item(185) = "A parancsikon nem olvasható, figyelmen kívül hagyva: %1"
	$mIDToHungarian.Item(186) = "Összesen túl sok elem (korlát: %1): a többi elem nem jelenik meg."
	$mIDToHungarian.Item(187) = "Az elemek maximális száma menünként %1. A beállítási fájlban módosítható ([ToolTime] MaxEntries, 10 - 20)."
	$mIDToHungarian.Item(188) = "A ToolTime mappa beolvasása közben problémák léptek fel. A részletekért kattintson a menüben a (!) jelű elemre."
	$mIDToHungarian.Item(189) = "A ToolTime mappa nem található, és nem hozható létre: %1"
	$mIDToHungarian.Item(190) = "Minden almappa almenüvé, minden parancsikon (.lnk fájl) menüelemmé válik. Az összes többi fájl, mint ez is, figyelmen kívül marad."
	$mIDToHungarian.Item(191) = "Legfeljebb %1 menüszint (a ToolTime menü és almenüi) és összesen legfeljebb %2 elem jelenik meg. A korlát feletti elemek nem jelennek meg, helyettük egy megjegyzés kerül a menübe."
	$mIDToHungarian.Item(192) = "Sorrend: először a mappák, utána a parancsikonok, mindkettő név szerint rendezve. A név előtti kétjegyű vagy háromjegyű szám és aláhúzás határozza meg a sorrendet; a szám nem jelenik meg a menüben."
	$mIDToHungarian.Item(193) = "Példa:"

EndFunc   ;==>CreateMapIDToHungarian


; ====================================================================================================
; Function: OnExit
; Description: Performs application shutdown cleanup by restoring normal power-management behavior,
;              releasing stored GDI bitmaps, saving configuration, and unregistering the hotkey.
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func OnExit()
	Logfile("OnExit() start", 6)
	Logfile("Releasing power saving", 6)
	; Reset the execution state
	If _WinAPI_SetThreadExecutionState($ES_CONTINUOUS) = 0 Then Logfile("Error: _WinAPI_SetThreadExecutionState($ES_CONTINUOUS) could not be executed successfully")
	Logfile("Stopping the ToolTime folder change detection", 6)
	ToolTimeStopWatch()
	Logfile("Releasing all GDI bitmaps", 6)
	;Release open GDI bitmaps
	DeleteAllhBitmaps()
	Logfile("Saving configuration", 6)
	;Save the configuration
	SaveSettings()
	Logfile("Removing hotkey: " & $sAlwaysOnTopHotKey, 6)
	;Unregister the hotkey
	HotKeySet($sAlwaysOnTopHotKey)
	Logfile("OnExit() end", 6)
EndFunc   ;==>OnExit
