//
//  ViewControllerA.swift
//  Popup
//
//  Created by Raj Dhakate on 10/02/18.
//  Copyright © 2018 Dhakate Codes. All rights reserved.
//

import UIKit

class ViewControllerA: UIViewController, PopupViewControllerProtocol {

    @IBOutlet weak var dimBG: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func goToViewControllerBAction(_ sender: UIButton) {
        let viewControllerB = ViewControllerB()
        viewControllerB.delegate = self
        viewControllerB.modalPresentationStyle = .overFullScreen
        UIView.animate(withDuration: 0.5) {
            self.dimBG.alpha = 0.5
        }
        self.present(viewControllerB, animated: true, completion: nil)
    }
    
    func didReturnToPreviousViewController() {
        self.dimBG.alpha = 0.0
    }
}
