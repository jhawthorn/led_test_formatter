require 'spec_helper'

RSpec.describe "bogus" do
  200.times do
    it "doesn't do shit" do
      sleep 0.02
    end
  end

  if ENV['FAIL']
    it "fails" do
      raise "yolo"
    end
  end
end
