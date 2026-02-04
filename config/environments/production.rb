require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot for better performance.
  config.eager_load = true

  # Full error reports are disabled.
  config.consider_all_requests_local = false

  # Enable caching.
  config.action_controller.perform_caching = true

  # Cache assets for far-future expiry.
  config.public_file_server.headers = {
    "cache-control" => "public, max-age=#{1.year.to_i}"
  }

  # Active Storage
  config.active_storage.service = :local

  # Logging
  config.log_tags = [:request_id]
  config.logger   = ActiveSupport::TaggedLogging.logger(STDOUT)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Silence health check logs
  config.silence_healthcheck_path = "/up"

  # Disable deprecation logs
  config.active_support.report_deprecations = false

  # =========================
  # Cache / Job（Render向け）
  # =========================

  # シンプルなメモリキャッシュ
  config.cache_store = :memory_store

  # DB不要の非同期ジョブ
  config.active_job.queue_adapter = :async

  # =========================
  # Mailer
  # =========================
  config.action_mailer.default_url_options = {
    host: ENV.fetch("APP_HOST", "jukumane-app.onrender.com")
  }

  # I18n
  config.i18n.fallbacks = true

  # DB schema
  config.active_record.dump_schema_after_migration = false
  config.active_record.attributes_for_inspect = [:id]
end