Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_fbtab_views'
  s.version     = '0.0.1'
  s.summary     = 'Adds support of Facebook Tab to Spree stores'
  s.description = 'Works through jQuery Mobile'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'David Li'
  s.email             = 'taweili@yahoo.com'
  s.homepage          = 'https://github.com/taweili/spree_fbtab_views'
  # s.rubyforge_project = 'actionmailer'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency('spree_core', '>= 0.50.0')
end
