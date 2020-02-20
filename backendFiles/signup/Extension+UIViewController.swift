//
//  Extension+UIViewController.swift
//  LoginAndSignUpScreens
//
//  Created by Himansu Sekhar Panigrahi on 18/01/20.
//  Copyright © 2020 Osos Technologies. All rights reserved.
//

import UIKit


extension UIViewController
{
    func hideKeyBoardWhenTappedAround()
    {
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func statusCodeCheck() {
        if statusCode != 200 {
            
        }
    }
}

extension SignUpSecondVC {
    
    func configureLabelsInSignUpSecondVC() {
        usernameLabel.configureGeneralLabelFont()
        passwordLabel.configureGeneralLabelFont()
        namefooterLabel.configureFooterLabelFont()
        nameHeaderLabel.configureGeneralLabelFont()
        //self.allHeaderLabels
        emailFooterLabel.configureFooterLabelFont()
        emailHeaderLabel.configureGeneralLabelFont()
        mobileHeaderLabel.configureGeneralLabelFont()
        emailWarningLabel.configureFooterLabelFont()
        passwordFooterLabel.configureFooterLabelFont()
        passwordHeaderLabel.configureGeneralLabelFont()
        usernameFooterLabel.configureFooterLabelFont()
        usernameHeaderLabel.configureGeneralLabelFont()
        confirmWarningLabel.configureFooterLabelFont()
        passwordWarningLabel.configureFooterLabelFont()
        usernameWarningLabel.configureFooterLabelFont()
        mobileNoWarningLabel.configureFooterLabelFont()
        confirmPasswordHeaderLabel.configureGeneralLabelFont()
        ageDeclarationLabel.configureGeneralLabelFont()
        //print(termsConditionLabel)
        termsAndConditionsLabel.configureFooterLabelFont()
        //createAccountLabel.configureToolBarLabelFont()
    }
    
    func configureButtonsInSignUpSecondVC() {
        if isCheckboxChecked == false { // when checkbox is not checked
    
            checkBoxWarningButton.isHidden = false //button shows
        }
        else {
            checkBoxWarningButton.isHidden = true // button hides
        }
    }
    
    func configureTermsConditionsLabel() {
        termsAndConditionsLabel.text = "By creating an account or logging in you agree to our Conditions of Use and Privacy Policy"
        termsAndConditionsLabel.textColor = Colors.gray
        termsAndConditionsLabel.adjustsFontForContentSizeCategory = true
        changeLabelTextColor(label: termsAndConditionsLabel, stringArray: ["Conditions of Use","Privacy Policy"], colorArray: [UIColor.blue,UIColor.blue])
    }
    
