//
//  ViewController.swift
//  Caesar Cipher
//
//  Created by Cedric on 01/07/2020.
//  Copyright © 2020 cedric06nice. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textToCodeTextView: UITextView!
    @IBOutlet weak var parametersStackView: UIStackView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var stepperStepper: UIStepper!
    @IBOutlet weak var encodeButton: UIButton!
    @IBOutlet weak var decodeButton: UIButton!
    @IBOutlet weak var codedTextTextView: UITextView!
    
    var rot: UInt32 = 13
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        encodeButton.layer.cornerRadius = 15
        decodeButton.layer.cornerRadius = 15
    }
    
    @IBAction func stepper(_ sender: UIStepper) {
        rot = UInt32(sender.value)
        numberLabel.text = "ROT \(String(rot))"
    }
    
    @IBAction func encodeButtonTapped(_ sender: Any) {
        codedTextTextView.text = encodeMessage(text: textToCodeTextView.text!, rot: rot)
    }
    
    @IBAction func decodeButtonTapped(_ sender: Any) {
        codedTextTextView.text = decodeMessage(text: textToCodeTextView.text!, rot: rot)
    }
    
    func encodeMessage(text: String, rot: UInt32) -> String {
        return CaesarCipher.encipher(text: text, shiftBy: rot)
    }
    
    func decodeMessage(text: String, rot: UInt32) -> String {
        return CaesarCipher.encipher(text: text, shiftBy: 26 - rot)
    }
    
    @IBAction func clearTextToCode(_ sender: Any) {
        textToCodeTextView.text = ""
    }
    
    @IBAction func copyCoddedText(_ sender: Any) {
        UIPasteboard.general.string = codedTextTextView.text
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
