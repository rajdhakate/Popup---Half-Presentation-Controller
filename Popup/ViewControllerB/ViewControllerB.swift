//
//  ViewControllerB.swift
//  Popup
//
//  Created by Raj Dhakate on 10/02/18.
//  Copyright © 2018 Dhakate Codes. All rights reserved.
//

import UIKit

protocol PopupViewControllerProtocol {
    func didReturnToPreviousViewController()
}

class ViewControllerB: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private static let imageCellID = "ImageCell"
    private static let textCellID = "TextCell"
    
    var imageURL = "https://d4t7t8y8xqo0t.cloudfront.net/app/resized/750X/pages/443/image20180202113444.jpg"
    var labelText = "Dummy text"
    
    var imageHeightCache: NSCache<AnyObject, AnyObject>?

    var delegate: PopupViewControllerProtocol!
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        
        let tapToDismiss = UITapGestureRecognizer(target: self, action: #selector(tapAction(gesture:)))
        view.addGestureRecognizer(tapToDismiss)

        // Do any additional setup after loading the view.
        
        let imageCellNib = UINib(nibName: "ImageCell", bundle: nil)
        tableView.register(imageCellNib, forCellReuseIdentifier: ViewControllerB.imageCellID)
        
        let textCellNib = UINib(nibName: "TextCell", bundle: nil)
        tableView.register(textCellNib, forCellReuseIdentifier: ViewControllerB.textCellID)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if imageHeightCache != nil {
                return CGFloat(self.imageHeightCache?.object(forKey: imageURL as AnyObject) as! Float)
            } else {
                return UITableViewAutomaticDimension
            }
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let imageCell = tableView.dequeueReusableCell(withIdentifier: ViewControllerB.imageCellID, for: indexPath) as! ImageCell
            
            let url = URL(string: imageURL)
            imageCell.imageview.sd_setImage(with: url, completed: { (image, error, cacheType, url) in
                self.imageHeightCache?.setObject(image?.size.height as AnyObject, forKey: self.imageURL as AnyObject)
                self.tableView.beginUpdates()
                self.tableView.reloadRows(at: [indexPath], with: .none)
                self.tableView.endUpdates()
            })
            return imageCell
        } else {
            let textCell = tableView.dequeueReusableCell(withIdentifier: ViewControllerB.textCellID, for: indexPath) as! TextCell
            textCell.labelView.text =  labelText
            return textCell
        }
    }
    
    @objc private func tapAction(gesture: UITapGestureRecognizer) {
        self.delegate.didReturnToPreviousViewController()
        self.dismiss(animated: true, completion: nil)
    }
}
