class Chef
  class Provider
    # Provider for the lapine_consumer Chef provider
    #
    # lapine_consumer 'my-app' do
    #   ...
    # end
    #
    class LapineConsumer < Chef::Provider::LWRPBase
      def load_current_resource
        @current_resource ||= new_resource.class.new(new_resource.name)
      end

      def action_create
        install_service
      end

      def action_restart
        new_resource.notifies_immediately(:restart, service_resource)
        new_resource.updated_by_last_action(true)
      end

      private

      def install_service
        start_command = service_command
        smf_config = service_config
        smf_service = smf(new_resource.name) do
          user new_resource.user
          group new_resource.group if new_resource.group
          project new_resource.project if new_resource.project
          start_command start_command
          start_timeout 60
          stop_timeout 30
          working_directory new_resource.working_directory

          property_groups 'config' => smf_config

          dependencies(new_resource.dependencies) unless new_resource.dependencies.empty?
          environment(new_resource.environment) if new_resource.environment
        end

        new_resource.updated_by_last_action(true) if smf_service.updated_by_last_action?
      end

      def service_resource
        begin
          run_context.resource_collection.find(service: new_resource.name)
        rescue Chef::Exceptions::ResourceNotFound
          service new_resource.name do
            supports restart: true, status: true, reload: true
          end
        end
      end

      def service_command
        %w(bundle exec lapine consume --config %{config/yaml_file}).tap do |command|
          command << '--logfile %{config/logfile}' if new_resource.logfile
          command << '--host %{config/rabbit_host}' if new_resource.rabbit_host
          command << '--port %{config/rabbit_port}' if new_resource.rabbit_port
          command << '--vhost %{config/vhost}' if new_resource.rabbit_vhost
          command << '--username %{config/username}' if new_resource.rabbit_username
          command << '--password %{config/password}' if new_resource.rabbit_password
          command << '--debug &'
        end.join(' ')
      end

      def service_config
        {}.tap do |config|
          config.merge!('logfile' => new_resource.logfile) if new_resource.logfile
          config.merge!('rabbit_host' => new_resource.rabbit_host) if new_resource.rabbit_host
          config.merge!('rabbit_port' => new_resource.rabbit_port) if new_resource.rabbit_port
          config.merge!('yaml_file' => new_resource.lapine_config) if new_resource.lapine_config
          config.merge!('vhost' => new_resource.rabbit_vhost) if new_resource.rabbit_vhost
          config.merge!('username' => new_resource.rabbit_username) if new_resource.rabbit_username
          config.merge!('password' => new_resource.rabbit_password) if new_resource.rabbit_password
        end
      end
    end
  end
end
