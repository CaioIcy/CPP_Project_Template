#include "gtest/gtest.h"
#include <some_module/feature.h>

TEST(Feature_toString, toString)
{
  some_module::Feature myfeature;
  ASSERT_STREQ("Feature", myfeature.toString().c_str());
}

TEST(Feature_work, work)
{
  some_module::Feature myfeature;
  ASSERT_STREQ("work", myfeature.work().c_str());
}
