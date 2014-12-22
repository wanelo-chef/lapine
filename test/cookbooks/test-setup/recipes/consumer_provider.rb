include_recipe 'lapine'

lapine_consumer 'my-consumer' do
  user 'blah'
  lapine_config '/path/to/config.yml'
  working_directory '/path/to/dir'
  notifies :restart, 'lapine_consumer[my-consumer]'
end
