// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function showUsers() {
  c = document.getElementsByClassName('collaborator-form');
  if(c[0].style.display === "initial" || c[0].style.display === "") {
    c[0].style.display = "none";
  }else{
    c[0].style.display = "initial";
  }
}
