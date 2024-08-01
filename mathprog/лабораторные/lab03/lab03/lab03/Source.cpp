// --- main 
#include "stdafx.h"
#include <iostream>
#include <iomanip> 
#include <ctime>
#include "Salesman.h"
#define N 5
int main()
{
    setlocale(LC_ALL, "rus");
    int d[N][N] = { //0   1    2    3     4        
                  {  INF,  4, 23,  INF,   2},    //  0
                  { 2,   INF,  17,  66,   82},    //  1
                  { 4,  6,   INF,  86,   51},    //  2 
                  { 19,  56,  8,   INF,   6},    //  3
                  { 91,  68,  52,  15,   INF} };   //  4 



    int r[N];                     // ��������� 
    int t1 = clock();
    int s = salesman(
        N,          // [in]  ���������� ������� 
        (int*)d,          // [in]  ������ [n*n] ���������� 
        r           // [out] ������ [n] ������� 0 x x x x  

    );
    int t2 = clock();
    std::cout << std::endl << "-- ������ ������������ -- ";
    std::cout << std::endl << "-- ����������  �������: " << N;
    std::cout << std::endl << "-- ������� ���������� : ";
    for (int i = 0; i < N; i++)
    {
        std::cout << std::endl;
        for (int j = 0; j < N; j++)

            if (d[i][j] != INF) std::cout << std::setw(3) << d[i][j] << " ";

            else std::cout << std::setw(3) << "INF" << " ";
    }
    std::cout << std::endl << "-- ����������� �������: ";
    for (int i = 0; i < N; i++) std::cout << r[i] + 1 << "-->"; std::cout << 1;
    std::cout << std::endl << "-- ����� ��������     : " << s;
    std::cout << std::endl << "����� ��������       : " << ((double)(t2 - t1)) / ((double)CLOCKS_PER_SEC);
    std::cout << std::endl;
    system("pause");
    return 0;
}
