Pod::Spec.new do |s|
  s.name         = "NSString+Decimal"
  s.version      = "1.0.0"
  s.summary      = "A NSString category that provides decimal arithmetic support for NSString."
  s.description  = <<-DESC
  NSString+Decimal is a NSString category that provides decimal arithmetic support for NSString.
  You can:
    1. Use strings to do decimal arithmetic;
    2. Format strings into currency format.
                   DESC
  s.homepage     = "https://github.com/zzd258147/NSString-Decimal"
  s.license      = "MIT"
  s.author       = "zzd258147"
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/zzd258147/NSString-Decimal.git", :tag => "#{s.version}" }
  s.source_files = "src/*.{h,m}"
  s.requires_arc = true
end
