# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

# Run Qt's meta object compiler.
# 
# Usage: ./moc [options] [header-file] [@option-file] [MOC generated json file]
# Qt Meta Object Compiler version 68 (Qt 6.2.4)
#
# Options:
#   -h, --help                        Displays help on commandline options.
#   --help-all                        Displays help including Qt specific
#                                     options.
#   -v, --version                     Displays version information.
#   -o <file>                         Write output to file rather than stdout.
#   -I <dir>                          Add dir to the include path for header
#                                     files.
#   -F <framework>                    Add Mac framework to the include path for
#                                     header files.
#   -E                                Preprocess only; do not generate meta
#                                     object code.
#   -D <macro[=def]>                  Define macro, with optional definition.
#   -U <macro>                        Undefine macro.
#   -M <key=value>                    Add key/value pair to plugin meta data
#   --compiler-flavor <flavor>        Set the compiler flavor: either "msvc" or
#                                     "unix".
#   -i                                Do not generate an #include statement.
#   -p <path>                         Path prefix for included file.
#   -f <file>                         Force #include <file> (overwrite default).
#   -b <file>                         Prepend #include <file> (preserve default
#                                     include).
#   --include <file>                  Parse <file> as an #include before the main
#                                     source(s).
#   -n <which>                        Do not display notes (-nn) or warnings
#                                     (-nw). Compatibility option.
#   --no-notes                        Do not display notes.
#   --no-warnings                     Do not display warnings (implies
#                                     --no-notes).
#   --ignore-option-clashes           Ignore all options that conflict with
#                                     compilers, like -pthread conflicting with
#                                     moc's -p option.
#   --output-json                     In addition to generating C++ code, create
#                                     a machine-readable JSON file in a file that
#                                     matches the output file and an extra .json
#                                     extension.
#   --collect-json                    Instead of processing C++ code, collect
#                                     previously generated JSON output into a
#                                     single file.
#   --output-dep-file                 Output a Make-style dep file for build
#                                     system consumption.
#   --dep-file-path <file>            Path where to write the dep file.
#   --dep-file-rule-name <rule name>  The rule name (first line) of the dep file.
#   --require-complete-types          Require complete types for better
#                                     performance
#
# Arguments:
#   [header-file]                     Header file to read from, otherwise stdin.
#   [@option-file]                    Read additional options from option-file.
#   [MOC generated json file]         MOC generated json output
define rx.moc
$(qt.moc) -o $@ $<
endef

# Use Qt's resource compiler to process a .qrc (QML resource) file.
#   arguments:
#     $(name) -name argument to rcc
#
# Usage: ./rcc [options] inputs
# Qt Resource Compiler version 6.2.4
#
# Options:
#   -h, --help                            Displays help on commandline options.
#   --help-all                            Displays help including Qt specific
#                                         options.
#   -v, --version                         Displays version information.
#   -o, --output <file>                   Write output to <file> rather than
#                                         stdout.
#   -t, --temp <file>                     Use temporary <file> for big resources.
#   --name <name>                         Create an external initialization
#                                         function with <name>.
#   --root <path>                         Prefix resource access path with root
#                                         path.
#   --compress-algo <algo>                Compress input files using algorithm
#                                         <algo> ([zlib], none).
#   --compress <level>                    Compress input files by <level>.
#   --no-compress                         Disable all compression. Same as
#                                         --compress-algo=none.
#   --no-zstd                             Disable usage of zstd compression.
#   --threshold <level>                   Threshold to consider compressing
#                                         files.
#   --binary                              Output a binary file for use as a
#                                         dynamic resource.
#   -g, --generator <cpp|python|python2>  Select generator.
#   --pass <number>                       Pass number for big resources
#   --namespace                           Turn off namespace macros.
#   --verbose                             Enable verbose mode.
#   --list                                Only list .qrc file entries, do not
#                                         generate code.
#   --list-mapping                        Only output a mapping of resource paths
#                                         to file system paths defined in the .qrc
#                                         file, do not generate code.
#   -d, --depfile <file>                  Write a depfile with the .qrc
#                                         dependencies to <file>.
#   --project                             Output a resource file containing all
#                                         files from the current directory.
#   --format-version <number>             The RCC format version to write
#
# Arguments:
#   inputs                                Input files (*.qrc).
define rx.rcc
$(qt.rcc) --name $(name) -o $@ $<
endef
