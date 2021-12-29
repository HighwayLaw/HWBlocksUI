Pod::Spec.new do |spec|

  spec.name         = "HWBlocksUI"
  spec.version      = "0.0.3"
  spec.summary      = "optimize UIKit such as UITableview, UIButton, UITextField, UISwitch with Blocks to make it easier to write"

  spec.description  = <<-DESC
  HWBlocksUI对UITableView，UITextField，UIButton，UISwitch等常用的UIKit类进行了扩展，将之前需要Delegate或target+selector回调的方式改成了Block。大部分情况下，使用Block更加有优势，具体体现在：
（1）代码紧凑，无需声明协议，可以将相关代码逻辑集中在一起，降低开发调试成本；
（2）允许访问上下文变量，无需再专门抽出实例变量供不同代理方法共享。
                   DESC

  spec.homepage     = "https://github.com/HighwayLaw/HWBlocksUI"

  spec.license      = "MIT"
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "HighwayLaw" => "495255019@qq.com" }

  spec.platform     = :ios
  spec.platform     = :ios, "9.0"

  spec.source       = { :git => "https://github.com/HighwayLaw/HWBlocksUI.git", :tag => "#{spec.version}" }

  spec.source_files  = "HWBlocksUI", "HWBlocksUI/**/*.{h,m}"

  spec.public_header_files = "HWBlocksUI/**/*.h"

  spec.frameworks = "Foundation", "UIKit"

end
