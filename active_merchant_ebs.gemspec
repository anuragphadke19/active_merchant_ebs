# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "active_merchant_ebs/version"

Gem::Specification.new do |s|
  s.name        = "active_merchant_ebs"
  s.version     = ActiveMerchantEbs::VERSION
  s.authors     = ["Anurag Phadke"]
  s.email       = ["anuragphadke19@gmail.com"]
  s.homepage    = ""
  s.summary     = "Active merchant integration for EBS Payment Gateway from India"
  s.description = "Active merchant integration for EBS Payment Gateway from India"

  s.rubyforge_project = "active_merchant_ebs"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
