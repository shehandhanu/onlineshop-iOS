import SwiftUI

struct OrderTile: View {
    
    var orderItem : Order
    @State static var product : Product = Product(id: "String",productName: "name", type : "type", productDescription : "description", image : "123" ,price: 50, availability: 50, v: 5)
    
    var body: some View {
        NavigationLink(destination:  ProductDetailsScreen(product : orderItem.product)){
            HStack{
                
                VStack(alignment : .leading){
                    Text(orderItem.product.productName)
                        .font(.system(size: 20, weight: .bold))
                    HStack{
                        Text(" \(String(orderItem.product.price)) x \(orderItem.quantity)")
                            .font(.system(size: 15))
                    }
                }
                .foregroundColor(.black)
                .padding(.leading, 10)
                
                Spacer()
                
                AsyncImage(url: URL(string: orderItem.product.image))
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                
            }
            .padding(5)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
    }
}
