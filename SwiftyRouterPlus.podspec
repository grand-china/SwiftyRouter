Pod::Spec.new do |s|
    
    s.name = 'SwiftyRouterPlus'
    s.version = '1.0.2'
    s.license = 'MIT'
    s.summary = 'Swift Module Router Center'
    s.homepage = 'https://github.com/grand-china/SwiftyRouter'
    s.authors = { 'TopMan' => 'gychaobest@foxmail.com' }
    s.source = { :git => 'https://github.com/grand-china/SwiftyRouter.git', :tag => s.version }
    s.requires_arc = true
    
    s.ios.deployment_target = '10.0'
    s.osx.deployment_target = '10.12'
    s.tvos.deployment_target = '10.0'
    s.watchos.deployment_target = '3.0'
    
    s.swift_versions = ['5.1', '5.2']
    
    s.source_files = 'SwiftyRouter/Classes/**/*'
    
end
