app.ui.utils = (function() {
  function initUtils() {
    toastr.options = {
      closeButton: false,
      debug: false,
      newestOnTop: false,
      progressBar: false,
      positionClass: "toast-top-center",
      preventDuplicates: false,
      onclick: null,
      showDuration: "300",
      hideDuration: "300",
      timeOut: "2500",
      showEasing: "swing",
      hideEasing: "linear",
      showMethod: "fadeIn",
      hideMethod: "fadeOut"
    };
  }

  return {
    initUtils: initUtils
  };
})();
