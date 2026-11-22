# Building and releasing CCTrayTool

This page describes how to compile CCTrayTool from the source code, how to sign the program and how to
publish it as a release on GitHub. The compiled program is **not** stored in the repository; it is attached to
a *release* (see [Publishing a release](#publishing-a-release-on-github)).

## Requirements

- A 64-bit version of Windows 10 or newer (the program is built as a 64-bit application and runs on 64-bit Windows only)
- [AutoIt](https://www.autoitscript.com/site/autoit/downloads/) and
  [SciTE4AutoIt3](https://www.autoitscript.com/site/autoit-script-editor/downloads/) (contains AutoIt3Wrapper
  and the compiler)
- For signing: the Windows SDK (`signtool.exe`) and a code-signing certificate

## Icons

The script embeds its icons into the program with `#AutoIt3Wrapper_Res_Icon_Add` and loads them at run time
from the resources. The following files must exist in the folder `icons` before the program is compiled:

| File | Used for |
| --- | --- |
| `TrayWhite.ico`, `TrayRed.ico`, `TrayGreen.ico`, `TrayBlue.ico` | tray icon (program icon: `TrayWhite.ico`) |
| `WhiteBox.ico`, `RedBox.ico`, `GreenBox.ico`, `BlueBox.ico` | KeepAwake menu items (off) |
| `WhiteBoxChecked.ico`, `RedBoxChecked.ico`, `GreenBoxChecked.ico`, `BlueBoxChecked.ico` | KeepAwake menu items (on) |
| `About.ico`, `Exit.ico`, `Keyboard.ico`, `Settings.ico`, `GreenCheck.ico`, `Empty.ico` | other menu items |

The order of the `#AutoIt3Wrapper_Res_Icon_Add` lines in `CCTrayTool.au3` determines the resource numbers
that the program uses. Do not reorder or insert lines there without changing the code that uses the numbers.

## Compile

1. Open `CCTrayTool.au3` in SciTE4AutoIt3.
2. Press `Ctrl+F7` (*Tools > Compile*). AutoIt3Wrapper reads the directives at the top of the file (icons,
   file properties, 64 bit) and writes the program `CCTrayTool.exe` next to the script.

The program is compiled as a **64-bit** application (`#AutoIt3Wrapper_UseX64=y`). Keep this directive: the default
ToolTime tools live in `System32`, which a 32-bit program on 64-bit Windows would see as `SysWOW64`, and a 32-bit
build has not been tested. The resulting program runs on 64-bit Windows only; 32-bit Windows is not supported.

Two directives at the top of the file change the source code itself when the program is compiled:

- `#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y` increases the last number of `Res_Fileversion` with every
  compilation. Check the change with `git diff` before you commit it; for a release the version must be the one
  that you name in the tag.
- `#AutoIt3Wrapper_Run_Tidy=y` reformats the source code. Review the result before committing, so that
  commits contain only intended changes.

## Signing

The program is signed after compilation. With a Certum certificate (SimplySign) log in to *SimplySign Desktop*
first, so that the certificate is available in the Windows certificate store. Then:

```bat
signtool sign /sha1 <thumbprint-of-the-certificate> /fd SHA256 /tr http://time.certum.pl /td SHA256 /d "CCTrayTool" CCTrayTool.exe
signtool verify /pa /v CCTrayTool.exe
```

Replace the thumbprint, and the timestamp server if your certificate provider names a different one.
Compress with UPX (if used) **before** signing; any change to the file after signing invalidates the signature.

## Publishing a release on GitHub

A release consists of a *tag* (a fixed point in the source code), the signed program and a checksum.
GitHub adds the source code archive of the tag automatically, so the program and its source always belong
together – this is what the GPL requires when the program is passed on.

1. Commit and push all changes to the `main` branch. Make sure the file version in
   `#AutoIt3Wrapper_Res_Fileversion` is the version that you want to release.
2. Compile and sign the program (see above) and check that the signature is valid.
3. Create the checksum file (PowerShell):

   ```powershell
   $h = (Get-FileHash .\CCTrayTool.exe -Algorithm SHA256).Hash.ToLower()
   "$h  CCTrayTool.exe" | Set-Content -Encoding ascii .\CCTrayTool.exe.sha256
   ```

4. Create the tag and push it. The tag name is `v` plus the file version, for example:

   ```bat
   git tag -a v2026.0.0.110 -m "CCTrayTool 2026.0.0.110"
   git push origin v2026.0.0.110
   ```

5. Create the release:
   - **On the website:** *Releases > Draft a new release*, choose the tag, enter a title and release notes,
     drag `CCTrayTool.exe` and `CCTrayTool.exe.sha256` into the *Attach binaries* area and click
     *Publish release*.
   - **With the GitHub CLI:**

     ```bat
     gh release create v2026.0.0.110 CCTrayTool.exe CCTrayTool.exe.sha256 --title "CCTrayTool 2026.0.0.110" --notes-file RELEASE_NOTES.md
     ```

To replace a faulty file of an already published release, upload the corrected file to the same release
(`gh release upload <tag> <file> --clobber`) and update the checksum file. Do not move a tag that other people
may already have used; publish a new version instead.
