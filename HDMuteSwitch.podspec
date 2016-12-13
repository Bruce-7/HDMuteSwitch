
Pod::Spec.new do |s|
  s.name         = "HDMuteSwitch"
  s.version      = "1.0.0"
  s.summary      = "relatively straightforward to detect whether a device was muted by using an audio route to detect playback type. "
  s.homepage     = "https://github.com/Bruce-7/HDMuteSwitch.git"
  s.license      = "MIT"
  s.author       = { "HeDong" => "hedong7777777@gmail.com" }
  s.source       = { :git => "https://github.com/Bruce-7/HDMuteSwitch.git", :tag => s.version }
  s.platform     = :ios, "7.0"
  s.requires_arc = true
  s.source_files = "HDMuteSwitch"
  s.framework = "AudioToolbox"
end