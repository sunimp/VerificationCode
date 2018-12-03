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
        
        guard let count = textField.text?.count, count != 0 else {
            textField.resignFirstResponder()
            return
        }
        
        if count < textField.numel {
            checkingButton.isEnabled = false
            checkingButton.setTitle("Check", for: .disabled)
            checkingButton.backgroundColor = UIColor(red: 0.543, green: 0.345, blue: 0.345, alpha: 1.0)
        } else {
            checkingButton.isEnabled = true
            checkingButton.backgroundColor = UIColor(red: 0.972, green: 0.345, blue: 0.345, alpha: 1.0)
            
        }
    }
}
