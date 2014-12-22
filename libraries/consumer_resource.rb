class Chef
  class Resource
    # Resource for the lapine_consumer Chef provider
    #
    # lapine_consumer 'my-app' do
    #   ...
    # end
    #
    class LapineConsumer < Chef::Resource
      def initialize(name, run_context = nil)
        super
        @resource_name = :lapine_consumer
        @provider = Chef::Provider::LapineConsumer
        @action = :create
        @allowed_actions = [:create, :restart]
      end

      def name(arg = nil)
        set_or_return(:name, arg, kind_of: String)
      end

      def user(arg = nil)
        set_or_return(:user, arg, kind_of: String, required: true)
      end

      def group(arg = nil)
        set_or_return(:group, arg, kind_of: String)
      end

      def project(arg = nil)
        set_or_return(:project, arg, kind_of: String)
      end

      def working_directory(arg = nil)
        set_or_return(:working_directory, arg, kind_of: String, required: true)
      end

      def lapine_config(arg = nil)
        set_or_return(:lapine_config, arg, kind_of: String, required: true)
      end

      def logfile(arg = nil)
        set_or_return(:logfile, arg, kind_of: String, default: '/var/log/lapine.log')
      end

      def rabbit_host(arg = nil)
        set_or_return(:rabbit_host, arg, kind_of: String)
      end

      def rabbit_port(arg = nil)
        set_or_return(:rabbit_port, arg, kind_of: Integer)
      end

      def rabbit_vhost(arg = nil)
        set_or_return(:vhost, arg, kind_of: String)
      end

      def rabbit_username(arg = nil)
        set_or_return(:username, arg, kind_of: String)
      end

      def rabbit_password(arg = nil)
        set_or_return(:password, arg, kind_of: String)
      end

      def dependencies(arg = nil)
        set_or_return(:dependencies, arg, kind_of: Array, default: [])
      end

      def environment(arg = nil)
        set_or_return(:environment, arg, kind_of: Hash)
      end
    end
  end
end
