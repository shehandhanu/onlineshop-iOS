//
//  HomeScreen.swift
//  OnlineShop
//
//  Created by Shehan Dhanuddara on 2022-04-17.
//

import SwiftUI

struct HomeScreen: View {
    
    let data = Array(1...1000).map{"Item \($0)"}
    
    let layout = [
        GridItem(.flexible(minimum : 10)),
        GridItem(.flexible(minimum : 10))
    ]
    
    var image : String = "https://res.cloudinary.com/shehandhanu/image/upload/v1650823482/onlinestore/2_x3qu9v.jpg"
    
    @State var productList : [Product] = []
    
    func getMethod() {
            guard let url = URL(string: "https://online-shop-backend-shehan.herokuapp.com/api/v1/product/getproducts") else {
                print("Error: cannot create URL")
                return
            }
        
            // Create the url request
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
            request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
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

                    guard let productResponse = try? JSONDecoder().decode(GetProductResponse.self, from: data)
                    else {
                        print("cannot decode json")
                        return
                    }
                    
                    productList = productResponse.product
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }.resume()
        }
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Text("Featured Products")
                        .padding(.leading, 15)
                        .padding(.top, 5)
                        .font(.system(size: 20, weight: .bold))
                    
                    Spacer()
                    
                    Button(action: {})
                    {
                        NavigationLink(destination : ProductScreen(screenName: "Featured Products", productList: $productList)){
                            HStack{
                                Text("View All")
                                    .font(.subheadline)
                                Image(systemName: "chevron.forward")
                            }
                        }
                    }
                    .padding(.trailing, 30)
                    .foregroundColor(Color.black)
                }
                .padding(.top, 20)
                
                LazyVGrid(columns: layout, spacing: 20){
                    ForEach(productList.reversed().prefix(4), id: \.self) { item in
                        HStack{
                            HomeTile(product: item)
                        }
                    }
                }
                .padding(.horizontal)
            }.padding(.bottom)
            
            Divider()
            
            VStack{
                HStack{
                    Text("New Products")
                        .padding(.leading, 15)
                        .padding(.top, 5)
                        .font(.system(size: 20, weight: .bold))
                    
                    Spacer()
                    
                    Button(action: {})
                    {
                        NavigationLink(destination : ProductScreen(screenName: "New Products", productList: $productList)){
                            HStack{
                                Text("View All")
                                    .font(.subheadline)
                                Image(systemName: "chevron.forward")
                            }
                        }
                    }
                    .padding(.trailing, 30)
                    .foregroundColor(Color.black)
                    
                }
                
                LazyVGrid(columns: layout, spacing: 20){
                    ForEach(productList.prefix(4), id: \.self) { item in
                        HStack{
                            HomeTile(product : item)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            getMethod()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
            HomeScreen()
    }
}