    func HttpReqNextButtonTapped() {
        let parameter = ["phone" : mobileFromSignUp, "username" : usnameFromSignUp, "email" : emailFromSignUp]
        guard let url = URL(string: "https://osos-testing.herokuapp.com/api/auth/sendOTP") else { return }
        var request = URLRequest(url: url)
             
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
             
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                statusCode = response.statusCode
                print(response)
            }
                if let data = data {
                    do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                        
                    if statusCode != 200 { // error
                        statusInfo = try JSONDecoder().decode(StatusInfo.self, from: data)
                        statusFromStatusInfo = statusInfo.status  // string of status i.e success or failed
                        messageFromStatusInfo = statusInfo.message
                        let alert = UIAlertController(title: "Try Again", message: messageFromStatusInfo, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    } else {
                        info = try JSONDecoder().decode(Info.self, from: data)
                        print(info.Status)
                        print(info.Details)
                             
                        detailsFromSignUp = info.Details
                    }
                   
                    info = try JSONDecoder().decode(Info.self, from: data)
                    print(info.Status)
                    print(info.Details)
                         
                    detailsFromSignUp = info.Details
                         
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
//    func warningLabelsIndividualShowSetup() {
//        if usernameTextField.text!.count < 8 {
//            usernameWarningLabel.isHidden = false
//        }
//        if !isValidEmail(emailID: emailTextField.text!) {
//            emailWarningLabel.isHidden = false
//        }
//        
//        
//    }

}

extension PasswordSecondVC {
    
    func configureLabelsInPasswordSecondVC() {
        passwordWarningLabel.configureFooterLabelFont()
        passwordHeaderLabel.configureGeneralLabelFont()
        passwordFooterLabel.configureFooterLabelFont()
        //msgLabel2.configureGeneralLabelFont()
        confirmpasswordFooterLabel.configureFooterLabelFont()
        confirmPasswordHeaderLabel.configureFooterLabelFont()
        //changePassLabel.configureToolBarLabelFont()
        enterPassHeadLabel.configureGeneralLabelFont()
    }
    
    func configureButtonsInPasswordSecondVC() {
        
        
    }
    
    func httpReqChangePasswordConfirmed() {
        guard let newPass = passwordTF2.text else { return }
        guard let confPass = confirmPasswordTF2.text else { return }
        let parameters = ["token" : temporaryToken, "password" : newPass, "confirm" : confPass ]
        guard let url = URL(string:"https://osos-testing.herokuapp.com/api/reset/password") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
           
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                       
                    /*tokenInfo = try JSONDecoder().decode(TokenInfo.self, from: data)
                    print(tokenInfo.id)
                    print(tokenInfo.username)
                    print(tokenInfo.token)
                    
                    tokenRetrievedFromWelcome = tokenInfo.token
                    UserDefaults.standard.set(tokenRetrievedFromWelcome, forKey: tokenKeyForUser)
                    tokenFromKeyOfUser = UserDefaults.standard.object(forKey: tokenKeyForUser)
                    print("Token saved permanently from token key is \(tokenFromKeyOfUser!)") */
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}

extension OtpSecondVC {
    
    func configureLabelsInOtpSecondVC() {
            
        timerLabel.configureGeneralLabelFont()
        headerMsgLabel.configureGeneralLabelFont()
        verifyOtpLabel.configureGeneralLabelFont()
        //otpVerificationLabel.configureToolBarLabelFont()
        
    }
    
    func configureButtonsInOtpSecondVC() {
        resendButton.configureButtonFont()
        wrongNumberButton.configureButtonFont()
//        wrongNumberButton.titleLabel?.text = "Wrong Number?"
//        wrongNumberButton.titleLabel?.textColor = Colors.gray
        wrongNumberButton.setTitle("Wrong Number?", for: .normal)
        wrongNumberButton.setTitleColor(Colors.gray, for: .normal)
    }
    
    func httpReqResendOtpTappedToPhone() { // during sign up only
        print("mobile num is \(mobileFromSignUp)")
        let parameterResendOtp = ["phone" : mobileFromSignUp]
        guard let url = URL(string: "https://osos-testing.herokuapp.com/api/auth/resendOTP") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterResendOtp, options: []) else { return }
        request.httpBody = httpBody
           
        let session1 = URLSession.shared
        session1.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json1 = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json1)
                       
                    info = try JSONDecoder().decode(Info.self, from: data)
                    print(info.Status)
                    print(info.Details)
                         
                    detailsFromSignUp = info.Details
                    
                } catch {
                    print(error)
                }
            }
        }.resume()
    }

    
    func httpReqResendOtpTappedToEmail() {
        let parameterResendOtpEmail = ["email" : emailFromForgotPass]// take email from forgot pass entered email
        guard let url = URL(string: "https://osos-testing.herokuapp.com/api/auth/resendOTP") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterResendOtpEmail, options: []) else { return }
        request.httpBody = httpBody
           
        let session1 = URLSession.shared
        session1.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json1 = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json1)
                       
                    info = try JSONDecoder().decode(Info.self, from: data)
                    print(info.Status)
                    print(info.Details)
                         
                    detailsFromSignUp = info.Details
                    
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func httpReqSubmitButtonTappedToPhone() {  // verify otp
        let otp = otpTf[0].text! + otpTf[1].text! + otpTf[2].text! + otpTf[3].text! + otpTf[4].text! + otpTf[5].text!
                        
        let parameters = ["encodedOtp": detailsFromSignUp, "phone": mobileFromSignUp,"cOtp": otp, "name": nameFromSignUp, "username": usnameFromSignUp, "email": emailFromSignUp, "password": passwordFromSignUp]
        guard let url1 = URL(string: "https://osos-testing.herokuapp.com/api/auth/verifyOTP") else { return }
            var request1 = URLRequest(url: url1)
            request1.httpMethod = "POST"
            request1.addValue("application/json", forHTTPHeaderField: "Content-Type")
                                      
            guard let httpBody1 = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
            request1.httpBody = httpBody1
                                   
            let session1 = URLSession.shared
            session1.dataTask(with: request1) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print(response)
                let status = response.statusCode
                print("Status is \(status)")
                                           
                }
                if let data = data {
                    do {
                        let json1 = try JSONSerialization.jsonObject(with: data, options: [])
                            print(json1)
                        
                        permanentInfo = try JSONDecoder().decode(PermanentInfo.self, from: data)
                        permanentToken = permanentInfo.token
                        print("Permanent token when retrieved")
                        UserDefaults.standard.set(permanentToken, forKey: permanentTokenKey)
                        permanentToken = UserDefaults.standard.object(forKey: permanentTokenKey) as! String
                        print("Token saved permanently from token key is \(permanentToken)")
                        idFromOtpSubmit = permanentInfo.id
                        print("id from user = \(idFromOtpSubmit)")
                        
                        otpresponse = try JSONDecoder().decode(otpResponse.self, from: data)
                        detailsFromSignUp = otpresponse.details
                        print("details in otp vc is \(detailsFromSignUp)")
                        
                        //UserDefaults.standard.set(tokenRetrievedFromWelcome, forKey: tokenKeyForUser)
                        //tokenFromKeyOfUser = UserDefaults.standard.object(forKey: tokenKeyForUser)
                       
                                                  
                    } catch {
                            print(error)
                }
            }
        }.resume()
    }
    
    func httpReqSubmitButtonTappedToEmail() { //during login - reset password
        let passSecondVc = self.storyboard?.instantiateViewController(identifier: "PasswordSecondVC") as! PasswordSecondVC
        passSecondVc.modalPresentationStyle = .fullScreen
        view.configurePresentAnimation()
        present(passSecondVc, animated: false, completion: nil)
        
        let otp = otpTf[0].text! + otpTf[1].text! + otpTf[2].text! + otpTf[3].text! + otpTf[4].text! + otpTf[5].text!
            print(otp)
            let parameters = ["token": temporaryToken, "OTP": otp]
            guard let url = URL(string: "https://osos-testing.herokuapp.com/api/reset/checkToken") else { return }
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                           

                guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
                request.httpBody = httpBody
                        
                let session = URLSession.shared
                session.dataTask(with: request) { (data, response, error) in
                    if let response = response {
                        print(response)
                    }
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            print(json)
                            
                            //we get message and the the same temporary token
                            
                        } catch {
                            print(error)
                        }
                    }
                }.resume()
    }
}

