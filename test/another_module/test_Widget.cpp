#include "gtest/gtest.h"
#include <another_module/Widget.h>

TEST(Widget_life, Zero)
{
  Widget mywidget;
  ASSERT_EQ(42, mywidget.life(0));
}

TEST(Widget_life, Non_Zero)
{
  Widget mywidget;
  ASSERT_EQ(42, mywidget.life(69));
}
