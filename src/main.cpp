#include <iostream>
#include <cstdio>

#include <some_module/feature.h>
#include <another_module/Widget.h>

// Omit <string> inclusion for cpplint test

int main(int argc, char** argv) {

	std::cout << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" << std::endl;
	std::cout << "~------Project template main!-------~" << std::endl;
	std::cout << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" << std::endl;

	// Making sure other classes are being linked properly
	some_module::Feature feature;
	const std::string testString = feature.toString();
	std::cout << testString << std::endl;

	Widget widget;
	const int testMeaning = widget.life(69);
	std::cout << testMeaning << std::endl;

	// Checking for C++11
	void* ptr = nullptr;
	((void)ptr);

	// Generating some bad code for cpplint and cppcheck
	char* kyop = "W O L O L O L O";
	printf(kyop);
	printf("\n");
	int x;
	for(int i = 0; i != 10; i++){
		x = (i%2) + (i*3) - i;
	}

	return 0;
}
