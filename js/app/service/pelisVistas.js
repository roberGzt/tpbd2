app.service.pelisVistas = (function() {
  function listarPelisQueVieron() {
    return $.ajax({
      url: "./php/controlador/listarPelisQueVieronController.php"
    });
  }

  return {
    listarPelisQueVieron: listarPelisQueVieron
  };
})();
