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

A release consists of a *tag* (a fixed point in the source code) and a ZIP file with the signed program, the
user guide, the license files and a checksum file. GitHub adds the source code archive of the tag
automatically, so the program and its source always belong together – this is what the GPL requires when the
program is passed on.

The ZIP file is named `CCTrayTool_<version>.zip`, for example `CCTrayTool_2026.0.0.109.zip`. It contains:

| File | Source |
| --- | --- |
| `CCTrayTool.exe` | the compiled and signed program |
| `README.txt` | `release/README.txt` – the user guide as plain text in 8 languages |
| `LICENSE`, `NOTICE` | the files of the same name in the repository |
| `SOURCE.txt` | `release/SOURCE.txt` – with `<version>` replaced by the version of the release |

`release/README.txt` is the plain text version of `README.md` and `docs/README.<lang>.md`. Keep them in sync
when the documentation changes.

1. Commit and push all changes to the `main` branch. Make sure the version in `#AutoIt3Wrapper_Res_Fileversion`
   is the version that you want to release.
2. Compile and sign the program (see above). Check that the signature is valid and that the file version of
   `CCTrayTool.exe` (*Properties > Details*) is the version of the release.
3. Create the ZIP file (PowerShell, in the folder of the repository):

   ```powershell
   $v = "2026.0.0.109"    # version of the release
   New-Item -ItemType Directory release_tmp | Out-Null
   Copy-Item CCTrayTool.exe, LICENSE, NOTICE, release\README.txt release_tmp\
   (Get-Content release\SOURCE.txt -Raw).Replace("<version>", $v) | Set-Content -Encoding ascii release_tmp\SOURCE.txt
   Compress-Archive -Path release_tmp\* -DestinationPath "CCTrayTool_$v.zip" -Force
   Remove-Item release_tmp -Recurse
   ```

4. Create the checksum file of the ZIP file:

   ```powershell
   $h = (Get-FileHash ".\CCTrayTool_$v.zip" -Algorithm SHA256).Hash.ToLower()
   "$h  CCTrayTool_$v.zip" | Set-Content -Encoding ascii ".\CCTrayTool_$v.zip.sha256"
   ```

5. Create the tag and push it. The tag name is `v` plus the file version. (When you publish the release on the
   website you can also let GitHub create the tag.)

   ```bat
   git tag -a v<version> -m "CCTrayTool <version>"
   git push origin v<version>
   ```

6. Create the release:
   - **On the website:** *Releases > Draft a new release*, choose the tag, enter a title and release notes,
     drag `CCTrayTool_<version>.zip` and `CCTrayTool_<version>.zip.sha256` into the *Attach binaries* area and
     click *Publish release*.
   - **With the GitHub CLI:**

     ```bat
     gh release create v<version> CCTrayTool_<version>.zip CCTrayTool_<version>.zip.sha256 --title "CCTrayTool <version>" --notes-file RELEASE_NOTES.md
     ```

To replace a faulty file of an already published release, upload the corrected file to the same release
(`gh release upload <tag> <file> --clobber`) and update the checksum file. Do not move a tag that other people
may already have used; publish a new version instead.
