//
//  ViewController.swift
//  fitnes
//
//  Created by wsr5 on 05.10.2021.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIGestureRecognizerDelegate {

    var iconClick = false
    var iconClick1 = false
    var arrowClick = false
    var imageIcon = UIImageView()
    var imageIcon1 = UIImageView()
    var arrowImage = UIImageView()
    

    var list = ["Мужской", "Женский", "Другой"]
    
    @IBOutlet weak var passwordField, passwordField1: UITextField!
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var buttonContinue: UIButton!
    @IBOutlet weak var textConf: UILabel!
    @IBOutlet var fields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordField.delegate = self
        passwordField1.delegate = self
        for field in fields {
            field.delegate = self
        }
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        imageIcon.image = UIImage(named:"eye")
        
        var contentView = UIView()
        contentView.addSubview(imageIcon)
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "eye")!.size.width, height: UIImage(named: "eye")!.size.height)
        
        imageIcon.frame = CGRect(x: -10, y: 0, width: UIImage(named: "eye")!.size.width, height: UIImage(named: "eye")!.size.height)
        
        passwordField.rightView = contentView
        passwordField.rightViewMode = .always
            
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
        
        imageIcon1.image = UIImage(named:"eye1")
        
        contentView = UIView()
        contentView.addSubview(imageIcon1)
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "eye1")!.size.width, height: UIImage(named: "eye1")!.size.height)
        
        imageIcon1.frame = CGRect(x: -10, y: 0, width: UIImage(named: "eye1")!.size.width, height: UIImage(named: "eye1")!.size.height)
        
        passwordField1.rightView = contentView
        passwordField1.rightViewMode = .always
        
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped1(tapGestureRecognizer:)))
        
        imageIcon1.isUserInteractionEnabled = true
        imageIcon1.addGestureRecognizer(tapGestureRecognizer1)
        
        arrowImage.image = UIImage(named: "Vector")
        
        let arrowView = UIView()
        arrowView.addSubview(arrowImage)
        
        arrowView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "Vector")!.size.width, height: UIImage(named: "Vector")!.size.height)
        
        arrowImage.frame = CGRect(x: -10, y: 0, width: UIImage(named: "Vector")!.size.width, height: UIImage(named: "Vector")!.size.height)
        
        textBox.rightView = arrowView
        textBox.rightViewMode = .always
        
        buttonContinue.layer.cornerRadius = 12
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            print("TextField did begin editing method called")
        if textField == self.textBox {
            self.dropDown.isHidden = false
//                buttonContinue.isHidden = true
//                textConf.isHidden = true

            textField.endEditing(true)
        }

        
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            print("TextField did end editing method called\(textField.text!)")
        }
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            print("TextField should begin editing method called")
            return true;
        }
        func textFieldShouldClear(_ textField: UITextField) -> Bool {
            print("TextField should clear method called")
            return true;
        }
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            print("TextField should end editing method called")
            return true;
        }
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            print("While entering the characters this method gets called")
            return true;
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            print("TextField should return method called")
            textField.resignFirstResponder();
            return true;
        }

    @objc func imageTapped(tapGestureRecognizer:UITapGestureRecognizer)
    {
        
        if iconClick
        {
            iconClick=false
            passwordField.isSecureTextEntry = false
        }

        else
        {
            iconClick=true
            passwordField.isSecureTextEntry = true


        }

    }
    
    @objc func imageTapped1(tapGestureRecognizer:UITapGestureRecognizer)
    {
        
        if iconClick1
        {
            iconClick1=false
            passwordField1.isSecureTextEntry = false
        }

        else
        {
            iconClick1=true
            passwordField1.isSecureTextEntry = true


        }

    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
            return 1
        }

        public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{

            return list.count
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

            self.view.endEditing(true)
            return list[row]
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

            self.textBox.text = self.list[row]
            self.dropDown.isHidden = true
//            buttonContinue.isHidden = false
//            textConf.isHidden = false
        }

}


