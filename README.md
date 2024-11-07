# Description

A simple boilerplace Makefile that automatically generates rules for compiling C source files, with separate debug and release build folders. Specify a list of source files and header file search directories for the preprocessor in `config.mk` and the top level Makefile will generate a dependency file (*.d) for each source file.

# Requirements/Limitations

- **GNU make**: This Makefile uses multiple features that (AFAIK) are unique to the GNU variant of make.
- **Compatible compiler**: Automatic dependency generation relies on the availability of a preprocessor that can output rules suitable for make. Specifically, this Makefile uses the `-MM` and `-MT` preprocessor options.
- **Distinct file names**: The dependency generation rule relies on the make `VPATH` variable for finding source files. If a given source file is not found in the current directory, make will sequentially search through the list of directories specified in `VPATH`. If the same file name exists in multiple `VPATH` directories, it's possible (depending on the search order) for make to match the wrong source file. Thus, it's important to ensure there aren't duplicate file names in the `VPATH` directories. Additionally, all compiled object files are presently placed in a single directory, which could also lead to conflicts if you try to compile two separate source files with the same name. Basically, just save yourself the headache and use unique file names across your project :).
- **Command line utilities**: This Makefile uses common Unix utilities such as `sed` and `printf`.
