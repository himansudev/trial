//
//  OtpSecondVC2.swift
//  LoginAndSignUpScreens
//
//  Created by Himansu Sekhar Panigrahi on 18/01/20.
//  Copyright © 2020 Osos Technologies. All rights reserved.

import UIKit

struct PermanentInfo : Decodable {
    let id : String
    let token : String
    let OTPresponse : [otpResponse]?
    let user : Dictionary<String,String>
}
var permanentToken : String = ""
var permanentTokenKey : String = "permTokenKey"
var permanentInfo = PermanentInfo(id: "", token: "", OTPresponse: [], user: [:])
var idFromOtpSubmit : String = ""

struct otpResponse : Decodable {
    let details : String         // details from otp
    let status : String            // status from otp
}
var otpresponse = otpResponse(details: "", status: "")

struct StatusInfo : Decodable {
    let status : String
    let message : String
}
var statusInfo = StatusInfo(status: "", message: "")
var statusFromStatusInfo : String = ""
var messageFromStatusInfo : String = ""
var statusCode = 220
struct user {
    // leave this
}



class OtpSecondVC: UIViewController,UITextFieldDelegate
{

    
    
    var mobileNo = String()
    var touchCount:Float = 0
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet var stepIndicator: [UIButton]!
    
    @IBOutlet weak var headerMsgLabel: UILabel!
    
    @IBOutlet weak var msgLabel: UILabel!
    
    
    @IBOutlet weak var resendButton: UIButton!
    
    @IBOutlet var otpTf: [UITextField]!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var verifyOtpLabel: UILabel!
    @IBOutlet weak var wrongNumberButton: UIButton!
    
    @IBOutlet weak var otpVerificationLabel: UILabel!
    
      var timer:Timer!
    var emailLogin : String = ""
        
