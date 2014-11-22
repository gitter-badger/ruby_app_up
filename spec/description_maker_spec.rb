
require 'spec_helper'

require 'ruby_app_up/description_maker'

# Module containing our Gem's logic.
module RubyAppUp
  describe DescriptionMaker do
    it 'responds to :long_description and returns a string' do
      expect(subject).to respond_to :long_description
      expect(subject.long_description).to be_a String
    end
  end # describe RubyAppUp::DescriptionMaker
end # module RubyAppUp
