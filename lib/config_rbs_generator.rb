# frozen_string_literal: true

require_relative 'config_rbs_generator/version'
require_relative '../config/initializers/config'

module ConfigRbsGenerator
  def self.run
    outputs = Outputs.new

    Settings.each do |setting|
      outputs.add_method_definition(setting)
    end

    outputs.finalize
    outputs.text
  end

  class Outputs
    attr_reader :text

    def initialize
      @text = "class #{Config.const_name}\n"
    end

    def add_method_definition(setting)
      @text += "  def #{setting[0]}: () -> #{setting[1].class}\n"
    end

    def finalize
      @text += "end\n"
    end
  end

  class Error < StandardError; end
end
