require 'spec_helper'
require 'colorize'

describe RubyAppUp do
  it 'has a version number' do
    expect(RubyAppUp::VERSION).not_to be nil
  end

  it 'does nothing useful yet' do
    puts '***** FIXME!'.light_red + ' Add specs!'
    expect(true).to eq(true)
  end
end
