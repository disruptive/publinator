class PublishableGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  argument :class_name, :type => :string, :default => "article"

  def create_publishable_initializer
    # create file for class
    template "app/models/publishable_class.rb.erb", "app/models/publinator/#{file_name}.rb.erb"
    
    # create migration
    # 
  end
end
