var birthday = new Date(1985, 8, 28, 04, 00);
var age = Math.floor((Date.now() - birthday) / (31557600000));
document.getElementById('age').innerHTML = age;
