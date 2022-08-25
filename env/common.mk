# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

D_prefix               := MK_

####### Compiler and linker options

defines                 = $(cxx_D)$(D_prefix)OS=$(os) $(cxx_D)$(D_prefix)OS_VERSION=$(os_version)

#cxx.release            =
#cxx.debug              =
#cxxflags               =
incpath                 = $(depincpath)

#link.release           =
#link.debug             =
lflags                  = $(deplflags)
libs                    = $(deplibs)

#cxx_c                 :=
#cxx_D                 :=
#cxx_I                 :=
#cxx_o                 :=
#link_o                :=

####### Commands, tools, and options

#ar                    :=
#cp                    :=
#del_dir               :=
#del_file              :=
#echo_empty            :=
#exe_ext               :=
#mkdir                 :=
#nuke                  :=
