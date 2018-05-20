
import UIKit
import  GoogleMobileAds
class ViewController: UIViewController, GADNativeExpressAdViewDelegate, GADVideoControllerDelegate{

    @IBOutlet weak var nativeExpressAd: GADNativeExpressAdView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nativeExpressAd.adUnitID = "ca-app-pub-413036338/3639606"
        nativeExpressAd.rootViewController = self
        nativeExpressAd.delegate = self
        
        let videoOptions = GADVideoOptions()
        videoOptions.startMuted = true
        nativeExpressAd.setAdOptions([videoOptions])
        nativeExpressAd.videoController.delegate = self
        
        let  request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        nativeExpressAd.load(request)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func  nativeExpressAdViewDidReceiveAd(_ nativeExpressAdView: GADNativeExpressAdView) {
        if nativeExpressAd.videoController.hasVideoContent(){
            print("received and add with a video asset.")
        }
        else{
            print("Received an ad without a video asset.")
        }
        
    }

    func videoControllerDidEndVideoPlayback(_ videoController: GADVideoController) {
        print("the video asset has completed playback.")
    }
}

