@ECHO OFF
color b
ECHO ###################################################
ECHO #### Hello, Welcome to Abdelfatah custom batch ####
ECHO ###################################################
:: you can choose from all the URLs that youtube-dl support check https://ytdl-org.github.io/youtube-dl/supportedsites.html
:enterURL
ECHO --------------------------------------
SET /P URL="[Enter video URL] "
ECHO --------------------------------------
goto selection
:: Uncomment Below if you don't know youtube-dl formats & remove above line.
Rem goto formatList

:formatList
ECHO --------------------------------------
youtube-dl -F %URL%
ECHO --------------------------------------
goto selection

:selection
ECHO.
ECHO 1) Stream
ECHO 2) Download video
ECHO 3) Download audio only
ECHO 4) check available formats
ECHO 5) new url ?
ECHO 6) exit
ECHO.
ECHO --------------------------------------
SET /P option="Select option: "
if %option% == 1 (goto streaming)
if %option% == 2 (goto dl-video)
if %option% == 3 (goto dl_mp3)
if %option% == 4 (goto formatList)
if %option% == 5 (goto enterURL)
if %option% == 6 (goto bye)
ECHO Unknown value
ECHO --------------------------------------
goto selection

:streaming
ECHO.
ECHO 1) stream default?
ECHO 2) stream with selected format
ECHO.
ECHO --------------------------------------
SET /P option="Select option: "
if %option% == 1 (goto stream-default)
if %option% == 2 (goto stream-format)
ECHO.
ECHO Unknown value
ECHO --------------------------------------
goto selection

:: feel free to choose different media player
:stream-format
ECHO.
SET /P video="Select format-code (after you select option 4 in Main Menu): "
ECHO.
mpv.exe --ytdl-format=%video% %URL%
ECHO --------------------------------------
ECHO.
goto selection

:stream-default
ECHO.
mpv.exe --ytdl-format=22 %URL%
ECHO --------------------------------------
ECHO.
goto selection

:: Downlaod Video with selected formats 
:dl-video
ECHO --------------------------------------
ECHO.
SET /P format="Select format: "
ECHO --------------------------------------
youtube-dl -o Downloads/%%(title)s.%%(ext)s -f %format% -i --ignore-config --hls-prefer-native %URL%
ECHO --------------------------------------
goto selector

::Downlaod audio with format m4a with selected formats 
:dl_mp3
ECHO.
youtube-dl -o Downloads/%%(title)s.%%(ext)s -f bestaudio[ext=m4a] -i --ignore-config --hls-prefer-native %URL%
ECHO --------------------------------------
goto selector

:selector
ECHO 1) another URL ?
ECHO 2) exit
ECHO --------------------------------------
SET /P option="Select option: "
if %option% == 1 (goto enterURL)
if %option% == 2 (goto Bye)
ECHO.
ECHO Unknown value
ECHO --------------------------------------
goto selector

:bye
echo.
echo Done!
exit