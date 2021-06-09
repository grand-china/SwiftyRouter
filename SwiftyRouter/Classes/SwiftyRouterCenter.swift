
import Foundation

//MARK:- Core
@objc public protocol SwiftyService {
    init()
    
    var routers: [String] { get }
    
    func listen(router: String,
                parameter: Any?,
                complete: ((_ rspData: Any?) -> Void)?)
}


//MARK: Service discovery
extension SwiftyService {
    public  init(register: Bool) {
        self.init()
        if register {
            SwiftyRouterCenter.share.register(service: self)
        }
    }
    
    fileprivate var swiftyServiceId: String {
        return NSUUID().uuidString
    }
    
    public func registedCount() -> Int {
        return SwiftyRouterCenter.share.serviceCount()
    }
}



//MARK:- Service 状态机
/**
 /* Closure is already escaping in optional type argument */
 */
open class SwiftyRouterCenter {
    
    public typealias T = SwiftyService
    
    public static let share = SwiftyRouterCenter()
    private var services: [WeakRef<T>] = []
    
    internal func listen(router: String,
                parameter: Any? = nil,
                complete:((_ responseData: Any?) -> Void)? = nil) {
        let tmp = self.services
        for ref in tmp {
            if ref.value?.routers.contains(router) == true {
                ref.value?.listen(router: router,
                                  parameter: parameter,
                                  complete: complete)
                break
            }
        }
    }
    
    internal func broadcast(router: String,
                            parameter: Any? = nil,
                            complete: ((_ responseData: Any?) -> Void)?) {
        let tmp = self.services
        for ref in tmp {
            if ref.value?.routers.contains(router) == true {
                ref.value?.listen(router: router,
                                  parameter: parameter,
                                  complete: complete)
            }
        }
    }
     
    //MARK:-  Helper
    public func register(service: T) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        let ref = WeakRef<T>(value: service)
        self.services.append(ref)
        /// 一个app 合理的范围
        if self.serviceCount() >= 15 {
            self.compact()
        }
    }
    
    public func remove(service: T) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        self.services.removeAll { ref in
            return ref.value?.swiftyServiceId == service.swiftyServiceId
        }
    }
    
    public func serviceCount() -> Int {
        return self.services.count
    }
    
    func compact() {
        self.services.removeAll { (ref) -> Bool in
            return  ref.value == nil
        }
    }
}
