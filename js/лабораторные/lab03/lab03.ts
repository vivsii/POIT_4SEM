let arrayOfNumb: number[] = [1, 2, 3, 4, 5, 6, 7 , 8, 9, 0];

function createPhoneNumber(numbers: number[]){
    let inBrackets = numbers.slice(0, 3).join('');
    let firstPart = numbers.slice(3, 6).join('');
    let secondPart = numbers.slice(6).join('');

    return `(${inBrackets})${firstPart}-${secondPart}`;
}

console.log(createPhoneNumber(arrayOfNumb));

class Challenge{
    static solution(number:number){
        if (number <= 0) {
            return 0;
        }

        let sum = 0;
        for (let i = 3; i < number; i++) {
            if (i % 3 === 0 || i % 5 === 0) {
                sum += i;
            }
        }
        return sum;
    }
}

console.log(Challenge.solution(20));

let nums: number[] = [1, 2, 3, 4, 5, 6, 7];
let k = 3;
function newArray(array: number[], a: number){
    let firstPart = array.slice(-a);
    let secondPart = array. slice(0, -a);
    return `${firstPart},${secondPart}`;
}
console.log(newArray(nums,k));

let nums1: number[] = [1, 2];
let nums2: number[] = [3, 4, 5, 6];
function findMedian(array1: number[], array2: number[]){
    let mediana: number;
    let array3: number[];
    array3 = array1.concat(array2);
    let middle = Math.floor(array3.length / 2);
    if (array3.length % 2 === 0){
        mediana = (array3[middle + 1] + array3[middle])/2
        return mediana
    }
    else{
        mediana = array3[middle]
        return mediana
    }
}
console.log(findMedian(nums1,nums2))