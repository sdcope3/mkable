// Copyright (c) 2022 Stephen David Cope III. All rights reserved.

#include "api/mk/goodbye/cGoodbye.h"

#include <stdio.h>

#include "goodbye_constants.h"

void mk::bye::cGoodbye::show() {
  printf("The meaning of life is... %d!\n", kMeaningOfLife);
}
