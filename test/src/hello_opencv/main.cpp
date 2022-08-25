// Copyright (c) 2022 Stephen David Cope III. All rights reserved.

#include <iostream>
#include <opencv2/core.hpp>
#include <opencv2/imgcodecs.hpp>

int main() {
  cv::Mat img = cv::imread("gb.png");
  std::cout << "w = " << img.cols << std::endl;
  std::cout << "h = " << img.rows << std::endl;
}
