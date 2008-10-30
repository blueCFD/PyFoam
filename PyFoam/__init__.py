#  ICE Revision: $Id: __init__.py 9548 2008-10-20 09:08:31Z bgschaid $ 
""" Utility-classes for OpenFOAM

Module for the Execution of OpenFOAM-commands and processing their output
"""

from Infrastructure.Configuration import Configuration

def version():
    """@return: Version number as a tuple"""
    return (0,5,1)

def versionString():
    """@return: Version number of PyFoam"""
    v=version()

    vStr="%d" % v[0]
    for d in v[1:]:
        if type(d)==int:
            vStr+=(".%d" % d)
        else:
            vStr+=("-%s" % str(d))
    return vStr

_configuration = Configuration()

def configuration():
    """@return: The Configuration information of PyFoam"""
    return _configuration

