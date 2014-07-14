rem ------------------------------------------------------------------------------
rem
rem License
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
rem File
rem     PyFoam.bat
rem
rem Description
rem     Add PyFoam to the search path.
rem
rem ------------------------------------------------------------------------------

set PYFOAM_ARCH_PATH=%WM_THIRD_PARTY_DIR%\platforms\%WM_ARCH%%WM_COMPILER%\PyFoam
set PYTHONPATH=%PYFOAM_ARCH_PATH%\lib\site-packages;%PYTHONPATH%
set PATH=%PATH%;%PYFOAM_ARCH_PATH%\bin
