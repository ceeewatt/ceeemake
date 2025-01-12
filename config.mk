EXE := demo
BUILD_DIR := .build
EXT := .c

SRCS := \
	demo/src/a.c \
	demo/src/b.c

INCLUDE_DIRS := \
	demo/include

MACROS := \
	FOO=42

CC := gcc
LD := gcc
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
