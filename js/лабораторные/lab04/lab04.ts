interface IShoe{
    id: number;
    size: number;
    color: string;
    price: number;
}

interface IShoesType{
    boots: IShoe[];
    sneakers: IShoe[];
    sandals: IShoe[];
}

interface Shoes{
    shoes: IShoesType;
}

let products: Shoes = {
    shoes:{
        boots:[
            {id: 111, size: 39, color: 'red', price: 100},
            {id: 212, size: 41, color: 'blue', price: 203},
            {id: 333, size: 43, color: 'purple', price: 532},
        ],
        sneakers:[
            {id: 432, size: 37, color: 'green', price: 566},
            {id: 666, size: 38, color: 'white', price: 231},
            {id: 543, size: 37, color: 'pink', price: 753},
            {id: 851, size: 40, color: 'yellow', price: 444},
        ],
        sandals:[
            {id: 626, size: 42, color: 'orange', price: 635},
            {id: 936, size: 37, color: 'red', price: 342},
            {id: 734, size: 35, color: 'pink', price: 362},
        ]
    }
}

function* iterator(products: Shoes){
    for(let category in  products.shoes)
    {
        for(let shoe of products.shoes[category as keyof IShoesType])
        {
            yield shoe;
        }
    }
};

function filterPrice(products: Shoes, minPrice: number, maxPrice: number): void {
    for(let category  in  products.shoes)
    {
        for(let shoe of products.shoes[category as keyof IShoesType])
        {
            if(shoe.price >= minPrice && shoe.price<=maxPrice)
            {
                console.log(shoe.id);
            }
        }
    }
}

console.log('Фильтр по цене');
filterPrice(products, 200, 500);

function filterSize(products: Shoes, Size: number): void {
    for(let category in  products.shoes)
    {
        for(let shoe of products.shoes[category as keyof IShoesType])
        {
            if (shoe.size === Size) {
                console.log(shoe.id);
            }
        }
    }
}

console.log('Фильтр по размеру');
filterSize(products, 37);

function filterColor(products: Shoes, Color: string): void {
    for(let category in  products.shoes)
    {
        for(let shoe of products.shoes[category as keyof IShoesType])
        {
            if (shoe.color === Color) {
                console.log(shoe.id);
            }
        }
    }
}

console.log('Фильтр по цвету');
filterColor(products, 'red');

interface InewShoe{
    id: number;
    size: number;
    color: string;
    price: number;
    discount: number;
    cost: number;
}

interface InewShoesType{
    boots: InewShoe[];
    sneakers: InewShoe[];
    sandals: InewShoe[];
}

interface newShoes{
    shoes: InewShoesType;
}

class NewShoe implements InewShoe {
    constructor(
        public id: number,
        public size: number,
        public color: string,
        public price: number,
        public discount: number
    ) {}

    get cost(): number {
        return this.price - (this.price * this.discount) / 100;
    }
}

const shoe = new NewShoe(111, 39, 'red', 100, 10);
console.log('Цена со скидкой')
console.log(shoe.cost);