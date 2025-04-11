let form = document.forms[0]
let LastNameElem = form.elements.LastName
let NameElem = form.elements.nameVal
let TelElem = form.elements.telVal
let AboutElem = form.elements.about
let cityElem = form.elements.select
let courseValue = form.elements.course
let belstu = form.elements.checkBelstu
//фамилия
LastNameElem.onblur = function () {
    if (LastNameElem.value.length > 20) {
        LastNameElem.classList.add('invalid');
        LastNameError.innerHTML = 'Поле не должно содержать более 20 символов.'
    }
    if (!LastNameElem.value) {
        LastNameElem.classList.add('invalid');
        LastNameError.innerHTML = 'Поле не должно быть пустым!'
    }
    else if (/^[A-Za-zа-яА-Я]+$/.test(LastNameElem.value) != true) {
        LastNameElem.classList.add('invalid');
        LastNameError.innerHTML = 'Поле должно содержать только символы русского и английского алфавита'
    }
}
LastNameElem.onfocus = function () {
    if (this.classList.contains('invalid')) {
        this.classList.remove('invalid');
        LastNameError.innerHTML = "";
    }
};
//имя
NameElem.onblur = function () {
    if (NameElem.value.length > 20) {
        NameElem.classList.add('invalid');
        nameError.innerHTML = 'Поле не должно содержать более 20 символов.'
    }
    if (!NameElem.value) {
        NameElem.classList.add('invalid');
        nameError.innerHTML = 'Поле не должно быть пустым!'
    }
    else if (/^[A-Za-zа-яА-Я]+$/.test(NameElem.value) != true) {
        NameElem.classList.add('invalid');
        nameError.innerHTML = 'Поле должно содержать только символы русского и английского алфавита'
    }
}
NameElem.onfocus = function () {
    if (this.classList.contains('invalid')) {
        this.classList.remove('invalid');
        nameError.innerHTML = "";
    }
};
//email
Email.onblur = function () {
    if (!Email.value.includes('@')) {
        Email.classList.add('invalid');
        error.innerHTML = 'Пожалуйста, введите правильный email.'
    }
    if (!Email.value) {
        Email.classList.add('invalid');
        error.innerHTML = 'Поле не должно быть пустым'
    }
    else if (/^[^\s]+@[a-zA-Z]{2,5}\.[a-zA-Z]{2,3}$/.test(Email.value) != true) {
        Email.classList.add('invalid');
        error.innerHTML = 'Недопустимый формат!'
    }
};
Email.onfocus = function () {
    if (this.classList.contains('invalid')) {
        this.classList.remove('invalid');
        error.innerHTML = "";
    }
};
//phone
TelElem.onblur = function () {
    if (!TelElem.value) {
        TelElem.classList.add('invalid');
        telError.innerHTML = 'Поле не должно быть пустым!'
    }
    else if (/^\(0\d{2}\)\d{3}-\d{2}-\d{2}$/.test(TelElem.value != true)) {
        TelElem.classList.add('invalid');
        telError.innerHTML = 'Недопустимый формат!'
    }
};
TelElem.onfocus = function () {
    if (this.classList.contains('invalid')) {
        this.classList.remove('invalid');
        telError.innerHTML = "";
    }
};
//о себе
AboutElem.onblur = function () {
    if (!AboutElem.value) {
        AboutElem.classList.add('invalid');
        aboutError.innerHTML = 'Поле не должно быть пустым!'
    }
    if (AboutElem.value.length > 250) {
        AboutElem.classList.add('invalid');
        aboutError.innerHTML = 'Поле не должно содержать более 250 символов.'
    }
};
AboutElem.onfocus = function () {
    if (this.classList.contains('invalid')) {
        this.classList.remove('invalid');
        aboutError.innerHTML = "";
    }
};

var submitButton = document.querySelector("input[type=submit]");

submitButton.addEventListener("click", function(event) {
    event.preventDefault();
    if (cityElem.value != 'Минск' || courseValue.value != '3' || !belstu.checked)
    {
        var confired=confirm("Вы уверены ?");
    if(!confired)
    {
        event.preventDefault();
    }
    else{
        form.submit();
    }
    }
    else{
        form.submit();
    }
});
