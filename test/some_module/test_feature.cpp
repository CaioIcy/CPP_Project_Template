#include "gtest/gtest.h"
#include <some_module/feature.h>

TEST(FeatureTest, ToString)
{
  some_module::Feature myfeature;
  ASSERT_STREQ("Feature", myfeature.toString().c_str());
}

TEST(FeatureTest, Work)
{
  some_module::Feature myfeature;
  ASSERT_STREQ("work", myfeature.work().c_str());
}
