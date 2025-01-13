#!/usr/bin/sh

###
# These scripts are used to ensure the Makefile compiles the
#  appropriate files for a given target. To run all tests,
#  execute this script from within the directory containing
#  the demo source code and Makefile.
# The 'test_recompilation' script tests that, for a given source
#  file, only the translation units that depend on that source
#  file get recompiled. For example, if 'a.c' is edited, only
#  'a.o' should get recompiled, but if 'a.h' is edited, both
#  'a.o' and 'main.o' should get recompiled.
# The 'test_debug_release' script tests the separate debug
#  and release configurations and ensures that nothing gets
#  rebuilt if no file modifications occur.
###

. ./test/test_recompilation.sh
. ./test/test_debug_release.sh
