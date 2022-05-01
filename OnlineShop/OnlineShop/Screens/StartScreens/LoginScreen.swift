//
//  LoginScreen.swift
//  OnlineShop
//
//  Created by Shehan Dhanuddara on 2022-04-15.
//

import SwiftUI

struct LoginScreen: View {
    
    let userDefaults = UserDefaults.standard
    
    func postMethod() {
            guard let url = URL(string: "https://online-shop-backend-shehan.herokuapp.com/api/v1/user/signin") else {
                print("Error: cannot create URL")
                return
            }
            
            // Create model
            struct UploadData: Codable {
                let email: String
                let password: String
            }
        
            // Add data to the model
            let uploadDataModel = UploadData(email: username, password: password)
        
            print(uploadDataModel)
            
            // Convert model to JSON data
            guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
                print("Error: Trying to convert model to JSON data")
                return
            }
            // Create the url request
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
                    alertViewShow = true
                    return
                }


                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    
                    if let token = jsonObject["token"] as? String {
                        userDefaults.set(token, forKey: "Token")
                        loginSuccess = true
                    }

                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }.resume()
        }
    
    @State var username = ""
    @State var password = ""
    @State var alertViewShow = false
    @State var passwordVisible = true
    @State var loginSuccess = false
    
    var body: some View {
        VStack{
            
            TopStartHeader(title: "Login", subTitle: "Please sign in to continue")
            
            VStack{
                TextField("Username", text: $username)
                    .textInputAutocapitalization(.never)
                    .padding(10)
                    .overlay(
                            RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                            )
                
                HStack {
                    if (passwordVisible){
                        SecureField("Password", text: $password)
                    } else {
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
                
                Button {
                    postMethod()
                } label: {
                    Text("LOGIN")
                        .frame(width: 300, height: 30)
                        .font(.system(size: 15))
                }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .tint(Color("theamBlue"))
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                
                Button {
                    print("GUEST Login")
                } label: {
                    NavigationLink(destination : ForgotPasswordScreen()){
                        Text("FORGOT PASSWORD?")
                            .frame(width: 300, height: 30)
                            .font(.system(size: 15))
                    }
                }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .foregroundColor(Color("theamBlue"))
                    .tint(Color.clear)
                
                Button {
                    print("Login")
                } label: {
                    Group {
                        Text("Don't have an account ? ").foregroundColor(.gray) +
                        Text("**SIGNUP** ").foregroundColor(Color("theamBlue")) +
                        Text("now").foregroundColor(.gray)
                    }
                        .frame(width: 300, height: 30)
                        .font(.system(size: 12))
                }
                    .buttonStyle(.plain)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .padding(.bottom, 20)
                
            }
            .padding()
            .alert(isPresented: $alertViewShow, content: {
                Alert(title: Text("Unable To Login"), message: Text("Your User Name or password worng please check and try again"), dismissButton: .default(Text("Ok")){
                    loginSuccess = false
                    username = ""
                    password = ""
                    
                })
            })
            
            NavigationLink("", destination: HomeScreenTab() ,isActive: $loginSuccess)
            
            Spacer()
            
            BottomTextButton()
            
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
