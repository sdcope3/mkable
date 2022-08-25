# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

include $(mkable_env_dir)/common.mk

####### Active developer path configuration

adp.sdk                := /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk
adp.frameworks         := $(adp.sdk)/System/Library/Frameworks

####### Compiler and linker options

#defines               +=

cxx.release            += clang++ -O3
cxx.debug              += clang++ -Og -DDEBUG
cxxflags               += -pipe -std=gnu++17 -Wall -Wextra -Werror -fPIC -MMD\
                          -isysroot $(adp.sdk)\
                          -mmacosx-version-min=12.0\
                          -fvisibility=hidden
#incpath               +=

link.release           += clang++ -O3
link.debug             += clang++ -Og -DDEBUG
lflags                 += -isysroot $(adp.sdk)\
                          -mmacosx-version-min=12.0\
                          -fvisibility=hidden\
                          -headerpad_max_install_names\
                          -Wl,-rpath,@executable_path/../Frameworks
#libs                  +=

cxx_c                  := -c
cxx_D                  := -D
cxx_I                  := -I
cxx_o                  := -o
link_o                 := $(cxx_o)

####### Commands, tools, and options

ar                     := ar rcs 
cp                     := cp
del_dir                := rmdir
del_file               := rm -f
echo_empty             := echo;
exe_ext                := .bin
mkdir                  := mkdir -p
nuke                   := rm -rf
