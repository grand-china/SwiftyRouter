# SwiftyRouterPlus

## Purpose
Module decoupling


## Example


### 1. define  your service

```swift
class DemoSeveice: SwiftyService {
    
    required init() {}
    
    var routers: [String] {
        return [ "path/user/info"]
    }
    
    func listen(router: String, parameter: Any?, complete: ((Any?) -> Void)?) {
        if router == "path/user/info" {
            complete?("rsp>info")
        }
    }
}
```

### 2. use it

```swift

 override func viewDidLoad() {
        super.viewDidLoad()
        self.service = DemoSeveice(register: true)
}

```

### 3. access service

```swift

func doSomething() {
	requestService("path/user/info", parameter: "uid") { [weak self] rspData in
		print(rspData)
	}
}

```



## Requirements

```
  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'
```

## Installation

SwiftyRouter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftyRouterPlus'
```

## Author

TopMan

## License

SwiftyRouter is available under the MIT license. See the LICENSE file for more info.
