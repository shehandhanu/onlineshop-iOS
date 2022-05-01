//
//  ProductScreen.swift
//  OnlineShop
//
//  Created by Shehan Dhanuddara on 2022-04-17.
//

import SwiftUI

struct ProductScreen: View {
    
    var screenName : String
    
    var image : String = "https://res.cloudinary.com/shehandhanu/image/upload/v1650823482/onlinestore/2_x3qu9v.jpg"
    
    
    let layout = [
        GridItem(.flexible(minimum : 10)),
        GridItem(.flexible(minimum : 10))
    ]
    
    @Binding var productList : [Product]
    
    var body: some View {
        ScrollView{
            VStack{
                LazyVGrid(columns: layout, spacing: 20){
                    ForEach(productList, id: \.self) { item in
                        HStack{
                            HomeTile(product : item)
                        }
                    }
                }
                .padding(.horizontal)
            }.padding(.bottom)
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle(screenName)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading:
                HStack {
                    Button(action: {})
                    {
                        Image(systemName: "line.horizontal.3")
                    }.foregroundColor(Color.black)
                },
            trailing:
                HStack {
                    Button(action: {})
                    {
                        Image(systemName: "magnifyingglass")
                    }
                    .foregroundColor(Color.black)
                }
        )
    }
}

struct ProductScreen_Previews: PreviewProvider {
    @State static var productList = [Product]()
    static var previews: some View {
        ProductScreen(screenName: "Featured Products", productList: $productList)
    }
}