        override func viewDidLoad()
        {
            super.viewDidLoad()

        
            scrollView.showsVerticalScrollIndicator = false
            
            scrollView.layer.cornerRadius = 20
            
            backButton.addTarget(self, action: #selector(backButtonEH), for: UIControl.Event.touchUpInside)
            
            if(ForgotPasswordSecondVC.isEmailOtpReq)
            {
                let myString = "OTP has been sent to your E-mail address\n \(emailLogin)\nPlease enter it below. "
                
                
                
                
                //let myAttribute = [NSAttributedString.Key.font : UIFont(name: "Chalkduster", size: 20)]
                
                
                
                
//                let x = NSAttributedString(string: str1)
//
//                let y = NSAttributedString(string: str2)
                
               // headerMsgLabel.attributedText = attriburtedString
            }
            else
            {
                let attributedString = NSMutableAttributedString(string:"OTP has been has been sent to\n \(mobileNo)\nplease enter it below")
                
                attributedString.setFontSize(fontSize: 30, forText: mobileNo)
                
                
                
                headerMsgLabel.attributedText = attributedString
            }
            
            
            for tf in otpTf
            {
               tf.delegate = self
            }
            
            
            
            
            headerMsgLabel.numberOfLines = 0
            
            headerMsgLabel.textColor = Colors.gray
            
            timerLabel.backgroundColor = .clear
            timerLabel.text = "01:30"
            timerLabel.textAlignment = .center
            timerLabel.layer.cornerRadius = 25
            timerLabel.clipsToBounds = true
            
            
//            msgLabel.textAlignment = .center
//            msgLabel.numberOfLines = 0
//            msgLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//            msgLabel.font = msgLabel.font.withSize(12)
//            msgLabel.text = "''OTP sent to wrong number ?''"
            
            configureOtpTf()
            
            
//            submitButton.layer.borderWidth = 0.5
//            submitButton.layer.borderColor = UIColor.blue.cgColor
            submitButton.configureButtonStyle(title: "Submit", cornerRadius: 20)
            resendButton.layer.cornerRadius = 25
            
            //resendButton.layer.borderColor = UIColor.gray.cgColor
            resendButton.backgroundColor = .clear
            
//            resendButton.titleLabel?.font = UIFont(name: "System", size: 1)
            resendButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            resendButton.isHidden = true
            resendButton.addTarget(self, action: #selector(resendButtonEH), for: UIControl.Event.touchUpInside)
            
//            configurePageIndicator(buttonArray: stepIndicator, selectedButtonIndex: 2)
            
            startTimer()
            configureLabelsInOtpSecondVC()
            configureButtonsInOtpSecondVC()
            
        }
    
    
    @IBAction func resendOtpButtonTapped(_ sender: Any) {
        if ForgotPasswordSecondVC.isEmailOtpReq == false { // when otp is again sent to phone number during signup
            httpReqResendOtpTappedToPhone()
        } else { // when otp is again sent to email during login
            httpReqResendOtpTappedToEmail()
        }
    }
    
    
    //func startAvtivityViewIndicator()
    @IBAction func wrongNumberTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure?", message: "Do you really want to change your mobile number \(mobileFromSignUp)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            self.view.configureDismissAnimation()
            
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func submitButtonTapped(_ sender: Any)
    {
        if ForgotPasswordSecondVC.isEmailOtpReq == false // phone number otp during signup
        {
            httpReqSubmitButtonTappedToPhone()
        
                
            //                    if let httpResponse = response as? HTTPURLResponse {
            //                        let status = httpResponse.statusCode
            //                        if status != 200  { // when the connection is an Error
            //                            // dismiss spots progress dialog
            //                            let alert = UIAlertController(title: "Try Again", message: "Please try again", preferredStyle: .alert)
            //                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            //                            self.present(alert, animated: true, completion: nil)
            //                        } else { // when the connection is a Success
            //                            // dismiss spots progress dialog
            //                            // show alert that it is a success
            //                            let alert = UIAlertController(title: "Success", message: "Thank you for signing up", preferredStyle: .alert)
            //                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            //                            self.present(alert, animated: true, completion: nil)
            //                        }
            //                    }
                    
            
            
        } else if ForgotPasswordSecondVC.isEmailOtpReq == true //email otp during forgot pass login
        {
            httpReqSubmitButtonTappedToEmail()
            //                    if let httpResponse = response as? HTTPURLResponse {
            //                        let status = httpResponse.statusCode
            //                        if status != 200  { // when the connection is an Error
            //                            // dismiss spots progress dialog
            //                            let alert = UIAlertController(title: "Try Again", message: "Please try again", preferredStyle: .alert)
            //                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            //                            self.present(alert, animated: true, completion: nil)
            //                        } else { // when the connection is a Success
            //                            // dismiss spots progress dialog
            //                            // show alert that it is a success
            //                            let alert = UIAlertController(title: "Success", message: "Your password has been changed", preferredStyle: .alert)
            //                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            //                            self.present(alert, animated: true, completion: nil)
            //                            // go to next vc - login page
            //
            //                        }
            //                    }
                            
        }
        
        
        
        
    }
    
        
        func configureOtpTf()
        {
            for tf in otpTf
            {
                let label = UILabel()
                label.backgroundColor = .gray
                tf.addSubview(label)
                tf.addTarget(self, action: #selector(otpTfEH(tf:)), for: UIControl.Event.editingChanged)
                
                //Constraints
                label.translatesAutoresizingMaskIntoConstraints = false
                label.leadingAnchor.constraint(equalTo: tf.leadingAnchor, constant: 0).isActive = true
                label.bottomAnchor.constraint(equalTo: tf.bottomAnchor, constant: 0).isActive = true
                label.heightAnchor.constraint(equalTo: tf.heightAnchor, multiplier: 0.03).isActive = true
                label.widthAnchor.constraint(equalTo: tf.widthAnchor, multiplier: 1).isActive = true
                
            }
        }
        
        
        @objc func otpTfEH(tf:UITextField)
        {
    //       if(tf.text?.count == 1 && touchCount < 6)
    //       {
    //            if(tf.text?.count != 0)
    //            {
    //                touchCount += 0.5
    //
    //            }
    //
    //        print("Touch Count : ",touchCount)
    //
    //            switch tf
    //            {
    //            case otpTf[0]:
    //                otpTf[0].resignFirstResponder()
    //                otpTf[1].becomeFirstResponder()
    //
    //            case otpTf[1]:
    //                    otpTf[1].resignFirstResponder()
    //                    otpTf[2].becomeFirstResponder()
    //
    //            case otpTf[2]:
    //                    otpTf[2].resignFirstResponder()
    //                    otpTf[3].becomeFirstResponder()
    //
    //            case otpTf[3]:
    //                    otpTf[3].resignFirstResponder()
    //                    otpTf[4].becomeFirstResponder()
    //
    //            case otpTf[4]:
    //                    otpTf[4].resignFirstResponder()
    //                    otpTf[5].becomeFirstResponder()
    //            case otpTf[5]:
    //                    otpTf[5].resignFirstResponder()
    //                print(touchCount)
    //
    //            default:
    //                break
    //                    //otpTf[1].becomeFirstResponder()
    //            }
    //        }
    //        else if(touchCount == 6)
    //       {
    //
    //            print("K")
    //
    //            for x in otpTf
    //            {
    //                    x.text = ""
    //            }
    //        touchCount = 0
    //        }
            
            if(tf.text?.count == 1)
            {
                
                
                switch tf
                {
                case otpTf[0]:
                    //otpTf[0].resignFirstResponder()
                    otpTf[1].becomeFirstResponder()

                case otpTf[1]:
                    //otpTf[1].resignFirstResponder()
                    otpTf[2].becomeFirstResponder()

                case otpTf[2]:
                    //otpTf[2].resignFirstResponder()
                    otpTf[3].becomeFirstResponder()

                case otpTf[3]:
                    //otpTf[3].resignFirstResponder()
                    otpTf[4].becomeFirstResponder()

                case otpTf[4]:
                    
                    print("Tf Array Count : ",otpTf.count)
                    //otpTf[4].resignFirstResponder()
                    otpTf[5].becomeFirstResponder()
                case otpTf[5]:
                    print("tf 5")
                    
                    //otpTf[5].resignFirstResponder()
                    
                default:
                    break
                        //otpTf[1].becomeFirstResponder()
                }
            }
            else if(otpTf[5].text?.count == 2)
            {
                otpTf[5].text?.removeLast()
            }
            
            
            
            
        }
        
        
    
    func startTimer()
       {
          timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerEH), userInfo: nil, repeats: true)
           
           
       }
       
       @objc func timerEH()
       {
               
               var min = Int(String(Array(timerLabel.text!)[0]) + String(Array(timerLabel.text!)[1]))!
               
               var sec = Int(String(Array(timerLabel.text!)[3]) + String(Array(timerLabel.text!)[4]))!
               
               if(min != 0)
               {
                   if(sec != 0)
                   {
                       sec -= 1
                   }
                   else
                   {
                       min -= 1
                       sec = 59
                   }
                   
               }
               else
               {
                   if(sec != 0)
                   {
                       sec -= 1
                   }
                   else
                   {
                       timer.invalidate()
                    timerLabel.isHidden = true
                    resendButton.isHidden = false
                   }
               }
               
               
               timerLabel.text = "0" + String(min) + ":" + ((String(sec).count == 1) ? "0" + String(sec) : String(sec))
               
               
           }
       
       
    @objc func resendButtonEH()
    {
        resendButton.isHidden = true
        timerLabel.isHidden = false
        timerLabel.text = "00:30"
        startTimer()
    }
    
    
       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
       {
           if(string == "")
           {
       
               
               switch textField
               {
           
               case otpTf[1]:
                   
                   otpTf[1].text = ""
                   otpTf[0].becomeFirstResponder()
                   return false

               case otpTf[2]:
                  
                   otpTf[2].text = ""
                  otpTf[1].becomeFirstResponder()
                  return false

               case otpTf[3]:
                   
                   otpTf[3].text = ""
                   otpTf[2].becomeFirstResponder()
                   return false

               case otpTf[4]:
                   
                   otpTf[4].text = ""
                   otpTf[3].becomeFirstResponder()
                   return false
               case otpTf[5]:
                   
                   otpTf[5].text = ""
                   otpTf[4].becomeFirstResponder()
                   return false
               default:
                   break
                      
               }
           }
           
           
           //Restricting The User To Enter More Than One Character In Each Text Field
           if((textField.text! + string).count > 1)
           {
               
               return false
           }
           
           
           
           return true
       }
    
    
    @objc func backButtonEH()
    {
//        let alert = UIAlertController(title: "Are you sure?", message: "Do you really want to go back ?", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
//        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
        
        let alert = UIAlertController(title: "Are you sure?", message: "Do you really want to go back ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            self.view.configureDismissAnimation()
            self.dismiss(animated: false, completion:nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
       

}

extension OtpSecondVC {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case otpTf[0]:
            hideKeyBoardWhenTappedAround()
        case otpTf[1]:
            hideKeyBoardWhenTappedAround()
        case otpTf[2]:
            hideKeyBoardWhenTappedAround()
        case otpTf[3]:
            hideKeyBoardWhenTappedAround()
        case otpTf[4]:
            hideKeyBoardWhenTappedAround()
        case otpTf[5]:
            hideKeyBoardWhenTappedAround()
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case otpTf[0]:
            otpTf[0].resignFirstResponder()
        case otpTf[1]:
            otpTf[1].resignFirstResponder()
        case otpTf[2]:
            otpTf[2].resignFirstResponder()
        case otpTf[3]:
            otpTf[3].resignFirstResponder()
        case otpTf[4]:
            otpTf[4].resignFirstResponder()
        case otpTf[5]:
            otpTf[5].resignFirstResponder()
        default:
            break
        }
        return true
    }
}
