//
//  ViewController.swift
//  Example
//
//  Created by Sun on 2018/12/3.
//  Copyright © 2018 Umbrella. All rights reserved.
//

import UIKit
import MFVerificationCode

class ViewController: UIViewController {

    @IBOutlet weak var verificationCodeView: VerificationCode!
    
    @IBOutlet weak var checkingButton: UIButton!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkingButton.backgroundColor = UIColor(red: 0.543, green: 0.345, blue: 0.345, alpha: 1.0)
        checkingButton.setTitleColor(.white, for: .normal)
        checkingButton.setTitleColor(.lightGray, for: .disabled)
        checkingButton.isEnabled = false

        verificationCodeView.keyboardAppearance = .dark
        verificationCodeView.delegate = self
    }

    @IBAction func checking(_ sender: UIButton) {
        let title = sender.currentTitle
        sender.isEnabled = false
        sender.setTitle("", for: .disabled)
        checkingButton.backgroundColor = UIColor(red: 0.543, green: 0.345, blue: 0.345, alpha: 1.0)
        activityView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
            sender.setTitle(title, for: .normal)
            self?.checkingButton.backgroundColor = UIColor(red: 0.972, green: 0.345, blue: 0.345, alpha: 1.0)
            self?.activityView.stopAnimating()
            sender.isEnabled = true
        }
    }
    
}

extension ViewController: VerificationCodeProtocol {
    func textFieldValueChanged(_ textField: VerificationCode) {
        
        if textField.text?.count == textField.numel {
            checkingButton.isEnabled = true
            checkingButton.backgroundColor = UIColor(red: 0.972, green: 0.345, blue: 0.345, alpha: 1.0)
        } else if textField.text?.count == 0 {
            checkingButton.isEnabled = false
            checkingButton.setTitle("Check", for: .disabled)
            checkingButton.backgroundColor = UIColor(red: 0.543, green: 0.345, blue: 0.345, alpha: 1.0)
            textField.resignFirstResponder()
        }
    }
}


extension UIImage {
    
    static func from(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
