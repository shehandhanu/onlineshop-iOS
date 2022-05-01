//
//  ProductDetailsScreen.swift
//  Online Shop
//
//  Created by Shehan Dhanuddara on 2022-04-18.
//

import SwiftUI

struct ProductDetailsScreen: View {
    
    @State var discriptionOpened : Bool = false
    @State var lineNumbers : Int = 2
    @State var addToCartNumber : Int = 1
    
    @State var alertViewShow = false
    @State var addToCartSuccess = false
    
    var product : Product
    
    func postMethod() {
            guard let url = URL(string: "https://online-shop-backend-shehan.herokuapp.com/api/v1/product/addcart") else {
                print("Error: cannot create URL")
                return
            }
            
            // Create model
            struct UploadData: Codable {
                let quantity: String
                let product: String
            }
        
            var quantity : String = String(addToCartNumber)
        
            // Add data to the model
        let uploadDataModel = UploadData(quantity: quantity, product: product.id)
            
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
                
                let response = response as? HTTPURLResponse
                
                if(response?.statusCode == 200){
                    alertViewShow = true
                }
                
            }.resume()
        }

    let layout = [
        GridItem(.flexible(minimum : 10)),
        GridItem(.flexible(minimum : 10))
    ]
    
    var body: some View {
        VStack{
            ScrollView{
                VStack(alignment: .leading){
                    HStack{
                        ProductImage(image: product.image)
                    }
                }
                .padding(.vertical)
                .padding(.bottom, 30)
                
                VStack(alignment: .leading){
                    HStack{
                        Text("Product Name")
                            .font(.system(size: 15, weight: .bold))
                            .frame(alignment: .leading)
                        Spacer()
                    }
                    
                    Text(product.productName)
                        .font(.system(size: 30, weight: .bold))
                    
                    VStack{
                        HStack{
                            Text("Type : \(product.type)")
                                .foregroundColor(.gray)
                                .font(.system(size: 15))
                            
                            Spacer()
                            
                            Text("\(product.availability) Units Available")
                                .foregroundColor(Color("theamRed"))
                                .font(.system(size: 15))
                        }
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom)
                    
                    HStack(alignment: .bottom){
                        Text("Rs \(product.price, specifier: "%.2f")")
                            .font(.system(size: 30, weight: .bold))
                        Spacer()
                        Text("\(product.price + ((product.price/100) * 5), specifier: "%.2f") incl. GST")
                            .foregroundColor(.gray)
                            .font(.system(size: 15))
                    }
                    .padding(.trailing)
                    .padding(.bottom)
                    
                    VStack{
                        
                        VStack(alignment: .leading){
                            Text("Product Discription")
                                .font(.system(size: 20, weight: .bold))
                            VStack{
                                Text(product.productDescription)
                                    .padding(.leading)
                                    .padding(.trailing)
                                    .lineLimit(lineNumbers)
                                    .font(.system(size: 15))
                                HStack{
                                    Spacer()
                                    VStack(alignment: .trailing){
                                        !discriptionOpened ?
                                        Button(action: {
                                            discriptionOpened = true
                                            lineNumbers = 100
                                        })
                                        {
                                            Text("Read More...")
                                        }
                                        :
                                        Button(action: {
                                            discriptionOpened = false
                                            lineNumbers = 2
                                        })
                                        {
                                            Text("Show Less...")
                                        }
                                    }
                                    .foregroundColor(Color.gray)
                                    .padding(.trailing, 10)
                                }
                            }
                        }
                    }
                    
                }
                .padding(.leading)
            }
            .navigationBarBackButtonHidden(false)
            .navigationTitle(product.productName)
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
            
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        addToCartNumber -= 1
                    })
                    {
                        Image(systemName: "minus.square")
                            .resizable()
                            .background(Color("theamRed"))
                            .foregroundColor(.white)
                            .frame(width: 35, height: 35)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                    Text(String(addToCartNumber))
                        .font(.system(size: 30))
                    Button(action: {
                        addToCartNumber += 1
                    })
                    {
                        Image(systemName: "plus.square")
                            .resizable()
                            .background(Color("theamRed"))
                            .foregroundColor(.white)
                            .frame(width: 35, height: 35)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                    
                    Spacer()
                    
                    Button {
                        postMethod()
                    } label: {
                        Text("Add To Cart")
                            .frame(width: 150, height: 30)
                            .font(.system(size: 20))
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 5))
                    .tint(Color("theamRed"))
                    .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding()
            }
            .alert(isPresented: $alertViewShow, content: {
                Alert(title: Text("Add To Cart Successful"), message: Text("Your Item **\(product.productName)** Adding success you can move to cart and checkout products"), dismissButton: .default(Text("Ok")){
                    addToCartSuccess = true
                })
            })
            
            NavigationLink("", destination: CartScreen() ,isActive: $addToCartSuccess)
        }
        
    }
}

struct ProductDetailsScreen_Previews: PreviewProvider {
    @State static var product : Product = Product(id: "String",productName: "name", type : "type", productDescription : "description", image : "123" ,price: 50, availability: 50, v: 5)
    static var previews: some View {
        ProductDetailsScreen(product: product)
    }
}
