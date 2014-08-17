'''
------------------------------------------------------------------------------
 License
    This file is part of blueCAPE's modifications to PyFoam for working on
    Windows. For more information on these modifications, visit:
        http://www.bluecape.com.pt/blueCFD

    PyFoam is free software; you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by the
    Free Software Foundation; either version 2 of the License, or (at your
    option) any later version.  See the file COPYING in this directory,
    for a description of the GNU General Public License terms under which 
    you can copy the files.

 Script
     winhacks.py

 Description
     This script file acts mostly as a dummy stub for several POSIX functions
     that are not available on Windows and on Python for Windows.
     Source code available on this file is a compilation of public domain
     solutions.

------------------------------------------------------------------------------
'''

import os

__CSL = None
def symlink(source, link_name):
    '''symlink(source, link_name)
       Creates a symbolic link pointing to source named link_name'''
    global __CSL
    if __CSL is None:
        import ctypes
        csl = ctypes.windll.kernel32.CreateSymbolicLinkW
        csl.argtypes = (ctypes.c_wchar_p, ctypes.c_wchar_p, ctypes.c_uint32)
        csl.restype = ctypes.c_ubyte
        __CSL = csl
    flags = 0
    if source is not None and os.path.isdir(source):
        flags = 1
    if __CSL(link_name, source, flags) == 0:
        raise ctypes.WinError()

def getlogin():
    '''getlogin()
       Get login username from environment.'''
    return os.getenv('USERNAME')
    
def getloadavg():
    '''Dummy result, 1 to avoid division by zero'''
    return 1

'''hack the three functions above into the os module'''
os.symlink = symlink
os.getlogin = getlogin
os.getloadavg = getloadavg

"""These 3 can be improved if we use http://code.google.com/p/psutil/"""
"""Issue for solving this: https://github.com/blueCFD/PyFoam/issues/2"""
"""All return 1 to avoid divisions by zero"""
def getrusage(who):
    class DummyRUsage(object):
        ru_utime=1    # time in user mode (float)
        ru_stime=1    # time in system mode (float)
        ru_maxrss=1   # maximum resident set size
        ru_ixrss=1    # shared memory size
        ru_idrss=1    # unshared memory size
        ru_isrss=1    # unshared stack size
        ru_minflt=1   # page faults not requiring I/O
        ru_majflt=1   # page faults requiring I/O
        ru_nswap=1    # number of swap outs
        ru_inblock=1  # block input operations
        ru_oublock=1  # block output operations
        ru_msgsnd=1   # messages sent
        ru_msgrcv=1   # messages received
        ru_nsignals=1 # signals received
        ru_nvcsw=1    # voluntary context switches
        ru_nivcsw=1   # involuntary context switches


    return DummyRUsage()

def getpagesize():
    return 1

RUSAGE_CHILDREN = 1
