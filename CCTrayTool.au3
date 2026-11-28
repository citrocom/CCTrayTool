#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icons\TrayWhite.ico
#AutoIt3Wrapper_Res_Fileversion=2026.0.0.115
#AutoIt3Wrapper_Res_ProductVersion=2026.0.0.115
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_Description=CCTrayTool - KeepAwake, AlwaysOnTop, CloseGuard and quick start tray tool
#AutoIt3Wrapper_Res_ProductName=CCTrayTool
#AutoIt3Wrapper_Res_CompanyName=CITRO Computer
#AutoIt3Wrapper_Res_LegalCopyright=(c) 2026 Markus Debus, CITRO Computer
#AutoIt3Wrapper_Res_Language=1033
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
#AutoIt3Wrapper_Res_Icon_Add=icons\CloseGuardLock.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\CloseGuardRule.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\CloseGuardList.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\SubmenuToolTime.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\SubmenuKeepAwake.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\SubmenuAlwaysOnTop.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\SubmenuCloseGuard.ico
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Run_Tidy=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; Version resources of the compiled EXE (file properties, Task Manager, Windows Firewall prompt):
; - Res_ProductVersion is always identical to Res_Fileversion; raise both together with every new version.
; - Res_Fileversion_AutoIncrement stays n on purpose: with =y the compiler would raise only the file
;   version and the product version would fall behind.
; - Res_Language 1033 = English (US), the base language of the program texts (German would be 1031).
; This comment stays below the #Region block, because the AutoIt3Wrapper GUI rewrites the block itself.

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

CCTrayTool is a lightweight Windows tray utility that bundles four things
people often reach for separately: **KeepAwake** (instantly suppress display
and/or system sleep without touching your Windows power plan), an
**AlwaysOnTop** toggle with a global hotkey for pinning the active window,
**CloseGuard** (locks the close button of chosen windows, by hotkey or by
rules), and a fully **configurable tray menu** for launching frequently used
tools and folders. The tools are plain shortcuts (.lnk files) in a folder structure -
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

- **Locking the close button.** The X of a window is controlled by the "Close"
  item in its system menu. CloseGuard removes that item with GetSystemMenu()
  and DeleteMenu(), so Windows draws the X grayed out, and resets the menu to
  give the X back. A hotkey or rules (window title and class, kept in a
  file of their own: CloseGuardRules.ini), which are checked in the background,
  decide which windows are locked. Optionally a click on the grayed-out X
  minimizes the window instead of doing nothing (the mouse button is polled
  briefly, there is no hook). Whether a window is locked
  is always read from its system menu and never assumed from a list, so windows
  that stayed locked after CCTrayTool was ended hard can be released again.

- **A few other details:** built-in support for eight languages, auto-detected
  from the OS; a global AlwaysOnTop hotkey the user can redefine from a small
  in-app dialog; and careful cleanup of every GDI bitmap handle the script
  creates, to avoid leaking OS resources over a long uptime.

### AI assistance

Parts of this project were created with AI assistance: the tray icon artwork,
the translations into the supported languages, the README, this text, and
portions of the AutoIt source code (including debugging and cleanup work) were
produced or refined with the help of an AI assistant.

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

;Rules of CloseGuard: an INI file of its own (section [Rules], "Number=Title|Class"), see CloseGuardEnsureRulesFile()
Global $sCloseGuardRulesFile = $sAppDataDir & "\CloseGuardRules.ini"

;Icons
#cs Icons

201 Tray white / off					205 red
202 Tray red / Monitors					206 green
203 Tray green / Monitors and System	207 blue
204 Tray blue / System					208 white

209 red active							213 About
210 green active						214 Exit
211 blue active							215 Keyboard
212 white active						216 Settings

217 GreenCheck
218 Empty
219 CloseGuard: lock/unlock (padlock)
220 CloseGuard: create rule (page with a plus)
221 CloseGuard: show locked windows (window with a padlock)

#ce Icons

Global $iIconNumberSettings = 216
Global $iIconNumberExit = 214
Global $iIconNumberAbout = 213
Global $iIconnumberKeyboard = 215
Global $iIconnumberGreenCheck = 217
Global $iIconnumberEmpty = 218
Global $iIconnumberCloseGuardLock = 219
Global $iIconnumberCloseGuardRule = 220
Global $iIconnumberCloseGuardList = 221
;Icons of the sections shown as submenus
Global $iIconnumberSubmenuToolTime = 222
Global $iIconnumberSubmenuKeepAwake = 223
Global $iIconnumberSubmenuAlwaysOnTop = 224
Global $iIconnumberSubmenuCloseGuard = 225

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
Global $bToolTimeSubmenuSetting = 0 ;1 = the section is shown as a submenu of the tray menu ([ToolTime] AsSubmenu)
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
Global $bKeepAwakeSubmenuSetting = 0 ;1 = the section is shown as a submenu of the tray menu ([KeepAwake] AsSubmenu)
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
Global $bAlwaysOnTopSubmenuSetting = 0 ;1 = the section is shown as a submenu of the tray menu ([AlwaysOnTop] AsSubmenu)
Global $bActivateAlwaysOnTopHotKey = 1
Global $sAlwaysOnTopHotKey = "+!t"
Global $bAlwaysOnTopShowToolTip = 1

;CloseGuard (see the CloseGuard section further down)
Global $bCloseGuardEnabledSetting = 0 ;off after a new installation; the first switch-on shows a one-time notice
Global $bCloseGuardSubmenuSetting = 0 ;1 = the section is shown as a submenu of the tray menu ([CloseGuard] AsSubmenu)
Global Const $sCloseGuardHotkeyToggleDefault = "^!x"
Global Const $sCloseGuardHotkeyAddRuleDefault = "^!+x"
Global $sCloseGuardHotkeyToggle = $sCloseGuardHotkeyToggleDefault
Global $sCloseGuardHotkeyAddRule = $sCloseGuardHotkeyAddRuleDefault
Global $bCloseGuardApplyOnStartup = 1 ;check the windows that are open at program start (otherwise they are exempt)
Global $bCloseGuardAutoApply = 1 ;check new windows automatically
Global Const $iCloseGuardPollMin = 250
Global Const $iCloseGuardPollMax = 5000
Global Const $iCloseGuardPollDefault = 500
Global $iCloseGuardPollInterval = $iCloseGuardPollDefault
Global $bCloseGuardMinimizeOnClick = 0 ;1 = a click on the locked X minimizes the window (the mouse button is polled, no hook)
Global Const $iCloseGuardClickMin = 10
Global Const $iCloseGuardClickMax = 100
Global Const $iCloseGuardClickDefault = 30
Global $iCloseGuardClickInterval = $iCloseGuardClickDefault ;ms, how often the mouse button is polled
Global $bCloseGuardClickGeometry = 1 ;1 = also recognize the X by its position (windows with their own title bar, e.g. Outlook)
Global Const $iCloseGuardExtendMax = 100
Global Const $iCloseGuardExtendLeftDefault = 0
Global Const $iCloseGuardExtendDownDefault = 87
Global $iCloseGuardClickExtendLeft = $iCloseGuardExtendLeftDefault ;percent of the width of the X: the area reaches this far to the left
Global $iCloseGuardClickExtendDown = $iCloseGuardExtendDownDefault ;percent of the height of the X: the area reaches this far down
Global $bCloseGuardClickDebug = 0 ;1 = show the areas of the click detection as transparent rectangles (for troubleshooting)
Global Const $sCloseGuardShieldClassesDefault = "Chrome_WidgetWin_1,MozillaWindowClass"
Global $sCloseGuardShieldClasses = $sCloseGuardShieldClassesDefault ;window classes whose X cannot be locked: they get a shield over the X (see "Shield")
Global $sCG_ShieldClassList = "" ;the same, as "|class|class|" in lower case (for the comparison), see _CloseGuardParseShieldClasses()
Global Const $iCloseGuardMaxRules = 200
Global Const $iCG_TickInterval = 250 ;ms, how often CloseGuardTick() runs
Global Const $iCG_SC_CLOSE = 0xF060 ;system command "Close"
Global Const $iCG_WS_SYSMENU = 0x00080000 ;window style: the window has a system menu (and therefore an X)
Global Const $iCG_GWL_STYLE = -16
Global Const $iCG_SWP_REDRAW = 0x4037 ;NOSIZE | NOMOVE | NOZORDER | NOACTIVATE | FRAMECHANGED | ASYNCWINDOWPOS
Global Const $iCG_SC_MINIMIZE = 0xF020 ;system command "Minimize"
Global Const $iCG_WM_SYSCOMMAND = 0x0112
Global Const $iCG_WM_NCHITTEST = 0x0084
Global Const $iCG_HTCLOSE = 20 ;result of WM_NCHITTEST: the mouse is on the close button
Global Const $iCG_ClickMaxHold = 3000 ;ms, a press on the X that lasts longer is ignored
Global Const $iCG_MinimizeCheckDelay = 300 ;ms until it is checked whether the window has been minimized
Global Const $iCG_DWMWA_CAPTION_BUTTON_BOUNDS = 5 ;DwmGetWindowAttribute: area of the caption buttons (window-relative)
Global Const $iCG_WS_MINIMIZEBOX = 0x00020000
Global Const $iCG_WS_MAXIMIZEBOX = 0x00010000
Global Const $iCG_DiagMax = 40 ;at most so many diagnosis lines per program run
Global $oCG_Locked = ObjCreate("Scripting.Dictionary") ;window -> reason (1 = rule, 2 = by hand)
Global $oCG_Overlay = ObjCreate("Scripting.Dictionary") ;locked window -> "handle of the red overlay|handle of the blue overlay"
Global $oCG_OverlayHandles = ObjCreate("Scripting.Dictionary") ;handles of all overlay windows (they never take part in the hit test)
Global Const $iCG_OvStyle = 0x88000000 ;WS_POPUP | WS_DISABLED (WindowFromPoint does not return disabled windows)
Global Const $iCG_OvExStyle = 0x080800A8 ;WS_EX_LAYERED | WS_EX_TRANSPARENT (click-through) | WS_EX_TOPMOST | WS_EX_TOOLWINDOW | WS_EX_NOACTIVATE
Global $oCG_Exempt = ObjCreate("Scripting.Dictionary") ;window -> reason (1 = open at start, 2 = released by the user, 3 = could not be locked)
Global $oCG_ClassCache = ObjCreate("Scripting.Dictionary") ;window -> window class
Global $oCG_NoDwm = ObjCreate("Scripting.Dictionary") ;window -> 1 = the log line about missing caption button data was written
Global $oCG_Shield = ObjCreate("Scripting.Dictionary") ;locked window -> handle of its shield (see "Shield")
Global $oCG_ShieldOwner = ObjCreate("Scripting.Dictionary") ;handle of a shield -> the locked window it belongs to
Global $oCG_ShieldRect = ObjCreate("Scripting.Dictionary") ;locked window -> "x,y,w,h" of its shield, or "hidden"
Global $oCG_ShieldGeo = ObjCreate("Scripting.Dictionary") ;locked window -> "window size|offsets of the X" (found by asking the window)
Global $oCG_ScanGeo = ObjCreate("Scripting.Dictionary") ;window -> "window size|offsets of the X" (windows without DWM data: found by asking the window)
Global $oCG_ScanFail = ObjCreate("Scripting.Dictionary") ;window -> "window size|time of the search" (the search found nothing)
Global Const $iCG_ScanRetry = 3000 ;ms until a search for the X that found nothing is repeated
Global Const $iCG_ShieldStyle = 0x80000000 ;WS_POPUP
Global Const $iCG_ShieldExStyle = 0x08080088 ;WS_EX_LAYERED | WS_EX_TOPMOST | WS_EX_TOOLWINDOW | WS_EX_NOACTIVATE (takes the mouse, unlike the overlay)
Global Const $iCG_ShieldInterval = 100 ;ms between two updates of the shields
Global $bCG_ShieldDue = False ;True = update the shields at the next poll
Global $bCG_ShieldFailed = False ;True = the log line about a shield that could not be created was written
Global $hCG_ShieldTimer = TimerInit()
Global $oCG_GeoNeed = ObjCreate("Scripting.Dictionary") ;window -> 1 = reports its X only by position (fallback needed), 0 = reports HTCLOSE
Global $aCG_RuleTitle[1] ;rules: title text (index 1 .. $iCG_RuleCount)
Global $aCG_RuleClass[1] ;rules: window class
Global $iCG_RuleCount = 0
Global $hCG_LastForeign = 0 ;the window the user worked in last (target of the tray menu actions)
Global $iCG_BusyDepth = 0 ;> 0 while an action runs, the automatic check waits for the next tick
Global $hCG_PollTimer = TimerInit()
Global $sCG_Note = "" ;message that is shown as soon as the tray icon exists
Global $bCG_Running = False ;True between CloseGuardStart() and CloseGuardStop()
;Click on the locked X (see "Click on the locked X" below)
Global $bCG_ClickTimerOn = False
Global $iCG_ClickTimerInterval = 0 ;interval the timer was registered with
Global $bCG_ClickBusy = False
Global $bCG_BtnDown = False ;state of the primary mouse button at the last poll
Global $bCG_SwapButtons = False ;mouse buttons swapped (left-handed setting)
Global $hCG_SwapTimer = 0
Global $hCG_PressWnd = 0 ;locked window whose X is pressed right now
Global $hCG_PressTimer = 0
Global $hCG_ClickPollLast = 0
Global $iCG_VerifyStage = 0 ;0 = nothing to check, 1 = after the minimize command, 2 = after the fallback
Global $hCG_VerifyWnd = 0
Global $hCG_VerifyTimer = 0
Global $bCG_DpiWarned = False
;Counters for the log (written when CloseGuard is stopped)
Global $iCG_StatPolls = 0
Global $fCG_StatMaxGap = 0
Global $iCG_StatPresses = 0
Global $iCG_StatMinimized = 0
Global $iCG_StatCancelled = 0
Global $iCG_DiagCount = 0

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
Logfile("CloseGuard rules file: " & $sCloseGuardRulesFile)
Logfile("ToolTime enabled: " & $bToolTimeEnabledSetting, 6)
Logfile("ToolTime as submenu: " & $bToolTimeSubmenuSetting, 6)
Logfile("ToolTime entries per menu: " & $iToolTimeMaxEntriesSetting, 6)
Logfile("KeepAwake enabled: " & $bKeepAwakeEnabledSetting, 6)
Logfile("KeepAwake as submenu: " & $bKeepAwakeSubmenuSetting, 6)
Logfile("Save KeepAwake status: " & $bRestoreKeepAwakeStateSetting, 6)
Logfile("Saved KeepAwake status: " & $iKeepAwakeStateSetting, 6)
Logfile("Autostart: " & $bAutostartSetting, 6)
Logfile("Use log file: " & $bUseLogSetting, 6)
Logfile("AlwaysOnTop enabled: " & $bAlwaysOnTopEnabledSetting, 6)
Logfile("AlwaysOnTop as submenu: " & $bAlwaysOnTopSubmenuSetting, 6)
Logfile("Enable AlwaysOnTop hotkey: " & $bActivateAlwaysOnTopHotKey, 6)
Logfile("AlwaysOnTop hotkey: " & $sAlwaysOnTopHotKey, 6)
Logfile("Show AlwaysOnTop tooltip: " & $bAlwaysOnTopShowToolTip, 6)
Logfile("CloseGuard enabled: " & $bCloseGuardEnabledSetting, 6)
Logfile("CloseGuard as submenu: " & $bCloseGuardSubmenuSetting, 6)
Logfile("CloseGuard hotkey lock/unlock: " & $sCloseGuardHotkeyToggle, 6)
Logfile("CloseGuard hotkey create rule: " & $sCloseGuardHotkeyAddRule, 6)
Logfile("CloseGuard check windows open at start: " & $bCloseGuardApplyOnStartup, 6)
Logfile("CloseGuard check new windows automatically: " & $bCloseGuardAutoApply, 6)
Logfile("CloseGuard poll interval: " & $iCloseGuardPollInterval, 6)
Logfile("CloseGuard minimize on click of the locked X: " & $bCloseGuardMinimizeOnClick, 6)
Logfile("CloseGuard mouse poll interval: " & $iCloseGuardClickInterval, 6)
Logfile("CloseGuard window classes whose X gets a shield: " & $sCloseGuardShieldClasses, 6)
Logfile("CloseGuard position fallback for the locked X: " & $bCloseGuardClickGeometry & ", extension to the left " & $iCloseGuardClickExtendLeft & " %, downwards " & $iCloseGuardClickExtendDown & " %", 6)
Logfile("CloseGuard debug overlay for the click detection: " & $bCloseGuardClickDebug, 6)
Logfile("CloseGuard rules: " & $iCG_RuleCount, 6)
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
Global $iToolTimeRootMenu = 0 ;submenu that holds the ToolTime entries (0 = the tray menu itself)
;KeepAwake
Global $iTitelKeepAwake
Global $iDisplaySystem
Global $iDisplay
Global $iSystem
Global $iDeactivated
Global $iKeepLastKeepAwakeState
Global $iSepKeepAwake
Global $iKeepAwakeSettingsMenu = 0 ;submenu "Settings" of KeepAwake
;AlwaysOnTop
Global $iTitelAlwaysOnTop
Global $iActivateAOTHotKeyTrayItem
Global $iMenuId_iActivateAOTHotKeyTrayItem ;used to set icon
Global $iSetAOTHotKeyTrayItem
Global $iAlwaysOnTopShowToolTipTrayItem
Global $iSepAlwaysOnTop
Global $iAlwaysOnTopSettingsMenu = 0 ;submenu "Settings" of AlwaysOnTop
;CloseGuard
Global $iTitelCloseGuard = 0
;Settings: "<section> as submenu"
Global $iToolTimeSubmenuTrayItem = 0
Global $iKeepAwakeSubmenuTrayItem = 0
Global $iAlwaysOnTopSubmenuTrayItem = 0
Global $iCloseGuardSubmenuTrayItem = 0
Global $iCloseGuardToggleTrayItem = 0
Global $iCloseGuardAddRuleTrayItem = 0
Global $iCloseGuardListTrayItem = 0
Global $iCloseGuardSettingsMenu = 0 ;submenu "Settings" of CloseGuard
Global $iCloseGuardAutoTrayItem = 0
Global $iCloseGuardStartTrayItem = 0
Global $iCloseGuardMinimizeTrayItem = 0
Global $iSepCloseGuardMenuB = 0
Global $iCloseGuardHotkeyToggleTrayItem = 0
Global $iCloseGuardHotkeyAddRuleTrayItem = 0
Global $iCloseGuardEditRulesTrayItem = 0
Global $iSepCloseGuard = 0
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
Global $iCloseGuardEnabledTrayItem = 0
Global $iSepCloseGuardEnabled = 0
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

;CloseGuard: lock the windows that match the rules and start the automatic check
If $bCloseGuardEnabledSetting = 1 Then CloseGuardStart()

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

		Case $iToolTimeSubmenuTrayItem
			CheckSectionSubmenu(0)

		Case $iKeepAwakeSubmenuTrayItem
			CheckSectionSubmenu(1)

		Case $iAlwaysOnTopSubmenuTrayItem
			CheckSectionSubmenu(2)

		Case $iCloseGuardSubmenuTrayItem
			CheckSectionSubmenu(3)

		Case $iAlwaysOnTopEnabledTrayItem
			CheckAlwaysOnTopEnabled()

		Case $iActivateAOTHotKeyTrayItem
			CheckAOTTrayItem()

		Case $iSetAOTHotKeyTrayItem
			SetAOTHotkey()

		Case $iAlwaysOnTopShowToolTipTrayItem
			CheckAOTShowToolTipTrayItem()

		Case $iCloseGuardEnabledTrayItem
			CheckCloseGuardEnabled()

		Case $iCloseGuardToggleTrayItem
			CloseGuardToggleMenu()

		Case $iCloseGuardAddRuleTrayItem
			CloseGuardAddRuleMenu()

		Case $iCloseGuardListTrayItem
			CloseGuardShowLocked()

		Case $iCloseGuardAutoTrayItem
			CheckCloseGuardAutoTrayItem()

		Case $iCloseGuardStartTrayItem
			CheckCloseGuardStartTrayItem()

		Case $iCloseGuardMinimizeTrayItem
			CheckCloseGuardMinimizeTrayItem()

		Case $iCloseGuardHotkeyToggleTrayItem
			SetCloseGuardHotkey(1)

		Case $iCloseGuardHotkeyAddRuleTrayItem
			SetCloseGuardHotkey(2)

		Case $iCloseGuardEditRulesTrayItem
			CloseGuardEditRules()

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

	;CloseGuard enabled/disabled: like AlwaysOnTop above, the checkbox icons are set directly (the Check
	;functions toggle relative to the current value of their setting). The hotkeys are registered here; the
	;automatic check and the lock of the windows are started by CloseGuardStart().
	If $bCloseGuardEnabledSetting = 1 Then
		_CloseGuardSetItemIcon($iCloseGuardEnabledTrayItem, True)
		_CloseGuardSetItemIcon($iCloseGuardAutoTrayItem, $bCloseGuardAutoApply = 1)
		_CloseGuardSetItemIcon($iCloseGuardStartTrayItem, $bCloseGuardApplyOnStartup = 1)
		_CloseGuardSetItemIcon($iCloseGuardMinimizeTrayItem, $bCloseGuardMinimizeOnClick = 1)
		_CloseGuardRegisterHotkeys()
	Else
		;CloseGuard is disabled entirely: make sure the hotkeys are not registered
		Logfile("CloseGuard disabled, removing hotkeys: " & $sCloseGuardHotkeyToggle & " " & $sCloseGuardHotkeyAddRule, 6)
		HotKeySet($sCloseGuardHotkeyToggle)
		HotKeySet($sCloseGuardHotkeyAddRule)
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
	IniWrite($sIniFile, "KeepAwake", "AsSubmenu", "0")
	IniWrite($sIniFile, "KeepAwake", "KeepState", "1")
	IniWrite($sIniFile, "KeepAwake", "State", "0")
	FileWrite($sIniFile, @CRLF)

	IniWrite($sIniFile, "AlwaysOnTop", "Enabled", "1")
	IniWrite($sIniFile, "AlwaysOnTop", "AsSubmenu", "0")
	IniWrite($sIniFile, "AlwaysOnTop", "Active", "1")
	IniWrite($sIniFile, "AlwaysOnTop", "HotKey", "+!t")
	IniWrite($sIniFile, "AlwaysOnTop", "ShowToolTip", "1")
	FileWrite($sIniFile, @CRLF)

	IniWrite($sIniFile, "ToolTime", "Enabled", "1")
	IniWrite($sIniFile, "ToolTime", "AsSubmenu", "0")
	IniWrite($sIniFile, "ToolTime", "MaxEntries", $iToolTimeMaxEntriesDefault)
	IniWrite($sIniFile, "ToolTime", "Folder", "")
	FileWrite($sIniFile, @CRLF)

	IniWrite($sIniFile, "CloseGuard", "Enabled", "0") ;off after a new installation
	IniWrite($sIniFile, "CloseGuard", "AsSubmenu", "0")
	IniWrite($sIniFile, "CloseGuard", "HotkeyToggle", $sCloseGuardHotkeyToggleDefault)
	IniWrite($sIniFile, "CloseGuard", "HotkeyAddRule", $sCloseGuardHotkeyAddRuleDefault)
	IniWrite($sIniFile, "CloseGuard", "ApplyOnStartup", "1")
	IniWrite($sIniFile, "CloseGuard", "AutoApply", "1")
	IniWrite($sIniFile, "CloseGuard", "PollInterval", $iCloseGuardPollDefault)
	IniWrite($sIniFile, "CloseGuard", "MinimizeOnClick", "0")
	IniWrite($sIniFile, "CloseGuard", "ClickPollInterval", $iCloseGuardClickDefault)
	IniWrite($sIniFile, "CloseGuard", "ClickGeometryFallback", "1")
	IniWrite($sIniFile, "CloseGuard", "ClickGeometryExtendLeft", $iCloseGuardExtendLeftDefault)
	IniWrite($sIniFile, "CloseGuard", "ClickGeometryExtendDown", $iCloseGuardExtendDownDefault)
	IniWrite($sIniFile, "CloseGuard", "ClickDebugOverlay", "0")
	IniWrite($sIniFile, "CloseGuard", "ClickShieldClasses", $sCloseGuardShieldClassesDefault)
	CloseGuardEnsureRulesFile() ;the rules are not part of this INI file, they have a file of their own

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
	$iToolTimeRootMenu = 0

	;KeepAwake
	If $bKeepAwakeEnabledSetting = 1 Then
		TrayItemDelete($iTitelKeepAwake)
		TrayItemDelete($iDisplaySystem)
		TrayItemDelete($iDisplay)
		TrayItemDelete($iSystem)
		TrayItemDelete($iDeactivated)
		TrayItemDelete($iKeepAwakeSettingsMenu) ;also deletes the items in the submenu
		If $iSepKeepAwake <> 0 Then TrayItemDelete($iSepKeepAwake) ;no separator between two sections shown as submenus
	EndIf
	;Reset to 0 regardless - see comment above
	$iTitelKeepAwake = 0
	$iDisplaySystem = 0
	$iDisplay = 0
	$iSystem = 0
	$iDeactivated = 0
	$iKeepAwakeSettingsMenu = 0
	$iKeepLastKeepAwakeState = 0
	$iSepKeepAwake = 0

	;AlwaysOnTop
	$iMenuId_iActivateAOTHotKeyTrayItem = 0
	If $bAlwaysOnTopEnabledSetting = 1 Then
		TrayItemDelete($iTitelAlwaysOnTop)
		TrayItemDelete($iActivateAOTHotKeyTrayItem)
		TrayItemDelete($iAlwaysOnTopSettingsMenu) ;also deletes the items in the submenu
		If $iSepAlwaysOnTop <> 0 Then TrayItemDelete($iSepAlwaysOnTop) ;no separator between two sections shown as submenus
	EndIf
	;Reset to 0 regardless - see comment above
	$iTitelAlwaysOnTop = 0
	$iActivateAOTHotKeyTrayItem = 0
	$iAlwaysOnTopSettingsMenu = 0
	$iSetAOTHotKeyTrayItem = 0
	$iAlwaysOnTopShowToolTipTrayItem = 0
	$iSepAlwaysOnTop = 0

	;CloseGuard
	If $bCloseGuardEnabledSetting = 1 Then
		TrayItemDelete($iTitelCloseGuard)
		TrayItemDelete($iCloseGuardToggleTrayItem)
		TrayItemDelete($iCloseGuardAddRuleTrayItem)
		TrayItemDelete($iCloseGuardListTrayItem)
		TrayItemDelete($iCloseGuardSettingsMenu) ;also deletes all items in the submenu
		If $iSepCloseGuard <> 0 Then TrayItemDelete($iSepCloseGuard) ;no separator between two sections shown as submenus
	EndIf
	;Reset ALL CloseGuard IDs to 0 regardless of $bCloseGuardEnabledSetting - see comment above. This includes the
	;entry in the Settings menu (it is deleted together with the Settings menu below).
	$iTitelCloseGuard = 0
	$iCloseGuardToggleTrayItem = 0
	$iCloseGuardAddRuleTrayItem = 0
	$iCloseGuardListTrayItem = 0
	$iCloseGuardSettingsMenu = 0
	$iCloseGuardAutoTrayItem = 0
	$iCloseGuardStartTrayItem = 0
	$iCloseGuardMinimizeTrayItem = 0
	$iSepCloseGuardMenuB = 0
	$iCloseGuardHotkeyToggleTrayItem = 0
	$iCloseGuardHotkeyAddRuleTrayItem = 0
	$iCloseGuardEditRulesTrayItem = 0
	$iSepCloseGuard = 0
	$iCloseGuardEnabledTrayItem = 0
	$iSepCloseGuardEnabled = 0
	;"<section> as submenu" (deleted together with the Settings menu below)
	$iToolTimeSubmenuTrayItem = 0
	$iKeepAwakeSubmenuTrayItem = 0
	$iAlwaysOnTopSubmenuTrayItem = 0
	$iCloseGuardSubmenuTrayItem = 0

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
	If $idParent <= 0 Then $idParent = $iToolTimeRootMenu ;top level: the tray menu or the submenu "ToolTime"
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
	If $idParent <= 0 Then $idParent = $iToolTimeRootMenu
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

