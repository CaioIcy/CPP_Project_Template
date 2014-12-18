#include "gtest/gtest.h"
#include <some_module/feature.h>

TEST(Feature, toString)
{
  some_module::Feature myfeature;
  ASSERT_STREQ("Feature", myfeature.toString().c_str());
}

TEST(Feature, work)
{
  some_module::Feature myfeature;
  ASSERT_STREQ("work", myfeature.work().c_str());
}
