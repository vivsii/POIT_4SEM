#include "Factorial.h"
#include <iostream>
using namespace std;

long double factorial(int num) {
    if (num == 0 || num == 1) {
        return 1;
    }
    else {
        return num * factorial(num - 1);
    }
}