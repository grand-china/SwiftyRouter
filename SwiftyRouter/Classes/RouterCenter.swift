
import Foundation

func RequestService(router: String,
                    requestData: Any? = nil,
                    responseComplete: ((_ responseData: Any?) -> Void)? = nil) {
    
    RouterCenter.share.listen(router: router,
                                 requestData: requestData,
                                 responseComplete: responseComplete)
}

func BroadcastService(router: String,
                      requestData: Any? = nil,
                      responseComplete: ((_ responseData: Any?) -> Void)? = nil) {
    
    RouterCenter.share.listen(router: router,
                                 requestData: requestData,
                                 responseComplete: responseComplete)
}


//MARK:- Core
protocol ServiceInterface {
    var router: [String] { get }
    
    func listen(router: String,
                requestData: Any?,
                responseComplete: ((_ responseData: Any?) -> Void)?
    )
    
    /// Note:
    init()
}

//MARK:- Service discovery
extension ServiceInterface {
    init(register: Bool) {
        self.init()
        if register {
            RouterCenter.share.register(service: self)
        }
    }
}

//MARK:- Extend
extension ServiceInterface {
    func registedCount() -> Int {
        return RouterCenter.share.serviceCount()
    }
}

//MARK:- Service 状态机
/**
 /* Closure is already escaping in optional type argument */
 */
fileprivate final class RouterCenter {
    
    typealias T = ServiceInterface
    
    static let share = RouterCenter()
    var services: [WeakRef<T>] = []
    
    func register(service: T) {
        let ref = WeakRef<T>(value: service)
        self.services.append(ref)
        /// 一个app 合理的范围
        if self.services.count >= 15 {
            self.compact()
        }
    }
    
    func listen(router: String,
                requestData: Any? = nil,
                responseComplete:((_ responseData: Any?) -> Void)? = nil
    ) {
        for ref in self.services {
            if ref.value?.router.contains(router) == true {
                ref.value?.listen(router: router,
                                  requestData: requestData,
                                  responseComplete: responseComplete)
                break
            }
        }
    }
    
    func broadcast(router: String,
                   requestData: Any? = nil,
                   responseComplete: ((_ responseData: Any?) -> Void)?
    ) {
        for ref in self.services {
            if ref.value?.router.contains(router) == true {
                
                ref.value?.listen(router: router,
                                  requestData: requestData,
                                  responseComplete: responseComplete)
            }
        }
    }
    
    public func serviceCount() -> Int {
        return self.services.count
    }
    
    //MARK:-  Helper
    func compact() {
        self.services.removeAll { (ref) -> Bool in
            return  ref.value == nil
        }
    }
}
