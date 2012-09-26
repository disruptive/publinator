class PublishableGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  argument :class_name, :type => :string, :default => "article"

  def create_publishable_initializer
    # create file for class
    template "app/models/publishable_model.rb.erb", "app/models/#{file_name}.rb"
    
    # create migration
    template "app/models/publishable_migration.rb.erb", "db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S").to_i}_create_#{class_name.pluralize}.rb"
  end
end
