$(document).ready(function() {
  $.ajax({
    url: "./app/controlador/listarPelisQueVieronController.php",
    success: function(result) {
      document.getElementById("content").innerHTML = result;
    }
  });
});
