import  Foundation
import UIKit



class ImageLoader {
    
    var cache = NSCache<AnyObject, AnyObject>()
    
    class var sharedLoader : ImageLoader {
        struct Static {
            static let instance : ImageLoader = ImageLoader()
        }
        return Static.instance
    }
    
    func imageForUrl(urlString: String, completionHandler:@escaping (_ image: UIImage?, _ url: String) -> ()) {
        DispatchQueue.global(priority:DispatchQueue.GlobalQueuePriority.default).async(execute: {()in
            var data: NSData? = self.cache.object(forKey: urlString as AnyObject) as? NSData
            
            if let goodData = data {
                let image = UIImage(data: goodData as Data)
                DispatchQueue.main.async(execute: {() in
                    completionHandler(image, urlString)
                })
                return
            }
            
            var downloadTask: URLSessionDataTask = URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: {(data: Data!, response: URLResponse!, error: Error?) -> Void in
                //if (error != nil) {
                    completionHandler(nil, urlString)
                    return
                //}
                
                if data != nil {
                    let image = UIImage(data: data)
                    self.cache.setObject(data as AnyObject, forKey: urlString as AnyObject)
                    DispatchQueue.main.async(execute: {() in
                        completionHandler(image, urlString)
                    })
                    return
                }
                
            } as! (Data?, URLResponse?, Error?) -> Void)
            downloadTask.resume()
        })
        
    }
}
