# Language specific options (C/C++)
LANGUAGE := C

ifeq (${LANGUAGE},C)
	CC := gcc
	LD := gcc
	EXT := .c
	CFLAGS :=
else
	CC := g++
	LD := g++
	EXT := .cpp
	CFLAGS := -Wsign-conversion
endif

EXE := demo
BUILD_DIR := .build

SRCS := \
	src/main.c \
	src/a.c \
	src/b.c

INCLUDE_DIRS := \
	include

MACROS := \
	FOO=42

CFLAGS := -Wall -Werror -Wextra -Wconversion -Wshadow ${CFLAGS}
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

# Remove unnecessary whitespace
CFLAGS := $(strip ${CFLAGS})
