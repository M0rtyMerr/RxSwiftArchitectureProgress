platform :ios, '12.0'

target 'RxSwiftArchitectureProgress' do
  use_frameworks!
  
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxSwiftExt'
  pod 'RxDataSources'
  pod 'ReactorKit'
  pod 'Reusable'
  pod 'Then'
  pod 'SwiftLint'

  target 'RxSwiftArchitectureProgressTests' do
    inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
    pod 'RxTest'
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'RxSwift'
      target.build_configurations.each do |config|
        if config.name == 'Debug'
          config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
        end
      end
    end
  end
end