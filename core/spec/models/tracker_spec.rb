require 'spec_helper'

describe Tracker do

  context "validations" do
    it { should have_valid_factory(:tracker) }
  end

end
