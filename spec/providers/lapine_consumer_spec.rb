require 'spec_helper'

RSpec.describe 'provider::lapine_consumer' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(step_into: ['lapine_consumer']).converge('test-setup::consumer_provider')
  end

  describe 'create' do
    it 'installs an smf service' do
      expect(chef_run).to install_smf('my-consumer')
    end

    it 'restarts the service' do
      resource = chef_run.lapine_consumer('my-consumer')
      expect(resource).to notify('lapine_consumer[my-consumer]').to(:restart)
    end
  end
end
