# Description

A simple boilerplace Makefile that automatically generates rules for compiling C source files, with separate debug and release build folders. Specify a list of source files and header file search directories for the preprocessor in `config.mk` and the top level Makefile will generate a dependency file (*.d) for each source file.

# Requirements/Limitations

- **GNU make**: This Makefile uses multiple features that (AFAIK) are unique to the GNU variant of make.
- **Compatible compiler**: Automatic dependency generation relies on the availability of a preprocessor that can output rules suitable for make. Specifically, this Makefile uses the `-MM`, `-MP`, and `-MT` preprocessor options.
- **Distinct file names**: The dependency generation rule relies on the make `VPATH` variable for finding source files. If a given source file is not found in the current directory, make will sequentially search through the list of directories specified in `VPATH`. If the same file name exists in multiple `VPATH` directories, it's possible (depending on the search order) for make to match the wrong source file. Thus, it's important to ensure there aren't duplicate file names in the `VPATH` directories. Additionally, all compiled object files are presently placed in a single directory, which could also lead to conflicts if you try to compile two separate source files with the same name. Basically, just save yourself the headache and use unique file names across your project :).
- **Command line utilities**: This Makefile uses common Unix utilities such as `sed` and `printf`.

# Automatic Dependency Generation

See the [GNU make Docs](https://www.gnu.org/software/make/manual/html_node/Automatic-Prerequisites.html) for a basic overview.

Perhaps the most tedious part of writing a Makefile is manually specifying the header file dependencies for building each translation unit. For any given source file, it's important for a build system to ensure that the corresponding object file is recompiled when any of its dependencies are updated. Traditionally this is done by manually specifying any `#include`'d header files in the rule's prerequisite list for a target object file.

If, however, you have a compiler that can generate make rules, you can rely on the compiler to automatically determine the dependencies for each object file.

A generic Makefile for generating a dependency file `source.d` from a source file `source.c` is:

```Makefile
source.d: source.c
    ${CC} -MM -MP $< > $@

include source.d
```

When make is directed to `include` the dependency file, it will attempt to create `source.d` according to the specified rule (see [How Makefiles Are Remade](https://www.gnu.org/software/make/manual/html_node/Remaking-Makefiles.html)). The file `source.d` will contain a single rule that takes the following form: `source.o: source.c header1.h header2.h ...`, where the listed header file prerequisites are the header files included in `source.c`.

With the above generated dependency file, we now have the rule necessary for compiling `source.c` into `source.o`. Whenever the `source.o` dependencies change, we would also like to update the dependency file itself. Thus, we'll simply duplicate the object file rule and change the target: `source.d: source.c header1.h header2.h ...`.

At this point, there are two lines in our generated dependency file. Our Makefile will add another line comprising the recipe for the object file rule (see the `printf` command in the dependency generation recipe). The dependency file will additionally contain phony targets for each header file prerequisite - these come from the `-MP` preprocessor option. The purpose of these phony targets is to prevent make from throwing an error if a header file is deleted.
