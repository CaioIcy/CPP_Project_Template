#include <gtest/gtest.h>
#include <mylib/feature.h>

TEST(Feature, toString)
{
  mylib::Feature myfeature;
  ASSERT_STREQ("Feature", myfeature.toString().c_str());
}

TEST(Feature, work)
{
  mylib::Feature myfeature;
  ASSERT_STREQ("work", myfeature.work().c_str());
}
