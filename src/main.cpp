#include <iostream>
#include "mymath.hpp"

extern "C"
{
	#include "mycmath.h"
}

int main()
{
	std::cout << "It works! " << mysquare(2,4) << ' ' << mycsquare(2,4) << std::endl;
}
