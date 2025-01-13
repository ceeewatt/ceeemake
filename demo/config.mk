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
