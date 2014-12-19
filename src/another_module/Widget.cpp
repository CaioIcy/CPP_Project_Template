#include <another_module/Widget.h>

Widget::Widget() {

}

Widget::~Widget() {

}

int Widget::life(const int number) const {
	int meaning = 42;

	if(number != 0) {
		meaning = (number/number) + 41;
	}

	return meaning;
}
