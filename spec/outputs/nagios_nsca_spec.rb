# encoding: utf-8
require_relative "../spec_helper"

describe LogStash::Outputs::NagiosNsca do

  it "should register without errors" do
    plugin = LogStash::Plugin.lookup("output", "nagios_nsca").new({"nagios_status" => "1"})
    expect { plugin.register }.to_not raise_error
  end

  describe "send" do

    let(:properties) { { "message" => "This is a message!", "nagios_status" => "nagios_status" } }
    let(:event)      { LogStash::Event.new(properties) }


    subject { LogStash::Outputs::NagiosNsca.new({ "nagios_status" => "1" }) }

    before(:each) do
      subject.register
      expect(subject).to receive(:command_file_exist?).and_return(true)
    end

    it "send the event to nagios" do
      expect(subject).to receive(:send_to_nagios).with(subject.cmd, instance_of(String))
      subject.receive(event)
    end
  end

end
