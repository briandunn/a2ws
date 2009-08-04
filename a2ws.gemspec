# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{a2ws}
  s.version = "0.1.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andy Shen", "Josh Owens"]
  s.date = %q{2009-08-04}
  s.email = %q{brianpatrickdunn@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION.yml",
     "a2ws.gemspec",
     "lib/a2ws.rb",
     "lib/a2ws/base.rb",
     "lib/a2ws/image.rb",
     "lib/a2ws/image_search.rb",
     "lib/a2ws/item.rb",
     "lib/a2ws/item_search.rb",
     "lib/a2ws/methodize.rb",
     "lib/a2ws/signature.rb",
     "spec/a2ws_live_spec.rb",
     "spec/a2ws_spec.rb",
     "spec/fixtures/empty_response.yml",
     "spec/fixtures/single_item_response.yml",
     "spec/spec_helper.rb",
     "test/a2ws_test.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/handcrafted/a2ws}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Wrapper for Amazon Associates Web Service (A2WS).}
  s.test_files = [
    "spec/a2ws_live_spec.rb",
     "spec/a2ws_spec.rb",
     "spec/spec_helper.rb",
     "test/a2ws_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0.4.3"])
      s.add_runtime_dependency(%q<activesupport>, [">= 2.2.2"])
      s.add_runtime_dependency(%q<ruby-hmac>, [">= 0"])
    else
      s.add_dependency(%q<httparty>, [">= 0.4.3"])
      s.add_dependency(%q<activesupport>, [">= 2.2.2"])
      s.add_dependency(%q<ruby-hmac>, [">= 0"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0.4.3"])
    s.add_dependency(%q<activesupport>, [">= 2.2.2"])
    s.add_dependency(%q<ruby-hmac>, [">= 0"])
  end
end