extension WelcomeSecondVC {
    
    func configureLabelsInWelcomeSecondVC() {
        usernameHeaderLabel.configureGeneralLabelFont()
        usernameWarningLabel.configureFooterLabelFont()
        passwordHeadreLabel.configureGeneralLabelFont()
        passwordWarningLabel.configureFooterLabelFont()
        //loginLabel.configureToolBarLabelFont()
    }
    func configureButtonsInWelcomeSecondVC() {
        newUserButton.configureButtonFont()
        forgotPasswordButton.configureButtonFont()
    }
    
    func loginButtonTapped() {
        
        let homeVc = self.storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeVC
        homeVc.modalPresentationStyle = .fullScreen
        view.configurePresentAnimation()
        present(homeVc, animated: false, completion: nil)
        guard let emailLogin = usernameTextField.text else { return }
        guard let passwordLogin = passwordTextField.text else { return }
        print("Emmail is \(emailLogin)")
        print("Password is \(passwordLogin)")
        let parametersLogin = ["username" : emailLogin, "password" : passwordLogin]
        guard let urlLogin = URL(string: "https://osos-testing.herokuapp.com/api/auth/signin") else { return }
        var requestLogin = URLRequest(url: urlLogin)
        requestLogin.httpMethod = "POST"
        requestLogin.addValue("application/json", forHTTPHeaderField: "Content-Type")
           
        guard let httpBody1 = try? JSONSerialization.data(withJSONObject: parametersLogin, options: []) else { return }
        requestLogin.httpBody = httpBody1
           
        let session1 = URLSession.shared
        session1.dataTask(with: requestLogin) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse {
                statusCode = response.statusCode
                print(response)
                print("Status code is \(statusCode)")
                
            
        
            }
            if let data = data {
                do {
                    let json1 = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json1)
                       
                    
                   //if statusCode != 200 { // error
//                        statusInfo = try JSONDecoder().decode(StatusInfo.self, from: data)
//                        statusFromStatusInfo = statusInfo.status  // string of status i.e success or failed
//                        messageFromStatusInfo = statusInfo.message
//                        let alert = UIAlertController(title: "Try Again", message: messageFromStatusInfo, preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                        self.present(alert, animated: true, completion: nil)
//                        /} else if statusCode == 200 {
                                permanentInfo = try JSONDecoder().decode(PermanentInfo.self, from: data)
                    idFromOtpSubmit = permanentInfo.id
                                permanentToken = permanentInfo.token
                                print("Permanent token when retrieved \(permanentToken)")
                                UserDefaults.standard.set(permanentToken, forKey: permanentTokenKey)
                                permanentToken = UserDefaults.standard.object(forKey: permanentTokenKey) as! String
                                print("Token saved permanently from token key is \(permanentToken)")
                                
                                print("id from user = \(idFromOtpSubmit)")
                                
                                otpresponse = try JSONDecoder().decode(otpResponse.self, from: data)
                                detailsFromSignUp = otpresponse.details
                                print("details in otp vc is \(detailsFromSignUp)")
                            
                      //  }
                    
                } catch {
                    print(error)
                }
            }
            
        }.resume()
    }
    
    
    
}

