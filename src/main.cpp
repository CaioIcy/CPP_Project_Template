#include <iostream>
#include <string>

#include <myproject/feature.h>

int main(int argc, char** argv) {

	std::cout << "*************************************" << std::endl;
	std::cout << "*------Project template main!-------*" << std::endl;
	std::cout << "*************************************" << std::endl;

	myproject::Feature feature;
	const std::string testString = feature.toString();
	std::cout << testString << std::endl;

	return 0;
}
