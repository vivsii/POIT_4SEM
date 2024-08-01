#include <stdio.h>
#include <tchar.h>
#include "Combi.h"
#include <algorithm>
namespace combi
{
	subset::subset(short n) //конструктор с параметром мощности
	{
		this->n = n;//мощность исходного множества
		this->sset = new short[n];  // адрес нулевого элем. массива индексов
		this->reset();
	};
	void  subset::reset()//переводит все функции в исходное состояние
	{
		this->sn = 0;
		this->mask = 0;
	};
	short subset::getfirst() //формирует подмножества в соответсвии с маской
	{
		__int64 buf = this->mask;
		this->sn = 0;
		for (short i = 0; i < n; i++)
		{
			if (buf & 0x1) this->sset[this->sn++] = i;
			buf >>= 1;
		}
		return this->sn; // возвращает значение в соответсвии с новым значением маски
	};
	short subset::getnext() //применяется для получения других подмножеств.
	{
		int rc = -1;
		this->sn = 0;
		if (++this->mask < this->count()) rc = getfirst();
		return rc;
	};
	short subset::ntx(short i) //возвращает значение элемента массива индексов по индексу этого элемента
	{
		return  this->sset[i];
	};
	unsigned __int64 subset::count()//вычисляет и возвращает количество элементов булеана за
	{
		return (unsigned __int64)(1 << this->n);
	};
};