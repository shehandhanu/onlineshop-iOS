//
//  MoreScreen.swift
//  OnlineShop
//
//  Created by Shehan Dhanuddara on 2022-04-17.
//

import SwiftUI

struct MoreScreen: View {
    
    @State var isAlertDoneClicked = false
    @State var alertViewShow = false
    
    func logout() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
        
        
        
    }
    
    var body: some View {
        Button {
            logout()
            alertViewShow.toggle()
        } label: {
            Label("Logout", systemImage: "arrow.right.square")
                .alert(isPresented: $alertViewShow, content: {
                    Alert(title: Text("User Logout"), message: Text("Thank you for using this app. you can login again with user account credentiaols"), dismissButton: .default(Text("Ok")){
                        isAlertDoneClicked = true
                    })
                })
            
            NavigationLink("", destination: StartScreen() ,isActive: $isAlertDoneClicked)
        }
        
    }
    
}

struct MoreScreen_Previews: PreviewProvider {
    static var previews: some View {
        MoreScreen()
    }
}
