//
//  ViewController.swift
//  VKTest
//
//  Created by Daniil Smirnov on 18.10.16.
//  Copyright © 2016 Daniil Smirnov. All rights reserved.
//

import UIKit

let APP_ID = "5664811"
let APP_Bundle = "com.vk.Vlanguish"
let SCOPE = [VK_PER_FRIENDS, VK_PER_WALL, VK_PER_AUDIO, VK_PER_PHOTOS, VK_PER_NOHTTPS, VK_PER_EMAIL, VK_PER_MESSAGES];
var TOKEN_KEY: VKAccessToken?

class ViewController: UIViewController, VKSdkDelegate, VKSdkUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vkSdkInstanse = VKSdk.initialize(withAppId: APP_ID)
        vkSdkInstanse?.register(self)
        vkSdkInstanse?.uiDelegate = self
        
        VKSdk.wakeUpSession(SCOPE) { (state, error) in
            if state == .authorized{
                print("authorized")
                self.goToTabBarController()
            } else if state == .initialized {
                print("initialized")
            } else {
                print(error)
            }
        }
    }
    
    @IBAction func authTouchUp(sender: UIButton) {
        
        VKSdk.authorize(SCOPE)
        
    }
    
    @IBAction func segueToTabBarController(_ sender: UIButton) {
        goToTabBarController()
    }
    
    func goToTabBarController(){
        print("\n\n\n\n\n\n____________________________________\n\n\n\n\n\n")
        performSegue(withIdentifier: "showTabBarController", sender: self)
    }
    
    func vkSdkAcceptedUserToken(token: VKAccessToken!) {
        print("ACCEPTED")
    }
    
    @objc(vkSdkShouldPresentViewController:) func vkSdkShouldPresent(_ controller: UIViewController!) {
        //        navigationController?.topViewController?.present(controller, animated: true, completion: nil)
        present(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        let captchaViewController = VKCaptchaViewController.captchaControllerWithError(captchaError)
        //        captchaViewController?.present(in: navigationController?.topViewController)
        captchaViewController?.present(in: self)
    }
    
    
    func vkSdkTokenHasExpired(_ expiredToken: VKAccessToken!) {
        VKSdk.authorize(nil)
    }
    
    @objc(vkSdkAccessAuthorizationFinishedWithResult:) func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult) {
        if let token = result.token{
            TOKEN_KEY = token
            //perform segue here
            goToTabBarController()
        } else if let _ = result.error {
            let alertController = UIAlertController(title: "Error", message: "Access denied1", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                
            }))
            present(alertController, animated: true, completion: nil)
        }
        
    }
    func vkSdkUserAuthorizationFailed() {
        present(UIAlertController(title: "Error", message: "Access denied2", preferredStyle: .alert), animated: true, completion: nil)
        //        navigationController?.popToRootViewController(animated: true)
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        guard segue.identifier == "showTabBarController" else { return }
    //        guard let destinationVC = segue.destination as? FriendsViewController else { return }
    //        let getFriendsRequest = VKApi.friends().get(destinationVC.parameters)
    //        getFriendsRequest?.execute(resultBlock: { (response) in
    //            print(response?.json)
    //            if let wrapperDictionary = response?.json as! [String : Any]?{
    //                if let friendsCountString = wrapperDictionary["count"] as? Int{
    //                    destinationVC.friendsCount = friendsCountString
    //                }
    //                destinationVC.friendsDictionaryArray = wrapperDictionary["items"] as? [[String: Any]]
    //                for friendsDictionary in destinationVC.friendsDictionaryArray!{
    //                    let friend = Friend()
    //                    friend.firstName = friendsDictionary["first_name"] as? String
    //                    friend.lastName = friendsDictionary["last_name"] as? String
    //                    friend.id = friendsDictionary["id"] as? Int
    //                    friend.isOnline = friendsDictionary["online"] as? Int == 0 ? false : true
    //                    if friend.isOnline != nil {
    //                        friend.isMobile = friendsDictionary["online_mobile"] == nil ? false : true
    //                    }
    //                    friend.imageUrl = URL(string: friendsDictionary["photo_50"] as! String)
    //                    destinationVC.friends.append(friend)
    //                }
    //            }
    //
    //            print(destinationVC.friends)
    //            
    //            }, errorBlock: { (error) in
    //                print(error)
    //        })
    //    }
    
}
