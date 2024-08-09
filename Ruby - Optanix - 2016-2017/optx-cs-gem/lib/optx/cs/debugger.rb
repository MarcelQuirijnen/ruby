# Should be/will be replaced by OPRIT-23 (create log lib)
class Optx::Cs::Debugger
  # @param [Hash] debug options
  # @option :level (0) the debug level
  # @option :file ('') file to write debug string to, opened in append mode
  # @example Optx::Cs::Debugger.new(:level => 7, :file => 'mydebugfile.txt')
  # @example Optx::Cs::Debugger.new(:file => 'mydebugfile.txt')
  # @return nothing

  attr_accessor :level, :file

  def initialize(params = {})
    @level = params.fetch(:level, 0)
    @file = params.fetch(:file, '')
  end

  def to_s
    "#{level} #{file}"
  end

  def debug(msg)
    File.open("#{@file}", 'a') { |f| f.write("[#{Time.now}][Optx-CS][#{msg}]\n") }
  end
end