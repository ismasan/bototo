# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bototo/version"

Gem::Specification.new do |s|
  s.name        = "bototo"
  s.version     = Bototo::VERSION
  s.authors     = ["Ismael Celis"]
  s.email       = ["ismaelct@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Eventmachine-based DSL for creating Campfire bots}
  s.description = %q{Eventmachine-based DSL for creating Campfire bots}

  s.rubyforge_project = "bototo"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_runtime_dependency "multi_json"
  s.add_runtime_dependency "firering"
end
