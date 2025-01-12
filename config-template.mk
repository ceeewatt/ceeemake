# Change if working in C++ project
LANGUAGE := C

ifeq (${LANGUAGE},C)
	CC := gcc
	LD := gcc
	EXT := .c
else
	CC := g++
	LD := g++
	EXT := .cpp
endif

EXE := a.out
BUILD_DIR := .build

SRCS :=

INCLUDE_DIRS :=

MACROS :=

CFLAGS := -Wall -Werror -Wextra -Wconversion -Wshadow
CPPFLAGS :=
LDFLAGS :=
LDLIBS :=

DEBUG_CFLAGS := -O0
DEBUG_CPPFLAGS := -DDEBUG
DEBUG_LDFLAGS :=
DEBUG_LDLIBS :=

RELEASE_CFLAGS := -O2
RELEASE_CPPFLAGS := -DNDEBUG
RELEASE_LDFLAGS :=
RELEASE_LDLIBS :=
