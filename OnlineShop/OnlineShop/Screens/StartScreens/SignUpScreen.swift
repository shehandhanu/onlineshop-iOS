//
//  SignUpScreen.swift
//  OnlineShop
//
//  Created by Shehan Dhanuddara on 2022-04-15.
//

import SwiftUI

struct SignUpScreen: View {
    
    let userDefaults = UserDefaults.standard
    
    func postMethod() {
        guard let url = URL(string: "https://online-shop-backend-shehan.herokuapp.com/api/v1/user/signup") else {
            print("Error: cannot create URL")
            return
        }
        
        // Create model
        struct UploadData: Codable {
            let firstName: String
            let lastName : String
            let email: String
            let password : String
        }
        
        // Add data to the model
        let uploadDataModel = UploadData(firstName: firstName,lastName: lastName,email: email,password: password)
        
        print(uploadDataModel)
        
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
//         Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }

            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                
                print(jsonObject)
                
                if let token = jsonObject["token"] as? String {
                    userDefaults.set(token, forKey: "Token")
                    print(token)
                }
                
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = "" {
        didSet{
            print("sample")
            passwordMatching()
        }
    }
    @State var passwordVisible = true
    @State var matchedPasswords = true
    
    func passwordMatching(){
        if(password == confirmPassword){
            matchedPasswords = true
        }else{
            matchedPasswords = false
        }
    }
    
    var body: some View {
        
        VStack{
            
            TopStartHeader(title: "Sign Up", subTitle: "Signup for free")
            
            VStack (spacing: 10) {
                
                TextField("First Name", text: $firstName)
                    .textInputAutocapitalization(.never)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                TextField("Last Name", text: $lastName)
                    .textInputAutocapitalization(.never)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                TextField("Email Address", text: $email)
                    .textInputAutocapitalization(.never)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                HStack {
                    if(passwordVisible){
                        SecureField("Password", text: $password)
                    } else{
                        TextField("Password", text: $password)
                    }
                    
                    Button {
                        passwordVisible.toggle()
                    } label: {
                        Label("Toggle Password", systemImage: passwordVisible ? "eye" : "eye.slash")
                            .labelStyle(.iconOnly)
                            .foregroundColor((Color(UIColor.lightGray)))
                    }
                }
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                HStack {
                    if(passwordVisible){
                        SecureField("Confirm Password", text: $confirmPassword)
                    } else{
                        TextField("Confirm Password", text: $confirmPassword)
                    }
                    Button {
                        passwordVisible.toggle()
                    } label: {
                        Label("Toggle Password", systemImage: passwordVisible ? "eye" : "eye.slash")
                            .labelStyle(.iconOnly)
                            .foregroundColor((Color(UIColor.lightGray)))
                    }
                }
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
            .padding()
            
            Button {
                postMethod()
            } label: {
                Text("SIGNUP")
                    .frame(width: 300, height: 30)
                    .font(.system(size: 15))
            }
            .disabled(matchedPasswords == false)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle(radius: 10))
            .tint(Color("theamBlue"))
            .padding(.bottom, 10)
            .padding(.top, 10)
            
            Button {
                print("Login")
            } label: {
                Group {
                    Text("Already have an account ? ").foregroundColor(.gray) +
                    Text("**SIGNIN** ").foregroundColor(Color("theamBlue")) +
                    Text("now").foregroundColor(.gray)
                }
                .frame(width: 300, height: 30)
                .font(.system(size: 12))
            }
            .buttonStyle(.plain)
            .buttonBorderShape(.roundedRectangle(radius: 10))
            .padding(.bottom, 20)
            
            Spacer()
            
            BottomTextButton()
        }
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
