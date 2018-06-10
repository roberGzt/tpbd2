app.ui.pelisVistas = (function() {
  function inicializarUI () {
    listarPelisQueVieron();
  }

  function listarPelisQueVieron() {
    app.service.pelisVistas()
      .done(function (data){
        $('#content').html(data);
        console.log("Carga de Listado de peliculas: OK");
      })
      .fail(function (){
        console.log("Carga de Listado de peliculas: FALLO");
      });
  }

  return {
    inicializarUI: inicializarUI
  };
})();

$(document).ready(function() {
 app.ui.pelisVistas.inicializarUI();
});
