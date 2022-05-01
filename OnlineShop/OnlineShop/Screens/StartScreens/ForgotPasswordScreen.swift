//
//  ForgotPasswordScreen.swift
//  OnlineShop
//
//  Created by Shehan Dhanuddara on 2022-04-15.
//

import SwiftUI

struct ForgotPasswordScreen: View {
    
    func postMethod() {
            guard let url = URL(string: "https://online-shop-backend-shehan.herokuapp.com/api/v1/user/forgotpassword") else {
                print("Error: cannot create URL")
                return
            }
            
            // Create model
            struct UploadData: Codable {
                let email: String
            }
        
            // Add data to the model
            let uploadDataModel = UploadData(email: email)
        
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
                    return
                }


                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }.resume()
        }

    
    @State var email = ""
    @State var passwordVisible = true
    @State var alertViewShow = false
    @State var isAlertDoneClicked = false
    
    var body: some View {
        
        VStack{
            TopStartHeader(title: "Forgot Password", subTitle: "Please ender you email address below. an email will be sent with a link for you to reset your password")
            VStack{
                TextField("Email Address", text: $email)
                .textInputAutocapitalization(.never)
                .padding(10)
                .overlay(
                        RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                        )
                
                Button {
                    postMethod()
                    alertViewShow.toggle()
                } label: {
                    Text("SEND PASSWORD RESET LINK")
                        .frame(width: 300, height: 30)
                        .font(.system(size: 15))
                }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .tint(Color("theamBlue"))
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .alert(isPresented: $alertViewShow, content: {
                        Alert(title: Text("Password reset link sent to your inbox"), message: Text("Please login in your mail \(email) and click on the reset link to password reset"), dismissButton: .default(Text("Ok")){
                            isAlertDoneClicked = true
                        })
                    })
            }
            .padding()
            
            NavigationLink("", destination: PasswordResetScreen() ,isActive: $isAlertDoneClicked)
            
            Spacer()
            
            BottomTextButton()
        }
    
    }
}

struct ForgotPasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordScreen()
    }
}
