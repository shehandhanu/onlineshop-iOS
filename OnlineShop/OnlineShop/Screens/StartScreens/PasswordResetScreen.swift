//
//  PasswordResetScreen.swift
//  OnlineShop
//
//  Created by Shehan Dhanuddara on 2022-04-15.
//

import SwiftUI

struct PasswordResetScreen: View {
    
    @State var password = ""
    @State var confirmPassword = ""
    @State var passwordVisible = true
    @State var alertViewShow = false
    @State var isAlertDoneClicked = false
    
    var body: some View {
        VStack{
            
            TopStartHeader(title: "Reset Password", subTitle: "Reset you password for better security")
            
            VStack{
                
                HStack {
                    TextField("New Password", text: $password)
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
                    TextField("Confirm Password", text: $confirmPassword)
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
                    alertViewShow.toggle()
                } label: {
                    Text("RESET PASSWORD")
                        .frame(width: 300, height: 30)
                        .font(.system(size: 15))
                }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .tint(Color("theamBlue"))
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .alert(isPresented: $alertViewShow, content: {
                        Alert(title: Text("Password resetted successfully"), message: Text("Please login in with new credentials"), dismissButton: .default(Text("Ok")){
                            isAlertDoneClicked = true
                        })
                    })
                
                
            }.padding()
            
            NavigationLink("", destination: LoginScreen() ,isActive: $isAlertDoneClicked)
            
            Spacer()
            
            BottomTextButton()
            
        }
    }
}

struct PasswordResetScreen_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetScreen()
    }
}
