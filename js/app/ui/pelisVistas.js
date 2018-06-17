app.ui.pelisVistas = (function() {
  function inicializarUI() {
    app.ui.utils.initUtils();
    listarPelisQueVieron();
    listarMisPeliculas();
  }

  function listarPelisQueVieron() {
    app.service.pelisVistas
      .listarPelisQueVieron()
      .done(function(data) {
        $("#mismas-peliculas-content").html(data);
        console.log("Carga de Listado de peliculas: OK");
        console.log("recibido: " + data);
      })
      .fail(function() {
        console.log("Carga de Listado de peliculas: FALLO");
      });
  }

  function listarMisPeliculas() {
    app.service.pelisVistas
      .listarMisPeliculas()
      .done(function(data) {
        $("#mis-peliculas-content").html(data);
        console.log("Carga de Listado de peliculas del usuario: OK");
        console.log("recibido: " + data);
      })
      .fail(function() {
        console.log("Carga de Listado de peliculas del usuario: FALLO");
      });
  }

  return {
    inicializarUI: inicializarUI
  };
})();

$(document).ready(function() {
  app.ui.pelisVistas.inicializarUI();
});
