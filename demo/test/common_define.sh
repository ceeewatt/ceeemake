CC='gcc'
LD='gcc'
EXE='demo'
BUILD_DIR='.build'

SRCS='src/main.c src/a.c src/b.c'
INCLUDE_DIRS='include'
MACROS='FOO=42'

CFLAGS='-Wall -Werror -Wextra -Wconversion -Wshadow'

DEBUG_CFLAGS='-O0'
DEBUG_CPPFLAGS='-DDEBUG'
RELEASE_CFLAGS='-O2'
RELEASE_CPPFLAGS='-DNDEBUG'

addprefix -I "${INCLUDE_DIRS}"
INCLUDE_FLAGS="${function_output}"

addprefix -D "${MACROS}"
MACRO_FLAGS="${function_output}"

CPPFLAGS="${INCLUDE_FLAGS} ${MACRO_FLAGS}"
