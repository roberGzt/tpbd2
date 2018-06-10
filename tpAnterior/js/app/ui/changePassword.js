app.ui.changePassword = (function() {
  function inicializarUI() {
    mostrarMensaje();
  }

  function mostrarMensaje() {
    toastr.options = {
      "closeButton": false,
      "debug": false,
      "newestOnTop": false,
      "progressBar": false,
      "positionClass": "toast-top-center",
      "preventDuplicates": false,
      "onclick": null,
      "showDuration": "300",
      "hideDuration": "1000",
      "timeOut": "5000",
      "extendedTimeOut": "1000",
      "showEasing": "swing",
      "hideEasing": "linear",
      "showMethod": "fadeIn",
      "hideMethod": "fadeOut"
    };
    mensaje.success? toastr.success(mensaje.success) : mensaje.error? toastr.error(mensaje.error) : null;
  }

  return {
    inicializarUI: inicializarUI
  };
})();

$(document).ready(function() {
  app.ui.changePassword.inicializarUI();
});
