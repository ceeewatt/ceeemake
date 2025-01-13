#!/usr/bin/sh

. ./test/color.sh
. ./test/common_func.sh
. ./test/common_define.sh

### Start of script

# Ensure all targets are up to date
make -s debug

printf "[${MGN}Test Recompilation${DEF}]\n\n"

printf "[${MGN}Test 1${DEF}]: Touch 'a.c'\n"
test_file_recompilation debug src/a.c
printf "\n"

printf "[${MGN}Test 2${DEF}]: Touch 'b.c'\n"
test_file_recompilation debug src/b.c
printf "\n"

printf "[${MGN}Test 3${DEF}]: Touch 'main.c'\n"
test_file_recompilation debug src/main.c
printf "\n"

printf "[${MGN}Test 4${DEF}]: Touch 'a.h'\n"
test_file_recompilation debug include/a.h
printf "\n"

printf "[${MGN}Test 5${DEF}]: Touch 'b.h'\n"
test_file_recompilation debug include/b.h
printf "\n"

# Cleanup temporary file
rm expected_output.$$
