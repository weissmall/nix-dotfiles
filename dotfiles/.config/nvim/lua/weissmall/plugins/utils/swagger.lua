return {
  "vinnymeller/swagger-preview.nvim",
  cmd = { "SwaggerPreview", "SwaggerPreviewStop", "SwaggerPreviewToggle" },
  build = "npm i",
  opts = {
    port = 8088,
    host = "localhost",
  },
}
