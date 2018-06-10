app.service.pelisVistas = (function() {
  function listarPelisQueVieron() {
    return $.ajax({
      url: "./app/controlador/listarPelisQueVieronController.php"
    });
  }

  return {
    listarPelisQueVieron: listarPelisQueVieron
  };
})();
