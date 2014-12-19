#pragma once

class Widget {

	public:
		explicit Widget();
		virtual ~Widget();

		/**
		* @param number : Don't ask me.
		* @return The meaning of life.
		*/
		int life(const int number) const;
};
