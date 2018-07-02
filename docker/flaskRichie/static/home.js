function myFunction(){
  var str0 = new String("Press me");
  var str1 = new String("I can see it in your eyes!");
  var str2 = new String("I can see it in your smile!");
  var value = document.getElementById("hello").innerHTML;
  if(value == str0){
    document.getElementById("hello").innerHTML = str1;
    document.getElementById("theimage").src="/static/images/lionelwink.jpg";
  }
  if(value == str1){
    document.getElementById("theimage").src="/static/images/lioneltounge.jpg";
    document.getElementById("hello").innerHTML = str2;
  }
  if(value == str2) {
    document.getElementById("theimage").src="/static/images/lionel.jpg";
    document.getElementById("hello").innerHTML = str0;
  }
}

function myFunction2(){
  alert('No function here.');
}
