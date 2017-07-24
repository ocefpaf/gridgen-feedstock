copy "%RECIPE_DIR%\build.sh" .
set PREFIX=%PREFIX:\=/%
set SRC_DIR=%SRC_DIR:\=/%
set MSYSTEM=MINGW%ARCH%
set MSYS2_PATH_TYPE=inherit
set CHERE_INVOKING=1
bash -lc "./build.sh"
if errorlevel 1 exit 1

:: Restore the original paths.
set PREFIX=%PREFIX:/=\%
set SRC_DIR=%SRC_DIR:/=\%

:: For some odd reason make install is not working on Windows' MSYS2 bash.
:: We are installing the files manually.
xcopy %SRC_DIR%\gridgen\gridgen.exe %LIBRARY_BIN% /s /e || exit 1

if not exist %PREFIX%\include\ mkdir %PREFIX%\include\ || exit 1
xcopy %SRC_DIR%\gridgen\gridgen.h %PREFIX%\include\ /s /e || exit 1

if not exist %PREFIX%\lib\ mkdir %PREFIX%\lib\ || exit 1
xcopy %SRC_DIR%\gridgen\libgridgen.a %PREFIX%\lib\ /s /e || exit 1
xcopy %SRC_DIR%\gridgen\libgridgen.so %PREFIX%\lib\ /s /e || exit 1

exit 0
