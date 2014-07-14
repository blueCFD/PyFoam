#!/bin/sh
#------------------------------------------------------------------------------
# License
#    This file is part of blueCAPE's modifications to PyFoam for working on
#    Windows. For more information on these modifications, visit:
#         http://bluecfd.com/Core
#
#    PyFoam is free software; you can redistribute it and/or modify it
#    under the terms of the GNU General Public License as published by the
#    Free Software Foundation; either version 2 of the License, or (at your
#    option) any later version.  See the file COPYING in this directory,
#    for a description of the GNU General Public License terms under which 
#    you can copy the files.
#
# Script
#     winsetup.sh
#
# Description
#     This script helps setup PyFoam in a blueCFD-Core prepared MSys shell on 
#   Windows.
#
#------------------------------------------------------------------------------

if ! isMinGW || [ -z "`uname -s | grep -i -e "MINGW"`" ]; then
  echo "This script is meant to be used in MSys and under a MinGW OpenFOAM environment."
  exit 1
fi

if [ -z "$PYFOAM_ARCH_PATH" ]; then
  echo "Environment variables for PyFoam are not available."
  echo "More specifically, PYFOAM_ARCH_PATH is missing."
  exit 1
fi

TARGETFOLDER=`cmd //c echo %PYFOAM_ARCH_PATH% | sed -e 's=/=\\\\\\\\=g'`

eval start //B //WAIT python setup.py install --prefix=$TARGETFOLDER

PYFOAM_BINARY_FOLDER="$PYFOAM_ARCH_PATH/bin"
mkdir "$PYFOAM_BINARY_FOLDER"

echo "Generating interface scripts for shell interaction"
for pythonScript in "$PYFOAM_ARCH_PATH/Scripts"/*.py ; do

  pythonScriptName=${pythonScript##*/}
  pythonScriptName=${pythonScriptName%%.*}
  sed -i -e 's=^#!.*python.*=#!python=' "$pythonScript" 2>/dev/null

  shellJumpScript="$PYFOAM_BINARY_FOLDER/${pythonScriptName}"
  cmdJumpBatch="$PYFOAM_BINARY_FOLDER/${pythonScriptName}.bat"

  echo "#!/bin/sh" > "${shellJumpScript}"
  echo 'TARGETFOLDER=`cmd //c echo %PYFOAM_ARCH_PATH% | sed -e '\''s=/=\\\\=g'\''`' >> "${shellJumpScript}"
  echo 'HOME=`cmd //c echo %HOME% | sed -e '\''s=/=\\\\=g'\''`' >> "${shellJumpScript}"
  echo "eval start //B //WAIT python \$PYFOAM_ARCH_PATH\\\\\\\\Scripts\\\\\\\\${pythonScriptName}.py \$*" >> "${shellJumpScript}"

  echo "@echo off" > "${cmdJumpBatch}"
  echo "set ARGUMENTS="  >> "${cmdJumpBatch}"
  echo ":LOOP" >> "${cmdJumpBatch}"
  echo '  if "%1"=="" goto afterloop' >> "${cmdJumpBatch}"
  echo "  set ARGUMENTS=%ARGUMENTS% %1" >> "${cmdJumpBatch}"
  echo "  shift" >> "${cmdJumpBatch}"
  echo "  goto LOOP" >> "${cmdJumpBatch}"
  echo ":AFTERLOOP" >> "${cmdJumpBatch}"
  echo "python %PYFOAM_ARCH_PATH%/Scripts/${pythonScriptName}.py %ARGUMENTS%" >> "${cmdJumpBatch}"
done

cmdJumpBatch="$PYFOAM_BINARY_FOLDER/PyFoam.bat"
echo "@echo off" > "${cmdJumpBatch}"
echo 'dir /w /a-d "%PYFOAM_ARCH_PATH%\bin"' >> "${cmdJumpBatch}"

echo "PyFoam installation complete."
