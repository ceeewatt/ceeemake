#!/usr/bin/sh

. ./test/color.sh
. ./test/common_func.sh
. ./test/common_define.sh

test_nothing_to_be_done()
{
  # Example usage: test_nothing_to_be_done debug
  # This function checks that no targets are recompiled
  #  for the specified build configuration.

  TARGET="${1}"
  MAKE_OUTPUT=$(make "${TARGET}")
  MAKE_OUTPUT_EXPECTED="make: Nothing to be done for '${TARGET}'."

  if [ "${MAKE_OUTPUT}" = "${MAKE_OUTPUT_EXPECTED}" ]; then
    printf "(${GRN}pass${DEF}) ${MAKE_OUTPUT}\n"
    printf "Test: ${GRN}PASSED${DEF}\n"
  else
    printf "Expected command line: ${MAKE_OUTPUT_EXPECTED}\n"
    printf "Actual command line: ${MAKE_OUTPUT}\n"
    printf "Test: ${RED}FAILED${DEF}\n"
  fi
}

### Start of script

# Remove all compiled targets
make -s clean

printf "[${MGN}Test Debug/Release${DEF}]\n\n"

printf "[${MGN}Test 1${DEF}]: Debug Configuration\n"
test_file_recompilation debug all
printf "\n"

printf "[${MGN}Test 2${DEF}]: Attempt to Remake Debug Target\n"
test_nothing_to_be_done debug
printf "\n"

printf "[${MGN}Test 3${DEF}]: Release Configuration\n"
test_file_recompilation release all
printf "\n"

# Cleanup temporary file
rm expected_output.$$

printf "[${MGN}Test 4${DEF}]: Attempt to Remake Release Target\n"
test_nothing_to_be_done release
printf "\n"

printf "[${MGN}Test 5${DEF}]: Attempt to Remake all Targets\n"
test_nothing_to_be_done all
printf "\n"
