AppConfig = Figgy.build do |config|
  config.root = Rails.root.join('etc')

  # config.foo is read from etc/foo.yml
  config.define_overlay :default, nil

  # config.foo is then updated with values from etc/production/foo.yml
  config.define_overlay(:environment) { Rails.env }

  # lastly, apply any local overrides (USE WITH CAUTION, FOLKS!)
  config.define_overlay :local, "local"
end
