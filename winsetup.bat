@echo off
rem ------------------------------------------------------------------------------
rem  License
rem    This file is part of blueCAPE's modifications to PyFoam for working on
rem    Windows. For more information on these modifications, visit:
rem         http://bluecfd.com/Core
rem 
rem     PyFoam is free software; you can redistribute it and/or modify it
rem     under the terms of the GNU General Public License as published by the
rem     Free Software Foundation; either version 2 of the License, or (at your
rem     option) any later version.  See the file COPYING in this directory,
rem     for a description of the GNU General Public License terms under which 
rem     you can copy the files.
rem 
rem  Script
rem      winsetup.bat
rem 
rem  Description
rem      This batch file helps setup PyFoam in a Windows Command Line.
rem 
rem ------------------------------------------------------------------------------

if "%PYFOAM_ARCH_PATH%" == "" GOTO ERRORMSG

python setup.py install --prefix="%PYFOAM_ARCH_PATH%"

set PYFOAM_BINARY_FOLDER=%PYFOAM_ARCH_PATH%\bin
mkdir "%PYFOAM_BINARY_FOLDER%"

echo Generating interface scripts for command line interaction...
for %%a in ("%PYFOAM_ARCH_PATH%\Scripts\*.py") do call :PREPSCRIPT "%%a"

call :PYFOAMDIR

echo.
echo.
echo PyFoam installation complete.
echo Run the following command to list the existing PyFoam commands:
echo    PyFoam
GOTO END

:PREPSCRIPT
set pythonScriptName=%~n1
set cmdJumpBatch=%PYFOAM_BINARY_FOLDER%\%pythonScriptName%.bat

echo @echo off > "%cmdJumpBatch%"
echo set ARGUMENTS=  >> "%cmdJumpBatch%"
echo :LOOP >> "%cmdJumpBatch%"
echo   if "%%1"=="" goto afterloop >> "%cmdJumpBatch%"
echo   set ARGUMENTS=%%ARGUMENTS%% %%1 >> "%cmdJumpBatch%"
echo   shift >> "%cmdJumpBatch%"
echo   goto LOOP >> "%cmdJumpBatch%"
echo :AFTERLOOP >> "%cmdJumpBatch%"
echo python %%PYFOAM_ARCH_PATH%%/Scripts/%pythonScriptName%.py %%ARGUMENTS%% >> "%cmdJumpBatch%"

rem unset variables
set cmdJumpBatch=
set pythonScriptName=

GOTO END

:PYFOAMDIR
set cmdJumpBatch=%PYFOAM_BINARY_FOLDER%\PyFoam.bat
echo @echo off > "%cmdJumpBatch%"
echo dir /w /a-d "%%PYFOAM_ARCH_PATH%%\bin"  >> "%cmdJumpBatch%"

rem unset variables
set cmdJumpBatch=
set pythonScriptName=

GOTO END

:ERRORMSG
echo Environment variables for PyFoam are not available.
echo More specifically, PYFOAM_ARCH_PATH is missing.
GOTO END

:END
