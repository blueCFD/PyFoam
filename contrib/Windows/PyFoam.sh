#----------------------------------*-sh-*--------------------------------------
#
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
# File
#     PyFoam.sh
#
# Description
#     Set PyFoam enviroment variables.
#
#------------------------------------------------------------------------------

export PYFOAM_ARCH_PATH=$WM_THIRD_PARTY_DIR/platforms/$WM_ARCH$WM_COMPILER/PyFoam
export PATH=$PATH:$PYFOAM_ARCH_PATH/bin

TARGETFOLDER=`cmd //c echo %PYFOAM_ARCH_PATH% | sed -e 's=/=\\\\=g'`
export PYTHONPATH=$TARGETFOLDER\\lib\\site-packages\;$PYTHONPATH
unset TARGETFOLDER

if [ -d "$ParaView_DIR" ]
then
    export TARGETFOLDER=$ParaView_DIR\\lib\\paraview-$ParaView_MAJOR\\site-packages\\vtk
    export TARGETFOLDER=`cmd //c echo %TARGETFOLDER% | sed -e 's=/=\\\\=g'`
    export PYTHONPATH=$TARGETFOLDER\;$PYTHONPATH
    unset TARGETFOLDER
fi

# ----------------------------------------------------------------- end-of-file
