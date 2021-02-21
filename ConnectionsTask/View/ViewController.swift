//
//  ViewController.swift
//  ConnectionsTask
//
//  Created by Venkatarao Ponnapalli  on 20/02/21.
//  Copyright © 2021 Venkatarao Ponnapalli . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var email_txtfld: UITextField!
    @IBOutlet weak var pwd_txtfld: UITextField!
    @IBOutlet weak var error_lbl: UILabel!
    @IBOutlet weak var submit_btn: UIButton!

    var testbool : Bool = false
    var testboo12 : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       updateUI()
    }
    @objc func buttonTapped(sender : UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "NextViewController") as! NextViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func emailValidation(textfield:UITextField){
        if isValidEmail(textfield.text!){
            
            error_lbl.isHidden = true
            testbool = true
            if(testbool == testboo12){
                submit_btn.isEnabled = true
            }
        }
        else{
            error_lbl.text = "Please enter valid email"
            error_lbl.isHidden = false
            submit_btn.isEnabled = false
            testbool = false
        }
    }
    @objc func pwdValidation(textfield:UITextField){
        if isValidPassword(textfield.text!){
            error_lbl.isHidden = true
            testboo12 = true
            if(testbool == testboo12){
                print("true")
                submit_btn.isEnabled = true
            }
        }
        else{
            error_lbl.text = "Please enter valid password"
            error_lbl.isHidden = false
            submit_btn.isEnabled = false
            testboo12 = false
        }
    }
    func updateUI(){
        error_lbl.isHidden = true
        email_txtfld.addTarget(self, action: #selector(emailValidation(textfield:)), for: .editingChanged)
        pwd_txtfld.addTarget(self, action: #selector(pwdValidation(textfield:)), for: .editingChanged)
        submit_btn.addTarget(self, action:#selector(self.buttonTapped), for: .touchUpInside)
        submit_btn.isEnabled = false
    }

}
// email Validation
func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}
// Password validation
func isValidPassword(_ PasswordString: String) -> Bool {

    var returnValue = true
    let mobileRegEx =  "[A-Za-z0-9.-_@#$!%&*]{8,15}"

    do {
        let regex = try NSRegularExpression(pattern: mobileRegEx)
        let nsString = PasswordString as NSString
        let results = regex.matches(in: PasswordString, range: NSRange(location: 0, length: nsString.length))

        if results.count == 0
        {
            returnValue = false
        }

    } catch let error as NSError {
        print("invalid regex: \(error.localizedDescription)")
        returnValue = false
    }

    return  returnValue
}
