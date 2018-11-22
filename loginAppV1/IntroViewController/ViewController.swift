//
//  ViewController.swift
//  loginAppV1
//
//  Created by Burak Başeskioğlu on 19.10.2018.
//  Copyright © 2018 Burak Başeskioğlu. All rights reserved.
//
import UIKit
import paper_onboarding

class ViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {

    @IBOutlet weak var onboardingView: OnboardingView!
    @IBOutlet weak var getStartedButtonOut: UIButton!
    
    @IBAction func getStartedButton(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "GetStarted")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainPage") as! MainPageViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingView.dataSource = self
        onboardingView.delegate = self
        onboardingView.translatesAutoresizingMaskIntoConstraints = false
        
        for attribute : NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom, .leading, .trailing]{
            let constraint = NSLayoutConstraint(item: onboardingView, attribute: attribute, relatedBy: .equal, toItem: view, attribute: attribute, multiplier: 1, constant: 0)
            view.addConstraint(constraint)
        }
        
        if UserDefaults.standard.bool(forKey: "GetStarted") == true{ //If the user has clicked the GetStarted button, the intro page will not open again
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainPage") as! MainPageViewController
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
//        let userDefaults = UserDefaults.standard
//        let isFirstOpen = userDefaults.bool(forKey: "isFirstOpen")
//        if isFirstOpen == true {
//            if let welcomeController = storyboard?.instantiateViewController(withIdentifier: "welcome")
//            {
//                self.present(welcomeController, animated: true, completion: nil)
//            }
//        }
    }
//    let introImage : UIImageView = {
//       let image = UIImageView()
//        image.image = UIImage(named: "Ekran Resmi")
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.contentMode = .scaleAspectFill
//        return image
//    }()
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return [
            OnboardingItemInfo(informationImage: UIImage(named: "brush")!, title: "Safest user registration", description: "desc", color: colors().backgroundColorOne, titleColor: colors().backgroundColorTwo, descriptionColor: colors().backgroundColorThree, titleFont: fonts().titleFont, descriptionFont: fonts().descriptionFont),
            OnboardingItemInfo(informationImage: UIImage(named: "rocket")!, title: "title", description: "desc", color: colors().backgroundColorTwo, titleColor: colors().backgroundColorOne, descriptionColor: colors().backgroundColorThree, titleFont: fonts().titleFont, descriptionFont: fonts().descriptionFont),
            OnboardingItemInfo(informationImage: UIImage(named: "notification")!, title: "title", description: "desc", color: colors().backgroundColorThree, titleColor: colors().backgroundColorOne, descriptionColor: colors().backgroundColorTwo, titleFont: fonts().titleFont, descriptionFont: fonts().descriptionFont)
        ][index]
        
    }
    func onboardingDidTransitonToIndex(_ index: Int) {
//        if ((index == 1) && (self.getStartedButtonOut.alpha == 1)) {
//            //if self.getStartedButton.alpha == 1{
//                UIView.animate(withDuration: 0, animations: { self.getStartedButtonOut.alpha = 0 })
//           //}
//        }
        if index == 2 {
            UIView.animate(withDuration: 0.4, animations: { self.getStartedButtonOut.alpha = 1 })
        }
    }
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 1{
            if self.getStartedButtonOut.alpha == 1{
                UIView.animate(withDuration: 0.2, animations: { self.getStartedButtonOut.alpha = 0 })
            }
        }
    }
    
    class fonts : UIFont{
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 25)!
        let descriptionFont = UIFont(name: "AvenirNext-Regular", size: 18)!
    }
    
    class colors : UIColor {
        let backgroundColorOne = UIColor(red: 56/255, green: 203/255, blue: 248/255, alpha: 1)
        let backgroundColorTwo = UIColor(red: 60/255, green: 129/255, blue: 250/255, alpha: 1)
        let backgroundColorThree = UIColor(red: 88/255, green: 86/255, blue: 214/255, alpha: 1)
    }
}

