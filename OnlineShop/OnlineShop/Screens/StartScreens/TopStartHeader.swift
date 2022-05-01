//
//  TopStartHeader.swift
//  OnlineShop
//
//  Created by Shehan Dhanuddara on 2022-04-15.
//

import SwiftUI

struct TopStartHeader: View {
    
    var title : String
    var subTitle : String
    
    var body: some View {
        HStack (alignment : .top){

            VStack{
                HStack{
                    Spacer()
                    VStack(alignment : .trailing){
                        LogoImage(image: Image("online_shop_logo"))
                            .opacity(0.7)
                            .frame(width: 200, height: 200, alignment: .topTrailing)
                    }
                }
                HStack{
                    VStack(alignment : .leading){
                        Text(title)
                            .bold()
                            .font(.system(size: 30))
                        Text(subTitle)
                            .foregroundColor(Color("theamBlue"))
                            .font(.system(size: 15))
                            .padding(.trailing, 30)
                    }
                    Spacer()
                }
                .frame(alignment: .bottomLeading)
            }
            .padding(.leading, 20)
        }
    }
}

struct TopStartHeader_Previews: PreviewProvider {
    static var previews: some View {
        TopStartHeader(title: "Sign Up", subTitle: "Signup for free")
//        TopStartHeader(title: "Forgot Password", subTitle: "Please ender you email address below. an email will be sent with a link for you to reset your password")
    }
}
