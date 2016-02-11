/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        print("Image Selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        ImportedImage.image = image
    
    }
    
    @IBOutlet weak var ImportedImage: UIImageView!
    
    @IBAction func ImportImage(sender: AnyObject) {
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    @available(iOS 8.0, *)
    @IBAction func signUp(sender: AnyObject) {
        
        if username.text == "" || password.text == "" {
            var alert = UIAlertController(title: "Error", message: "Please enter a username and password", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) ->Void in
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
                })))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var user = PFUser()
            user.username = username.text
            user.password = password.text
            
            user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if error == nil {
                    //signup successful
                } else {
                    if let errorString = error.userInfo?["error"] as? NSString {
                        
                    }
                }
                
            })
        }
        
    }
    
    @IBAction func login(sender: AnyObject) {
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
