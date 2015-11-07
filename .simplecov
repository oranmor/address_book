SimpleCov.start do
  add_filter 'Rakefile'
  add_filter '/spec/'
  add_filter '/config/'

  add_group 'Models', 'app/models'
  add_group 'Controllers', 'app/controllers'
  add_group 'Helpers', 'app/helpers'
  add_group 'Mailers', 'app/mailers'
  add_group 'Libraries', 'lib'
  add_group 'Long files' do |src_file|
    src_file.lines.count > 100
  end
end
