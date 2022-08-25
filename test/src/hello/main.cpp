// Copyright (c) 2022 Stephen David Cope III. All rights reserved.

#include <iostream>

#include "mk/goodbye/cGoodbye.h"

int main() {
  std::cout << "Hello World!" << std::endl;

  mk::bye::cGoodbye goodbye;
  goodbye.show();

  return 0;
}
