
Pod::Spec.new do |s|

  s.name         = "SFModularization"
  s.version      = "1.0.0"
  s.summary      = "模块化框架"

  s.description  = <<-DESC
                    模块化框架，模块间解耦，模块各自处理app生命周期
                   DESC

  s.homepage     = "https://github.com/sofach/SFModularization"

  s.license      = "MIT"

  s.author       = { "sofach" => "sofach@126.com" }

  s.platform     = :ios
  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/sofach/SFModularization.git", :tag => s.version }

  s.source_files  = "SFModularization/lib/**/*.{h,m}"
  s.requires_arc = true

end
