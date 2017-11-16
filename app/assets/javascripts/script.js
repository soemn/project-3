$(function() {
  $("#upload_widget_opener").cloudinary_upload_widget(
    {
      cloud_name: "dnqgbyfhs",
      upload_preset: "qd6agr0o",
      cropping: "server",
      folder: "user_photos",
      sources: ["local", "url", "instagram"],
      button_caption: "Select Image"
    },
    function(error, result) {
      console.log(error, result)
    }
  )

  $('[data-toggle="tooltip"]').tooltip()
})
