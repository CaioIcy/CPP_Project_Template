#pragma once

#include <string>

namespace some_module {

class Feature {

	public:
		explicit Feature();
		virtual ~Feature();

		/**
		* @return "Feature"
		*/
		std::string toString() const;

		/**
		* @return "work"
		*/
		std::string work() const;
};

} // namespace some_module
