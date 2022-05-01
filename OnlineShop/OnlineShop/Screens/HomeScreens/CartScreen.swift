//
//  CartScreen.swift
//  OnlineShop
//
//  Created by Shehan Dhanuddara on 2022-04-17.
//

import SwiftUI

struct CartScreen: View {
    
    let userDefaults = UserDefaults.standard
    
    @State var cartList : [Cart] = []
    @State var totalPrice : Double = 0
    
    func getMethod() {
        let token = userDefaults.string(forKey: "Token")
            guard let url = URL(string: "https://online-shop-backend-shehan.herokuapp.com/api/v1/product/getcart") else {
                print("Error: cannot create URL")
                return
            }

            // Create the url request
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
            request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
            request.setValue(token, forHTTPHeaderField: "authorization")
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
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    return
                }

                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }

                    let productResponse = try  JSONDecoder().decode(GetCartResponse.self, from: data)

                    cartList = productResponse.cart

                } catch {
                    print(error)
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }.resume()
        }
    
    func calTotal(price : Double) {
        totalPrice = totalPrice + price
    }
    
    let layout = [
        GridItem(.flexible(minimum : 10))
    ]
    
    var image : String = "https://res.cloudinary.com/shehandhanu/image/upload/v1650823482/onlinestore/2_x3qu9v.jpg"
    
    
    var body: some View {
        VStack{
            ScrollView{
                VStack{
                    HStack{
                        Text("Cart")
                            .padding(.leading, 15)
                            .padding(.top, 5)
                            .font(.system(size: 20, weight: .bold))
                        
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    LazyVGrid(columns: layout, spacing: 5){
                        ForEach(cartList.prefix(10), id: \.self) { item in
//                            calTotal(price: item.product.price)
                            VStack{
                                CartTile(cartItem: item)
                                Divider()
                            }
                        }
                    }
                    .padding(.horizontal)
                }.padding(.bottom)
            }
            .navigationBarItems(
                leading:
                    HStack {
                        Button(action: {})
                        {
                            Image(systemName: "line.horizontal.3")
                        }.foregroundColor(Color.black)

                        Image("online_shop_logo")
                            .resizable()
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60, alignment: .center)
                            .padding(UIScreen.main.bounds.size.width/4+15)

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
                    
                    Text("Rs. \(String(totalPrice))")
                        .font(.system(size: 30))
                    
                    Spacer()
                    
                    Button {
                        print("Login")
                    } label: {
                        Text("Check Out")
                            .frame(width: 120, height: 30)
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
        }
        .onAppear {
            getMethod()
        }
    }
}

struct CartScreen_Previews: PreviewProvider {
    static var previews: some View {
        CartScreen()
    }
}
