#include "gtest/gtest.h"
#include <another_module/Widget.h>

TEST(Widget, life)
{
  Widget mywidget;
  ASSERT_EQ(42, mywidget.life());
}
