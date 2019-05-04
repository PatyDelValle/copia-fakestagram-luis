//
//  CameraViewController.swift
//  fakestagram
//
//  Created by patricia  D3 on 4/27/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {
    let client = CreatePostClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapSnap(_ sender: UIButton) {
        guard let img = UIImage(named: "imagen1"),
        let imgBase64 = img.encodedBase64() else {return}
        let payload = CreatePostBase64(title: "imagen1 - \(Date().currentTimestamp())",imageData: imgBase64)
        client.create(payload: payload) {
            post in print (post)
        }
        
        /*guard let data = img.jpegData(compressionQuality: 0.95) else {return}
        print (data.base64EncodedString(options: .lineLength64Characters))
 */
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