; Gear icon of a submenu "Settings" (KeepAwake, AlwaysOnTop, CloseGuard): the same icon as the Settings menu of
; CCTrayTool further down.
Func _TraySetSettingsMenuIcon($iMenuItem)
	If @Compiled Then
		TrayItemSetIcon($hMenu, $iMenuItem, @ScriptFullPath, $iIconNumberSettings - $iIconOffset, $iIconsSize)
	Else
		TrayItemSetIcon($hMenu, $iMenuItem, @ScriptDir & "\icons\Settings.ico", 0, $iIconsSize)
	EndIf
EndFunc   ;==>_TraySetSettingsMenuIcon

; ====================================================================================================
; Sections of the tray menu as submenus ("<section> as submenu" in the Settings menu)
;   Section numbers: 0 = ToolTime, 1 = KeepAwake, 2 = AlwaysOnTop, 3 = CloseGuard.
;   A section that is shown as a submenu has no grayed-out title line: the submenu carries the name of the section
;   and holds all of its entries (including its own submenu "Settings"). The functions are not affected, only the
;   menu gets shorter. Sections shown as submenus stand together without separators between them.
; ====================================================================================================

; Creates the name of a section: a grayed-out title line, or a submenu (returns the ID of the submenu, the entries of
; the section are then created in it).
Func _TraySectionTitle($sName, $bAsSubmenu)
	Local $id
	If $bAsSubmenu = 1 Then
		$id = TrayCreateMenu($sName)
	Else
		$id = TrayCreateItem($sName)
		TrayItemSetState($id, $TRAY_DISABLE)
	EndIf
	Return $id
EndFunc   ;==>_TraySectionTitle

; Icon of a section that is shown as a submenu. The grayed-out title line gets no icon. Needs $hMenu.
Func _TraySectionIcon($id, $bAsSubmenu, $iIconNumber, $sIconFile)
	If $bAsSubmenu <> 1 Or $id = 0 Then Return
	_CloseGuardSetActionIcon($id, $iIconNumber, $sIconFile)
EndFunc   ;==>_TraySectionIcon

; True if no separator is needed after section $iSection: the section is shown as a submenu and so is the next
; section that is switched on. After the last section there is always a separator (in front of "CCTrayTool").
Func _TrayNoSeparatorAfter($iSection)
	Local $aSub[4] = [$bToolTimeSubmenuSetting, $bKeepAwakeSubmenuSetting, $bAlwaysOnTopSubmenuSetting, $bCloseGuardSubmenuSetting]
	Local $aOn[4] = [$bToolTimeEnabledSetting, $bKeepAwakeEnabledSetting, $bAlwaysOnTopEnabledSetting, $bCloseGuardEnabledSetting]
	If $aSub[$iSection] <> 1 Then Return False
	Local $i
	For $i = $iSection + 1 To 3
		If $aOn[$i] = 1 Then Return ($aSub[$i] = 1)
	Next
	Return False
EndFunc   ;==>_TrayNoSeparatorAfter

; ====================================================================================================
; Function: CheckSectionSubmenu
; Description: Switches "<section> as submenu" for one section on or off. Like CheckKeepAwakeEnabled() this
;              changes which tray items exist, so the whole tray menu is rebuilt; the menu is deleted BEFORE the
;              setting is flipped, so DeleteTrayMenu() still sees the menu as it was created. The function of the
;              section keeps running unchanged.
; Parameters: $iSection - 0 = ToolTime, 1 = KeepAwake, 2 = AlwaysOnTop, 3 = CloseGuard.
; Returns: None.
; ====================================================================================================
Func CheckSectionSubmenu($iSection)
	Logfile("CheckSectionSubmenu(" & $iSection & ") start", 6)
	DeleteTrayMenu()
	DeleteAllhBitmaps()
	Switch $iSection
		Case 0
			$bToolTimeSubmenuSetting = 1 - $bToolTimeSubmenuSetting
			Logfile("ToolTime as submenu: " & $bToolTimeSubmenuSetting)
		Case 1
			$bKeepAwakeSubmenuSetting = 1 - $bKeepAwakeSubmenuSetting
			Logfile("KeepAwake as submenu: " & $bKeepAwakeSubmenuSetting)
		Case 2
			$bAlwaysOnTopSubmenuSetting = 1 - $bAlwaysOnTopSubmenuSetting
			Logfile("AlwaysOnTop as submenu: " & $bAlwaysOnTopSubmenuSetting)
		Case 3
			$bCloseGuardSubmenuSetting = 1 - $bCloseGuardSubmenuSetting
			Logfile("CloseGuard as submenu: " & $bCloseGuardSubmenuSetting)
	EndSwitch
	SaveSettings()
	CreateTrayMenu()
	ApplyTrayMenuSettings()
	SetIconTooltip()
	Logfile("CheckSectionSubmenu() end", 6)
EndFunc   ;==>CheckSectionSubmenu

