//
//  BottomTextButton.swift
//  OnlineShop
//
//  Created by Shehan Dhanuddara on 2022-04-15.
//

import SwiftUI

struct BottomTextButton: View {
    
    @State private var showingAboutUS = false
    @State private var showingTAndC = false
    @State private var showingPrivacy = false
    
    var body: some View {
        HStack{
                Spacer()
                Button{
                    showingAboutUS.toggle()
                } label: {
                    Text("About us")
                }
                .sheet(isPresented: $showingAboutUS){
                    AboutUs()
                }
                
                Spacer()
                
                Button{
                    showingTAndC.toggle()
                } label: {
                    Text("Terms & Conditions")
                }
                .sheet(isPresented: $showingTAndC){
                    TAndC()
                }
                
                Spacer()
                
                Button{
                    showingPrivacy.toggle()
                } label: {
                    Text("Privacy")
                }
                .sheet(isPresented: $showingPrivacy){
                    Privacy()
                }
                Spacer()
            
        }
        .buttonStyle(.plain)
        .foregroundColor(Color("theamBlue"))
        .font(.system(size: 12))
    }
}

struct BottomTextButton_Previews: PreviewProvider {
    static var previews: some View {
        BottomTextButton()
    }
}
