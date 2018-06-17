app.service.pelisVistas = (function() {
  function listarPelisQueVieron() {
    return $.ajax({
      url: "./php/controlador/listarPelisQueVieronController.php"
    });
  }

  function listarMisPeliculas() {
    return $.ajax({
      url: "./php/controlador/listarMisPeliculasController.php"
    });
  }

  return {
    listarPelisQueVieron: listarPelisQueVieron,
    listarMisPeliculas: listarMisPeliculas
  };
})();
