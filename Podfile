use_frameworks!

target 'AnimationComparison' do
  pod "Macaw", :git => "https://github.com/exyte/Macaw.git"  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
