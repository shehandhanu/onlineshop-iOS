//
//  ProductImage.swift
//  OnlineShop
//
//  Created by Shehan Dhanuddara on 2022-04-18.
//

import SwiftUI

struct ProductImage: View {
    
    var image : String
    var body: some View {
        AsyncImage(url: URL(string: image))
            .frame(width: 325, height: 325)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct ProductImage_Previews: PreviewProvider {
    static var previews: some View {
        ProductImage(image: "https://res.cloudinary.com/shehandhanu/image/upload/v1650823482/onlinestore/2_x3qu9v.jpg")
    }
}
