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
    
    @IBOutlet weak var GetStartedOut: UIButton!
    
    @IBAction func GetStartedButton(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "GetStarted")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainPage") as! MainPageViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnboardingView()
        view.bringSubviewToFront(GetStartedOut)
        
        if UserDefaults.standard.bool(forKey: "GetStarted") == true{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainPage") as! MainPageViewController
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    private func setupOnboardingView(){
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        for attribute : NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom]{
            let constraint = NSLayoutConstraint(item: onboarding, attribute: attribute, relatedBy: .equal, toItem: view, attribute: attribute, multiplier: 1, constant: 0)
            view.addConstraint(constraint)
        }
    }
    
    fileprivate let items = [
        OnboardingItemInfo(informationImage: UIImage(named: "brush")!, title: "Title", description: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", color: colors().backgroundColorOne, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: fonts().titleFont, descriptionFont: fonts().descriptionFont),
        OnboardingItemInfo(informationImage: UIImage(named: "notification")!, title: "Title", description: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", color: colors().backgroundColorTwo, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: fonts().titleFont, descriptionFont: fonts().descriptionFont),
        OnboardingItemInfo(informationImage: UIImage(named: "rocket")!, title: "Title", description: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", color: colors().backgroundColorThree, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: fonts().titleFont, descriptionFont: fonts().descriptionFont)
    ]
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return items[index]
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 1{
            if self.GetStartedOut.alpha == 1{
                UIView.animate(withDuration: 0.2, animations: {self.GetStartedOut.alpha = 0})
            }
        }
    }

    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 2 {
            UIView.animate(withDuration: 0.4, animations: {self.GetStartedOut.alpha = 1})
        }
    }
    
    class fonts : UIFont{
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 25)!
        let descriptionFont = UIFont(name: "AvenirNext-Regular", size: 18)!
    }
    
    class colors : UIColor{
        let backgroundColorOne = UIColor(red: 0.40, green: 0.56, blue: 0.71, alpha: 1)
        let backgroundColorTwo = UIColor(red: 0.40, green: 0.69, blue: 0.71, alpha: 1)
        let backgroundColorThree = UIColor(red: 0.61, green: 0.56, blue: 0.74, alpha: 1)
    }
}

