require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NihonLink
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }

    config.after_initialize do
      guest_user = User.find_or_create_by(email: 'guest@example.com')

      guest_user.posts.each { |post| post.destroy } if guest_user.posts.any?
      guest_user.comments.each { |comment| comment.destroy } if guest_user.comments.any?
    end
  end
end


