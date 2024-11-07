include config.mk

# A list of paths to search for source files.
# Needed by dependency file generation rule.
# The sort function is used here to remove duplicates.
VPATH := ${sort ${dir ${SRCS}}}

CPPFLAGS := \
	${CPPFLAGS} \
	${addprefix -I,${INCLUDE_DIRS}} \
	${addprefix -D,${MACROS}}

# Transform path/to/source.x to source.o
OBJS := ${addsuffix .o,${basename ${notdir ${SRCS}}}}

OBJ_DIR := obj

DEP_DIR := ${BUILD_DIR}/dep
DEPS := ${addprefix ${DEP_DIR}/,${OBJS:.o=.d}}

RELEASE_DIR := ${BUILD_DIR}/release
RELEASE_OBJS := ${addprefix ${RELEASE_DIR}/${OBJ_DIR}/,${OBJS}}

DEBUG_DIR := ${BUILD_DIR}/debug
DEBUG_OBJS := ${addprefix ${DEBUG_DIR}/${OBJ_DIR}/,${OBJS}}

.PHONY: default all release debug configure clean

default: release

all: release debug

release: CFLAGS := ${CFLAGS} ${RELEASE_CFLAGS}
release: CPPFLAGS := ${CPPFLAGS} ${RELEASE_CPPFLAGS}
release: LDFLAGS := ${LDFLAGS} ${RELEASE_LDFLAGS}
release: LDLIBS := ${LDLIBS} ${RELEASE_LDLIBS}
release: ${RELEASE_DIR}/${EXE}

debug: CFLAGS := ${CFLAGS} ${DEBUG_CFLAGS}
debug: CPPFLAGS := ${CPPFLAGS} ${DEBUG_CPPFLAGS}
debug: LDFLAGS := ${LDFLAGS} ${DEBUG_LDFLAGS}
debug: LDLIBS := ${LDLIBS} ${DEBUG_LDLIBS}
debug: ${DEBUG_DIR}/${EXE}

${RELEASE_DIR}/${EXE}: ${RELEASE_OBJS}
	${LD} ${LDFLAGS} ${LDLIBS} ${RELEASE_OBJS} -o $@

${DEBUG_DIR}/${EXE}: ${DEBUG_OBJS}
	${LD} ${LDFLAGS} ${LDLIBS} ${DEBUG_OBJS} -o $@

${DEP_DIR}/%.d: %.c
	@set -e; rm -f $@; \
	${CC} -MM -MP -MT '${BUILD_DIR}/%/${OBJ_DIR}/${addsuffix .o,${basename ${notdir $<}}}' ${CPPFLAGS} $< > $@.$$$$; \
	sed -n '1p' $@.$$$$ > $@; \
	printf '\t$${CC} $${CPPFLAGS} $${CFLAGS} -c $$< -o $$@\n' >> $@; \
	sed -n '2,$$p' $@.$$$$ >> $@; \
	sed -n '1s/.*:/${subst /,\/,${DEP_DIR}}\/${addsuffix .d,${basename ${notdir $<}}}:/; 1p' $@.$$$$ >> $@; \
	rm -f $@.$$$$;

include ${DEPS}

configure:
	mkdir -p ${DEP_DIR} ${RELEASE_DIR}/${OBJ_DIR} ${DEBUG_DIR}/${OBJ_DIR}

clean:
	rm -f ${DEP_DIR}/* ${RELEASE_DIR}/${OBJ_DIR}/* ${DEBUG_DIR}/${OBJ_DIR}/* ${RELEASE_DIR}/${EXE} ${DEBUG_DIR}/${EXE}
