
    // ViewController.swift
    // Treads
    //
    // Created by Noye Samuel on 23/01/2023.
    //
import UIKit
import Nuke
class ViewController: UIViewController {
    var imageView = UIImageView()
    var imageCount = 0
    let group = DispatchGroup()
    override func viewDidLoad() {
        super.viewDidLoad()
            //      // Do any additional setup after loading the view.
            //    var thread: Thread = Thread()
            //
            //    var dispatchQueue = DispatchQueue(label: "serial", attributes: .concurrent)
            //
            //    DispatchQueue.global(qos: .background)
            //    var imgCount = 10
            //
            //
        var imgs = ["https://i.picsum.photos/id/478/200/300.jpg?hmac=9XTsWr649TEW4EJf8V09OflQrYWLvD63zeYkUNJ8Aq4", "https://i.picsum.photos/id/237/200/200.jpg?hmac=zHUGikXUDyLCCmvyww1izLK3R3k8oRYBRiTizZEdyfI", "https://i.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI", "https://i.picsum.photos/id/881/200/300.jpg?grayscale&hmac=Dcu6Uox2IJi1KfTR5HgW5XBJfzppS7uTgtI0Gh1QjKk", "https://i.picsum.photos/id/306/200/300.jpg?blur=5&hmac=8ExpGKP5fttp7T2frCjUKKDCwUGwWpFSgZeG6HfalfE"]
        
        imageCount = imgs.count
        for image in imgs {
                //enter
            group.enter()
            fetchImage(img:image)
        }
            // notify
        group.notify(queue: .global()){
            print("downloads complete")
        }
    }
    func fetchImage(img: String){
            // The image to dowload
        let remoteImageURL = URL(string: img)!
        let request = ImageRequest(
            url: remoteImageURL,
            processors: [.resize(width: 320)],
            priority: .high,
            options: [.reloadIgnoringCachedData]
        )
        Nuke.loadImage(with: request, into: imageView) { result in
            if let image = try? result.get(){
                    //leave
                self.group.leave()
            }
                // operation queues
                // race conditions and how to use
        }
    }
}
