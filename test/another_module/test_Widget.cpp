#include "gtest/gtest.h"
#include <another_module/Widget.h>

TEST(Widget, LifeZero)
{
  Widget mywidget;
  ASSERT_EQ(42, mywidget.life(0));
}

TEST(Widget, LifeNonZero)
{
  Widget mywidget;
  ASSERT_EQ(42, mywidget.life(69));
}
