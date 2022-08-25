# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

###############################################################################
# This file sets up the build environment by defining several parameters:
#   os         = identifier for the general OS (e.g. Ubuntu)
#   os_version = identifier for the specific OS release (e.g. 18.04)
#   platform   = identifier for the hardware platform (e.g. x86_64)
#   toolchain  = identifier for the collection of build tools (e.g. gcc)
###############################################################################

ifeq ($(OS),Windows_NT)
    uname := $(strip 'Get-CimInstance Win32_OperatingSystem \
                      | Select-Object OBJECT \
                      | Format-Table -HideTableHeaders')
    uname_s := Windows
    uname_m := $(strip $(shell powershell $(uname:OBJECT=OSArchitecture)))
    uname_o := Windows
    uname_r := $(strip $(shell powershell $(uname:OBJECT=Version)))
    uname_p := $(uname_m)
    uname_v := unknown
else
    uname_s := $(shell sh -c 'uname -s 2>/dev/null || echo unknown')
    uname_m := $(shell sh -c 'uname -m 2>/dev/null || echo unknown')
    uname_o := $(shell sh -c 'uname -o 2>/dev/null || echo unknown')
    uname_r := $(shell sh -c 'uname -r 2>/dev/null || echo unknown')
    uname_p := $(shell sh -c 'uname -p 2>/dev/null || echo unknown')
    uname_v := $(shell sh -c 'uname -v 2>/dev/null || echo unknown')
endif

# macOS
ifeq ($(uname_s),Darwin)
    os := macOS
    os_version := $(shell sw_vers -productVersion)
    platform := $(uname_m)
    toolchain := clang
endif

# Linux
ifeq ($(uname_s),Linux)
    os := $(shell lsb_release -is)
    os_version := $(shell lsb_release -rs)
    platform := $(uname_m)
    toolchain := gcc
endif

# Windows
ifeq ($(uname_s),Windows)
    os := Windows
    os_version := $(firstword $(subst ., ,$(uname_r)))
    platform := $(if $(filter-out 64-bit,$(uname_m)),unknown,x86_64)
    toolchain := vs2019
endif

env := $(os)-$(os_version)-$(platform)-$(toolchain)
env_makefile := $(mkable_env_dir)/$(env).mk

ifeq ($(wildcard $(env_makefile)),)
$(error $(os) $(os_version) for $(platform) ($(toolchain)) is not supported)
endif

include $(env_makefile)
