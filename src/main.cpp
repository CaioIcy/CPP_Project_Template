#include <iostream>
#include <string>

#include <some_module/feature.h>
#include <another_module/Widget.h>

int main(int argc, char** argv) {

	std::cout << "*************************************" << std::endl;
	std::cout << "*------Project template main!-------*" << std::endl;
	std::cout << "*************************************" << std::endl;

	some_module::Feature feature;
	const std::string testString = feature.toString();
	std::cout << testString << std::endl;

	Widget widget;
	const int testMeaning = widget.life();
	std::cout << testMeaning << std::endl;

	return 0;
}
