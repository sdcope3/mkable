# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

include $(mkable_env_dir)/common.mk

####### Compiler and linker options

#defines               +=

cxx.release            += cl /Ox
cxx.debug              += cl
cxxflags               += /nologo /std:c++17 /Zc:__cplusplus /EHsc
#incpath               +=

link.release           += link
link.debug             += link
lflags                 += /nologo
#libs                  +=

cxx_c                  := /c
cxx_D                  := /D
cxx_I                  := /I
cxx_o                  := /Fo:
link_o                 := /out:

####### Commands, tools, and options

ar                     := lib /nologo $(link_o)
cp                     := copy
del_dir                := rmdir
del_file               := del
echo_empty             := echo.
exe_ext                := .exe
mkdir                  := mkdir
nuke                   := rmdir /s /q