extension PasswordSecondVC5 {
    
    func configureLabelsInPasswordSecondVC5() {
        
        
    }
}

extension ForgotPasswordSecondVC {
    
    func configureLabelsInForgotPasswordSecondVC() {
        emailHeaderLabel.configureGeneralLabelFont()
        //bottomBorderLabel.configureLabelFont()
        emailWarninglabel.configureFooterLabelFont()
        emailHeadLabel.configureGeneralLabelFont()
        emailMessageLabel.configureGeneralLabelFont()
        //forgotPassLabel.configureToolBarLabelFont()
        
    }
    
    func httpReqEnterEmail() {
        emailFromForgotPass = emailTextField.text!
        let parameter = ["email" : emailFromForgotPass]
        guard let url = URL(string: "https://osos-testing.herokuapp.com/api/reset") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                   

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: []) else { return }
        request.httpBody = httpBody
                
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json1 = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json1)
                    
                    //message and temporary token
                    resetPassTokenInfo = try JSONDecoder().decode(ResetPassTokenInfo.self, from: data)
                    temporaryToken = resetPassTokenInfo.token
                    print("temporary token is \(temporaryToken)")
                    
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
}

extension HomeVC {
    
    func configureButtonsInHomeVC() {
        logoutButton.configureButtonFont()
        logoutButton.configureButtonStyle(title: "Logout", cornerRadius: 20)
    }
    
    func httpReqLogoutButtonTapped() {
        
        let parameters = ["id" : idFromOtpSubmit]
        print("id is\(idFromOtpSubmit)")
        //print(<#T##items: Any...##Any#>)
            guard let url = URL(string: "https://osos-testing.herokuapp.com/api/auth/logout") else { return }
               var request = URLRequest(url: url)
               request.httpMethod = "POST"
               request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                          

               guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
               request.httpBody = httpBody
                       
               let session = URLSession.shared
               session.dataTask(with: request) { (data, response, error) in
                   if let response = response {
                       print(response)
                   }
                   if let data = data {
                       do {
                           let json1 = try JSONSerialization.jsonObject(with: data, options: [])
                           print(json1)
                           
                           
                           
                           
                       } catch {
                           print(error)
                       }
                   }
               }.resume()
    }
}
