# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

# vendor/assets サードパーティー製アセットのパス定義
Rails.application.config.assets.paths << Rails.root.join("vendor/css")
Rails.application.config.assets.paths << Rails.root.join("vendor/jquery")
Rails.application.config.assets.paths << Rails.root.join("vendor/jquery-easing")
Rails.application.config.assets.paths << Rails.root.join("vendor/js")
Rails.application.config.assets.paths << Rails.root.join("vendor/datatables")
# ファイル指定
Rails.application.config.assets.precompile += [
  'sb-admin-2.min.css',
  'jquery.min.js',
  'jquery.easing.min.js',
  'sb-admin-2.min.js',
  'dataTables.bootstrap4.min.css',
  'jquery.dataTables.min.js',
  'dataTables.bootstrap4.min.js',
  'datatables-demo.js'
]
