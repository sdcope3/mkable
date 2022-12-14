// Copyright (c) 2022 Stephen David Cope III. All rights reserved.

#include <boost/regex.hpp>
#include <iostream>
#include <string>

int main() {
  std::string s = "Boost Libraries";
  boost::regex expr{"(\\w+)\\s(\\w+)"};
  boost::smatch what;
  if (boost::regex_search(s, what, expr)) {
    std::cout << what[0] << '\n';
    std::cout << what[1] << "_" << what[2] << '\n';
  }
}
