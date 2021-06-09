
import Foundation

/// 向第一个特定路由, 请求服务
public func requestService(_ router: String,
                           parameter: Any? = nil,
                           complete: ((_ rspData: Any?) -> Void)? = nil) {
    
    SwiftyRouterCenter.share.listen(router: router,
                              parameter: parameter,
                              complete: complete)
}

/// 向所有特定路由, 广播服务
public func broadcastService(_ router: String,
                             parameter: Any? = nil,
                             complete: ((_ responseData: Any?) -> Void)? = nil) {
    
    SwiftyRouterCenter.share.broadcast(router: router,
                                 parameter: parameter,
                                 complete: complete)
}
