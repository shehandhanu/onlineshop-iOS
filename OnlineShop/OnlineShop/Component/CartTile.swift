import SwiftUI

struct CartTile: View {
    
    var cartItem : Cart
    @State static var product : Product = Product(id: "String",productName: "name", type : "type", productDescription : "description", image : "123" ,price: 50, availability: 50, v: 5)
    
    var body: some View {
        NavigationLink(destination:  ProductDetailsScreen(product : cartItem.product)){
            HStack{
                
                VStack(alignment : .leading){
                    Text(cartItem.product.productName)
                        .font(.system(size: 20, weight: .bold))
                    HStack{
                        Text(" \(String(cartItem.product.price)) x \(cartItem.quantity)")
                            .font(.system(size: 15))
                    }
                }
                .foregroundColor(.black)
                .padding(.leading, 10)
                
                Spacer()
                
                AsyncImage(url: URL(string: cartItem.product.image))
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                
            }
            .padding(5)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
    }
}

//struct CartTile_Previews: PreviewProvider {
//    static var previews: some View {
//        CartTile()
//    }
//}