; ====================================================================================================
; Function: CreateTrayMenu
; Description: Creates the complete tray menu, including ToolTime (the folders and shortcuts of the
;              ToolTime folder), KeepAwake, AlwaysOnTop, CloseGuard and the application settings. Each of the
;              four sections is shown either with a grayed-out title line or - "<section> as submenu" in the
;              Settings menu - as a submenu (see _TraySectionTitle()).
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func CreateTrayMenu()
	Logfile("CreateTrayMenu() start", 6)
	;Every section starts with its name: a grayed-out title line, or - with "<section> as submenu" - a submenu that
	;holds all entries of the section (_TraySectionTitle)
	$iTitleToolTime = _TraySectionTitle(_("ToolTime"), $bToolTimeSubmenuSetting)
	$iToolTimeRootMenu = ($bToolTimeSubmenuSetting = 1) ? $iTitleToolTime : 0

	$hMenu = TrayItemGetHandle(0)
	_TraySectionIcon($iTitleToolTime, $bToolTimeSubmenuSetting, $iIconnumberSubmenuToolTime, "SubmenuToolTime.ico")
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
		$iToolTimeRootMenu = 0
	Else
		If Not _TrayNoSeparatorAfter(0) Then $iSepToolTime = TrayCreateItem("") ; Separator
	EndIf

	;KeepAwake
	If $bKeepAwakeEnabledSetting = 1 Then
		$iTitelKeepAwake = _TraySectionTitle(_("KeepAwake"), $bKeepAwakeSubmenuSetting)
		_TraySectionIcon($iTitelKeepAwake, $bKeepAwakeSubmenuSetting, $iIconnumberSubmenuKeepAwake, "SubmenuKeepAwake.ico")
		Local $iKeepAwakeParent = ($bKeepAwakeSubmenuSetting = 1) ? $iTitelKeepAwake : -1

		$iDisplaySystem = TrayCreateItem(_("Monitors and System"), $iKeepAwakeParent)
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iDisplaySystem, @ScriptFullPath, 206 - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iDisplaySystem, @ScriptDir & "\icons\GreenBox.ico", 0, $iIconsSize)
		EndIf

		$iDisplay = TrayCreateItem(_("Monitors"), $iKeepAwakeParent)
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iDisplay, @ScriptFullPath, 205 - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iDisplay, @ScriptDir & "\icons\RedBox.ico", 0, $iIconsSize)
		EndIf

		$iSystem = TrayCreateItem(_("System"), $iKeepAwakeParent)
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iSystem, @ScriptFullPath, 207 - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iSystem, @ScriptDir & "\icons\BlueBox.ico", 0, $iIconsSize)
		EndIf

		$iDeactivated = TrayCreateItem(_("Deactivated"), $iKeepAwakeParent)
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iDeactivated, @ScriptFullPath, 208 - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iDeactivated, @ScriptDir & "\icons\WhiteBox.ico", 0, $iIconsSize)
		EndIf

		;Submenu "Settings"
		$iKeepAwakeSettingsMenu = TrayCreateMenu(_("Settings"), $iKeepAwakeParent)
		_TraySetSettingsMenuIcon($iKeepAwakeSettingsMenu)

		$iKeepLastKeepAwakeState = TrayCreateItem(_("Save state"), $iKeepAwakeSettingsMenu)
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iKeepLastKeepAwakeState, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iKeepLastKeepAwakeState, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
		EndIf
		If Not _TrayNoSeparatorAfter(1) Then $iSepKeepAwake = TrayCreateItem("") ; Separator
	EndIf

	;AlwaysOnTop
	If $bAlwaysOnTopEnabledSetting = 1 Then
		$iTitelAlwaysOnTop = _TraySectionTitle(_("AlwaysOnTop"), $bAlwaysOnTopSubmenuSetting)
		_TraySectionIcon($iTitelAlwaysOnTop, $bAlwaysOnTopSubmenuSetting, $iIconnumberSubmenuAlwaysOnTop, "SubmenuAlwaysOnTop.ico")
		Local $iAlwaysOnTopParent = ($bAlwaysOnTopSubmenuSetting = 1) ? $iTitelAlwaysOnTop : -1

		;Enable hotkey
		$iActivateAOTHotKeyTrayItem = TrayCreateItem(_("Hotkey active"), $iAlwaysOnTopParent)
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

		;Submenu "Settings"
		$iAlwaysOnTopSettingsMenu = TrayCreateMenu(_("Settings"), $iAlwaysOnTopParent)
		_TraySetSettingsMenuIcon($iAlwaysOnTopSettingsMenu)

		;Change hotkey
		$iSetAOTHotKeyTrayItem = TrayCreateItem(_('Change hotkey'), $iAlwaysOnTopSettingsMenu)
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iSetAOTHotKeyTrayItem, @ScriptFullPath, $iIconnumberKeyboard - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iSetAOTHotKeyTrayItem, @ScriptDir & "\icons\Keyboard.ico", 0, $iIconsSize)
		EndIf

		;Enable or disable tooltip
		$iAlwaysOnTopShowToolTipTrayItem = TrayCreateItem(_('Show tooltip'), $iAlwaysOnTopSettingsMenu)
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iAlwaysOnTopShowToolTipTrayItem, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iAlwaysOnTopShowToolTipTrayItem, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
		EndIf
		If Not _TrayNoSeparatorAfter(2) Then $iSepAlwaysOnTop = TrayCreateItem("") ; Separator
	EndIf

	;CloseGuard: title, the three actions on the top level, all options in the submenu "Settings"
	If $bCloseGuardEnabledSetting = 1 Then
		$iTitelCloseGuard = _TraySectionTitle(_("CloseGuard"), $bCloseGuardSubmenuSetting)
		_TraySectionIcon($iTitelCloseGuard, $bCloseGuardSubmenuSetting, $iIconnumberSubmenuCloseGuard, "SubmenuCloseGuard.ico")
		Local $iCloseGuardParent = ($bCloseGuardSubmenuSetting = 1) ? $iTitelCloseGuard : -1

		;Lock or unlock the close button of the active window
		$iCloseGuardToggleTrayItem = TrayCreateItem(_("Lock/unlock the close button of the active window") & " ( " & HotkeyToReadable($sCloseGuardHotkeyToggle) & " )", $iCloseGuardParent)
		_CloseGuardSetActionIcon($iCloseGuardToggleTrayItem, $iIconnumberCloseGuardLock, "CloseGuardLock.ico")

		;Create a rule for the active window
		$iCloseGuardAddRuleTrayItem = TrayCreateItem(_("Create rule for the active window") & " ( " & HotkeyToReadable($sCloseGuardHotkeyAddRule) & " )", $iCloseGuardParent)
		_CloseGuardSetActionIcon($iCloseGuardAddRuleTrayItem, $iIconnumberCloseGuardRule, "CloseGuardRule.ico")

		;List of the locked windows
		$iCloseGuardListTrayItem = TrayCreateItem(_("Show locked windows"), $iCloseGuardParent)
		_CloseGuardSetActionIcon($iCloseGuardListTrayItem, $iIconnumberCloseGuardList, "CloseGuardList.ico")

		;Submenu "Settings"
		$iCloseGuardSettingsMenu = TrayCreateMenu(_("Settings"), $iCloseGuardParent)
		_TraySetSettingsMenuIcon($iCloseGuardSettingsMenu)

		;Automatic check of new windows
		$iCloseGuardAutoTrayItem = TrayCreateItem(_("Check new windows automatically"), $iCloseGuardSettingsMenu)
		_CloseGuardSetItemIcon($iCloseGuardAutoTrayItem, False)

		;Check the windows that are open at program start
		$iCloseGuardStartTrayItem = TrayCreateItem(_("Check windows open at program start"), $iCloseGuardSettingsMenu)
		_CloseGuardSetItemIcon($iCloseGuardStartTrayItem, False)

		;A click on the locked X minimizes the window
		$iCloseGuardMinimizeTrayItem = TrayCreateItem(_("Minimize window when locked X is clicked"), $iCloseGuardSettingsMenu)
		_CloseGuardSetItemIcon($iCloseGuardMinimizeTrayItem, False)
		$iSepCloseGuardMenuB = TrayCreateItem("", $iCloseGuardSettingsMenu) ; Separator

		;Change the two hotkeys
		$iCloseGuardHotkeyToggleTrayItem = TrayCreateItem(_("Change hotkey: lock/unlock"), $iCloseGuardSettingsMenu)
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iCloseGuardHotkeyToggleTrayItem, @ScriptFullPath, $iIconnumberKeyboard - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iCloseGuardHotkeyToggleTrayItem, @ScriptDir & "\icons\Keyboard.ico", 0, $iIconsSize)
		EndIf
		$iCloseGuardHotkeyAddRuleTrayItem = TrayCreateItem(_("Change hotkey: create rule"), $iCloseGuardSettingsMenu)
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iCloseGuardHotkeyAddRuleTrayItem, @ScriptFullPath, $iIconnumberKeyboard - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iCloseGuardHotkeyAddRuleTrayItem, @ScriptDir & "\icons\Keyboard.ico", 0, $iIconsSize)
		EndIf

		;Edit the rules (they have a file of their own)
		$iCloseGuardEditRulesTrayItem = TrayCreateItem(_("Edit rules..."), $iCloseGuardSettingsMenu)
		If FileExists(@SystemDir & "\notepad.exe") Then
			TrayItemSetIcon($hMenu, $iCloseGuardEditRulesTrayItem, @SystemDir & "\notepad.exe", 0, $iIconsSize)
		Else
			_CloseGuardSetItemIcon($iCloseGuardEditRulesTrayItem, False)
		EndIf
		If Not _TrayNoSeparatorAfter(3) Then $iSepCloseGuard = TrayCreateItem("") ; Separator
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
	;Show the section as a submenu (grayed out while the section itself is switched off)
	$iToolTimeSubmenuTrayItem = TrayCreateItem(_ToolTimeFormat(_("%1 as submenu"), _("ToolTime"), "", "", ""), $iSettings)
	_CloseGuardSetItemIcon($iToolTimeSubmenuTrayItem, $bToolTimeSubmenuSetting = 1)
	If $bToolTimeEnabledSetting <> 1 Then TrayItemSetState($iToolTimeSubmenuTrayItem, $TRAY_DISABLE)
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
	;Show the section as a submenu (grayed out while the section itself is switched off)
	$iKeepAwakeSubmenuTrayItem = TrayCreateItem(_ToolTimeFormat(_("%1 as submenu"), _("KeepAwake"), "", "", ""), $iSettings)
	_CloseGuardSetItemIcon($iKeepAwakeSubmenuTrayItem, $bKeepAwakeSubmenuSetting = 1)
	If $bKeepAwakeEnabledSetting <> 1 Then TrayItemSetState($iKeepAwakeSubmenuTrayItem, $TRAY_DISABLE)
	$iSepKeepAwakeEnabled = TrayCreateItem("", $iSettings) ; Separator

	;Enable or disable AlwaysOnTop entirely
	$iAlwaysOnTopEnabledTrayItem = TrayCreateItem(_("Enable AlwaysOnTop"), $iSettings)
	If @Compiled Then
		TrayItemSetIcon($hMenu, $iAlwaysOnTopEnabledTrayItem, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
	Else
		TrayItemSetIcon($hMenu, $iAlwaysOnTopEnabledTrayItem, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
	EndIf
	;Show the section as a submenu (grayed out while the section itself is switched off)
	$iAlwaysOnTopSubmenuTrayItem = TrayCreateItem(_ToolTimeFormat(_("%1 as submenu"), _("AlwaysOnTop"), "", "", ""), $iSettings)
	_CloseGuardSetItemIcon($iAlwaysOnTopSubmenuTrayItem, $bAlwaysOnTopSubmenuSetting = 1)
	If $bAlwaysOnTopEnabledSetting <> 1 Then TrayItemSetState($iAlwaysOnTopSubmenuTrayItem, $TRAY_DISABLE)
	$iSepAlwaysOnTopEnabled = TrayCreateItem("", $iSettings) ; Separator

	;Enable or disable CloseGuard entirely
	$iCloseGuardEnabledTrayItem = TrayCreateItem(_("Enable CloseGuard"), $iSettings)
	_CloseGuardSetItemIcon($iCloseGuardEnabledTrayItem, False)
	;Show the section as a submenu (grayed out while the section itself is switched off)
	$iCloseGuardSubmenuTrayItem = TrayCreateItem(_ToolTimeFormat(_("%1 as submenu"), _("CloseGuard"), "", "", ""), $iSettings)
	_CloseGuardSetItemIcon($iCloseGuardSubmenuTrayItem, $bCloseGuardSubmenuSetting = 1)
	If $bCloseGuardEnabledSetting <> 1 Then TrayItemSetState($iCloseGuardSubmenuTrayItem, $TRAY_DISABLE)
	$iSepCloseGuardEnabled = TrayCreateItem("", $iSettings) ; Separator

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
			;Run, not RunWait: the log file is only read, so the tray menu must stay usable while it is open (the
			;INI file and the rules file are different: they are applied when the editor is closed, see EditINI())
			Local $iLogPid = Run('"' & @SystemDir & '\notepad.exe" "' & $sLogFile & '"')
			If $iLogPid = 0 Then Logfile("Error: the log file could not be opened with notepad.exe (@error " & @error & ")")
		Else
			Logfile("Log file not found: " & $sLogFile)
			MsgBox(48, _("Error"), _("Log file not found: ") & $sLogFile)
		EndIf
	Else
		Logfile("Error: notepad.exe not found: " & @SystemDir & "\notepad.exe")
		MsgBox(48, _("Error"), _ToolTimeFormat(_("%1 was not found"), @SystemDir & "\notepad.exe", "", "", ""))
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
			;   CloseGuard: the automatic check waits until the reload is done (see below)
			$iCG_BusyDepth += 1
			DeleteTrayMenu()
			DeleteAllhBitmaps()
			;The old hotkey: the INI file may contain another one or switch it off, ApplyTrayMenuSettings()
			;registers the new one if it is active
			HotKeySet($sAlwaysOnTopHotKey)
			;The same for the two CloseGuard hotkeys. Windows that CloseGuard has locked stay locked while the file is
			;edited; CloseGuardReapply(), CloseGuardStart() or CloseGuardStop() decides afterwards (see below).
			HotKeySet($sCloseGuardHotkeyToggle)
			HotKeySet($sCloseGuardHotkeyAddRule)
			Local $bOldCloseGuardEnabled = $bCloseGuardEnabledSetting
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

			;CloseGuard: LoadSettings() has read the settings and the rules again. The rules are applied to the open
			;windows (CloseGuardReapply), or the module is started or stopped if the INI file switched it on or off.
			$iCG_BusyDepth -= 1
			If $bCloseGuardEnabledSetting = 1 Then
				If $bOldCloseGuardEnabled = 1 Then
					CloseGuardReapply()
				Else
					CloseGuardStart()
					_CloseGuardFirstNotice() ;switched on in the INI file: the same one-time notice as in the menu
				EndIf
			ElseIf $bOldCloseGuardEnabled = 1 Then
				CloseGuardStop()
			EndIf
		Else
			MsgBox(48, _("Error"), _ToolTimeFormat(_("%1 was not found"), @SystemDir & "\notepad.exe", "", "", ""))
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
	;The same for CloseGuard messages that were collected while the tray icon did not exist yet
	_CloseGuardShowNote()
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
	$bKeepAwakeSubmenuSetting = Number(IniRead($sIniFile, "KeepAwake", "AsSubmenu", 0))
	If $bKeepAwakeSubmenuSetting <> 0 And $bKeepAwakeSubmenuSetting <> 1 Then $bKeepAwakeSubmenuSetting = 0

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
	$bToolTimeSubmenuSetting = Number(IniRead($sIniFile, "ToolTime", "AsSubmenu", 0))
	If $bToolTimeSubmenuSetting <> 0 And $bToolTimeSubmenuSetting <> 1 Then $bToolTimeSubmenuSetting = 0

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
	$bAlwaysOnTopSubmenuSetting = Number(IniRead($sIniFile, "AlwaysOnTop", "AsSubmenu", 0))
	If $bAlwaysOnTopSubmenuSetting <> 0 And $bAlwaysOnTopSubmenuSetting <> 1 Then $bAlwaysOnTopSubmenuSetting = 0
	$bActivateAlwaysOnTopHotKey = Number(IniRead($sIniFile, "AlwaysOnTop", "Active", 1))
	If $bActivateAlwaysOnTopHotKey <> 0 And $bActivateAlwaysOnTopHotKey <> 1 Then $bActivateAlwaysOnTopHotKey = 1
	$sAlwaysOnTopHotKey = StringStripWS(IniRead($sIniFile, "AlwaysOnTop", "HotKey", "+!t"), 8)
	If StringLen($sAlwaysOnTopHotKey) < 1 Or StringLen($sAlwaysOnTopHotKey) > 9 Then $sAlwaysOnTopHotKey = "+!t"
	$bAlwaysOnTopShowToolTip = Number(IniRead($sIniFile, "AlwaysOnTop", "ShowToolTip", "1"))
	If $bAlwaysOnTopShowToolTip <> 0 And $bAlwaysOnTopShowToolTip <> 1 Then $bAlwaysOnTopShowToolTip = 1

	;CloseGuard
	$bCloseGuardEnabledSetting = Number(IniRead($sIniFile, "CloseGuard", "Enabled", 0))
	If $bCloseGuardEnabledSetting <> 0 And $bCloseGuardEnabledSetting <> 1 Then $bCloseGuardEnabledSetting = 0
	$bCloseGuardSubmenuSetting = Number(IniRead($sIniFile, "CloseGuard", "AsSubmenu", 0))
	If $bCloseGuardSubmenuSetting <> 0 And $bCloseGuardSubmenuSetting <> 1 Then $bCloseGuardSubmenuSetting = 0
	$sCloseGuardHotkeyToggle = StringStripWS(IniRead($sIniFile, "CloseGuard", "HotkeyToggle", $sCloseGuardHotkeyToggleDefault), 8)
	If StringLen($sCloseGuardHotkeyToggle) < 1 Or StringLen($sCloseGuardHotkeyToggle) > 9 Then $sCloseGuardHotkeyToggle = $sCloseGuardHotkeyToggleDefault
	$sCloseGuardHotkeyAddRule = StringStripWS(IniRead($sIniFile, "CloseGuard", "HotkeyAddRule", $sCloseGuardHotkeyAddRuleDefault), 8)
	If StringLen($sCloseGuardHotkeyAddRule) < 1 Or StringLen($sCloseGuardHotkeyAddRule) > 9 Then $sCloseGuardHotkeyAddRule = $sCloseGuardHotkeyAddRuleDefault
	$bCloseGuardApplyOnStartup = Number(IniRead($sIniFile, "CloseGuard", "ApplyOnStartup", 1))
	If $bCloseGuardApplyOnStartup <> 0 And $bCloseGuardApplyOnStartup <> 1 Then $bCloseGuardApplyOnStartup = 1
	$bCloseGuardAutoApply = Number(IniRead($sIniFile, "CloseGuard", "AutoApply", 1))
	If $bCloseGuardAutoApply <> 0 And $bCloseGuardAutoApply <> 1 Then $bCloseGuardAutoApply = 1
	;Poll interval in ms (250 - 5000)
	$iCloseGuardPollInterval = Int(Number(IniRead($sIniFile, "CloseGuard", "PollInterval", $iCloseGuardPollDefault)))
	If $iCloseGuardPollInterval = 0 Then
		$iCloseGuardPollInterval = $iCloseGuardPollDefault ;missing or not a number
	ElseIf $iCloseGuardPollInterval < $iCloseGuardPollMin Then
		Logfile("CloseGuard PollInterval is too small (" & $iCloseGuardPollInterval & "), using " & $iCloseGuardPollMin)
		$iCloseGuardPollInterval = $iCloseGuardPollMin
	ElseIf $iCloseGuardPollInterval > $iCloseGuardPollMax Then
		Logfile("CloseGuard PollInterval is too large (" & $iCloseGuardPollInterval & "), using " & $iCloseGuardPollMax)
		$iCloseGuardPollInterval = $iCloseGuardPollMax
	EndIf
	;A click on the locked X minimizes the window
	$bCloseGuardMinimizeOnClick = Number(IniRead($sIniFile, "CloseGuard", "MinimizeOnClick", 0))
	If $bCloseGuardMinimizeOnClick <> 0 And $bCloseGuardMinimizeOnClick <> 1 Then $bCloseGuardMinimizeOnClick = 0
	;How often the mouse button is polled for that, in ms (10 - 100)
	$iCloseGuardClickInterval = Int(Number(IniRead($sIniFile, "CloseGuard", "ClickPollInterval", $iCloseGuardClickDefault)))
	If $iCloseGuardClickInterval = 0 Then
		$iCloseGuardClickInterval = $iCloseGuardClickDefault ;missing or not a number
	ElseIf $iCloseGuardClickInterval < $iCloseGuardClickMin Then
		Logfile("CloseGuard ClickPollInterval is too small (" & $iCloseGuardClickInterval & "), using " & $iCloseGuardClickMin)
		$iCloseGuardClickInterval = $iCloseGuardClickMin
	ElseIf $iCloseGuardClickInterval > $iCloseGuardClickMax Then
		Logfile("CloseGuard ClickPollInterval is too large (" & $iCloseGuardClickInterval & "), using " & $iCloseGuardClickMax)
		$iCloseGuardClickInterval = $iCloseGuardClickMax
	EndIf
	;Recognize the X by its position as well (for windows that draw their own title bar and do not report HTCLOSE)
	$bCloseGuardClickGeometry = Number(IniRead($sIniFile, "CloseGuard", "ClickGeometryFallback", 1))
	If $bCloseGuardClickGeometry <> 0 And $bCloseGuardClickGeometry <> 1 Then $bCloseGuardClickGeometry = 1
	;How far that area reaches to the left and downwards, in percent of the width / height of the X (0 - 100)
	$iCloseGuardClickExtendLeft = _CloseGuardReadPercent("ClickGeometryExtendLeft", $iCloseGuardExtendLeftDefault)
	$iCloseGuardClickExtendDown = _CloseGuardReadPercent("ClickGeometryExtendDown", $iCloseGuardExtendDownDefault)
	;Debug: show the areas as transparent rectangles
	$bCloseGuardClickDebug = Number(IniRead($sIniFile, "CloseGuard", "ClickDebugOverlay", 0))
	If $bCloseGuardClickDebug <> 0 And $bCloseGuardClickDebug <> 1 Then $bCloseGuardClickDebug = 0
	;Programs that close themselves when the X is released (Edge, Chrome, Firefox ...): their X gets a shield. A key
	;that is missing gives the default, an empty key switches this off.
	$sCloseGuardShieldClasses = StringStripWS(IniRead($sIniFile, "CloseGuard", "ClickShieldClasses", $sCloseGuardShieldClassesDefault), 3)
	_CloseGuardParseShieldClasses()
	;The hotkeys must differ from each other and from the AlwaysOnTop hotkey (read above)
	_CloseGuardCheckHotkeyConflicts()
	;The rules (they are read from their own file)
	CloseGuardLoadRules()

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
	IniWrite($sIniFile, "ToolTime", "AsSubmenu", $bToolTimeSubmenuSetting)
	IniWrite($sIniFile, "ToolTime", "MaxEntries", $iToolTimeMaxEntriesSetting)
	IniWrite($sIniFile, "ToolTime", "Folder", $sToolTimeFolderSetting)

	;KeepAwake
	IniWrite($sIniFile, "KeepAwake", "Enabled", $bKeepAwakeEnabledSetting)
	IniWrite($sIniFile, "KeepAwake", "AsSubmenu", $bKeepAwakeSubmenuSetting)
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
	IniWrite($sIniFile, "AlwaysOnTop", "AsSubmenu", $bAlwaysOnTopSubmenuSetting)
	IniWrite($sIniFile, "AlwaysOnTop", "Active", $bActivateAlwaysOnTopHotKey)
	IniWrite($sIniFile, "AlwaysOnTop", "HotKey", $sAlwaysOnTopHotKey)

	IniWrite($sIniFile, "AlwaysOnTop", "ShowToolTip", $bAlwaysOnTopShowToolTip)

	;CloseGuard (the rules have a file of their own, they are written when a rule is created, not here)
	IniWrite($sIniFile, "CloseGuard", "Enabled", $bCloseGuardEnabledSetting)
	IniWrite($sIniFile, "CloseGuard", "AsSubmenu", $bCloseGuardSubmenuSetting)
	IniWrite($sIniFile, "CloseGuard", "HotkeyToggle", $sCloseGuardHotkeyToggle)
	IniWrite($sIniFile, "CloseGuard", "HotkeyAddRule", $sCloseGuardHotkeyAddRule)
	IniWrite($sIniFile, "CloseGuard", "ApplyOnStartup", $bCloseGuardApplyOnStartup)
	IniWrite($sIniFile, "CloseGuard", "AutoApply", $bCloseGuardAutoApply)
	IniWrite($sIniFile, "CloseGuard", "PollInterval", $iCloseGuardPollInterval)
	IniWrite($sIniFile, "CloseGuard", "MinimizeOnClick", $bCloseGuardMinimizeOnClick)
	IniWrite($sIniFile, "CloseGuard", "ClickPollInterval", $iCloseGuardClickInterval)
	IniWrite($sIniFile, "CloseGuard", "ClickGeometryFallback", $bCloseGuardClickGeometry)
	IniWrite($sIniFile, "CloseGuard", "ClickGeometryExtendLeft", $iCloseGuardClickExtendLeft)
	IniWrite($sIniFile, "CloseGuard", "ClickGeometryExtendDown", $iCloseGuardClickExtendDown)
	IniWrite($sIniFile, "CloseGuard", "ClickDebugOverlay", $bCloseGuardClickDebug)
	IniWrite($sIniFile, "CloseGuard", "ClickShieldClasses", $sCloseGuardShieldClasses)

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
; Description: Displays a dialog for selecting a hotkey (AlwaysOnTop or CloseGuard) and validates the
;              selected combination by temporarily registering it.
; Parameters:
;   $sCurrent - Optional current hotkey used to preselect the dialog controls.
;   $sTaken   - Optional hotkeys that other functions of this program use, separated by "|". A combination from
;               this list is refused. If the current hotkey is selected again nothing is changed.
; Returns: The selected AutoIt hotkey string, or an empty string with @error = 1 if cancelled.
; ====================================================================================================
Func HotkeyDialog($sCurrent = "", $sTaken = "")
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

				;Nothing was changed: the hotkey is registered by this program already, so it must not be test-registered
				;below (HotKeySet() would replace its function and the removal would unregister it)
				If $sCurrent <> "" And HotkeyNormalize($sResult) = HotkeyNormalize($sCurrent) Then
					GUIDelete($hGui)
					Return $sCurrent
				EndIf

				;Already used by another function of CCTrayTool (AlwaysOnTop or CloseGuard)
				If HotkeyIsTaken($sResult, $sTaken) Then
					MsgBox($MB_ICONWARNING, _("Already in use"), _
							_("This combination is already used by another function of CCTrayTool.") & @CRLF & _
							_("Please choose a different hotkey."), 0, $hGui)
					ContinueLoop
				EndIf

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
	Local $sHotkey = HotkeyDialog($sAlwaysOnTopHotKey, CloseGuardHotkeysInUse())
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
; CloseGuard
;
; Locks the close button (X) of selected windows, either by hotkey or automatically by rules.
;
; How it works: the X of a window is controlled by the item "Close" in its system menu. CloseGuard removes
; that item from the system menu of the window (GetSystemMenu + DeleteMenu with SC_CLOSE), Windows then draws
; the X grayed out. Unlocking resets the system menu of the window to the default (GetSystemMenu with
; bRevert = TRUE). Whether a window is locked is always read from its system menu; the lists below only
; remember WHY a window is locked or exempt.
;
; Lists (Scripting.Dictionary, key = the window handle as a string, see _CloseGuardKey()):
;   $oCG_Locked     key -> reason: 1 = locked by a rule, 2 = locked by hand (hotkey or menu)
;   $oCG_Exempt     key -> reason: 1 = window was open at program start (option "check windows open at start"
;                          is off), 2 = released by the user (stays free until the window is closed),
;                          3 = could not be locked (no new attempt until the rules change)
;   $oCG_ClassCache key -> window class (it never changes, so it is only read once)
;   $oCG_GeoNeed    key -> 1 = the window does not report its X with the hit test (position fallback), 0 = it does
;   $oCG_NoDwm      key -> 1 = DWM has no caption button data for the window (noted in the log once)
;   $oCG_ScanGeo    key -> "window size|offsets of the X": the X of a window without DWM data, found by asking the window
;   $oCG_ScanFail   key -> "window size|time": that search found nothing (it is repeated after $iCG_ScanRetry ms)
;   $oCG_Shield*    shields over the X of windows that close themselves (see "Shield" below)
;
; Rules (section [Rules] of the file CloseGuardRules.ini, not of the main INI file): "Number=Title text|Window
; class". The title text is searched anywhere in the window title, the class has to match exactly, upper and
; lower case do not matter. One of the two parts may be empty, at least one has to be set. The line is split at
; the LAST "|". The file is created as a Unicode file, see CloseGuardEnsureRulesFile().
;
; Option MinimizeOnClick: a click on the (grayed-out) X of a locked window minimizes the window. The mouse button
; is polled, no hook is used, see "Click on the locked X" below.
;
; Programs that draw their own X and close themselves when the mouse button is released (Edge, Chrome, Firefox) are
; not stopped by the locked system menu: their X gets a shield, see "Shield" below (INI key ClickShieldClasses).
;
; Once per poll interval (default 500 ms) CloseGuardTick() checks the windows (AdlibRegister):
;   1. All windows are listed (WinList) and filtered (visible, has a system menu, not a window of
;      CCTrayTool, not the desktop or the taskbar).
;   2. Windows that are neither locked nor exempt are compared with the rules and locked on a match.
;   3. Locked windows are checked again (a program may restore its system menu) and locked again if needed.
;   4. Handles of windows that do not exist any more are removed from all lists.
; Additionally the tick remembers the last window the user worked in: when an action is started from the tray
; menu, the tray menu is the active window, so the action has to use the window that was active before.
;
; Limits (also described in the user guide): programs that draw their own title bar (UWP apps, Chromium, Electron,
; many Windows 11 apps) may keep a clickable X. For the window classes in ClickShieldClasses (Edge, Chrome and Firefox
; by default) CloseGuard puts a shield over the X, see "Shield". Windows of programs that run as administrator cannot
; be changed by a normal program. File > Exit, Ctrl+W, Alt+F4 and the task manager still close a locked window.
; ====================================================================================================

; ----------------------------------------------------------------------------------------------------
; Small helpers
; ----------------------------------------------------------------------------------------------------

; Key of a window in the dictionaries. HWnd($sKey) turns it back into a handle.
Func _CloseGuardKey($hWnd)
	Return String(HWnd($hWnd))
EndFunc   ;==>_CloseGuardKey

; Shows a notification. $bWarning = True uses the exclamation icon.
Func _CloseGuardTip($sText, $bWarning = False)
	Logfile("CloseGuard: " & $sText, 4)
	If $bWarning Then
		TrayTip(_("CloseGuard"), $sText, 8, BitOR($TIP_ICONEXCLAMATION, $TIP_NOSOUND))
	Else
		TrayTip(_("CloseGuard"), $sText, 5, BitOR($TIP_ICONASTERISK, $TIP_NOSOUND))
	EndIf
EndFunc   ;==>_CloseGuardTip

; %1 and %2 in the text are replaced by the parameters.
Func _CloseGuardFormat($sText, $s1 = "", $s2 = "")
	Return _ToolTimeFormat($sText, $s1, $s2, "", "")
EndFunc   ;==>_CloseGuardFormat

; Window title for messages: shortened, "(no title)" if it is empty
Func _CloseGuardShortTitle($sTitle, $iMax = 50)
	$sTitle = StringStripWS($sTitle, 7)
	If $sTitle = "" Then Return _("(no title)")
	If StringLen($sTitle) > $iMax Then Return StringLeft($sTitle, $iMax - 3) & "..."
	Return $sTitle
EndFunc   ;==>_CloseGuardShortTitle

; Shows the message that was collected while the tray menu did not exist yet (see $sCG_Note)
Func _CloseGuardShowNote()
	If $sCG_Note = "" Then Return
	Local $sNote = StringStripWS($sCG_Note, 3)
	$sCG_Note = ""
	_CloseGuardTip($sNote, True)
EndFunc   ;==>_CloseGuardShowNote

; Adds a message to $sCG_Note (without repeating one that is already waiting)
Func _CloseGuardAddNote($sText)
	If StringInStr($sCG_Note, $sText) = 0 Then $sCG_Note &= $sText & @CRLF
EndFunc   ;==>_CloseGuardAddNote

; Sets the icon of a CloseGuard tray item: checked (green check) or not (empty icon)
Func _CloseGuardSetItemIcon($iItem, $bChecked)
	If $bChecked Then
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iItem, @ScriptFullPath, $iIconnumberGreenCheck - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iItem, @ScriptDir & "\icons\GreenCheck.ico", 0, $iIconsSize)
		EndIf
	Else
		If @Compiled Then
			TrayItemSetIcon($hMenu, $iItem, @ScriptFullPath, $iIconnumberEmpty - $iIconOffset, $iIconsSize)
		Else
			TrayItemSetIcon($hMenu, $iItem, @ScriptDir & "\icons\Empty.ico", 0, $iIconsSize)
		EndIf
	EndIf
EndFunc   ;==>_CloseGuardSetItemIcon

; Sets the icon of a CloseGuard action in the tray menu. Compiled: the icon resource; as script: the file in the
; icons folder (the empty icon takes its place if the file is missing, so that the text stays aligned).
Func _CloseGuardSetActionIcon($iItem, $iIconNumber, $sIconFile)
	If @Compiled Then
		TrayItemSetIcon($hMenu, $iItem, @ScriptFullPath, $iIconNumber - $iIconOffset, $iIconsSize)
	ElseIf FileExists(@ScriptDir & "\icons\" & $sIconFile) Then
		TrayItemSetIcon($hMenu, $iItem, @ScriptDir & "\icons\" & $sIconFile, 0, $iIconsSize)
	Else
		_CloseGuardSetItemIcon($iItem, False)
	EndIf
EndFunc   ;==>_CloseGuardSetActionIcon

; ----------------------------------------------------------------------------------------------------
; Windows API
; ----------------------------------------------------------------------------------------------------

Func _CloseGuardWindowExists($hWnd)
	Local $aRet = DllCall("user32.dll", "bool", "IsWindow", "hwnd", $hWnd)
	If @error Or Not IsArray($aRet) Then Return False
	Return $aRet[0] <> 0
EndFunc   ;==>_CloseGuardWindowExists

Func _CloseGuardIsVisible($hWnd)
	Local $aRet = DllCall("user32.dll", "bool", "IsWindowVisible", "hwnd", $hWnd)
	If @error Or Not IsArray($aRet) Then Return False
	Return $aRet[0] <> 0
EndFunc   ;==>_CloseGuardIsVisible

Func _CloseGuardForegroundWindow()
	Local $aRet = DllCall("user32.dll", "hwnd", "GetForegroundWindow")
	If @error Or Not IsArray($aRet) Then Return 0
	If $aRet[0] = 0 Then Return 0
	Return $aRet[0]
EndFunc   ;==>_CloseGuardForegroundWindow

; Only windows with the style WS_SYSMENU have a system menu and therefore a close button.
; GetWindowLongW is used on purpose: GetWindowLongPtrW does not exist in the 32 bit user32.dll, and the
; window style is a 32 bit value anyway.
Func _CloseGuardHasSysMenu($hWnd)
	Local $aRet = DllCall("user32.dll", "long", "GetWindowLongW", "hwnd", $hWnd, "int", $iCG_GWL_STYLE)
	If @error Or Not IsArray($aRet) Then Return False
	Return BitAND($aRet[0], $iCG_WS_SYSMENU) <> 0
EndFunc   ;==>_CloseGuardHasSysMenu

; Window class (read once per window, then taken from the cache). Empty string if it cannot be read.
Func _CloseGuardGetClass($hWnd)
	Local $sKey = _CloseGuardKey($hWnd)
	If $oCG_ClassCache.Exists($sKey) Then Return $oCG_ClassCache.Item($sKey)
	Local $aRet = DllCall("user32.dll", "int", "GetClassNameW", "hwnd", $hWnd, "wstr", "", "int", 256)
	If @error Or Not IsArray($aRet) Then Return ""
	If $aRet[0] = 0 Then Return ""
	$oCG_ClassCache.Item($sKey) = $aRet[2]
	Return $aRet[2]
EndFunc   ;==>_CloseGuardGetClass

; Desktop, taskbar and similar shell windows are never locked
Func _CloseGuardIsExcludedClass($sClass)
	Switch $sClass
		Case "Progman", "WorkerW", "Shell_TrayWnd", "Shell_SecondaryTrayWnd", "NotifyIconOverflowWindow", "TopLevelWindowForOverflowXamlIsland", "#32768"
			Return True
	EndSwitch
	Return False
EndFunc   ;==>_CloseGuardIsExcludedClass

; Windows of CCTrayTool itself (hidden main window, hotkey dialog, message boxes) are never locked
Func _CloseGuardIsOwnWindow($hWnd)
	Local $iPid = WinGetProcess($hWnd)
	If @error Then Return False
	Return $iPid = @AutoItPID
EndFunc   ;==>_CloseGuardIsOwnWindow

; True for a window the user can work in: it exists, is visible and is neither one of our own windows nor the
; desktop or the taskbar. A system menu is not required here (the lock reports that problem itself).
Func _CloseGuardIsTargetable($hWnd)
	If $hWnd = 0 Then Return False
	If Not _CloseGuardWindowExists($hWnd) Then Return False
	If Not _CloseGuardIsVisible($hWnd) Then Return False
	Local $sClass = _CloseGuardGetClass($hWnd)
	If $sClass = "" Then Return False
	If _CloseGuardIsExcludedClass($sClass) Then Return False
	If _CloseGuardIsOwnWindow($hWnd) Then Return False
	Return True
EndFunc   ;==>_CloseGuardIsTargetable

; Handle of the system menu of the window (a copy that belongs to this window only), 0 if there is none
Func _CloseGuardGetSysMenu($hWnd)
	Local $aRet = DllCall("user32.dll", "handle", "GetSystemMenu", "hwnd", $hWnd, "bool", False)
	If @error Or Not IsArray($aRet) Then Return 0
	Return $aRet[0]
EndFunc   ;==>_CloseGuardGetSysMenu

; Reads the real state from the system menu of the window.
; Returns 1 = the item "Close" exists (X usable), 0 = the item is missing (X locked), -1 = no system menu.
; GetMenuState is declared with the return type "int" on purpose: it returns 0xFFFFFFFF (= -1) for a missing item.
Func _CloseGuardGetState($hWnd)
	Local $hSysMenu = _CloseGuardGetSysMenu($hWnd)
	If $hSysMenu = 0 Then Return -1
	Local $aRet = DllCall("user32.dll", "int", "GetMenuState", "handle", $hSysMenu, "uint", $iCG_SC_CLOSE, "uint", 0)
	If @error Or Not IsArray($aRet) Then Return -1
	If $aRet[0] = -1 Then Return 0
	Return 1
EndFunc   ;==>_CloseGuardGetState

; Without this the X would only look different after the next redraw of the window
Func _CloseGuardRedraw($hWnd)
	DllCall("user32.dll", "bool", "DrawMenuBar", "hwnd", $hWnd)
	DllCall("user32.dll", "bool", "SetWindowPos", "hwnd", $hWnd, "hwnd", 0, "int", 0, "int", 0, "int", 0, "int", 0, "uint", $iCG_SWP_REDRAW)
EndFunc   ;==>_CloseGuardRedraw

; Removes the item "Close" from the system menu of the window.
; Returns True if the X is locked afterwards (also if it was locked already, e.g. by an earlier run).
; @error: 1 = the window has no system menu, 2 = the item could not be removed (typically a window of a
;         program that runs as administrator: Windows does not let a normal program change it).
Func _CloseGuardLock($hWnd, $iReason)
	Local $sKey = _CloseGuardKey($hWnd)
	Local $iState = _CloseGuardGetState($hWnd)
	If $iState = -1 Then Return SetError(1, 0, False)
	If $iState = 1 Then
		Local $hSysMenu = _CloseGuardGetSysMenu($hWnd)
		DllCall("user32.dll", "bool", "DeleteMenu", "handle", $hSysMenu, "uint", $iCG_SC_CLOSE, "uint", 0)
		_CloseGuardRedraw($hWnd)
		;Do not trust DeleteMenu: ask the menu again
		If _CloseGuardGetState($hWnd) <> 0 Then Return SetError(2, 0, False)
	EndIf
	$oCG_Locked.Item($sKey) = $iReason
	If $oCG_Exempt.Exists($sKey) Then $oCG_Exempt.Remove($sKey)
	Logfile("CloseGuard: locked " & $sKey & " (reason " & $iReason & ") " & _CloseGuardGetClass($hWnd) & " - " & WinGetTitle($hWnd), 5)
	$bCG_ShieldDue = True
	_CloseGuardClickSync()
	Return True
EndFunc   ;==>_CloseGuardLock

; Gives the X back: the system menu of the window is reset to the default.
; (Entries that the program added to its own system menu are reset as well.)
Func _CloseGuardUnlock($hWnd)
	Local $sKey = _CloseGuardKey($hWnd)
	If _CloseGuardWindowExists($hWnd) Then
		DllCall("user32.dll", "handle", "GetSystemMenu", "hwnd", $hWnd, "bool", True)
		_CloseGuardRedraw($hWnd)
		Logfile("CloseGuard: released " & $sKey, 5)
	EndIf
	If $oCG_Locked.Exists($sKey) Then $oCG_Locked.Remove($sKey)
	_CloseGuardShieldRemove($sKey)
	_CloseGuardClickSync()
EndFunc   ;==>_CloseGuardUnlock

; Reports why a window could not be locked (@error of _CloseGuardLock()) to the user
Func _CloseGuardReportLockError($iError)
	If $iError = 1 Then
		_CloseGuardTip(_("This window has no system menu, so its close button cannot be locked."), True)
	Else
		_CloseGuardTip(_("The close button could not be locked. The window probably belongs to a program that runs as administrator."), True)
	EndIf
EndFunc   ;==>_CloseGuardReportLockError

; ----------------------------------------------------------------------------------------------------
; Rules
; ----------------------------------------------------------------------------------------------------

; Reads the section [Rules] of the rules file. Keys are numbers (1, 2, 3 ...), the value is "Title|Class".
; If the file does not exist there are no rules.
Func CloseGuardLoadRules()
	Logfile("CloseGuardLoadRules() start", 6)
	Local $aTitle[1], $aClass[1]
	Local $iCount = 0
	Local $aSection = IniReadSection($sCloseGuardRulesFile, "Rules")
	If Not @error Then
		Local $i, $iPos, $sRule, $sTitle, $sClass
		ReDim $aTitle[$aSection[0][0] + 1]
		ReDim $aClass[$aSection[0][0] + 1]
		For $i = 1 To $aSection[0][0]
			;Only numbered lines are rules
			If Not StringRegExp($aSection[$i][0], "^\s*\d+\s*$") Then ContinueLoop
			$sRule = $aSection[$i][1]
			$iPos = StringInStr($sRule, "|", 0, -1) ;split at the LAST "|"
			If $iPos = 0 Then
				$sTitle = $sRule ;no separator: the whole text is the title
				$sClass = ""
			Else
				$sTitle = StringLeft($sRule, $iPos - 1)
				$sClass = StringTrimLeft($sRule, $iPos)
			EndIf
			$sTitle = StringStripWS($sTitle, 3)
			$sClass = StringStripWS($sClass, 3)
			If $sTitle = "" And $sClass = "" Then
				Logfile("CloseGuard: rule " & $aSection[$i][0] & " ignored, title and class are both empty")
				ContinueLoop
			EndIf
			If $iCount >= $iCloseGuardMaxRules Then
				Logfile("CloseGuard: more than " & $iCloseGuardMaxRules & " rules, the rest is ignored")
				ExitLoop
			EndIf
			$iCount += 1
			$aTitle[$iCount] = $sTitle
			$aClass[$iCount] = $sClass
		Next
	EndIf
	$aCG_RuleTitle = $aTitle
	$aCG_RuleClass = $aClass
	$iCG_RuleCount = $iCount
	Logfile("CloseGuard rules: " & $iCG_RuleCount, 6)
	Logfile("CloseGuardLoadRules() end", 6)
EndFunc   ;==>CloseGuardLoadRules

; Number of the first rule that matches the window, 0 if no rule matches.
Func _CloseGuardMatchesRules($sTitle, $sClass)
	Local $i
	For $i = 1 To $iCG_RuleCount
		If StringLen($aCG_RuleTitle[$i]) > 0 Then
			If StringInStr($sTitle, $aCG_RuleTitle[$i]) = 0 Then ContinueLoop ;case insensitive
		EndIf
		If StringLen($aCG_RuleClass[$i]) > 0 Then
			If StringCompare($sClass, $aCG_RuleClass[$i]) <> 0 Then ContinueLoop ;case insensitive
		EndIf
		Return $i
	Next
	Return 0
EndFunc   ;==>_CloseGuardMatchesRules

; Adds a rule to the rules file and reads the rules again.
; Returns 1 = rule added, 0 = the rule exists already, -1 = the rule could not be saved (the limit of rules is
; reached, or the rules file can not be created or written).
Func CloseGuardAddRule($sTitle, $sClass)
	$sTitle = StringStripWS($sTitle, 3)
	$sClass = StringStripWS($sClass, 3)
	Local $i
	For $i = 1 To $iCG_RuleCount
		If StringCompare($aCG_RuleTitle[$i], $sTitle) = 0 And StringCompare($aCG_RuleClass[$i], $sClass) = 0 Then Return 0
	Next
	If $iCG_RuleCount >= $iCloseGuardMaxRules Then
		Logfile("CloseGuard: the limit of " & $iCloseGuardMaxRules & " rules is reached")
		Return SetError(1, 0, -1)
	EndIf
	If Not CloseGuardEnsureRulesFile() Then Return -1

	;The new rule gets the number after the highest one that is in use
	Local $iMax = 0
	Local $aSection = IniReadSection($sCloseGuardRulesFile, "Rules")
	If Not @error Then
		For $i = 1 To $aSection[0][0]
			If StringRegExp($aSection[$i][0], "^\s*\d+\s*$") Then
				If Number($aSection[$i][0]) > $iMax Then $iMax = Number($aSection[$i][0])
			EndIf
		Next
	EndIf
	If IniWrite($sCloseGuardRulesFile, "Rules", String($iMax + 1), $sTitle & "|" & $sClass) = 0 Then
		Logfile("CloseGuard: the rule could not be written to the rules file")
		Return -1
	EndIf
	CloseGuardLoadRules()
	Return 1
EndFunc   ;==>CloseGuardAddRule

; Makes sure the rules file exists. It is created as a Unicode file (UTF-16 little endian with BOM): the Windows
; INI functions (IniRead, IniWrite) only handle characters outside the ANSI code page (for example in window
; titles) correctly when the file is a Unicode file, and Notepad keeps that format when the file is edited.
; A short explanation is written into the file, so that the rules can be found and edited by hand.
; An existing file is never changed. Returns 1 = the file exists (or was created), 0 = it could not be created.
Func CloseGuardEnsureRulesFile()
	If FileExists($sCloseGuardRulesFile) Then Return 1
	;2 = overwrite (the file does not exist yet), 8 = create the folder if needed, 32 = Unicode UTF-16 LE with BOM
	Local $hFile = FileOpen($sCloseGuardRulesFile, 2 + 8 + 32)
	If $hFile = -1 Then
		Logfile("CloseGuard: the rules file could not be created: " & $sCloseGuardRulesFile)
		Return 0
	EndIf
	Local $sText = "; CloseGuard rules of CCTrayTool. The close button (X) of every window that matches a rule is locked." & @CRLF & _
			"; Keep this file in the Unicode format (UTF-16). Notepad does that automatically." & @CRLF & _
			"; The rules are read again when the editor that the tray menu entry ""Edit rules..."" opens is closed," & @CRLF & _
			"; and at every start of CCTrayTool." & @CRLF & _
			";" & @CRLF & _
			"; One rule per line, numbered 1, 2, 3 ...    Number=Title text|Window class" & @CRLF & _
			"; The title text is searched anywhere in the window title, the class has to match exactly." & @CRLF & _
			"; Upper and lower case do not matter. One of the two parts may be empty (the | stays)." & @CRLF & _
			"; Examples:   1=Calculator|    2=|Notepad    3=Untitled|Notepad" & @CRLF & _
			"; At most " & $iCloseGuardMaxRules & " rules are used." & @CRLF & _
			@CRLF & "[Rules]" & @CRLF
	FileWrite($hFile, $sText)
	FileClose($hFile)
	Logfile("CloseGuard: rules file created: " & $sCloseGuardRulesFile)
	Return 1
EndFunc   ;==>CloseGuardEnsureRulesFile

; ----------------------------------------------------------------------------------------------------
; Actions (hotkey, tray menu)
; ----------------------------------------------------------------------------------------------------

; The window a hotkey acts on: the active window
Func _CloseGuardTargetFromHotkey()
	Local $hWnd = _CloseGuardForegroundWindow()
	If Not _CloseGuardIsTargetable($hWnd) Then Return 0
	Return $hWnd
EndFunc   ;==>_CloseGuardTargetFromHotkey

; The window a tray menu action acts on: while the tray menu is open the tray menu is the active window, so
; the window that was active before is taken (remembered by CloseGuardTick()).
Func _CloseGuardTargetFromMenu()
	If Not _CloseGuardIsTargetable($hCG_LastForeign) Then Return 0
	Return $hCG_LastForeign
EndFunc   ;==>_CloseGuardTargetFromMenu

Func _CloseGuardNoTarget()
	_CloseGuardTip(_("No suitable window found. Click on the target window first."), True)
EndFunc   ;==>_CloseGuardNoTarget

; Hotkey "lock/unlock"
Func CloseGuardToggleActive()
	If Not $bCloseGuardEnabledSetting Then Return
	$iCG_BusyDepth += 1
	Local $hWnd = _CloseGuardTargetFromHotkey()
	If $hWnd = 0 Then
		_CloseGuardNoTarget()
	Else
		_CloseGuardToggle($hWnd)
	EndIf
	$iCG_BusyDepth -= 1
EndFunc   ;==>CloseGuardToggleActive

; Tray menu entry "lock/unlock"
Func CloseGuardToggleMenu()
	If Not $bCloseGuardEnabledSetting Then Return
	$iCG_BusyDepth += 1
	Local $hWnd = _CloseGuardTargetFromMenu()
	If $hWnd = 0 Then
		_CloseGuardNoTarget()
	Else
		_CloseGuardToggle($hWnd)
	EndIf
	$iCG_BusyDepth -= 1
EndFunc   ;==>CloseGuardToggleMenu

; Locks the window if the X is usable, releases it if the X is locked. The real state is read from the system
; menu, not from the lists: this also frees windows that stayed locked after CCTrayTool was ended hard.
; A window that is released by hand is exempt from the rules until it is closed.
Func _CloseGuardToggle($hWnd)
	Local $sKey = _CloseGuardKey($hWnd)
	Local $sTitle = _CloseGuardShortTitle(WinGetTitle($hWnd))
	Local $iState = _CloseGuardGetState($hWnd)
	If $iState = -1 Then
		_CloseGuardReportLockError(1)
	ElseIf $iState = 0 Then
		_CloseGuardUnlock($hWnd)
		$oCG_Exempt.Item($sKey) = 2
		_CloseGuardTip(_CloseGuardFormat(_("Close button released: %1"), $sTitle))
	Else
		If _CloseGuardLock($hWnd, 2) Then
			_CloseGuardTip(_CloseGuardFormat(_("Close button locked: %1"), $sTitle))
		Else
			_CloseGuardReportLockError(@error)
		EndIf
	EndIf
EndFunc   ;==>_CloseGuardToggle

; Hotkey "create rule"
Func CloseGuardAddRuleActive()
	If Not $bCloseGuardEnabledSetting Then Return
	$iCG_BusyDepth += 1
	Local $hWnd = _CloseGuardTargetFromHotkey()
	If $hWnd = 0 Then
		_CloseGuardNoTarget()
	Else
		_CloseGuardAddRuleFor($hWnd)
	EndIf
	$iCG_BusyDepth -= 1
EndFunc   ;==>CloseGuardAddRuleActive

; Tray menu entry "create rule"
Func CloseGuardAddRuleMenu()
	If Not $bCloseGuardEnabledSetting Then Return
	$iCG_BusyDepth += 1
	Local $hWnd = _CloseGuardTargetFromMenu()
	If $hWnd = 0 Then
		_CloseGuardNoTarget()
	Else
		_CloseGuardAddRuleFor($hWnd)
	EndIf
	$iCG_BusyDepth -= 1
EndFunc   ;==>CloseGuardAddRuleMenu

; Creates a rule from the title and the class of the window, saves it and locks the window
Func _CloseGuardAddRuleFor($hWnd)
	Local $sTitle = StringStripWS(WinGetTitle($hWnd), 3)
	Local $sClass = _CloseGuardGetClass($hWnd)
	If Not _CloseGuardHasSysMenu($hWnd) Then
		_CloseGuardReportLockError(1)
		Return
	EndIf
	Local $iResult = CloseGuardAddRule($sTitle, $sClass)
	If $iResult = -1 Then
		_CloseGuardTip(_("The rule could not be written to the rules file."), True)
		Return
	EndIf
	If _CloseGuardLock($hWnd, 1) Then
		Local $sShort = _CloseGuardShortTitle($sTitle, 40)
		If $sTitle = "" Then $sShort = ""
		If $iResult = 1 Then
			_CloseGuardTip(_CloseGuardFormat(_('Rule created (title: "%1", class: "%2"). The close button of this window is locked.'), $sShort, $sClass))
		Else
			_CloseGuardTip(_CloseGuardFormat(_('This rule already exists (title: "%1", class: "%2"). The close button of this window is locked.'), $sShort, $sClass))
		EndIf
	Else
		_CloseGuardReportLockError(@error)
	EndIf
EndFunc   ;==>_CloseGuardAddRuleFor

; Tray menu entry "show locked windows"
Func CloseGuardShowLocked()
	Logfile("CloseGuardShowLocked() start", 6)
	Local $sText = ""
	If $oCG_Locked.Count > 0 Then
		Local $aKeys = $oCG_Locked.Keys()
		Local $sKey, $hWnd, $sReason
		For $sKey In $aKeys
			$hWnd = HWnd($sKey)
			If Not _CloseGuardWindowExists($hWnd) Then ContinueLoop
			If $oCG_Locked.Item($sKey) = 1 Then
				$sReason = _("rule")
			Else
				$sReason = _("manual")
			EndIf
			$sText &= "- " & _CloseGuardShortTitle(WinGetTitle($hWnd), 70) & "  [" & _CloseGuardGetClass($hWnd) & "]  (" & $sReason & ")" & @CRLF
		Next
	EndIf
	If $sText = "" Then
		$sText = _("No windows are locked at the moment.")
	Else
		$sText = _("Windows whose close button is locked by CloseGuard:") & @CRLF & @CRLF & StringStripWS($sText, 2)
	EndIf
	$sText &= @CRLF & @CRLF & _CloseGuardFormat(_("Number of rules: %1"), $iCG_RuleCount)
	;Disable the tray menu while the MsgBox is shown (see About)
	Local $oTrayMenuStates = _TrayMenuDisableAll($hMenu)
	MsgBox(64, _("CloseGuard"), $sText)
	_TrayMenuRestoreDisabled($hMenu, $oTrayMenuStates)
	Logfile("CloseGuardShowLocked() end", 6)
EndFunc   ;==>CloseGuardShowLocked

; Tray menu entry "edit rules": opens the rules file in Notepad. As soon as Notepad is closed the rules are read
; again and applied to the open windows (CloseGuardReapply). The settings file and the tray menu are not touched,
; so there is no need to rebuild the menu like in EditINI().
Func CloseGuardEditRules()
	Logfile("CloseGuardEditRules() start", 6)
	;Hide the tray icon while the editor is open: the main TrayGetMsg() loop is not polled during that time (see EditINI())
	TraySetState(2)
	If Not CloseGuardEnsureRulesFile() Then
		MsgBox(48, _("Error"), _("The rules file could not be created."))
		TraySetState(1)
		Logfile("CloseGuardEditRules() end", 6)
		Return
	EndIf
	If Not FileExists(@SystemDir & "\notepad.exe") Then
		MsgBox(48, _("Error"), _ToolTimeFormat(_("%1 was not found"), @SystemDir & "\notepad.exe", "", "", ""))
		TraySetState(1)
		Logfile("CloseGuardEditRules() end", 6)
		Return
	EndIf
	Logfile("Editing the CloseGuard rules file", 6)
	;Both paths in quotation marks: the path of the user profile may contain spaces
	RunWait('"' & @SystemDir & '\notepad.exe" "' & $sCloseGuardRulesFile & '"')
	;Read the rules again; the automatic check waits until this is done
	$iCG_BusyDepth += 1
	CloseGuardLoadRules()
	$iCG_BusyDepth -= 1
	If $bCloseGuardEnabledSetting = 1 Then CloseGuardReapply()
	TraySetState(1)
	Logfile("CloseGuardEditRules() end", 6)
EndFunc   ;==>CloseGuardEditRules

; ----------------------------------------------------------------------------------------------------
; Automatic check
; ----------------------------------------------------------------------------------------------------

; Runs every $iCG_TickInterval ms (AdlibRegister). Remembers the window the user works in and runs the
; check of all windows once per poll interval.
Func CloseGuardTick()
	If Not $bCloseGuardEnabledSetting Then Return
	If $iCG_BusyDepth > 0 Then Return ;an action (hotkey, menu, reload) is running: try again at the next tick
	$iCG_BusyDepth += 1
	Local $hFg = _CloseGuardForegroundWindow()
	If $hFg <> 0 Then
		If _CloseGuardIsTargetable($hFg) Then $hCG_LastForeign = $hFg
	EndIf
	If TimerDiff($hCG_PollTimer) >= $iCloseGuardPollInterval Then
		$hCG_PollTimer = TimerInit()
		_CloseGuardScan($bCloseGuardAutoApply = 1)
	EndIf
	;The click detection runs only while a locked window is visible (windows get minimized, restored, closed ...)
	_CloseGuardClickSync()
	_CloseGuardOverlaySync() ;debug overlay (only with ClickDebugOverlay=1)
	$iCG_BusyDepth -= 1
EndFunc   ;==>CloseGuardTick

; One check of all windows.
;   $bCheckNew = True : windows that are neither locked nor exempt are compared with the rules (steps 1 + 2)
;   always            : locked windows are checked again (step 3), dead handles are removed (step 4)
Func _CloseGuardScan($bCheckNew)
	Local $i, $hWnd, $sKey, $sClass, $sK, $aKeys, $iError

	;1. + 2. New windows: filter, compare with the rules, lock
	If $bCheckNew And $iCG_RuleCount > 0 Then
		Local $aList = WinList()
		For $i = 1 To $aList[0][0]
			$hWnd = $aList[$i][1]
			$sKey = _CloseGuardKey($hWnd)
			If $oCG_Locked.Exists($sKey) Then ContinueLoop
			If $oCG_Exempt.Exists($sKey) Then ContinueLoop
			;The cheap tests come first: this loop runs for every window on the desktop
			If Not _CloseGuardIsVisible($hWnd) Then ContinueLoop
			$sClass = _CloseGuardGetClass($hWnd)
			If $sClass = "" Then ContinueLoop
			If _CloseGuardIsExcludedClass($sClass) Then ContinueLoop
			If _CloseGuardMatchesRules($aList[$i][0], $sClass) = 0 Then ContinueLoop
			If Not _CloseGuardHasSysMenu($hWnd) Then ContinueLoop ;no system menu = no X, nothing to lock
			If _CloseGuardIsOwnWindow($hWnd) Then ContinueLoop
			If Not _CloseGuardLock($hWnd, 1) Then
				$iError = @error
				;Do not try again at every interval, but tell the user once
				$oCG_Exempt.Item($sKey) = 3
				Logfile("CloseGuard: window could not be locked (error " & $iError & "): " & $sClass & " - " & $aList[$i][0])
				If $iError = 2 Then _CloseGuardReportLockError($iError)
			EndIf
		Next
	EndIf

	;3. Locked windows: has the program restored its system menu? Then lock again.
	If $oCG_Locked.Count > 0 Then
		$aKeys = $oCG_Locked.Keys()
		For $sK In $aKeys
			If Not $oCG_Locked.Exists($sK) Then ContinueLoop
			$hWnd = HWnd($sK)
			If Not _CloseGuardWindowExists($hWnd) Then ContinueLoop ;removed in step 4
			If _CloseGuardGetState($hWnd) = 1 Then
				Logfile("CloseGuard: the window restored its system menu, locking it again: " & $sK, 4)
				If Not _CloseGuardLock($hWnd, $oCG_Locked.Item($sK)) Then
					$oCG_Locked.Remove($sK)
					$oCG_Exempt.Item($sK) = 3
				EndIf
			EndIf
		Next
	EndIf

	;4. Remove handles of windows that do not exist any more (a handle can be used again by another window)
	_CloseGuardPurge($oCG_Locked)
	_CloseGuardPurge($oCG_Exempt)
	_CloseGuardPurge($oCG_ClassCache)
	_CloseGuardPurge($oCG_GeoNeed)
	_CloseGuardPurge($oCG_NoDwm)
	_CloseGuardPurge($oCG_ScanGeo)
	_CloseGuardPurge($oCG_ScanFail)
EndFunc   ;==>_CloseGuardScan

Func _CloseGuardPurge($oDict)
	If $oDict.Count = 0 Then Return
	Local $aKeys = $oDict.Keys()
	Local $sK
	For $sK In $aKeys
		If Not _CloseGuardWindowExists(HWnd($sK)) Then $oDict.Remove($sK)
	Next
EndFunc   ;==>_CloseGuardPurge

; Option "check windows open at start" is off: the windows that are open right now are exempt from the rules
Func _CloseGuardExemptOpenWindows()
	Local $aList = WinList()
	Local $i, $hWnd, $sClass
	For $i = 1 To $aList[0][0]
		$hWnd = $aList[$i][1]
		If Not _CloseGuardIsVisible($hWnd) Then ContinueLoop
		$sClass = _CloseGuardGetClass($hWnd)
		If $sClass = "" Then ContinueLoop
		If _CloseGuardIsExcludedClass($sClass) Then ContinueLoop
		If Not _CloseGuardHasSysMenu($hWnd) Then ContinueLoop
		If _CloseGuardIsOwnWindow($hWnd) Then ContinueLoop
		$oCG_Exempt.Item(_CloseGuardKey($hWnd)) = 1
	Next
	Logfile("CloseGuard: windows that are open at start are exempt: " & $oCG_Exempt.Count, 4)
EndFunc   ;==>_CloseGuardExemptOpenWindows

; ----------------------------------------------------------------------------------------------------
; Start, stop, reload
; ----------------------------------------------------------------------------------------------------

; Starts the module (program start, or CloseGuard is switched on). The hotkeys are registered by
; ApplyTrayMenuSettings().
Func CloseGuardStart()
	Logfile("CloseGuardStart() start", 6)
	$iCG_BusyDepth += 1
	$oCG_Locked.RemoveAll()
	$oCG_Exempt.RemoveAll()
	$oCG_ClassCache.RemoveAll()
	$oCG_GeoNeed.RemoveAll()
	$oCG_NoDwm.RemoveAll()
	$oCG_ScanGeo.RemoveAll()
	$oCG_ScanFail.RemoveAll()
	If $bCloseGuardApplyOnStartup = 1 Then
		;Windows that are open now are checked at once, even if the automatic check is switched off
		_CloseGuardScan(True)
	Else
		_CloseGuardExemptOpenWindows()
	EndIf
	$hCG_PollTimer = TimerInit()
	AdlibUnRegister("CloseGuardTick") ;never register it twice
	AdlibRegister("CloseGuardTick", $iCG_TickInterval)
	$bCG_Running = True
	_CloseGuardClickSync()
	$iCG_BusyDepth -= 1
	_CloseGuardShowNote()
	Logfile("CloseGuardStart() end", 6)
EndFunc   ;==>CloseGuardStart

; ====================================================================================================
; Function: _CloseGuardFirstNotice
; Description: Shown once, the first time CloseGuard is switched on: some windows cannot be locked, because their
;              programs deviate from the usual Windows standards. Not at program start: only when CloseGuard is switched
;              on in the menu or in the INI file (CloseGuard is off after a new installation). "NoticeShown=1" in the
;              [CloseGuard] section of the INI file remembers that the notice was shown; deleting the entry shows it
;              again. While the message box is open, the tray menu is disabled (the main loop is not polled meanwhile, see _TrayMenuDisableAll).
; Parameters: None.
; Returns: None.
; ====================================================================================================
Func _CloseGuardFirstNotice()
	If IniRead($sIniFile, "CloseGuard", "NoticeShown", "0") = "1" Then Return
	Logfile("CloseGuard: showing the one-time notice about windows that cannot be locked", 4)
	IniWrite($sIniFile, "CloseGuard", "NoticeShown", "1") ;written first: the notice must not come back if the program is ended meanwhile
	Local $oPrev = 0
	If $hMenu <> 0 Then $oPrev = _TrayMenuDisableAll($hMenu)
	MsgBox(64 + 262144, $sAppName & " - " & _("CloseGuard"), _("CloseGuard locks the close button (X) of the windows you choose.") & @CRLF & @CRLF & _
			_("Please note: some windows cannot be locked because their programs deviate from the usual Windows standards (for example, they draw their own title bar). With such windows the X may still close the window.") & @CRLF & @CRLF & _
			_("This notice is shown only once. More information: user guide (README.txt), section 4."))
	If IsObj($oPrev) Then _TrayMenuRestoreDisabled($hMenu, $oPrev)
EndFunc   ;==>_CloseGuardFirstNotice

; Gives the X back to all windows that CloseGuard has locked
Func CloseGuardReleaseAll()
	If $oCG_Locked.Count = 0 Then Return
	Logfile("CloseGuard: releasing all locked windows: " & $oCG_Locked.Count, 4)
	Local $aKeys = $oCG_Locked.Keys()
	Local $sK
	For $sK In $aKeys
		_CloseGuardUnlock(HWnd($sK))
	Next
	$oCG_Locked.RemoveAll()
EndFunc   ;==>CloseGuardReleaseAll

; Stops the module (program end, or CloseGuard is switched off): the automatic check ends, both hotkeys are
; released and all locked windows get their X back.
Func CloseGuardStop()
	Logfile("CloseGuardStop() start", 6)
	AdlibUnRegister("CloseGuardTick")
	$iCG_BusyDepth += 1
	HotKeySet($sCloseGuardHotkeyToggle)
	HotKeySet($sCloseGuardHotkeyAddRule)
	CloseGuardReleaseAll()
	$oCG_Exempt.RemoveAll()
	$oCG_ClassCache.RemoveAll()
	$oCG_GeoNeed.RemoveAll()
	$oCG_NoDwm.RemoveAll()
	$oCG_ScanGeo.RemoveAll()
	$oCG_ScanFail.RemoveAll()
	$hCG_LastForeign = 0
	$bCG_Running = False
	_CloseGuardClickSync() ;stops the click detection
	_CloseGuardOverlayClear()
	_CloseGuardShieldClear()
	_CloseGuardClickLogStats()
	$iCG_BusyDepth -= 1
	Logfile("CloseGuardStop() end", 6)
EndFunc   ;==>CloseGuardStop

; The settings or the rules were read again while CloseGuard stays switched on (see EditINI() and
; CloseGuardEditRules()): the rules may have changed.
;   - windows locked by a rule that does not match any more are released
;   - windows that were exempt only because they were open at start (or could not be locked) are checked again
;   - windows that the user has released by hand stay free until they are closed
;   - the automatic check applies the new rules to the open windows right away
Func CloseGuardReapply()
	Logfile("CloseGuardReapply() start", 6)
	$iCG_BusyDepth += 1
	Local $aKeys, $sK, $hWnd
	If $oCG_Exempt.Count > 0 Then
		$aKeys = $oCG_Exempt.Keys()
		For $sK In $aKeys
			If $oCG_Exempt.Item($sK) <> 2 Then $oCG_Exempt.Remove($sK)
		Next
	EndIf
	If $oCG_Locked.Count > 0 Then
		$aKeys = $oCG_Locked.Keys()
		For $sK In $aKeys
			If $oCG_Locked.Item($sK) <> 1 Then ContinueLoop ;locked by hand: not a matter of the rules
			$hWnd = HWnd($sK)
			If Not _CloseGuardWindowExists($hWnd) Then ContinueLoop
			If _CloseGuardMatchesRules(WinGetTitle($hWnd), _CloseGuardGetClass($hWnd)) = 0 Then
				Logfile("CloseGuard: no rule matches any more, releasing " & $sK, 4)
				_CloseGuardUnlock($hWnd)
			EndIf
		Next
	EndIf
	$hCG_PollTimer = TimerInit()
	_CloseGuardScan($bCloseGuardAutoApply = 1)
	_CloseGuardClickSync() ;the option or the interval may have been changed in the INI file
	$iCG_BusyDepth -= 1
	_CloseGuardShowNote()
	Logfile("CloseGuardReapply() end", 6)
EndFunc   ;==>CloseGuardReapply

; ----------------------------------------------------------------------------------------------------
; Click on the locked X: minimize the window (option "MinimizeOnClick")
;
; In a window with a normal title bar a locked X does nothing when it is clicked, so the click does not have to be
; intercepted, it only has to be noticed (programs that close themselves are the exception, see "Shield"). No hook is used (a global hook sits in the input path of the whole system). Instead the state of the
; primary mouse button is polled (GetAsyncKeyState reads it passively), every $iCloseGuardClickInterval ms:
;   - The button goes down: is the mouse on the X (WM_NCHITTEST = HTCLOSE) of a window that CloseGuard has locked?
;     Then that window is remembered. Windows that are not locked never get a message.
;   - The button goes up: is the mouse still on the X of the same window? Then the window is minimized. Like the
;     real button: pressing it and moving away before releasing does nothing.
; The worst case is a click that is not noticed (a short click while the script is busy): the window then simply
; stays as it is, locked. Nothing can slow down the mouse or the system.
; Programs that draw their own title bar (Outlook and other Office programs, ...) may answer the hit test with
; "client" or "caption" instead of HTCLOSE, although their X is on the screen. For such a window the position is
; compared with the close button area that DWM reports for the window (_CloseGuardCloseButtonRect, switch:
; ClickGeometryFallback in the INI file). The area is somewhat larger to the left and downwards
; (ClickGeometryExtendLeft / ClickGeometryExtendDown, percent of the size of the button).
; Presses near the title bar buttons of a locked window are written to the log
; (level 5, "CloseGuard diag") with the hit test result, so that it can be seen what a window answers.
; Troubleshooting: with ClickDebugOverlay=1 in the INI file the areas are drawn on the screen as transparent
; rectangles (red: area in which a press counts as a press on the X, blue: close button area that DWM reports,
; green: the shield over the X).
; Programs that draw their own X and close themselves when the mouse button is RELEASED (Edge, Chrome and other Chromium
; programs, Firefox) are not stopped by the locked system menu. For the window classes in the INI key ClickShieldClasses
; (default Chrome_WidgetWin_1 and MozillaWindowClass) the X gets a "shield", see "Shield" below; the timer runs also if
; MinimizeOnClick is 0.
; The timer runs only while it is needed (_CloseGuardClickSync): option on and at least one locked window that is
; visible and not minimized, or a locked window of one of those classes. Counters are written to the log when
; CloseGuard is stopped.
; ----------------------------------------------------------------------------------------------------

Func _CloseGuardMetric($iIndex)
	Local $aRet = DllCall("user32.dll", "int", "GetSystemMetrics", "int", $iIndex)
	If @error Or Not IsArray($aRet) Then Return 0
	Return $aRet[0]
EndFunc   ;==>_CloseGuardMetric

Func _CloseGuardIsIconic($hWnd)
	Local $aRet = DllCall("user32.dll", "bool", "IsIconic", "hwnd", $hWnd)
	If @error Or Not IsArray($aRet) Then Return False
	Return $aRet[0] <> 0
EndFunc   ;==>_CloseGuardIsIconic

; Which locked windows can be clicked (they exist, are visible and are not minimized)?
; Returns a bit mask: 1 = at least one such window, 2 = at least one of them is of a "shield" class (ClickShieldClasses)
Func _CloseGuardClickableMask()
	If $oCG_Locked.Count = 0 Then Return 0
	Local $aKeys = $oCG_Locked.Keys()
	Local $sK, $hWnd
	Local $iMask = 0
	For $sK In $aKeys
		$hWnd = HWnd($sK)
		If Not _CloseGuardWindowExists($hWnd) Then ContinueLoop
		If Not _CloseGuardIsVisible($hWnd) Then ContinueLoop
		If _CloseGuardIsIconic($hWnd) Then ContinueLoop
		$iMask = BitOR($iMask, 1)
		If _CloseGuardIsShieldClass($hWnd) Then
			$iMask = BitOR($iMask, 2)
			ExitLoop
		EndIf
	Next
	Return $iMask
EndFunc   ;==>_CloseGuardClickableMask

; Reads the list of window classes (separated by comma, semicolon or "|") into $sCG_ShieldClassList ("|class|class|", lower case)
Func _CloseGuardParseShieldClasses()
	$sCG_ShieldClassList = ""
	Local $aParts = StringSplit(StringReplace(StringReplace($sCloseGuardShieldClasses, ";", ","), "|", ","), ",", 2)
	Local $i, $sPart
	For $i = 0 To UBound($aParts) - 1
		$sPart = StringLower(StringStripWS($aParts[$i], 3))
		If $sPart = "" Then ContinueLoop
		If $sCG_ShieldClassList = "" Then $sCG_ShieldClassList = "|"
		$sCG_ShieldClassList &= $sPart & "|"
	Next
EndFunc   ;==>_CloseGuardParseShieldClasses

; True if the window is of a class whose X cannot be locked (the program closes itself when the X is released)
Func _CloseGuardIsShieldClass($hWnd)
	If $sCG_ShieldClassList = "" Then Return False
	Return StringInStr($sCG_ShieldClassList, "|" & StringLower(_CloseGuardGetClass($hWnd)) & "|") > 0
EndFunc   ;==>_CloseGuardIsShieldClass

; Starts or stops the timer, depending on whether it is needed right now. Called whenever that can change
; (lock, release, start, stop, new settings, menu entry) and by every tick of CloseGuardTick().
Func _CloseGuardClickSync()
	If $bCloseGuardMinimizeOnClick = 0 And $sCG_ShieldClassList = "" And Not $bCG_ClickTimerOn Then Return
	Local $bWanted = False
	Local $iInterval = $iCloseGuardClickInterval
	If $bCG_Running And $bCloseGuardEnabledSetting = 1 Then
		Local $iMask = _CloseGuardClickableMask()
		If BitAND($iMask, 2) <> 0 Then
			;A window of a "shield" class is there: the timer keeps its shield up to date, and as long as the shield is not in
			;place a press is answered at once (see _CloseGuardClickPress), so the button is polled as fast as possible (also
			;if MinimizeOnClick is 0)
			$bWanted = True
			$iInterval = $iCloseGuardClickMin
		ElseIf BitAND($iMask, 1) <> 0 And $bCloseGuardMinimizeOnClick = 1 Then
			$bWanted = True
		EndIf
	EndIf
	If Not $bWanted Then
		If $bCG_ClickTimerOn Then _CloseGuardClickTimerStop()
		Return
	EndIf
	If $bCG_ClickTimerOn Then
		If $iCG_ClickTimerInterval = $iInterval Then Return
		_CloseGuardClickTimerStop() ;the interval was changed (INI file, or a window of a "shield" class appeared or disappeared)
	EndIf
	_CloseGuardClickTimerStart($iInterval)
EndFunc   ;==>_CloseGuardClickSync

Func _CloseGuardClickTimerStart($iInterval)
	$bCG_SwapButtons = (_CloseGuardMetric(23) <> 0) ;SM_SWAPBUTTON
	$hCG_SwapTimer = TimerInit()
	$bCG_BtnDown = _CloseGuardPrimaryDown() ;a button that is down already is not a click on the X
	$bCG_ShieldDue = True
	$hCG_PressWnd = 0
	$iCG_VerifyStage = 0
	$hCG_ClickPollLast = TimerInit()
	$bCG_ClickBusy = False
	AdlibUnRegister("CloseGuardClickTick") ;never register it twice
	AdlibRegister("CloseGuardClickTick", $iInterval)
	$bCG_ClickTimerOn = True
	$iCG_ClickTimerInterval = $iInterval
	Logfile("CloseGuard: click detection started, interval " & $iInterval & " ms", 6)
EndFunc   ;==>_CloseGuardClickTimerStart

Func _CloseGuardClickTimerStop()
	AdlibUnRegister("CloseGuardClickTick")
	$bCG_ClickTimerOn = False
	_CloseGuardShieldClear()
	$hCG_PressWnd = 0
	$iCG_VerifyStage = 0 ;an old check must never run when the timer is started again
	Logfile("CloseGuard: click detection stopped", 6)
EndFunc   ;==>_CloseGuardClickTimerStop

; The counters go to the log (level 5) and start again from 0
Func _CloseGuardClickLogStats()
	If $iCG_StatPolls = 0 Then Return
	Logfile("CloseGuard click detection: " & $iCG_StatPolls & " polls, longest gap " & Round($fCG_StatMaxGap) & " ms, presses on a locked X " & $iCG_StatPresses & ", minimized " & $iCG_StatMinimized & ", cancelled " & $iCG_StatCancelled, 5)
	$iCG_StatPolls = 0
	$fCG_StatMaxGap = 0
	$iCG_StatPresses = 0
	$iCG_StatMinimized = 0
	$iCG_StatCancelled = 0
EndFunc   ;==>_CloseGuardClickLogStats

; The timer function (AdlibRegister). Short on purpose: it normally does nothing but read the button.
Func CloseGuardClickTick()
	If $iCG_BusyDepth > 0 Then Return ;an action is running: the next poll comes soon
	If $bCG_ClickBusy Then Return
	$bCG_ClickBusy = True

	Local $fGap = TimerDiff($hCG_ClickPollLast)
	$hCG_ClickPollLast = TimerInit()
	$iCG_StatPolls += 1
	If $fGap > $fCG_StatMaxGap Then $fCG_StatMaxGap = $fGap

	If $iCG_VerifyStage <> 0 Then _CloseGuardMinimizeVerify()

	;Swapped mouse buttons are checked once per second only
	If TimerDiff($hCG_SwapTimer) > 1000 Then
		$hCG_SwapTimer = TimerInit()
		$bCG_SwapButtons = (_CloseGuardMetric(23) <> 0)
	EndIf

	Local $bDown = _CloseGuardPrimaryDown()
	If $bDown <> $bCG_BtnDown Then
		$bCG_BtnDown = $bDown
		If $bDown Then
			_CloseGuardClickPress()
		Else
			_CloseGuardClickRelease()
		EndIf
	EndIf
	If $bCG_ShieldDue Or TimerDiff($hCG_ShieldTimer) >= $iCG_ShieldInterval Then _CloseGuardShieldSync()
	$bCG_ClickBusy = False
EndFunc   ;==>CloseGuardClickTick

; The primary mouse button. GetAsyncKeyState looks at the PHYSICAL buttons: with swapped buttons the primary
; button is the physical right one.
Func _CloseGuardPrimaryDown()
	Local $iVK = 0x01
	If $bCG_SwapButtons Then $iVK = 0x02
	Local $aRet = DllCall("user32.dll", "short", "GetAsyncKeyState", "int", $iVK)
	If @error Or Not IsArray($aRet) Then Return False
	Return BitAND($aRet[0], 0x8000) <> 0
EndFunc   ;==>_CloseGuardPrimaryDown

; The button went down: remember the window if the mouse is on the X of a locked window
Func _CloseGuardClickPress()
	$hCG_PressWnd = 0
	Local $aInfo = _CloseGuardHitUnderMouse()
	If $aInfo[0] = 0 Then
		;Not a locked window under the mouse: is it covering the X of a locked window? (only for the log)
		If $iCG_DiagCount < $iCG_DiagMax And $oCG_Locked.Count > 0 Then _CloseGuardClickDiagCovered($aInfo)
		Return
	EndIf
	If $aInfo[1] <> $iCG_HTCLOSE Then
		_CloseGuardClickDiag($aInfo) ;a locked window, but not on its X: the log shows what the window answered
		Return
	EndIf
	If _CloseGuardIsShieldClass($aInfo[0]) And Not _CloseGuardShieldActive(_CloseGuardKey($aInfo[0])) Then
		;This program draws its own X and closes itself when the button is RELEASED, the system menu cannot stop that,
		;and there is no shield over its X (yet). Fallback: the window is minimized now, while the button is still down.
		;(This is mostly too late, the program closes itself anyway. The shield is the real solution.)
		$iCG_StatPresses += 1
		$iCG_StatMinimized += 1
		_CloseGuardMinimizeWindow($aInfo[0], True)
		Return
	EndIf
	;The shield took the click (the window never saw it): that goes to the log, also if nothing is done with it
	If _CloseGuardIsShieldClass($aInfo[0]) Then Logfile("CloseGuard: the click on the X was taken by the shield: " & _CloseGuardKey($aInfo[0]) & " " & _CloseGuardGetClass($aInfo[0]), 5)
	If $bCloseGuardMinimizeOnClick = 0 Then Return ;the timer runs for windows of the "shield" classes only
	$hCG_PressWnd = $aInfo[0]
	$hCG_PressTimer = TimerInit()
	$iCG_StatPresses += 1
	If $aInfo[5] = 1 Then
		Logfile("CloseGuard: the X of a locked window was pressed (recognized by its position, the window answers hit test " & $aInfo[2] & ", mouse " & $aInfo[3] & "," & $aInfo[4] & " in the area " & $aInfo[7] & "): " & _CloseGuardKey($aInfo[0]), 5)
	Else
		Logfile("CloseGuard: the X of a locked window was pressed: " & _CloseGuardKey($aInfo[0]) & " " & _CloseGuardGetClass($aInfo[0]), 5)
	EndIf
EndFunc   ;==>_CloseGuardClickPress

; The button went up: minimize the window if the mouse is still on the X of the same window
Func _CloseGuardClickRelease()
	If $hCG_PressWnd = 0 Then Return
	Local $hTarget = $hCG_PressWnd
	$hCG_PressWnd = 0
	If TimerDiff($hCG_PressTimer) > $iCG_ClickMaxHold Then
		$iCG_StatCancelled += 1
		Return ;held for too long (or the script was blocked in between): not a click
	EndIf
	Local $aInfo = _CloseGuardHitUnderMouse()
	If $aInfo[0] <> 0 And $aInfo[1] = $iCG_HTCLOSE And _CloseGuardKey($aInfo[0]) = _CloseGuardKey($hTarget) Then
		$iCG_StatMinimized += 1
		_CloseGuardMinimizeWindow($hTarget)
	Else
		$iCG_StatCancelled += 1
		Logfile("CloseGuard: released away from the X, nothing happens", 6)
	EndIf
EndFunc   ;==>_CloseGuardClickRelease

; The top level window under the mouse and the result of its WM_NCHITTEST. Only a window that CloseGuard has
; locked is asked. Returns [0] = window (0 = none or not locked), [1] = hit test result.
; While the mouse is asked this thread works in physical pixels (DPI per monitor), so that the coordinates are
; right with every scaling and on every monitor.
Func _CloseGuardHitUnderMouse()
	Local $vOldCtx = _CloseGuardEnterDpi()
	Local $aOut = _CloseGuardHitUnderMouseRaw()
	_CloseGuardLeaveDpi($vOldCtx)
	Return $aOut
EndFunc   ;==>_CloseGuardHitUnderMouse

Func _CloseGuardHitUnderMouseRaw()
	;[0] locked window (0 = none), [1] hit test result used, [2] hit test result the window reported,
	;[3] + [4] mouse position, [5] 1 = recognized by position, [6] top level window under the mouse (locked or not),
	;[7] the area in which the position was recognized (text, for the log)
	Local $aOut[8] = [0, 0, 0, 0, 0, 0, 0, ""]
	Local $tPt = DllStructCreate("long X;long Y")
	Local $aCur = DllCall("user32.dll", "bool", "GetCursorPos", "struct*", $tPt)
	If @error Or Not IsArray($aCur) Then Return $aOut
	If $aCur[0] = 0 Then Return $aOut
	Local $iX = DllStructGetData($tPt, "X")
	Local $iY = DllStructGetData($tPt, "Y")
	$aOut[3] = $iX
	$aOut[4] = $iY
	Local $aWnd = DllCall("user32.dll", "hwnd", "WindowFromPoint", "struct", $tPt)
	If @error Or Not IsArray($aWnd) Then Return $aOut
	If $aWnd[0] = 0 Then Return $aOut
	Local $aRoot = DllCall("user32.dll", "hwnd", "GetAncestor", "hwnd", $aWnd[0], "uint", 2) ;GA_ROOT
	If @error Or Not IsArray($aRoot) Then Return $aOut
	If $aRoot[0] = 0 Then Return $aOut
	;A shield (see "Shield"): the press is a press on the X of the locked window that the shield belongs to
	If $oCG_ShieldOwner.Count > 0 Then
		If $oCG_ShieldOwner.Exists(_CloseGuardKey($aRoot[0])) Then
			Local $sOwner = $oCG_ShieldOwner.Item(_CloseGuardKey($aRoot[0]))
			If Not $oCG_Locked.Exists($sOwner) Then Return $aOut
			$aOut[0] = HWnd($sOwner)
			$aOut[1] = $iCG_HTCLOSE
			$aOut[2] = $iCG_HTCLOSE
			$aOut[6] = $aOut[0]
			Return $aOut
		EndIf
	EndIf
	;The debug overlay is click-through and disabled, so WindowFromPoint should not return it. If it does anyway, the
	;window below it is used: the overlay must never change what the detection sees.
	If $oCG_OverlayHandles.Count > 0 Then
		If $oCG_OverlayHandles.Exists(_CloseGuardKey($aRoot[0])) Then
			$aRoot[0] = _CloseGuardWindowBelow($aRoot[0], $iX, $iY)
			If $aRoot[0] = 0 Then Return $aOut
		EndIf
	EndIf
	$aOut[6] = $aRoot[0]
	If Not $oCG_Locked.Exists(_CloseGuardKey($aRoot[0])) Then Return $aOut ;no message for windows that are not locked
	Local $iLParam = BitOR(BitAND($iX, 0xFFFF), BitShift(BitAND($iY, 0xFFFF), -16))
	;SendMessageTimeout: a window that hangs must not block the script (SMTO_ABORTIFHUNG = 2, 100 ms)
	Local $aHit = DllCall("user32.dll", "lresult", "SendMessageTimeoutW", "hwnd", $aRoot[0], "uint", $iCG_WM_NCHITTEST, "wparam", 0, "lparam", $iLParam, "uint", 2, "uint", 100, "dword_ptr*", 0)
	If @error Or Not IsArray($aHit) Then Return $aOut
	If $aHit[0] = 0 Then Return $aOut
	Local $iReported = $aHit[7]
	Local $iUsed = $iReported
	;Windows with their own title bar answer "nowhere" (0), "client" (1) or "caption" (2) on their X: then the
	;position decides
	If $iReported <> $iCG_HTCLOSE And $bCloseGuardClickGeometry = 1 And ($iReported = 0 Or $iReported = 1 Or $iReported = 2) Then
		Local $aBtn = _CloseGuardCloseButtonRect($aRoot[0])
		Local $iBtnErr = @error
		If Not IsArray($aBtn) Then _CloseGuardNoDwmNote($aRoot[0], $iBtnErr)
		If IsArray($aBtn) Then
			If $aBtn[14] = 1 And $iX >= $aBtn[10] And $iX < $aBtn[12] And $iY >= $aBtn[11] And $iY < $aBtn[13] Then
				$iUsed = $iCG_HTCLOSE
				$aOut[5] = 1
				$aOut[7] = $aBtn[10] & "," & $aBtn[11] & " - " & $aBtn[12] & "," & $aBtn[13]
			EndIf
		EndIf
	EndIf
	$aOut[0] = $aRoot[0]
	$aOut[1] = $iUsed
	$aOut[2] = $iReported
	Return $aOut
EndFunc   ;==>_CloseGuardHitUnderMouseRaw

; Reads a percentage (0 - $iCloseGuardExtendMax) from the section [CloseGuard]. Missing or not a number: the default.
Func _CloseGuardReadPercent($sKey, $iDefault)
	Local $sVal = StringStripWS(IniRead($sIniFile, "CloseGuard", $sKey, ""), 3)
	If $sVal = "" Or Not StringIsDigit($sVal) Then Return $iDefault
	Local $iVal = Int($sVal)
	If $iVal > $iCloseGuardExtendMax Then
		Logfile("CloseGuard " & $sKey & " is too large (" & $iVal & "), using " & $iCloseGuardExtendMax)
		$iVal = $iCloseGuardExtendMax
	EndIf
	Return $iVal
EndFunc   ;==>_CloseGuardReadPercent

Func _CloseGuardGetStyle($hWnd)
	Local $aRet = DllCall("user32.dll", "long", "GetWindowLongW", "hwnd", $hWnd, "int", $iCG_GWL_STYLE)
	If @error Or Not IsArray($aRet) Then Return 0
	Return $aRet[0]
EndFunc   ;==>_CloseGuardGetStyle

; Screen rectangle (physical pixels) of the close button of a window, taken from the caption button area that DWM
; reports. The button is the right one of three (minimize, maximize, close); a window without minimize and maximize
; box has the close button only. Returns an array: [0] left, [1] top, [2] right, [3] bottom of the close button,
; [4..7] rectangle of the window, [8] number of caption buttons, [9] width of the whole caption button area,
; [10..13] left, top, right, bottom of the area in which a press counts as a press on the X (see below),
; [14] 1 = this area is used (the window does not report its X with the hit test), 0 = not used.
; [15] 0 = the rectangle comes from DWM, 1 = DWM has no data for the window (Firefox): the rectangle is the area of the
; X that was found by asking the window (_CloseGuardRectByScan), [10..13] are the same area, [14] is 0.
; Without data: 0 and @error = 1 (window rectangle), 2 (dwmapi.dll), 3 (DWM reports an error), 4 (empty area); the
; steps 2 to 4 are only returned if asking the window did not find the X either.
Func _CloseGuardCloseButtonRect($hWnd)
	Local $tWin = DllStructCreate("long L;long T;long R;long B")
	Local $aRet = DllCall("user32.dll", "bool", "GetWindowRect", "hwnd", $hWnd, "struct*", $tWin)
	If @error Or Not IsArray($aRet) Then Return SetError(1, 0, 0)
	If $aRet[0] = 0 Then Return SetError(1, 0, 0)
	Local $tBtn = DllStructCreate("long L;long T;long R;long B")
	$aRet = DllCall("dwmapi.dll", "long", "DwmGetWindowAttribute", "hwnd", $hWnd, "dword", $iCG_DWMWA_CAPTION_BUTTON_BOUNDS, "struct*", $tBtn, "dword", 16)
	Local $iDllErr = @error
	Local $iNoData = 0
	If $iDllErr Or Not IsArray($aRet) Then
		$iNoData = 2
	ElseIf $aRet[0] <> 0 Then
		$iNoData = 3
	ElseIf DllStructGetData($tBtn, "R") - DllStructGetData($tBtn, "L") <= 0 Or DllStructGetData($tBtn, "B") - DllStructGetData($tBtn, "T") <= 0 Then
		$iNoData = 4
	EndIf
	If $iNoData <> 0 Then
		;DWM has no caption button data (Firefox draws its title bar itself): the window is asked where its X is
		Local $aFound = _CloseGuardRectByScan($hWnd, $tWin)
		If IsArray($aFound) Then Return $aFound
		Return SetError($iNoData, 0, 0)
	EndIf
	Local $iAreaW = DllStructGetData($tBtn, "R") - DllStructGetData($tBtn, "L")
	Local $iButtons = 1
	If BitAND(_CloseGuardGetStyle($hWnd), BitOR($iCG_WS_MINIMIZEBOX, $iCG_WS_MAXIMIZEBOX)) <> 0 Then $iButtons = 3
	Local $aOut[16]
	$aOut[2] = DllStructGetData($tWin, "L") + DllStructGetData($tBtn, "R")
	$aOut[0] = $aOut[2] - Int($iAreaW / $iButtons)
	$aOut[1] = DllStructGetData($tWin, "T") + DllStructGetData($tBtn, "T")
	$aOut[3] = DllStructGetData($tWin, "T") + DllStructGetData($tBtn, "B")
	$aOut[4] = DllStructGetData($tWin, "L")
	$aOut[5] = DllStructGetData($tWin, "T")
	$aOut[6] = DllStructGetData($tWin, "R")
	$aOut[7] = DllStructGetData($tWin, "B")
	$aOut[8] = $iButtons
	$aOut[9] = $iAreaW
	;[10..13] area in which a press counts as a press on the X: the button, enlarged to the left and downwards.
	;Some programs draw their X somewhat further left and lower than DWM reports (measured with Outlook: the X only
	;reacts from about its middle to the right and upwards). The INI keys say how much, in percent of the button size.
	$aOut[10] = $aOut[0] - Int(($aOut[2] - $aOut[0]) * $iCloseGuardClickExtendLeft / 100)
	$aOut[11] = $aOut[1]
	$aOut[12] = $aOut[2]
	$aOut[13] = $aOut[3] + Int(($aOut[3] - $aOut[1]) * $iCloseGuardClickExtendDown / 100)
	;[14] 1 = the window does not report its X with the hit test: the area above is used. 0 = it does (Edge, Chrome,
	;Notepad ...): the hit test alone decides, the area would only cover other buttons below the X (the "Chat" button of Edge).
	$aOut[14] = _CloseGuardNeedsGeometry($hWnd, $aOut)
	$aOut[15] = 0
	Return $aOut
EndFunc   ;==>_CloseGuardCloseButtonRect

; The result of _CloseGuardCloseButtonRect() for a window without DWM data: the area of the X ($iAL, $iAT, $iAR, $iAB) takes
; the place of the button rectangle. $iL, $iT, $iR, $iB = rectangle of the window.
Func _CloseGuardScanResult($iL, $iT, $iR, $iB, $iAL, $iAT, $iAR, $iAB)
	Local $aOut[16]
	$aOut[0] = $iAL
	$aOut[1] = $iAT
	$aOut[2] = $iAR
	$aOut[3] = $iAB
	$aOut[4] = $iL
	$aOut[5] = $iT
	$aOut[6] = $iR
	$aOut[7] = $iB
	$aOut[8] = 1
	$aOut[9] = $iAR - $iAL
	$aOut[10] = $iAL
	$aOut[11] = $iAT
	$aOut[12] = $iAR
	$aOut[13] = $iAB
	$aOut[14] = 0 ;the window reports its X with the hit test: the hit test alone decides
	$aOut[15] = 1
	Return $aOut
EndFunc   ;==>_CloseGuardScanResult

; DWM reports no caption button data for this window (Firefox draws its own title bar), so there is no rectangle to start
; from. The window is asked where its X is: rows near the upper edge of the window (8, 16, 24, 34, 46 and 60 pixels
; below it) are asked from the right edge to the left in steps of 4 pixels (WM_NCHITTEST), the first answer "close" is
; a point on the X. From there the area is scanned (_CloseGuardScanClose), and once more from the middle of that area,
; because the first point lies somewhere at the edge of the X. An area that is not plausible for an X (less than 10 or
; more than 140 pixels wide, less than 10 or more than 110 high) is not used: a shield over a whole title bar would
; make the window impossible to move.
; The result is remembered as offsets to the upper right corner of the window as long as the size of the window stays the
; same (the X sits at the same place relative to that corner while the window is moved). A search that found nothing is
; remembered too and not repeated for $iCG_ScanRetry ms. $tWin = rectangle of the window (struct L, T, R, B, physical pixels).
; Returns the array of _CloseGuardScanResult(), or 0.
Func _CloseGuardRectByScan($hWnd, $tWin)
	Local $sKey = _CloseGuardKey($hWnd)
	Local $iL = DllStructGetData($tWin, "L")
	Local $iT = DllStructGetData($tWin, "T")
	Local $iR = DllStructGetData($tWin, "R")
	Local $iB = DllStructGetData($tWin, "B")
	Local $sSig = ($iR - $iL) & "x" & ($iB - $iT)
	Local $aPart
	Local $bFailedBefore = False
	;1. Found before: used as long as the size of the window stays the same
	If $oCG_ScanGeo.Exists($sKey) Then
		$aPart = StringSplit($oCG_ScanGeo.Item($sKey), "|", 2)
		If UBound($aPart) = 5 Then
			If $aPart[0] = $sSig Then Return _CloseGuardScanResult($iL, $iT, $iR, $iB, $iR + Int($aPart[1]), $iT + Int($aPart[2]), $iR + Int($aPart[3]), $iT + Int($aPart[4]))
		EndIf
		$oCG_ScanGeo.Remove($sKey)
	EndIf
	;2. A search that found nothing is not repeated at once
	If $oCG_ScanFail.Exists($sKey) Then
		$aPart = StringSplit($oCG_ScanFail.Item($sKey), "|", 2)
		If UBound($aPart) = 2 Then
			If $aPart[0] = $sSig Then
				If TimerDiff(Number($aPart[1])) < $iCG_ScanRetry Then Return 0
				$bFailedBefore = True ;a repeated search: the log line was written already
			EndIf
		EndIf
		$oCG_ScanFail.Remove($sKey)
	EndIf
	;3. Rows from top to bottom, in every row from right to left: the first "close" is a point on the X
	Local $aRows[6] = [8, 16, 24, 34, 46, 60]
	Local $iXMin = $iR - 300
	If $iXMin < $iL Then $iXMin = $iL
	Local $i, $iX, $iY, $iHit
	Local $iPX = 0
	Local $iPY = 0
	Local $bNoAnswer = False
	For $i = 0 To 5
		$iY = $iT + $aRows[$i]
		If $iY >= $iB Then ExitLoop
		For $iX = $iR - 2 To $iXMin Step -4
			$iHit = _CloseGuardHit($hWnd, $iX, $iY)
			If $iHit = -99 Then
				$bNoAnswer = True
				ExitLoop 2
			EndIf
			If $iHit = $iCG_HTCLOSE Then
				$iPX = $iX
				$iPY = $iY
				ExitLoop 2
			EndIf
		Next
	Next
	;4. The area around that point
	Local $sWhy = ""
	Local $aArea = 0
	Local $aArea2 = 0
	If $bNoAnswer Then
		$sWhy = "the window does not answer in time"
	ElseIf $iPX = 0 Then
		$sWhy = "the window does not answer ""close"" in the upper right corner"
	Else
		$aArea = _CloseGuardScanClose($hWnd, $iPX, $iPY)
		If IsArray($aArea) Then
			$aArea2 = _CloseGuardScanClose($hWnd, $aArea[0] + Int(($aArea[2] - $aArea[0]) / 2), $aArea[1] + Int(($aArea[3] - $aArea[1]) / 2))
			If IsArray($aArea2) Then $aArea = $aArea2
			If ($aArea[2] - $aArea[0]) < 10 Or ($aArea[2] - $aArea[0]) > 140 Or ($aArea[3] - $aArea[1]) < 10 Or ($aArea[3] - $aArea[1]) > 110 Then
				$sWhy = "the area " & $aArea[0] & "," & $aArea[1] & " - " & $aArea[2] & "," & $aArea[3] & " is not plausible for an X"
				$aArea = 0
			EndIf
		Else
			$sWhy = "the area around the point " & $iPX & "," & $iPY & " could not be read"
		EndIf
	EndIf
	If Not IsArray($aArea) Then
		$oCG_ScanFail.Item($sKey) = $sSig & "|" & TimerInit()
		If Not $bFailedBefore Then Logfile("CloseGuard: no caption button data from DWM for " & $sKey & " " & _CloseGuardGetClass($hWnd) & ", and the X was not found by asking the window (" & $sWhy & "; window " & $iL & "," & $iT & " - " & $iR & "," & $iB & "), the next try is in " & Int($iCG_ScanRetry / 1000) & " s", 5)
		Return 0
	EndIf
	$oCG_ScanGeo.Item($sKey) = $sSig & "|" & ($aArea[0] - $iR) & "|" & ($aArea[1] - $iT) & "|" & ($aArea[2] - $iR) & "|" & ($aArea[3] - $iT)
	Logfile("CloseGuard: no caption button data from DWM for " & $sKey & " " & _CloseGuardGetClass($hWnd) & ", the X was found by asking the window: " & $aArea[0] & "," & $aArea[1] & " - " & $aArea[2] & "," & $aArea[3] & " (window size " & $sSig & ")", 5)
	Return _CloseGuardScanResult($iL, $iT, $iR, $iB, $aArea[0], $aArea[1], $aArea[2], $aArea[3])
EndFunc   ;==>_CloseGuardRectByScan

; DWM reports no caption button data for this locked window and asking the window did not find its X either
; (_CloseGuardRectByScan): there is no overlay, no shield and no position fallback, only the hit test of the window is
; used. Written once per window (log level 5). $iErr = @error of _CloseGuardCloseButtonRect().
Func _CloseGuardNoDwmNote($hWnd, $iErr)
	Local $sKey = _CloseGuardKey($hWnd)
	If $oCG_NoDwm.Exists($sKey) Then Return
	$oCG_NoDwm.Item($sKey) = 1
	Logfile("CloseGuard: no caption button data for the locked window " & $sKey & " " & _CloseGuardGetClass($hWnd) & " (step " & $iErr & ": 1 = window rectangle, 2 = dwmapi.dll, 3 = DWM reports an error, 4 = empty area) and the X was not found by asking the window either, so there is no overlay, no shield and no position fallback, only the hit test of the window is used", 5)
EndFunc   ;==>_CloseGuardNoDwmNote

; Does the window need the position fallback? The window is asked itself (WM_NCHITTEST for a point on its X, the
; mouse is not needed): the answer "close" (20) means it reports its X correctly, so the hit test is enough. Any
; other answer (Outlook and Word answer "caption") means the X is only found by position.
; The answer is remembered for the window. If the window does not answer in time the fallback stays on, but the
; answer is not remembered. Returns 1 = fallback needed, 0 = not needed.
Func _CloseGuardNeedsGeometry($hWnd, $aBtn)
	Local $sKey = _CloseGuardKey($hWnd)
	If $oCG_GeoNeed.Exists($sKey) Then Return $oCG_GeoNeed.Item($sKey)
	;Two points in the middle of the height of the button, at 3/4 and at 1/2 of its width. (The middle of the height:
	;with a maximized window the upper edge of the rectangle lies outside of the screen.)
	Local $iY = $aBtn[1] + Int(($aBtn[3] - $aBtn[1]) / 2)
	Local $i, $iX, $iLParam, $aHit
	Local $sAnswers = ""
	Local $iNeed = 1
	Local $sState = "on"
	For $i = 1 To 2
		If $i = 1 Then
			$iX = $aBtn[0] + Int(($aBtn[2] - $aBtn[0]) * 3 / 4)
		Else
			$iX = $aBtn[0] + Int(($aBtn[2] - $aBtn[0]) / 2)
		EndIf
		$iLParam = BitOR(BitAND($iX, 0xFFFF), BitShift(BitAND($iY, 0xFFFF), -16))
		$aHit = DllCall("user32.dll", "lresult", "SendMessageTimeoutW", "hwnd", $hWnd, "uint", $iCG_WM_NCHITTEST, "wparam", 0, "lparam", $iLParam, "uint", 2, "uint", 100, "dword_ptr*", 0)
		If @error Or Not IsArray($aHit) Then Return 1
		If $aHit[0] = 0 Then Return 1
		$sAnswers &= " " & $aHit[7]
		If $aHit[7] = $iCG_HTCLOSE Then
			$iNeed = 0
			$sState = "off"
			ExitLoop
		EndIf
	Next
	$oCG_GeoNeed.Item($sKey) = $iNeed
	Logfile("CloseGuard: probe of the X of " & $sKey & " " & _CloseGuardGetClass($hWnd) & ": the window answers hit test" & $sAnswers & " at y " & $iY & ", position fallback " & $sState, 5)
	Return $iNeed
EndFunc   ;==>_CloseGuardNeedsGeometry

; Diagnosis (log level 5): the mouse button was pressed on a locked window, but not on its X. Only presses near the
; title bar buttons are written (not every click into the window), at most $iCG_DiagMax lines per program run.
Func _CloseGuardClickDiag($aInfo)
	If $iCG_DiagCount >= $iCG_DiagMax Then Return
	Local $vOldCtx = _CloseGuardEnterDpi()
	Local $aBtn = _CloseGuardCloseButtonRect($aInfo[0])
	Local $iErr = @error
	_CloseGuardLeaveDpi($vOldCtx)
	Local $sBtn = ""
	If IsArray($aBtn) Then
		If $aInfo[3] < $aBtn[0] - 400 Or $aInfo[3] > $aBtn[2] + 50 Or $aInfo[4] < $aBtn[1] - 20 Or $aInfo[4] > $aBtn[3] + 120 Then Return
		Local $sSrc = "from DWM"
		If $aBtn[15] = 1 Then $sSrc = "no DWM data, found by asking the window"
		$sBtn = "close button area " & $aBtn[0] & "," & $aBtn[1] & " - " & $aBtn[2] & "," & $aBtn[3] & " (" & $aBtn[8] & " buttons, area width " & $aBtn[9] & ", " & $sSrc & "), recognized area " & $aBtn[10] & "," & $aBtn[11] & " - " & $aBtn[12] & "," & $aBtn[13] & " (position fallback " & $aBtn[14] & "), window " & $aBtn[4] & "," & $aBtn[5] & " - " & $aBtn[6] & "," & $aBtn[7]
	Else
		$sBtn = "no caption button data from DWM (step " & $iErr & ")"
	EndIf
	Local $iDpi = 0
	Local $aDpi = DllCall("user32.dll", "uint", "GetDpiForWindow", "hwnd", $aInfo[0])
	If Not @error And IsArray($aDpi) Then $iDpi = $aDpi[0]
	$iCG_DiagCount += 1
	Logfile("CloseGuard diag: press on the locked window " & _CloseGuardKey($aInfo[0]) & " " & _CloseGuardGetClass($aInfo[0]) & ": the window answers hit test " & $aInfo[2] & ", mouse " & $aInfo[3] & "," & $aInfo[4] & ", " & $sBtn & ", DPI of the window " & $iDpi & " (" & $iCG_DiagCount & "/" & $iCG_DiagMax & ")", 5)
EndFunc   ;==>_CloseGuardClickDiag

; Diagnosis (log level 5): the mouse button was pressed on a window that is not locked, but the position is on the
; close button area of a locked window: something covers the X (another window, an overlay).
Func _CloseGuardClickDiagCovered($aInfo)
	Local $vOldCtx = _CloseGuardEnterDpi()
	Local $aKeys = $oCG_Locked.Keys()
	Local $sK, $hWnd, $aBtn, $sUnder
	For $sK In $aKeys
		$hWnd = HWnd($sK)
		If Not _CloseGuardWindowExists($hWnd) Then ContinueLoop
		If Not _CloseGuardIsVisible($hWnd) Then ContinueLoop
		If _CloseGuardIsIconic($hWnd) Then ContinueLoop
		$aBtn = _CloseGuardCloseButtonRect($hWnd)
		If Not IsArray($aBtn) Then ContinueLoop
		If $aInfo[3] >= $aBtn[0] And $aInfo[3] < $aBtn[2] And $aInfo[4] >= $aBtn[1] And $aInfo[4] < $aBtn[3] Then
			$iCG_DiagCount += 1
			$sUnder = "none"
			If $aInfo[6] <> 0 Then $sUnder = _CloseGuardKey($aInfo[6]) & " " & _CloseGuardGetClass($aInfo[6]) & " - " & WinGetTitle($aInfo[6])
			Logfile("CloseGuard diag: the mouse is on the close button area of the locked window " & $sK & " " & _CloseGuardGetClass($hWnd) & ", but the window under the mouse is " & $sUnder & " (" & $iCG_DiagCount & "/" & $iCG_DiagMax & ")", 5)
			ExitLoop
		EndIf
	Next
	_CloseGuardLeaveDpi($vOldCtx)
EndFunc   ;==>_CloseGuardClickDiagCovered

; ----------------------------------------------------------------------------------------------------
; Debug overlay (INI: ClickDebugOverlay=1): the areas of the click detection as transparent colored rectangles.
;   red  = area in which a press counts as a press on the X (button area + extension to the left and downwards);
;          only for windows that do not report their X with the hit test (Outlook, Word), see _CloseGuardNeedsGeometry()
;   blue = close button area that Windows (DWM) reports; for a window without DWM data (Firefox) the area of the X that
;          was found by asking the window (_CloseGuardRectByScan)
;   green = the shield over the X (windows of the classes in ClickShieldClasses, see "Shield")
; Shown while the click detection runs, for every locked window that can be clicked. The rectangles do not take
; any input: they are layered + transparent (the mouse goes through them) and disabled (WindowFromPoint skips
; disabled windows). They are updated by CloseGuardTick(), so they follow a moved window with a short delay.
; ----------------------------------------------------------------------------------------------------

; A locked window whose X can be seen: it exists, is visible and is not minimized
Func _CloseGuardClickableWindow($hWnd)
	If Not _CloseGuardWindowExists($hWnd) Then Return False
	If Not _CloseGuardIsVisible($hWnd) Then Return False
	If _CloseGuardIsIconic($hWnd) Then Return False
	Return True
EndFunc   ;==>_CloseGuardClickableWindow

; Creates, moves and removes the rectangles. Called at every tick of CloseGuardTick().
Func _CloseGuardOverlaySync()
	If $bCloseGuardClickDebug = 0 And $oCG_Overlay.Count = 0 Then Return
	Local $bShow = ($bCloseGuardClickDebug = 1 And $bCG_ClickTimerOn)
	Local $aKeys, $sK, $aBtn, $vOldCtx, $iBtnErr
	;1. Rectangles that are not needed any more
	If $oCG_Overlay.Count > 0 Then
		$aKeys = $oCG_Overlay.Keys()
		For $sK In $aKeys
			If Not $bShow Or Not $oCG_Locked.Exists($sK) Then
				_CloseGuardOverlayRemove($sK)
			ElseIf Not _CloseGuardClickableWindow(HWnd($sK)) Then
				_CloseGuardOverlayRemove($sK)
			EndIf
		Next
	EndIf
	If Not $bShow Then Return
	If $oCG_Locked.Count = 0 Then Return
	;2. Create or move the rectangles. The thread works in physical pixels meanwhile, like the hit test, and the
	;   rectangles are created in that state (so Windows does not scale them).
	$vOldCtx = _CloseGuardEnterDpi()
	$aKeys = $oCG_Locked.Keys()
	For $sK In $aKeys
		If Not _CloseGuardClickableWindow(HWnd($sK)) Then ContinueLoop
		$aBtn = _CloseGuardCloseButtonRect(HWnd($sK))
		$iBtnErr = @error
		If Not IsArray($aBtn) Then
			_CloseGuardNoDwmNote(HWnd($sK), $iBtnErr)
			ContinueLoop
		EndIf
		_CloseGuardOverlayPlace($sK, $aBtn)
		If $bCloseGuardClickDebug = 0 Then ExitLoop ;the rectangles could not be created
	Next
	_CloseGuardLeaveDpi($vOldCtx)
EndFunc   ;==>_CloseGuardOverlaySync

Func _CloseGuardOverlayPlace($sKey, $aBtn)
	Local $hArea, $hExact, $aParts
	If $oCG_Overlay.Exists($sKey) Then
		$aParts = StringSplit($oCG_Overlay.Item($sKey), "|", 2)
		$hArea = HWnd($aParts[0])
		$hExact = HWnd($aParts[1])
	Else
		$hArea = _CloseGuardOverlayCreate(0xFF0000, 90)
		$hExact = _CloseGuardOverlayCreate(0x0000FF, 120)
		If $hArea = 0 Or $hExact = 0 Then
			If $hArea <> 0 Then GUIDelete($hArea)
			If $hExact <> 0 Then GUIDelete($hExact)
			Logfile("CloseGuard: the debug overlay could not be created, it is switched off")
			$bCloseGuardClickDebug = 0
			Return
		EndIf
		$oCG_Overlay.Item($sKey) = _CloseGuardKey($hArea) & "|" & _CloseGuardKey($hExact)
		$oCG_OverlayHandles.Item(_CloseGuardKey($hArea)) = 1
		$oCG_OverlayHandles.Item(_CloseGuardKey($hExact)) = 1
	EndIf
	If $aBtn[14] = 1 Then
		_CloseGuardOverlayMove($hArea, $aBtn[10], $aBtn[11], $aBtn[12] - $aBtn[10], $aBtn[13] - $aBtn[11])
	Else
		;The window reports its X with the hit test: there is no area, only the blue rectangle is shown
		DllCall("user32.dll", "bool", "SetWindowPos", "hwnd", $hArea, "hwnd", 0, "int", 0, "int", 0, "int", 0, "int", 0, "uint", 0x0097) ;SWP_NOSIZE | SWP_NOMOVE | SWP_NOZORDER | SWP_NOACTIVATE | SWP_HIDEWINDOW
	EndIf
	_CloseGuardOverlayMove($hExact, $aBtn[0], $aBtn[1], $aBtn[2] - $aBtn[0], $aBtn[3] - $aBtn[1])
EndFunc   ;==>_CloseGuardOverlayPlace

; One colored, transparent, click-through window (not shown yet). Returns 0 if it could not be created.
Func _CloseGuardOverlayCreate($iColor, $iAlpha)
	Local $hGui = GUICreate("", 10, 10, 0, 0, $iCG_OvStyle, $iCG_OvExStyle)
	If @error Or $hGui = 0 Then Return 0
	GUISetBkColor($iColor, $hGui)
	WinSetTrans($hGui, "", $iAlpha)
	Return $hGui
EndFunc   ;==>_CloseGuardOverlayCreate

; Position and size in physical pixels, topmost, shown without taking the focus (SWP_NOACTIVATE | SWP_SHOWWINDOW)
Func _CloseGuardOverlayMove($hGui, $iX, $iY, $iW, $iH)
	If $iW < 1 Then $iW = 1
	If $iH < 1 Then $iH = 1
	DllCall("user32.dll", "bool", "SetWindowPos", "hwnd", $hGui, "hwnd", -1, "int", $iX, "int", $iY, "int", $iW, "int", $iH, "uint", 0x0050)
EndFunc   ;==>_CloseGuardOverlayMove

Func _CloseGuardOverlayRemove($sKey)
	If Not $oCG_Overlay.Exists($sKey) Then Return
	Local $aParts = StringSplit($oCG_Overlay.Item($sKey), "|", 2)
	Local $i
	For $i = 0 To UBound($aParts) - 1
		If $oCG_OverlayHandles.Exists($aParts[$i]) Then $oCG_OverlayHandles.Remove($aParts[$i])
		GUIDelete(HWnd($aParts[$i]))
	Next
	$oCG_Overlay.Remove($sKey)
EndFunc   ;==>_CloseGuardOverlayRemove

Func _CloseGuardOverlayClear()
	If $oCG_Overlay.Count > 0 Then
		Local $aKeys = $oCG_Overlay.Keys()
		Local $sK
		For $sK In $aKeys
			_CloseGuardOverlayRemove($sK)
		Next
	EndIf
	$oCG_OverlayHandles.RemoveAll()
EndFunc   ;==>_CloseGuardOverlayClear

; ----------------------------------------------------------------------------------------------------
; Shield (INI: ClickShieldClasses)
;
; Edge, Chrome and other Chromium programs and Firefox draw their own X and close the window themselves when the mouse
; button is released. The locked system menu does not stop that, and a reaction while the button is down is too late (the
; window is closed anyway). So the click must not reach the program at all: such a window gets a shield, an almost
; invisible window (opacity 1 of 255) right above its X. The mouse button lands on the shield, the program never sees
; it, and the press is handled like a press on the X of any locked window: nothing happens, or the window is
; minimized (option MinimizeOnClick). _CloseGuardHitUnderMouseRaw() maps a shield to its window.
;   - The area is found by asking the window itself: starting at the middle of the close button area that DWM reports,
;     the hit test (WM_NCHITTEST) is asked in steps of 2 pixels to every side as long as the window answers "close".
;     The result is remembered as long as the size of the window stays the same.
;   - Firefox draws its title bar itself, DWM reports no caption button data for it. There the X is searched first,
;     in the upper right corner of the window (_CloseGuardRectByScan), and the area that was found takes the place of
;     the rectangle of DWM.
;   - The shield is only shown while the window is on top at its X (nothing covers it) and is not fullscreen.
;   - The click timer updates the shields every 100 ms (CloseGuardClickTick), so they follow a moved window.
;   - With ClickDebugOverlay=1 the shield is green and visible.
; ----------------------------------------------------------------------------------------------------

; True if the window has a shield that is shown right now
Func _CloseGuardShieldActive($sKey)
	If Not $oCG_Shield.Exists($sKey) Then Return False
	If Not $oCG_ShieldRect.Exists($sKey) Then Return False
	Return $oCG_ShieldRect.Item($sKey) <> "hidden"
EndFunc   ;==>_CloseGuardShieldActive

; Creates, moves, hides and removes the shields. Called by the click timer every 100 ms.
Func _CloseGuardShieldSync()
	$bCG_ShieldDue = False
	$hCG_ShieldTimer = TimerInit()
	Local $aKeys, $sK, $aBtn, $iErr, $vOldCtx
	;1. Shields that are not needed any more
	If $oCG_Shield.Count > 0 Then
		$aKeys = $oCG_Shield.Keys()
		For $sK In $aKeys
			If Not $oCG_Locked.Exists($sK) Then
				_CloseGuardShieldRemove($sK)
			ElseIf Not _CloseGuardClickableWindow(HWnd($sK)) Then
				_CloseGuardShieldRemove($sK)
			ElseIf Not _CloseGuardIsShieldClass(HWnd($sK)) Then
				_CloseGuardShieldRemove($sK)
			EndIf
		Next
	EndIf
	If $sCG_ShieldClassList = "" Or $oCG_Locked.Count = 0 Then Return
	;2. Create, move or hide. The thread works in physical pixels meanwhile, like the hit test.
	$vOldCtx = _CloseGuardEnterDpi()
	$aKeys = $oCG_Locked.Keys()
	For $sK In $aKeys
		If Not _CloseGuardClickableWindow(HWnd($sK)) Then ContinueLoop
		If Not _CloseGuardIsShieldClass(HWnd($sK)) Then ContinueLoop
		$aBtn = _CloseGuardCloseButtonRect(HWnd($sK))
		$iErr = @error
		If Not IsArray($aBtn) Then
			_CloseGuardNoDwmNote(HWnd($sK), $iErr)
			_CloseGuardShieldRemove($sK)
			ContinueLoop
		EndIf
		If $aBtn[14] = 1 Then
			;The window does not report its X with the hit test, so there is no area that could be found by asking it
			_CloseGuardShieldRemove($sK)
			ContinueLoop
		EndIf
		_CloseGuardShieldPlace($sK, $aBtn)
	Next
	_CloseGuardLeaveDpi($vOldCtx)
EndFunc   ;==>_CloseGuardShieldSync

Func _CloseGuardShieldPlace($sKey, $aBtn)
	Local $hWnd = HWnd($sKey)
	If _CloseGuardIsFullscreen($hWnd, $aBtn) Then
		_CloseGuardShieldHide($sKey) ;no X is shown in a fullscreen window
		Return
	EndIf
	Local $aArea = _CloseGuardShieldArea($sKey, $hWnd, $aBtn)
	If Not IsArray($aArea) Then
		_CloseGuardShieldHide($sKey)
		Return
	EndIf
	Local $hShield = 0
	If $oCG_Shield.Exists($sKey) Then
		$hShield = HWnd($oCG_Shield.Item($sKey))
	Else
		$hShield = _CloseGuardShieldCreate()
		If $hShield = 0 Then
			If Not $bCG_ShieldFailed Then
				$bCG_ShieldFailed = True
				Logfile("CloseGuard: the shield over the X of " & $sKey & " could not be created", 5)
			EndIf
			Return
		EndIf
		$oCG_Shield.Item($sKey) = _CloseGuardKey($hShield)
		$oCG_ShieldOwner.Item(_CloseGuardKey($hShield)) = $sKey
		$oCG_ShieldRect.Item($sKey) = "hidden"
		Logfile("CloseGuard: shield created for the X of " & $sKey & " " & _CloseGuardGetClass($hWnd), 5)
	EndIf
	Local $iW = $aArea[2] - $aArea[0]
	Local $iH = $aArea[3] - $aArea[1]
	;Is the window on top at its X? The first window below the shield that contains the middle of the area must be the window
	Local $hTop = _CloseGuardWindowBelow($hShield, $aArea[0] + Int($iW / 2), $aArea[1] + Int($iH / 2))
	If $hTop = 0 Then
		_CloseGuardShieldHide($sKey)
		Return
	EndIf
	If _CloseGuardKey($hTop) <> $sKey Then
		_CloseGuardShieldHide($sKey)
		Return
	EndIf
	Local $sRect = $aArea[0] & "," & $aArea[1] & "," & $iW & "," & $iH
	If $oCG_ShieldRect.Item($sKey) = $sRect Then Return
	DllCall("user32.dll", "bool", "SetWindowPos", "hwnd", $hShield, "hwnd", -1, "int", $aArea[0], "int", $aArea[1], "int", $iW, "int", $iH, "uint", 0x0050) ;topmost, no activation, shown
	$oCG_ShieldRect.Item($sKey) = $sRect
	Logfile("CloseGuard: shield on the X of " & $sKey & " " & _CloseGuardGetClass($hWnd) & ": " & $sRect, 6)
EndFunc   ;==>_CloseGuardShieldPlace

; One almost invisible window that takes the mouse (not shown yet). Returns 0 if it could not be created.
; With ClickDebugOverlay=1 it is green and visible.
Func _CloseGuardShieldCreate()
	Local $hGui = GUICreate("", 10, 10, 0, 0, $iCG_ShieldStyle, $iCG_ShieldExStyle)
	If @error Or $hGui = 0 Then Return 0
	If $bCloseGuardClickDebug = 1 Then
		GUISetBkColor(0x00B000, $hGui)
		WinSetTrans($hGui, "", 90)
	Else
		GUISetBkColor(0x000000, $hGui)
		WinSetTrans($hGui, "", 1)
	EndIf
	Return $hGui
EndFunc   ;==>_CloseGuardShieldCreate

Func _CloseGuardShieldHide($sKey)
	If Not $oCG_Shield.Exists($sKey) Then Return
	If $oCG_ShieldRect.Item($sKey) = "hidden" Then Return
	DllCall("user32.dll", "bool", "SetWindowPos", "hwnd", HWnd($oCG_Shield.Item($sKey)), "hwnd", 0, "int", 0, "int", 0, "int", 0, "int", 0, "uint", 0x0097) ;SWP_NOSIZE | SWP_NOMOVE | SWP_NOZORDER | SWP_NOACTIVATE | SWP_HIDEWINDOW
	$oCG_ShieldRect.Item($sKey) = "hidden"
	Logfile("CloseGuard: shield hidden: " & $sKey, 6)
EndFunc   ;==>_CloseGuardShieldHide

Func _CloseGuardShieldRemove($sKey)
	If $oCG_Shield.Exists($sKey) Then
		Local $sShield = $oCG_Shield.Item($sKey)
		If $oCG_ShieldOwner.Exists($sShield) Then $oCG_ShieldOwner.Remove($sShield)
		GUIDelete(HWnd($sShield))
		$oCG_Shield.Remove($sKey)
		Logfile("CloseGuard: shield removed: " & $sKey, 6)
	EndIf
	If $oCG_ShieldRect.Exists($sKey) Then $oCG_ShieldRect.Remove($sKey)
	If $oCG_ShieldGeo.Exists($sKey) Then $oCG_ShieldGeo.Remove($sKey)
EndFunc   ;==>_CloseGuardShieldRemove

Func _CloseGuardShieldClear()
	If $oCG_Shield.Count > 0 Then
		Local $aKeys = $oCG_Shield.Keys()
		Local $sK
		For $sK In $aKeys
			_CloseGuardShieldRemove($sK)
		Next
	EndIf
	$oCG_ShieldOwner.RemoveAll()
	$oCG_ShieldRect.RemoveAll()
	$oCG_ShieldGeo.RemoveAll()
EndFunc   ;==>_CloseGuardShieldClear

; Screen rectangle [left, top, right, bottom] in which the window answers "close" (HTCLOSE) to WM_NCHITTEST, or 0.
; Found by asking the window (_CloseGuardScanClose) and remembered relative to the upper right corner of the window,
; as long as the size of the window does not change (maximizing, resizing and a change of the scaling ask again).
Func _CloseGuardShieldArea($sKey, $hWnd, $aBtn)
	Local $sSig = ($aBtn[6] - $aBtn[4]) & "x" & ($aBtn[7] - $aBtn[5])
	Local $aRel, $aScan
	Local $aOut[4]
	If $oCG_ShieldGeo.Exists($sKey) Then
		$aRel = StringSplit($oCG_ShieldGeo.Item($sKey), "|", 2)
		If UBound($aRel) = 5 Then
			If $aRel[0] = $sSig Then
				$aOut[0] = $aBtn[6] + Int($aRel[1])
				$aOut[1] = $aBtn[5] + Int($aRel[2])
				$aOut[2] = $aBtn[6] + Int($aRel[3])
				$aOut[3] = $aBtn[5] + Int($aRel[4])
				Return $aOut
			EndIf
		EndIf
	EndIf
	$aScan = _CloseGuardScanClose($hWnd, $aBtn[0] + Int(($aBtn[2] - $aBtn[0]) / 2), $aBtn[1] + Int(($aBtn[3] - $aBtn[1]) / 2))
	If Not IsArray($aScan) Then
		If $oCG_ShieldGeo.Exists($sKey) Then $oCG_ShieldGeo.Remove($sKey)
		Return 0
	EndIf
	$oCG_ShieldGeo.Item($sKey) = $sSig & "|" & ($aScan[0] - $aBtn[6]) & "|" & ($aScan[1] - $aBtn[5]) & "|" & ($aScan[2] - $aBtn[6]) & "|" & ($aScan[3] - $aBtn[5])
	Local $sFrom = "close button area of DWM "
	If $aBtn[15] = 1 Then $sFrom = "area of the X from the first search, no DWM data "
	Logfile("CloseGuard: area of the X of " & $sKey & " " & _CloseGuardGetClass($hWnd) & " found by asking the window: " & $aScan[0] & "," & $aScan[1] & " - " & $aScan[2] & "," & $aScan[3] & " (window size " & $sSig & ", " & $sFrom & $aBtn[0] & "," & $aBtn[1] & " - " & $aBtn[2] & "," & $aBtn[3] & ")", 5)
	Return $aScan
EndFunc   ;==>_CloseGuardShieldArea

; Asks the window (WM_NCHITTEST) around the point $iX0, $iY0 and returns the area in which it answers "close" as
; [left, top, right, bottom] (right and bottom exclusive, a margin of 1 pixel on every side), or 0 if the window does
; not answer "close" at the point itself or does not answer in time. The steps are 2 pixels, at most 80 pixels to the
; left and to the right, 40 up and 50 down.
Func _CloseGuardScanClose($hWnd, $iX0, $iY0)
	If _CloseGuardHit($hWnd, $iX0, $iY0) <> $iCG_HTCLOSE Then Return 0
	Local $iLeft = _CloseGuardScanDir($hWnd, $iX0, $iY0, -1, 0, 40)
	Local $iRight = _CloseGuardScanDir($hWnd, $iX0, $iY0, 1, 0, 40)
	Local $iUp = _CloseGuardScanDir($hWnd, $iX0, $iY0, 0, -1, 20)
	Local $iDown = _CloseGuardScanDir($hWnd, $iX0, $iY0, 0, 1, 25)
	Local $aOut[4]
	$aOut[0] = $iX0 - 2 * $iLeft - 1
	$aOut[1] = $iY0 - 2 * $iUp - 1
	$aOut[2] = $iX0 + 2 * $iRight + 2
	$aOut[3] = $iY0 + 2 * $iDown + 2
	Return $aOut
EndFunc   ;==>_CloseGuardScanClose

; Number of steps (of 2 pixels) in the direction $iDX, $iDY (-1, 0 or 1) as long as the window answers "close"
Func _CloseGuardScanDir($hWnd, $iX0, $iY0, $iDX, $iDY, $iMaxSteps)
	Local $i
	Local $iLast = 0
	For $i = 1 To $iMaxSteps
		If _CloseGuardHit($hWnd, $iX0 + $iDX * 2 * $i, $iY0 + $iDY * 2 * $i) <> $iCG_HTCLOSE Then ExitLoop
		$iLast = $i
	Next
	Return $iLast
EndFunc   ;==>_CloseGuardScanDir

; WM_NCHITTEST for a screen position (physical pixels). Returns the answer, or -99 if the window does not answer in time.
Func _CloseGuardHit($hWnd, $iX, $iY)
	Local $iLParam = BitOR(BitAND($iX, 0xFFFF), BitShift(BitAND($iY, 0xFFFF), -16))
	Local $aHit = DllCall("user32.dll", "lresult", "SendMessageTimeoutW", "hwnd", $hWnd, "uint", $iCG_WM_NCHITTEST, "wparam", 0, "lparam", $iLParam, "uint", 2, "uint", 100, "dword_ptr*", 0)
	If @error Or Not IsArray($aHit) Then Return -99
	If $aHit[0] = 0 Then Return -99
	Return $aHit[7]
EndFunc   ;==>_CloseGuardHit

; True if the window covers a whole monitor exactly (fullscreen): there is no X to cover then.
; $aBtn: result of _CloseGuardCloseButtonRect ([4..7] = rectangle of the window).
Func _CloseGuardIsFullscreen($hWnd, $aBtn)
	Local $aMon = DllCall("user32.dll", "handle", "MonitorFromWindow", "hwnd", $hWnd, "dword", 2) ;MONITOR_DEFAULTTONEAREST
	If @error Or Not IsArray($aMon) Then Return False
	If $aMon[0] = 0 Then Return False
	Local $tInfo = DllStructCreate("dword cbSize;long L;long T;long R;long B;long WL;long WT;long WR;long WB;dword Flags")
	DllStructSetData($tInfo, "cbSize", DllStructGetSize($tInfo))
	Local $aRet = DllCall("user32.dll", "bool", "GetMonitorInfoW", "handle", $aMon[0], "struct*", $tInfo)
	If @error Or Not IsArray($aRet) Then Return False
	If $aRet[0] = 0 Then Return False
	If $aBtn[4] <> DllStructGetData($tInfo, "L") Then Return False
	If $aBtn[5] <> DllStructGetData($tInfo, "T") Then Return False
	If $aBtn[6] <> DllStructGetData($tInfo, "R") Then Return False
	If $aBtn[7] <> DllStructGetData($tInfo, "B") Then Return False
	Return True
EndFunc   ;==>_CloseGuardIsFullscreen

; The first visible top level window below an overlay window or a shield (in the order on the screen) that contains the
; point. Needed if WindowFromPoint returns an overlay window, and for the shields. Returns 0 if there is none.
Func _CloseGuardWindowBelow($hWnd, $iX, $iY)
	Local $tRect = DllStructCreate("long L;long T;long R;long B")
	Local $hCur = $hWnd
	Local $i, $aNext, $aRet
	For $i = 1 To 300
		$aNext = DllCall("user32.dll", "hwnd", "GetWindow", "hwnd", $hCur, "uint", 2) ;GW_HWNDNEXT
		If @error Or Not IsArray($aNext) Then Return 0
		$hCur = $aNext[0]
		If $hCur = 0 Then Return 0
		If $oCG_OverlayHandles.Exists(_CloseGuardKey($hCur)) Then ContinueLoop
		If $oCG_ShieldOwner.Exists(_CloseGuardKey($hCur)) Then ContinueLoop
		If Not _CloseGuardIsVisible($hCur) Then ContinueLoop
		$aRet = DllCall("user32.dll", "bool", "GetWindowRect", "hwnd", $hCur, "struct*", $tRect)
		If @error Or Not IsArray($aRet) Then ContinueLoop
		If $aRet[0] = 0 Then ContinueLoop
		If $iX >= DllStructGetData($tRect, "L") And $iX < DllStructGetData($tRect, "R") And $iY >= DllStructGetData($tRect, "T") And $iY < DllStructGetData($tRect, "B") Then Return $hCur
	Next
	Return 0
EndFunc   ;==>_CloseGuardWindowBelow

; Switches this thread to "DPI per monitor" for the next few calls. Returns the previous context (0 = unchanged).
; SetThreadDpiAwarenessContext exists from Windows 10 1607; before that nothing is switched.
Func _CloseGuardEnterDpi()
	Local $aRet = DllCall("user32.dll", "int_ptr", "SetThreadDpiAwarenessContext", "int_ptr", -4) ;PER_MONITOR_AWARE_V2
	If @error Or Not IsArray($aRet) Then
		If Not $bCG_DpiWarned Then
			$bCG_DpiWarned = True
			Logfile("CloseGuard: SetThreadDpiAwarenessContext is not available, the mouse position is used as it is")
		EndIf
		Return 0
	EndIf
	Return $aRet[0]
EndFunc   ;==>_CloseGuardEnterDpi

Func _CloseGuardLeaveDpi($vOldCtx)
	If $vOldCtx = 0 Then Return
	DllCall("user32.dll", "int_ptr", "SetThreadDpiAwarenessContext", "int_ptr", $vOldCtx)
EndFunc   ;==>_CloseGuardLeaveDpi

; Minimizes the window like its minimize button does (the program is told in the usual way). If that does not
; work the window is minimized directly (see _CloseGuardMinimizeVerify).
Func _CloseGuardMinimizeWindow($hWnd, $bAtPress = False)
	If $bAtPress Then
		Logfile("CloseGuard: the locked X was pressed (the program closes itself when it is released), minimizing at once " & _CloseGuardKey($hWnd) & " " & _CloseGuardGetClass($hWnd) & " - " & WinGetTitle($hWnd), 5)
	Else
		Logfile("CloseGuard: click on the locked X, minimizing " & _CloseGuardKey($hWnd) & " " & _CloseGuardGetClass($hWnd) & " - " & WinGetTitle($hWnd), 5)
	EndIf
	DllCall("user32.dll", "bool", "PostMessageW", "hwnd", $hWnd, "uint", $iCG_WM_SYSCOMMAND, "wparam", $iCG_SC_MINIMIZE, "lparam", 0)
	$hCG_VerifyWnd = $hWnd
	$iCG_VerifyStage = 1
	$hCG_VerifyTimer = TimerInit()
EndFunc   ;==>_CloseGuardMinimizeWindow

; Some time after the minimize command: did the window follow? If it is neither minimized nor hidden by the
; program itself (for example into the notification area), it is minimized directly (once).
Func _CloseGuardMinimizeVerify()
	Local $fMs = TimerDiff($hCG_VerifyTimer)
	If $fMs < $iCG_MinimizeCheckDelay Then Return
	Local $hWnd = $hCG_VerifyWnd
	If $fMs > 3000 Or Not _CloseGuardWindowExists($hWnd) Then
		$iCG_VerifyStage = 0 ;too old, or the window is gone
		Return
	EndIf
	If _CloseGuardIsIconic($hWnd) Or Not _CloseGuardIsVisible($hWnd) Then
		$iCG_VerifyStage = 0 ;done (minimized, or the program has hidden the window itself)
	ElseIf $iCG_VerifyStage = 1 Then
		Logfile("CloseGuard: the window did not follow the minimize command, minimizing it directly: " & _CloseGuardKey($hWnd), 4)
		DllCall("user32.dll", "bool", "ShowWindowAsync", "hwnd", $hWnd, "int", 6) ;SW_MINIMIZE
		$iCG_VerifyStage = 2
		$hCG_VerifyTimer = TimerInit()
	Else
		Logfile("CloseGuard: the window could not be minimized: " & _CloseGuardKey($hWnd), 4)
		$iCG_VerifyStage = 0
	EndIf
EndFunc   ;==>_CloseGuardMinimizeVerify

; ----------------------------------------------------------------------------------------------------
; Settings, hotkeys
; ----------------------------------------------------------------------------------------------------

; A hotkey string in one fixed form (modifiers in the order ^ ! + #, key in lower case, without braces), so
; that "+!t" and "!+T" are recognized as the same hotkey.
Func HotkeyNormalize($sHotkey)
	Local $sMods = ""
	If StringInStr($sHotkey, "^") Then $sMods &= "^"
	If StringInStr($sHotkey, "!") Then $sMods &= "!"
	If StringInStr($sHotkey, "+") Then $sMods &= "+"
	If StringInStr($sHotkey, "#") Then $sMods &= "#"
	Local $sKey = StringReplace($sHotkey, "^", "")
	$sKey = StringReplace($sKey, "!", "")
	$sKey = StringReplace($sKey, "+", "")
	$sKey = StringReplace($sKey, "#", "")
	$sKey = StringReplace($sKey, "{", "")
	$sKey = StringReplace($sKey, "}", "")
	Return $sMods & StringLower($sKey)
EndFunc   ;==>HotkeyNormalize

; True if the hotkey is in the list $sTaken (hotkeys separated by "|")
Func HotkeyIsTaken($sHotkey, $sTaken)
	If $sTaken = "" Then Return False
	Local $aTaken = StringSplit($sTaken, "|", 2)
	Local $sNormalized = HotkeyNormalize($sHotkey)
	Local $i
	For $i = 0 To UBound($aTaken) - 1
		If $aTaken[$i] <> "" And HotkeyNormalize($aTaken[$i]) = $sNormalized Then Return True
	Next
	Return False
EndFunc   ;==>HotkeyIsTaken

; The hotkeys that CloseGuard uses (for the check in the hotkey dialog of AlwaysOnTop); empty if it is off
Func CloseGuardHotkeysInUse()
	If Not $bCloseGuardEnabledSetting Then Return ""
	Return $sCloseGuardHotkeyToggle & "|" & $sCloseGuardHotkeyAddRule
EndFunc   ;==>CloseGuardHotkeysInUse

; After the INI file was read: the two CloseGuard hotkeys must differ from each other and from the
; AlwaysOnTop hotkey. Otherwise the default hotkeys are used and the user is told.
Func _CloseGuardCheckHotkeyConflicts()
	Local $bConflict = False
	If HotkeyNormalize($sCloseGuardHotkeyToggle) = HotkeyNormalize($sCloseGuardHotkeyAddRule) Then $bConflict = True
	If $bAlwaysOnTopEnabledSetting = 1 Then
		If HotkeyIsTaken($sAlwaysOnTopHotKey, $sCloseGuardHotkeyToggle & "|" & $sCloseGuardHotkeyAddRule) Then $bConflict = True
	EndIf
	If $bConflict Then
		Logfile("CloseGuard: the hotkeys in the INI file collide with each other or with the AlwaysOnTop hotkey, using the default hotkeys")
		$sCloseGuardHotkeyToggle = $sCloseGuardHotkeyToggleDefault
		$sCloseGuardHotkeyAddRule = $sCloseGuardHotkeyAddRuleDefault
		_CloseGuardAddNote(_("A CloseGuard hotkey in the settings file is already used by another function. The default hotkeys are used instead."))
	EndIf
EndFunc   ;==>_CloseGuardCheckHotkeyConflicts

; Registers the two hotkeys. A hotkey that another program has taken cannot be registered: the user is told.
Func _CloseGuardRegisterHotkeys()
	;Release both hotkeys first: the menu is rebuilt for many reasons while the hotkeys are registered, and a
	;registration that fails now has to mean that another program owns the hotkey
	HotKeySet($sCloseGuardHotkeyToggle)
	HotKeySet($sCloseGuardHotkeyAddRule)
	If HotKeySet($sCloseGuardHotkeyToggle, "CloseGuardToggleActive") = 0 Then
		Logfile("CloseGuard: hotkey could not be registered: " & $sCloseGuardHotkeyToggle)
		_CloseGuardAddNote(_CloseGuardFormat(_("The hotkey is already used by another program and could not be registered: %1"), HotkeyToReadable($sCloseGuardHotkeyToggle)))
	EndIf
	If HotKeySet($sCloseGuardHotkeyAddRule, "CloseGuardAddRuleActive") = 0 Then
		Logfile("CloseGuard: hotkey could not be registered: " & $sCloseGuardHotkeyAddRule)
		_CloseGuardAddNote(_CloseGuardFormat(_("The hotkey is already used by another program and could not be registered: %1"), HotkeyToReadable($sCloseGuardHotkeyAddRule)))
	EndIf
EndFunc   ;==>_CloseGuardRegisterHotkeys

; Tray menu entry "change hotkey". $iWhich: 1 = lock/unlock, 2 = create rule
Func SetCloseGuardHotkey($iWhich)
	Local $sCurrent, $sTaken
	If $iWhich = 1 Then
		$sCurrent = $sCloseGuardHotkeyToggle
		$sTaken = $sCloseGuardHotkeyAddRule
	Else
		$sCurrent = $sCloseGuardHotkeyAddRule
		$sTaken = $sCloseGuardHotkeyToggle
	EndIf
	If $bAlwaysOnTopEnabledSetting = 1 Then $sTaken &= "|" & $sAlwaysOnTopHotKey

	;Disable every tray menu item while the dialog is open (see SetAOTHotkey)
	Local $oTrayMenuStates = _TrayMenuDisableAll($hMenu)
	Local $sHotkey = HotkeyDialog($sCurrent, $sTaken)
	Local $bError = @error
	_TrayMenuRestoreDisabled($hMenu, $oTrayMenuStates)
	If $bError Or $sHotkey = $sCurrent Then
		Logfile("HotkeyDialog without selection", 6)
		Return
	EndIf

	Logfile("New CloseGuard hotkey: " & $sHotkey, 6)
	HotKeySet($sCurrent) ;the old hotkey
	If $iWhich = 1 Then
		$sCloseGuardHotkeyToggle = $sHotkey
	Else
		$sCloseGuardHotkeyAddRule = $sHotkey
	EndIf
	SaveSettings()
	;The hotkey is part of the menu text: rebuild the menu (ApplyTrayMenuSettings() registers the new hotkey)
	DeleteTrayMenu()
	DeleteAllhBitmaps()
	CreateTrayMenu()
	ApplyTrayMenuSettings()
	SetIconTooltip()
EndFunc   ;==>SetCloseGuardHotkey

; ----------------------------------------------------------------------------------------------------
; Tray menu toggles
; ----------------------------------------------------------------------------------------------------

; Master switch "Enable CloseGuard". Changes which tray items exist, so - like CheckAlwaysOnTopEnabled() - the
; menu is deleted BEFORE the setting is flipped, so that DeleteTrayMenu() sees the state the items were
; created with.
Func CheckCloseGuardEnabled()
	Logfile("CheckCloseGuardEnabled() start", 6)
	If Not $bCloseGuardEnabledSetting Then
		Logfile("Enabling CloseGuard")
		DeleteTrayMenu()
		DeleteAllhBitmaps()
		$bCloseGuardEnabledSetting = 1
		SaveSettings()
		CreateTrayMenu()
		ApplyTrayMenuSettings() ;registers the hotkeys
		SetIconTooltip()
		CloseGuardStart()
		_CloseGuardFirstNotice() ;once, the first time CloseGuard is switched on
	Else
		Logfile("Disabling CloseGuard", 6)
		CloseGuardStop() ;automatic check off, hotkeys released, all windows get their X back
		DeleteTrayMenu()
		DeleteAllhBitmaps()
		$bCloseGuardEnabledSetting = 0
		SaveSettings()
		CreateTrayMenu()
		ApplyTrayMenuSettings()
		SetIconTooltip()
	EndIf
	Logfile("CheckCloseGuardEnabled() end", 6)
EndFunc   ;==>CheckCloseGuardEnabled

; Tray menu entry "check new windows automatically"
Func CheckCloseGuardAutoTrayItem()
	If Not $bCloseGuardEnabledSetting Then Return
	Logfile("CheckCloseGuardAutoTrayItem() start", 6)
	If Not $bCloseGuardAutoApply Then
		Logfile("Enabling the automatic CloseGuard check")
		_CloseGuardSetItemIcon($iCloseGuardAutoTrayItem, True)
		$bCloseGuardAutoApply = 1
		$hCG_PollTimer = 0 ;check at the next tick
	Else
		Logfile("Disabling the automatic CloseGuard check", 6)
		_CloseGuardSetItemIcon($iCloseGuardAutoTrayItem, False)
		$bCloseGuardAutoApply = 0
	EndIf
	Logfile("CheckCloseGuardAutoTrayItem() end", 6)
EndFunc   ;==>CheckCloseGuardAutoTrayItem

; Tray menu entry "check windows open at program start" (only used at the next start / when CloseGuard is switched on)
Func CheckCloseGuardStartTrayItem()
	If Not $bCloseGuardEnabledSetting Then Return
	Logfile("CheckCloseGuardStartTrayItem() start", 6)
	If Not $bCloseGuardApplyOnStartup Then
		Logfile("Enabling the CloseGuard check at program start")
		_CloseGuardSetItemIcon($iCloseGuardStartTrayItem, True)
		$bCloseGuardApplyOnStartup = 1
	Else
		Logfile("Disabling the CloseGuard check at program start", 6)
		_CloseGuardSetItemIcon($iCloseGuardStartTrayItem, False)
		$bCloseGuardApplyOnStartup = 0
	EndIf
	Logfile("CheckCloseGuardStartTrayItem() end", 6)
EndFunc   ;==>CheckCloseGuardStartTrayItem

; Tray menu entry "minimize the window when the locked close button is clicked"
Func CheckCloseGuardMinimizeTrayItem()
	If Not $bCloseGuardEnabledSetting Then Return
	Logfile("CheckCloseGuardMinimizeTrayItem() start", 6)
	If Not $bCloseGuardMinimizeOnClick Then
		Logfile("Enabling: a click on the locked close button minimizes the window")
		_CloseGuardSetItemIcon($iCloseGuardMinimizeTrayItem, True)
		$bCloseGuardMinimizeOnClick = 1
	Else
		Logfile("Disabling: a click on the locked close button minimizes the window", 6)
		_CloseGuardSetItemIcon($iCloseGuardMinimizeTrayItem, False)
		$bCloseGuardMinimizeOnClick = 0
	EndIf
	_CloseGuardClickSync() ;starts or stops the click detection
	Logfile("CheckCloseGuardMinimizeTrayItem() end", 6)
EndFunc   ;==>CheckCloseGuardMinimizeTrayItem

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
	$mEnglishToID.Item("CloseGuard") = 194
	$mEnglishToID.Item("Enable CloseGuard") = 195
	$mEnglishToID.Item("Lock/unlock the close button of the active window") = 196
	$mEnglishToID.Item("Create rule for the active window") = 197
	$mEnglishToID.Item("Check new windows automatically") = 198
	$mEnglishToID.Item("Check windows open at program start") = 199
	$mEnglishToID.Item("Show locked windows") = 200
	$mEnglishToID.Item("Change hotkey: lock/unlock") = 201
	$mEnglishToID.Item("Change hotkey: create rule") = 202
	$mEnglishToID.Item("Edit rules...") = 203
	$mEnglishToID.Item("Close button locked: %1") = 204
	$mEnglishToID.Item("Close button released: %1") = 205
	$mEnglishToID.Item('Rule created (title: "%1", class: "%2"). The close button of this window is locked.') = 206
	$mEnglishToID.Item('This rule already exists (title: "%1", class: "%2"). The close button of this window is locked.') = 207
	$mEnglishToID.Item("No suitable window found. Click on the target window first.") = 208
	$mEnglishToID.Item("This window has no system menu, so its close button cannot be locked.") = 209
	$mEnglishToID.Item("The close button could not be locked. The window probably belongs to a program that runs as administrator.") = 210
	$mEnglishToID.Item("This combination is already used by another function of CCTrayTool.") = 211
	$mEnglishToID.Item("The hotkey is already used by another program and could not be registered: %1") = 212
	$mEnglishToID.Item("A CloseGuard hotkey in the settings file is already used by another function. The default hotkeys are used instead.") = 213
	$mEnglishToID.Item("Windows whose close button is locked by CloseGuard:") = 214
	$mEnglishToID.Item("No windows are locked at the moment.") = 215
	$mEnglishToID.Item("rule") = 216
	$mEnglishToID.Item("manual") = 217
	$mEnglishToID.Item("Number of rules: %1") = 218
	$mEnglishToID.Item("(no title)") = 219
	$mEnglishToID.Item("The rule could not be written to the rules file.") = 220
	$mEnglishToID.Item("The rules file could not be created.") = 221
	$mEnglishToID.Item("Minimize window when locked X is clicked") = 222
	$mEnglishToID.Item("%1 was not found") = 223
	$mEnglishToID.Item("%1 as submenu") = 224
	$mEnglishToID.Item("CloseGuard locks the close button (X) of the windows you choose.") = 225
	$mEnglishToID.Item("Please note: some windows cannot be locked because their programs deviate from the usual Windows standards (for example, they draw their own title bar). With such windows the X may still close the window.") = 226
	$mEnglishToID.Item("This notice is shown only once. More information: user guide (README.txt), section 4.") = 227

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
	$mIDToGerman.Item(194) = "CloseGuard"
	$mIDToGerman.Item(195) = "CloseGuard aktivieren"
	$mIDToGerman.Item(196) = "Schließen-Button des aktiven Fensters sperren/freigeben"
	$mIDToGerman.Item(197) = "Regel für aktives Fenster anlegen"
	$mIDToGerman.Item(198) = "Neue Fenster automatisch prüfen"
	$mIDToGerman.Item(199) = "Beim Start offene Fenster prüfen"
	$mIDToGerman.Item(200) = "Gesperrte Fenster anzeigen"
	$mIDToGerman.Item(201) = "Hotkey ändern: Sperren/Freigeben"
	$mIDToGerman.Item(202) = "Hotkey ändern: Regel anlegen"
	$mIDToGerman.Item(203) = "Regeln bearbeiten..."
	$mIDToGerman.Item(204) = "Schließen-Button gesperrt: %1"
	$mIDToGerman.Item(205) = "Schließen-Button freigegeben: %1"
	$mIDToGerman.Item(206) = 'Regel angelegt (Titel: "%1", Klasse: "%2"). Der Schließen-Button dieses Fensters ist gesperrt.'
	$mIDToGerman.Item(207) = 'Diese Regel gibt es schon (Titel: "%1", Klasse: "%2"). Der Schließen-Button dieses Fensters ist gesperrt.'
	$mIDToGerman.Item(208) = "Kein passendes Fenster gefunden. Zuerst das Zielfenster anklicken."
	$mIDToGerman.Item(209) = "Dieses Fenster hat kein Systemmenü, daher kann sein Schließen-Button nicht gesperrt werden."
	$mIDToGerman.Item(210) = "Der Schließen-Button konnte nicht gesperrt werden. Das Fenster gehört wahrscheinlich zu einem Programm, das als Administrator läuft."
	$mIDToGerman.Item(211) = "Diese Kombination wird bereits von einer anderen Funktion von CCTrayTool verwendet."
	$mIDToGerman.Item(212) = "Der Hotkey wird bereits von einem anderen Programm verwendet und konnte nicht registriert werden: %1"
	$mIDToGerman.Item(213) = "Ein CloseGuard-Hotkey in der Einstellungsdatei wird bereits von einer anderen Funktion verwendet. Stattdessen werden die Standard-Hotkeys verwendet."
	$mIDToGerman.Item(214) = "Fenster, deren Schließen-Button von CloseGuard gesperrt ist:"
	$mIDToGerman.Item(215) = "Zurzeit ist kein Fenster gesperrt."
	$mIDToGerman.Item(216) = "Regel"
	$mIDToGerman.Item(217) = "manuell"
	$mIDToGerman.Item(218) = "Anzahl der Regeln: %1"
	$mIDToGerman.Item(219) = "(ohne Titel)"
	$mIDToGerman.Item(220) = "Die Regel konnte nicht in die Regeldatei geschrieben werden."
	$mIDToGerman.Item(221) = "Die Regeldatei konnte nicht angelegt werden."
	$mIDToGerman.Item(222) = "Fenster minimieren bei Klick auf gesperrtes X"
	$mIDToGerman.Item(223) = "%1 wurde nicht gefunden"
	$mIDToGerman.Item(224) = "%1 als Untermenü"
	$mIDToGerman.Item(225) = "CloseGuard sperrt den Schließen-Button (X) der Fenster, die Sie auswählen."
	$mIDToGerman.Item(226) = "Bitte beachten: Manche Fenster lassen sich nicht sperren, weil ihre Programme von den üblichen Windows-Standards abweichen (zum Beispiel, weil sie ihre Titelleiste selbst zeichnen). Bei solchen Fenstern kann das X das Fenster trotzdem schließen."
	$mIDToGerman.Item(227) = "Dieser Hinweis erscheint nur einmal. Mehr dazu: Anleitung (README.txt), Abschnitt 4."

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
	$mIDToSpanish.Item(194) = "CloseGuard"
	$mIDToSpanish.Item(195) = "Activar CloseGuard"
	$mIDToSpanish.Item(196) = "Bloquear/desbloquear el botón de cerrar de la ventana activa"
	$mIDToSpanish.Item(197) = "Crear regla para la ventana activa"
	$mIDToSpanish.Item(198) = "Comprobar automáticamente las ventanas nuevas"
	$mIDToSpanish.Item(199) = "Comprobar las ventanas abiertas al iniciar"
	$mIDToSpanish.Item(200) = "Mostrar ventanas bloqueadas"
	$mIDToSpanish.Item(201) = "Cambiar hotkey: bloquear/desbloquear"
	$mIDToSpanish.Item(202) = "Cambiar hotkey: crear regla"
	$mIDToSpanish.Item(203) = "Editar reglas..."
	$mIDToSpanish.Item(204) = "Botón de cerrar bloqueado: %1"
	$mIDToSpanish.Item(205) = "Botón de cerrar desbloqueado: %1"
	$mIDToSpanish.Item(206) = 'Regla creada (título: "%1", clase: "%2"). El botón de cerrar de esta ventana está bloqueado.'
	$mIDToSpanish.Item(207) = 'Esta regla ya existe (título: "%1", clase: "%2"). El botón de cerrar de esta ventana está bloqueado.'
	$mIDToSpanish.Item(208) = "No se ha encontrado ninguna ventana adecuada. Haz clic primero en la ventana de destino."
	$mIDToSpanish.Item(209) = "Esta ventana no tiene menú del sistema, por lo que no se puede bloquear su botón de cerrar."
	$mIDToSpanish.Item(210) = "No se pudo bloquear el botón de cerrar. Probablemente la ventana pertenece a un programa que se ejecuta como administrador."
	$mIDToSpanish.Item(211) = "Esta combinación ya la usa otra función de CCTrayTool."
	$mIDToSpanish.Item(212) = "La hotkey ya la usa otro programa y no se pudo registrar: %1"
	$mIDToSpanish.Item(213) = "Una hotkey de CloseGuard del archivo de configuración ya la usa otra función. Se usan las hotkeys predeterminadas."
	$mIDToSpanish.Item(214) = "Ventanas cuyo botón de cerrar está bloqueado por CloseGuard:"
	$mIDToSpanish.Item(215) = "Ahora mismo no hay ventanas bloqueadas."
	$mIDToSpanish.Item(216) = "regla"
	$mIDToSpanish.Item(217) = "manual"
	$mIDToSpanish.Item(218) = "Número de reglas: %1"
	$mIDToSpanish.Item(219) = "(sin título)"
	$mIDToSpanish.Item(220) = "No se pudo escribir la regla en el archivo de reglas."
	$mIDToSpanish.Item(221) = "No se pudo crear el archivo de reglas."
	$mIDToSpanish.Item(222) = "Minimizar la ventana al hacer clic en la X bloqueada"
	$mIDToSpanish.Item(223) = "No se encontró %1"
	$mIDToSpanish.Item(224) = "%1 como submenú"
	$mIDToSpanish.Item(225) = "CloseGuard bloquea el botón de cerrar (X) de las ventanas que elija."
	$mIDToSpanish.Item(226) = "Tenga en cuenta: algunas ventanas no se pueden bloquear porque sus programas se apartan de los estándares habituales de Windows (por ejemplo, porque dibujan su propia barra de título). En esas ventanas, la X puede seguir cerrando la ventana."
	$mIDToSpanish.Item(227) = "Este aviso solo se muestra una vez. Más información: guía (README.txt), sección 4."

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
	$mIDToFrench.Item(194) = "CloseGuard"
	$mIDToFrench.Item(195) = "Activer CloseGuard"
	$mIDToFrench.Item(196) = "Verrouiller/déverrouiller le bouton de fermeture de la fenêtre active"
	$mIDToFrench.Item(197) = "Créer une règle pour la fenêtre active"
	$mIDToFrench.Item(198) = "Vérifier automatiquement les nouvelles fenêtres"
	$mIDToFrench.Item(199) = "Vérifier les fenêtres ouvertes au démarrage"
	$mIDToFrench.Item(200) = "Afficher les fenêtres verrouillées"
	$mIDToFrench.Item(201) = "Modifier le raccourci : verrouiller/déverrouiller"
	$mIDToFrench.Item(202) = "Modifier le raccourci : créer une règle"
	$mIDToFrench.Item(203) = "Modifier les règles..."
	$mIDToFrench.Item(204) = "Bouton de fermeture verrouillé : %1"
	$mIDToFrench.Item(205) = "Bouton de fermeture déverrouillé : %1"
	$mIDToFrench.Item(206) = 'Règle créée (titre : "%1", classe : "%2"). Le bouton de fermeture de cette fenêtre est verrouillé.'
	$mIDToFrench.Item(207) = 'Cette règle existe déjà (titre : "%1", classe : "%2"). Le bouton de fermeture de cette fenêtre est verrouillé.'
	$mIDToFrench.Item(208) = "Aucune fenêtre appropriée trouvée. Cliquez d'abord sur la fenêtre cible."
	$mIDToFrench.Item(209) = "Cette fenêtre n'a pas de menu système ; son bouton de fermeture ne peut donc pas être verrouillé."
	$mIDToFrench.Item(210) = "Le bouton de fermeture n'a pas pu être verrouillé. La fenêtre appartient probablement à un programme exécuté en tant qu'administrateur."
	$mIDToFrench.Item(211) = "Cette combinaison est déjà utilisée par une autre fonction de CCTrayTool."
	$mIDToFrench.Item(212) = "Le raccourci est déjà utilisé par un autre programme et n'a pas pu être enregistré : %1"
	$mIDToFrench.Item(213) = "Un raccourci CloseGuard du fichier de configuration est déjà utilisé par une autre fonction. Les raccourcis par défaut sont utilisés à la place."
	$mIDToFrench.Item(214) = "Fenêtres dont le bouton de fermeture est verrouillé par CloseGuard :"
	$mIDToFrench.Item(215) = "Aucune fenêtre n'est verrouillée pour le moment."
	$mIDToFrench.Item(216) = "règle"
	$mIDToFrench.Item(217) = "manuel"
	$mIDToFrench.Item(218) = "Nombre de règles : %1"
	$mIDToFrench.Item(219) = "(sans titre)"
	$mIDToFrench.Item(220) = "La règle n'a pas pu être écrite dans le fichier de règles."
	$mIDToFrench.Item(221) = "Le fichier de règles n'a pas pu être créé."
	$mIDToFrench.Item(222) = "Réduire la fenêtre au clic sur le X verrouillé"
	$mIDToFrench.Item(223) = "%1 est introuvable"
	$mIDToFrench.Item(224) = "%1 en sous-menu"
	$mIDToFrench.Item(225) = "CloseGuard verrouille le bouton de fermeture (X) des fenêtres que vous choisissez."
	$mIDToFrench.Item(226) = "Remarque : certaines fenêtres ne peuvent pas être verrouillées, car leurs programmes s'écartent des standards Windows habituels (par exemple parce qu'ils dessinent eux-mêmes leur barre de titre). Pour ces fenêtres, le X peut tout de même fermer la fenêtre."
	$mIDToFrench.Item(227) = "Cet avis ne s'affiche qu'une seule fois. Plus d'informations : guide (README.txt), section 4."

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
	$mIDToPolish.Item(194) = "CloseGuard"
	$mIDToPolish.Item(195) = "Włącz CloseGuard"
	$mIDToPolish.Item(196) = "Zablokuj/odblokuj przycisk zamykania aktywnego okna"
	$mIDToPolish.Item(197) = "Utwórz regułę dla aktywnego okna"
	$mIDToPolish.Item(198) = "Automatycznie sprawdzaj nowe okna"
	$mIDToPolish.Item(199) = "Sprawdzaj okna otwarte przy uruchomieniu"
	$mIDToPolish.Item(200) = "Pokaż zablokowane okna"
	$mIDToPolish.Item(201) = "Zmień skrót: zablokuj/odblokuj"
	$mIDToPolish.Item(202) = "Zmień skrót: utwórz regułę"
	$mIDToPolish.Item(203) = "Edytuj reguły..."
	$mIDToPolish.Item(204) = "Przycisk zamykania zablokowany: %1"
	$mIDToPolish.Item(205) = "Przycisk zamykania odblokowany: %1"
	$mIDToPolish.Item(206) = 'Utworzono regułę (tytuł: "%1", klasa: "%2"). Przycisk zamykania tego okna jest zablokowany.'
	$mIDToPolish.Item(207) = 'Ta reguła już istnieje (tytuł: "%1", klasa: "%2"). Przycisk zamykania tego okna jest zablokowany.'
	$mIDToPolish.Item(208) = "Nie znaleziono odpowiedniego okna. Najpierw kliknij okno docelowe."
	$mIDToPolish.Item(209) = "To okno nie ma menu systemowego, więc nie można zablokować jego przycisku zamykania."
	$mIDToPolish.Item(210) = "Nie udało się zablokować przycisku zamykania. Okno prawdopodobnie należy do programu uruchomionego jako administrator."
	$mIDToPolish.Item(211) = "Ta kombinacja jest już używana przez inną funkcję CCTrayTool."
	$mIDToPolish.Item(212) = "Skrót jest już używany przez inny program i nie można go zarejestrować: %1"
	$mIDToPolish.Item(213) = "Skrót CloseGuard w pliku ustawień jest już używany przez inną funkcję. Zamiast tego używane są skróty domyślne."
	$mIDToPolish.Item(214) = "Okna, których przycisk zamykania jest zablokowany przez CloseGuard:"
	$mIDToPolish.Item(215) = "Obecnie żadne okno nie jest zablokowane."
	$mIDToPolish.Item(216) = "reguła"
	$mIDToPolish.Item(217) = "ręcznie"
	$mIDToPolish.Item(218) = "Liczba reguł: %1"
	$mIDToPolish.Item(219) = "(bez tytułu)"
	$mIDToPolish.Item(220) = "Nie udało się zapisać reguły w pliku reguł."
	$mIDToPolish.Item(221) = "Nie udało się utworzyć pliku reguł."
	$mIDToPolish.Item(222) = "Minimalizuj okno po kliknięciu zablokowanego X"
	$mIDToPolish.Item(223) = "Nie znaleziono: %1"
	$mIDToPolish.Item(224) = "%1 jako podmenu"
	$mIDToPolish.Item(225) = "CloseGuard blokuje przycisk zamykania (X) wybranych okien."
	$mIDToPolish.Item(226) = "Uwaga: niektórych okien nie da się zablokować, ponieważ ich programy odbiegają od typowych standardów Windows (na przykład same rysują pasek tytułu). W takich oknach X może nadal zamknąć okno."
	$mIDToPolish.Item(227) = "Ta informacja pojawia się tylko raz. Więcej: instrukcja (README.txt), punkt 4."

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
	$mIDToItalian.Item(194) = "CloseGuard"
	$mIDToItalian.Item(195) = "Attiva CloseGuard"
	$mIDToItalian.Item(196) = "Blocca/sblocca il pulsante di chiusura della finestra attiva"
	$mIDToItalian.Item(197) = "Crea regola per la finestra attiva"
	$mIDToItalian.Item(198) = "Controlla automaticamente le nuove finestre"
	$mIDToItalian.Item(199) = "Controlla le finestre aperte all'avvio"
	$mIDToItalian.Item(200) = "Mostra finestre bloccate"
	$mIDToItalian.Item(201) = "Cambia hotkey: blocca/sblocca"
	$mIDToItalian.Item(202) = "Cambia hotkey: crea regola"
	$mIDToItalian.Item(203) = "Modifica regole..."
	$mIDToItalian.Item(204) = "Pulsante di chiusura bloccato: %1"
	$mIDToItalian.Item(205) = "Pulsante di chiusura sbloccato: %1"
	$mIDToItalian.Item(206) = 'Regola creata (titolo: "%1", classe: "%2"). Il pulsante di chiusura di questa finestra è bloccato.'
	$mIDToItalian.Item(207) = 'Questa regola esiste già (titolo: "%1", classe: "%2"). Il pulsante di chiusura di questa finestra è bloccato.'
	$mIDToItalian.Item(208) = "Nessuna finestra adatta trovata. Fai prima clic sulla finestra di destinazione."
	$mIDToItalian.Item(209) = "Questa finestra non ha un menu di sistema, quindi il suo pulsante di chiusura non può essere bloccato."
	$mIDToItalian.Item(210) = "Impossibile bloccare il pulsante di chiusura. La finestra appartiene probabilmente a un programma eseguito come amministratore."
	$mIDToItalian.Item(211) = "Questa combinazione è già usata da un'altra funzione di CCTrayTool."
	$mIDToItalian.Item(212) = "L'hotkey è già usato da un altro programma e non è stato possibile registrarlo: %1"
	$mIDToItalian.Item(213) = "Un hotkey di CloseGuard nel file di impostazioni è già usato da un'altra funzione. Vengono usati gli hotkey predefiniti."
	$mIDToItalian.Item(214) = "Finestre il cui pulsante di chiusura è bloccato da CloseGuard:"
	$mIDToItalian.Item(215) = "Al momento nessuna finestra è bloccata."
	$mIDToItalian.Item(216) = "regola"
	$mIDToItalian.Item(217) = "manuale"
	$mIDToItalian.Item(218) = "Numero di regole: %1"
	$mIDToItalian.Item(219) = "(senza titolo)"
	$mIDToItalian.Item(220) = "Impossibile scrivere la regola nel file delle regole."
	$mIDToItalian.Item(221) = "Impossibile creare il file delle regole."
	$mIDToItalian.Item(222) = "Riduci a icona la finestra al clic sulla X bloccata"
	$mIDToItalian.Item(223) = "%1 non trovato"
	$mIDToItalian.Item(224) = "%1 come sottomenu"
	$mIDToItalian.Item(225) = "CloseGuard blocca il pulsante di chiusura (X) delle finestre scelte."
	$mIDToItalian.Item(226) = "Nota: alcune finestre non possono essere bloccate perché i loro programmi si discostano dagli standard abituali di Windows (ad esempio perché disegnano da sé la barra del titolo). In queste finestre la X può comunque chiudere la finestra."
	$mIDToItalian.Item(227) = "Questo avviso viene mostrato una sola volta. Maggiori informazioni: guida (README.txt), sezione 4."

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
	$mIDToRussian.Item(194) = "CloseGuard"
	$mIDToRussian.Item(195) = "Включить CloseGuard"
	$mIDToRussian.Item(196) = "Заблокировать/разблокировать кнопку закрытия активного окна"
	$mIDToRussian.Item(197) = "Создать правило для активного окна"
	$mIDToRussian.Item(198) = "Автоматически проверять новые окна"
	$mIDToRussian.Item(199) = "Проверять окна, открытые при запуске"
	$mIDToRussian.Item(200) = "Показать заблокированные окна"
	$mIDToRussian.Item(201) = "Изменить горячую клавишу: блокировка/разблокировка"
	$mIDToRussian.Item(202) = "Изменить горячую клавишу: создание правила"
	$mIDToRussian.Item(203) = "Редактировать правила..."
	$mIDToRussian.Item(204) = "Кнопка закрытия заблокирована: %1"
	$mIDToRussian.Item(205) = "Кнопка закрытия разблокирована: %1"
	$mIDToRussian.Item(206) = 'Правило создано (заголовок: "%1", класс: "%2"). Кнопка закрытия этого окна заблокирована.'
	$mIDToRussian.Item(207) = 'Такое правило уже существует (заголовок: "%1", класс: "%2"). Кнопка закрытия этого окна заблокирована.'
	$mIDToRussian.Item(208) = "Подходящее окно не найдено. Сначала щёлкните нужное окно."
	$mIDToRussian.Item(209) = "У этого окна нет системного меню, поэтому его кнопку закрытия нельзя заблокировать."
	$mIDToRussian.Item(210) = "Не удалось заблокировать кнопку закрытия. Вероятно, окно принадлежит программе, запущенной от имени администратора."
	$mIDToRussian.Item(211) = "Эта комбинация уже используется другой функцией CCTrayTool."
	$mIDToRussian.Item(212) = "Горячая клавиша уже используется другой программой и не может быть зарегистрирована: %1"
	$mIDToRussian.Item(213) = "Горячая клавиша CloseGuard в файле настроек уже используется другой функцией. Используются клавиши по умолчанию."
	$mIDToRussian.Item(214) = "Окна, у которых кнопка закрытия заблокирована CloseGuard:"
	$mIDToRussian.Item(215) = "Сейчас нет заблокированных окон."
	$mIDToRussian.Item(216) = "правило"
	$mIDToRussian.Item(217) = "вручную"
	$mIDToRussian.Item(218) = "Количество правил: %1"
	$mIDToRussian.Item(219) = "(без заголовка)"
	$mIDToRussian.Item(220) = "Не удалось записать правило в файл правил."
	$mIDToRussian.Item(221) = "Не удалось создать файл правил."
	$mIDToRussian.Item(222) = "Сворачивать окно при щелчке по заблокированному X"
	$mIDToRussian.Item(223) = "Не найдено: %1"
	$mIDToRussian.Item(224) = "%1 как подменю"
	$mIDToRussian.Item(225) = "CloseGuard блокирует кнопку закрытия (X) выбранных окон."
	$mIDToRussian.Item(226) = "Обратите внимание: некоторые окна заблокировать нельзя, потому что их программы отступают от обычных стандартов Windows (например, сами рисуют строку заголовка). В таких окнах крестик (X) всё равно может закрыть окно."
	$mIDToRussian.Item(227) = "Это уведомление показывается только один раз. Подробнее: руководство (README.txt), раздел 4."
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
	$mIDToHungarian.Item(194) = "CloseGuard"
	$mIDToHungarian.Item(195) = "CloseGuard bekapcsolása"
	$mIDToHungarian.Item(196) = "Az aktív ablak bezárás gombjának zárolása/feloldása"
	$mIDToHungarian.Item(197) = "Szabály létrehozása az aktív ablakhoz"
	$mIDToHungarian.Item(198) = "Új ablakok automatikus ellenőrzése"
	$mIDToHungarian.Item(199) = "Induláskor nyitott ablakok ellenőrzése"
	$mIDToHungarian.Item(200) = "Zárolt ablakok megjelenítése"
	$mIDToHungarian.Item(201) = "Gyorsbillentyű módosítása: zárolás/feloldás"
	$mIDToHungarian.Item(202) = "Gyorsbillentyű módosítása: szabály létrehozása"
	$mIDToHungarian.Item(203) = "Szabályok szerkesztése..."
	$mIDToHungarian.Item(204) = "Bezárás gomb zárolva: %1"
	$mIDToHungarian.Item(205) = "Bezárás gomb feloldva: %1"
	$mIDToHungarian.Item(206) = 'Szabály létrehozva (cím: "%1", osztály: "%2"). Ennek az ablaknak a bezárás gombja zárolva van.'
	$mIDToHungarian.Item(207) = 'Ez a szabály már létezik (cím: "%1", osztály: "%2"). Ennek az ablaknak a bezárás gombja zárolva van.'
	$mIDToHungarian.Item(208) = "Nem található megfelelő ablak. Előbb kattints a célablakra."
	$mIDToHungarian.Item(209) = "Ennek az ablaknak nincs rendszermenüje, ezért a bezárás gombja nem zárolható."
	$mIDToHungarian.Item(210) = "A bezárás gombot nem sikerült zárolni. Az ablak valószínűleg rendszergazdaként futó programhoz tartozik."
	$mIDToHungarian.Item(211) = "Ezt a kombinációt a CCTrayTool egy másik funkciója már használja."
	$mIDToHungarian.Item(212) = "A gyorsbillentyűt már egy másik program használja, ezért nem regisztrálható: %1"
	$mIDToHungarian.Item(213) = "A beállítási fájlban megadott egyik CloseGuard gyorsbillentyűt már egy másik funkció használja. Helyette az alapértelmezett gyorsbillentyűk lesznek használatban."
	$mIDToHungarian.Item(214) = "Ablakok, amelyek bezárás gombját a CloseGuard zárolta:"
	$mIDToHungarian.Item(215) = "Jelenleg egyetlen ablak sincs zárolva."
	$mIDToHungarian.Item(216) = "szabály"
	$mIDToHungarian.Item(217) = "kézi"
	$mIDToHungarian.Item(218) = "Szabályok száma: %1"
	$mIDToHungarian.Item(219) = "(cím nélkül)"
	$mIDToHungarian.Item(220) = "A szabályt nem sikerült a szabályfájlba írni."
	$mIDToHungarian.Item(221) = "A szabályfájlt nem sikerült létrehozni."
	$mIDToHungarian.Item(222) = "Ablak minimalizálása a zárolt X-re kattintáskor"
	$mIDToHungarian.Item(223) = "Nem található: %1"
	$mIDToHungarian.Item(224) = "%1 almenüként"
	$mIDToHungarian.Item(225) = "A CloseGuard zárolja a kiválasztott ablakok bezárás gombját (X)."
	$mIDToHungarian.Item(226) = "Figyelem: egyes ablakok nem zárolhatók, mert programjaik eltérnek a szokásos Windows-szabványoktól (például saját maguk rajzolják a címsorukat). Ilyen ablakoknál az X ennek ellenére bezárhatja az ablakot."
	$mIDToHungarian.Item(227) = "Ez a figyelmeztetés csak egyszer jelenik meg. További információ: útmutató (README.txt), 4. pont."

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
	;CloseGuard: all locked windows get their X back, the automatic check ends, the hotkeys are released
	Logfile("Releasing all windows locked by CloseGuard", 6)
	CloseGuardStop()
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
