
import unittest

theSuite=unittest.TestSuite()

from FoamFileGenerator import theSuite as FoamFileGenerator
from DataStructures import theSuite as DataStructures
from TemplateFile import theSuite as TemplateFile

theSuite.addTest(FoamFileGenerator)
theSuite.addTest(DataStructures)
theSuite.addTest(TemplateFile)