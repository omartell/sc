require 'rubygems'
require 'aruba'
require 'aruba/in_process'
require 'vcr'
require 'aruba/cucumber'
require_relative '../../lib/sc'

class ArubaFriendlyMain
  def initialize(argv, stdin, stdout, stderr, kernel)
    @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
  end

  def execute!
    $stdin = @stdin
    $stdout = @stdout
    Sc::Main.run(@argv)
  end
end

Aruba::InProcess.main_class = ArubaFriendlyMain
Aruba.process = Aruba::InProcess