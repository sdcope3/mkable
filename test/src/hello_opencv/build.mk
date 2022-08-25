# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

####### Variables

hello_opencv.srcs := $(wildcard $(hello_opencv.root)/*.cpp)
hello_opencv.objs := $(addprefix $(hello_opencv.build_root)/,$(notdir $(hello_opencv.srcs:.cpp=.o)))
hello_opencv.exe := $(hello_opencv.build_root)/hello_opencv$(exe_ext)

hello.opencv.png := gb.png
hello_opencv.src_png := $(hello_opencv.root)/$(hello.opencv.png)
hello_opencv.dest_png := $(hello_opencv.build_root)/$(hello.opencv.png)

hello_opencv.depfiles := $(hello_opencv.objs:%.o=%.d)
-include $(hello_opencv.depfiles)

####### Targets

.PHONY: hello_opencv.clean
hello_opencv.clean: component = hello_opencv
hello_opencv.clean: custom_files = $(hello_opencv.dest_png)
hello_opencv.clean: $(call fn.get_clean_prereqs,hello_opencv)
	$(rx.clean)

.PHONY: hello_opencv.exe
hello_opencv.exe: $(hello_opencv.exe)

.PHONY: hello_opencv.run
hello_opencv.run: $(hello_opencv.exe)
	$(rx.run)

$(hello_opencv.exe): $(call fn.get_link_prereqs,hello_opencv,objs)
	$(rx.link)

$(hello_opencv.build_root):
	$(rx.make_target_dir)
	$(call fn.copy_file,$(hello_opencv.src_png),$(hello_opencv.dest_png))

$(hello_opencv.build_root)/%.o: $(hello_opencv.root)/%.cpp | $(hello_opencv.build_root)
	$(rx.compile)
