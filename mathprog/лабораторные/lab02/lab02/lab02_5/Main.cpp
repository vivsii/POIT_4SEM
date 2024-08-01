#include <stdio.h>
#include <tchar.h>
#include <iostream>
#include "Combi.h"
#include <ctime>
#include "Knapsack.h"
#include "Auxil.h"
#define NN 18

clock_t SS[NN];

int _tmain(int argc, _TCHAR* argv[])
{
	setlocale(LC_ALL, "rus");
	int V = 300,                // вместимость рюкзака               
		v[NN],       // размер предмета каждого типа
		c[NN];       // стоимость предмета каждого типа
	short m[NN];               // количество предметов каждого типа  {0,1}    

	auxil::start();
	for (int i = 0; i < NN; i++)
	{
		v[i] = auxil::iget(10, 300);
		c[i] = auxil::iget(5, 55);
	}

	int maxcc = knapsack_s(
		V,   // [in]  вместимость рюкзака 
		NN,  // [in]  количество типов предметов
		v,   // [in]  размер предмета каждого типа  
		c,   // [in]   стоимость предмета каждого типа   
		m    // [out] количество предметов каждого типа  
	);

	std::cout << std::endl << "--------  Задача о рюкзаке--------- ";
	std::cout << std::endl << "- количество предметов : " << NN;
	std::cout << std::endl << "- вместимость рюкзака  : " << V;
	std::cout << std::endl << "- размеры предметов    : ";
	for (int i = 0; i < NN; i++) std::cout << v[i] << " ";
	std::cout << std::endl << "- стоимость предметов    : ";
	for (int i = 0; i < NN; i++) std::cout << c[i] << " ";
	std::cout << std::endl << "- стоимости предметов : v*c";
	for (int i = 0; i < NN; i++) std::cout << v[i] * c[i] << " ";
	std::cout << std::endl << "- оптимальная стоимость рюкзака: " << maxcc;
	std::cout << std::endl << "- вес рюкзака: ";
	int s = 0; for (int i = 0; i < NN; i++) s += m[i] * v[i];
	std::cout << s;
	std::cout << std::endl << "- выбраны предметы: ";
	for (int i = 0; i < NN; i++) {
		if (m[i] > 0) {
			std::cout << "  Размер: " << v[i] << ", Стоимость: " << c[i] << std::endl;
		}
	}

	system("pause");
	return 0;
}