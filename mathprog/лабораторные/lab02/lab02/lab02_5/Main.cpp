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
	int V = 300,                // ����������� �������               
		v[NN],       // ������ �������� ������� ����
		c[NN];       // ��������� �������� ������� ����
	short m[NN];               // ���������� ��������� ������� ����  {0,1}    

	auxil::start();
	for (int i = 0; i < NN; i++)
	{
		v[i] = auxil::iget(10, 300);
		c[i] = auxil::iget(5, 55);
	}

	int maxcc = knapsack_s(
		V,   // [in]  ����������� ������� 
		NN,  // [in]  ���������� ����� ���������
		v,   // [in]  ������ �������� ������� ����  
		c,   // [in]   ��������� �������� ������� ����   
		m    // [out] ���������� ��������� ������� ����  
	);

	std::cout << std::endl << "--------  ������ � �������--------- ";
	std::cout << std::endl << "- ���������� ��������� : " << NN;
	std::cout << std::endl << "- ����������� �������  : " << V;
	std::cout << std::endl << "- ������� ���������    : ";
	for (int i = 0; i < NN; i++) std::cout << v[i] << " ";
	std::cout << std::endl << "- ��������� ���������    : ";
	for (int i = 0; i < NN; i++) std::cout << c[i] << " ";
	std::cout << std::endl << "- ��������� ��������� : v*c";
	for (int i = 0; i < NN; i++) std::cout << v[i] * c[i] << " ";
	std::cout << std::endl << "- ����������� ��������� �������: " << maxcc;
	std::cout << std::endl << "- ��� �������: ";
	int s = 0; for (int i = 0; i < NN; i++) s += m[i] * v[i];
	std::cout << s;
	std::cout << std::endl << "- ������� ��������: ";
	for (int i = 0; i < NN; i++) {
		if (m[i] > 0) {
			std::cout << "  ������: " << v[i] << ", ���������: " << c[i] << std::endl;
		}
	}

	system("pause");
	return 0;
}