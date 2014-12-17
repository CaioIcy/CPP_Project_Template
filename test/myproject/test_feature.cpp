#include "gtest/gtest.h"
#include <myproject/feature.h>

TEST(Feature, toString)
{
  myproject::Feature myfeature;
  ASSERT_STREQ("Feature", myfeature.toString().c_str());
}

TEST(Feature, work)
{
  myproject::Feature myfeature;
  ASSERT_STREQ("work", myfeature.work().c_str());
}
