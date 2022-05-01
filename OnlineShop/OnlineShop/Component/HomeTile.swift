//
//  HomeTile.swift
//  OnlineShop
//
//  Created by Shehan Dhanuddara on 2022-04-17.
//

import SwiftUI

struct HomeTile: View {
    
    var product : Product
    
    var body: some View {
        HStack{
            VStack(alignment : .leading){
                NavigationLink(destination:  ProductDetailsScreen(product: product)){
                    AsyncImage(url: URL(string: product.image))
                        .frame(width: 150, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                
                Text(product.productName)
                    .font(.system(size: 15, weight: .bold))
                Text(String(product.price))
                    .font(.system(size: 10, weight: .bold))
                
            }
        }
    }
}

struct HomeTile_Previews: PreviewProvider {
    @State static var product : Product = Product(id: "String",productName: "name", type : "type", productDescription : "description", image : "123" ,price: 50, availability: 50, v: 5)
    static var previews: some View {
        HomeTile(product: product)
    }
}
