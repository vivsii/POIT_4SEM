let myPromise = new Promise(function(resolve,reject){
    setTimeout(() => resolve(console.log(Math.floor(Math.random() * (100 - 1 + 1)) + 1)), 3000)
})

function newFunction(delay) {
    return new Promise(function(resolve, reject) {
        setTimeout(() => {
            let randomNumber = Math.floor(Math.random() * (100 - 1 + 1)) + 1;
            resolve(randomNumber);
        }, delay);
    });
}

let promices = [newFunction(3000),newFunction(3000),newFunction(3000)]
Promise.all(promices).then(numbers => {console.log(numbers);
})

let pr = new Promise((res,rej) => {
    console.log('ku')
    rej('ku')
})

pr
    .then(() => console.log(1))
    .catch(() => console.log(2))
    .catch(() => console.log(3))
    .then(() => console.log(4))
    .then(() => console.log(5))

let promise =  new Promise(function(resolve, reject) {
    setTimeout(() => resolve(21), 1000); 
}).then(function(result) { 
    console.log(result); 
    return result * 2;
}).then(function(result) { 
    console.log(result);
})

async function f(){

    let promise =  new Promise(function(resolve, reject) {
        setTimeout(() => resolve(21), 1000); 
    })
    let result = await promise;
    console.log(result)
    result = result * 2
    console.log(result)
}
  
f();