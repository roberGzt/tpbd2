app.ui.changePassword = (function() {
  function inicializarUI() {
    mostrarMensaje();
  }

  function mostrarMensaje() {
    mensaje.success? toastr.success(mensaje.success) : mensaje.error? toastr.error(mensaje.error) : null;
  }

  return {
    inicializarUI: inicializarUI
  };
})();

$(document).ready(function() {
  app.ui.changePassword.inicializarUI();
});
