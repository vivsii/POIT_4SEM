let form = document.forms[0]
let heightNapValue = form.elements.heightNap
let weightNapValue = form.elements.weightNap
let resultValue = document.getElementById('result')
let diametrValue = form.elements.diametr
let saveValue = form.elements.save
let naperst1 = document.getElementById('layer1')
let naperst2 = document.getElementById('layer2')
let naperst3 = document.getElementById('layer3')
let Ball = document.getElementById('layer4')
let Right = document.getElementById('right')
let NotRight = document.getElementById('notRight')
let Update = document.getElementById('update')

function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min)) + min;
}

// Обработчик события для кнопки сброса
Update.addEventListener("click", function(event) {
    event.preventDefault();
    resultValue.value = 0
    NotRight.style.color= "white";
    Right.style.color= "white"  
});
saveValue.addEventListener("click", function(event) {
    NotRight.style.color= "white";
    Right.style.color= "white"  

    let saveClicked = false
    event.preventDefault();
    let a = getRandomInt(1, 4)
    if (a == 1)
    {
        Ball.style.left = 3 + "em"
    }
    else if(a == 2){
        Ball.style.left = 15.5 + "em"
    }
    else if(a == 3){
        Ball.style.left = 28 + "em"
    }
    let naperstClicked = false;
    if(!saveClicked){
        naperst1.addEventListener("click", function(event) {
            event.preventDefault();
            if(!naperstClicked){
                naperst1.style.top = -200 + "px"
                setTimeout(function() {
                naperst1.style.top = 0 + 'px';
                }, 2000);
                if(a == 1){
                    resultValue.value++
                    Right.style.color= "red";
                    NotRight.style.color= "white";
                }
                else{
                    resultValue.value--
                    NotRight.style.color= "red";
                    Right.style.color= "white" 
                }
                naperstClicked = true;
                saveClicked = true;
            }
        });
    }
    if(!saveClicked){
        naperst2.addEventListener("click", function(event) {
        event.preventDefault();
            if(!naperstClicked){
                naperst2.style.top = -200 + "px"
                setTimeout(function() {
                    naperst2.style.top = 0 + 'px';
                }, 2000);
                if(a == 2){
                    resultValue.value++
                    Right.style.color= "red";
                    NotRight.style.color= "white"; 
                }
                else{
                    resultValue.value--
                    NotRight.style.color= "red";
                    Right.style.color= "white"  
                }
                naperstClicked = true;
                saveClicked = true;
            }
        });
    }
    if(!saveClicked){
        naperst3.addEventListener("click", function(event) {
            event.preventDefault();
            if(!naperstClicked){
                naperst3.style.top = -200 + "px"
                setTimeout(function() {
                    naperst3.style.top = 0 + 'px';
                }, 2000);
                if(a == 3){
                    resultValue.value++
                    Right.style.color= "red";
                    NotRight.style.color= "white";
                }
                else{
                    resultValue.value--
                    Right.style.color= "white"  
                    NotRight.style.color= "red";
                }
                naperstClicked = true;
                saveClicked = true;
            }
        });
    }
});

weightNapValue.addEventListener('input', function() {
    let newWidth = weightNapValue.value;

    naperst1.style.width = newWidth + 'px';
    naperst2.style.width = newWidth + 'px';
    naperst3.style.width = newWidth + 'px';
});

heightNapValue.addEventListener('input', function() {
    let newHeight = heightNapValue.value;

    naperst1.style.height = newHeight + 'px';
    naperst2.style.height = newHeight + 'px';
    naperst3.style.height = newHeight + 'px';
});

diametrValue.addEventListener('input', function() {
    let newDiametr = diametrValue.value;
    Ball.style.width = newDiametr + 'px';
});
