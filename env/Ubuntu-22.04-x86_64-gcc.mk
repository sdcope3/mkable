# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

include $(mkable_env_dir)/common.mk

####### Compiler and linker options

#defines               +=

cxx.release            += g++ -O3
cxx.debug              += g++ -ggdb -Og -DDEBUG
cxxflags               += -pipe -std=c++17 -Wall -Wextra -Werror -fPIC -MMD
#incpath               +=

link.release           += g++ -O3
link.debug             += g++ -ggdb -Og -DDEBUG
#lflags                +=
libs                   += -lpthread

cxx_c                  := -c
cxx_D                  := -D
cxx_I                  := -I
cxx_o                  := -o
link_o                 := $(cxx_o)

####### Commands, tools, and options

ar                     := ar cqs 
cp                     := cp
del_dir                := rmdir -p --ignore-fail-on-non-empty
del_file               := rm -f
echo_empty             := echo;
exe_ext                := .bin
mkdir                  := mkdir -p
nuke                   := rm -rf
