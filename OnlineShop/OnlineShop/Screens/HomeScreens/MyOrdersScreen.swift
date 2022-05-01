//
//  MyOrdersScreen.swift
//  OnlineShop
//
//  Created by Shehan Dhanuddara on 2022-04-17.
//

import SwiftUI

struct MyOrdersScreen: View {
    
    let userDefaults = UserDefaults.standard
    @State var orderList : [Order] = []
    
    let layout = [
        GridItem(.flexible(minimum : 10))
    ]
    
    func getMethod() {
        let token = userDefaults.string(forKey: "Token")
            guard let url = URL(string: "https://online-shop-backend-shehan.herokuapp.com/api/v1/product/getorders") else {
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

                    let productResponse = try  JSONDecoder().decode(GetOrderResponse.self, from: data)
                    
                    print(productResponse)

                    orderList = productResponse.order

                } catch {
                    print(error)
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }.resume()
        }
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Text("My Orders")
                        .padding(.leading, 15)
                        .padding(.top, 5)
                        .font(.system(size: 20, weight: .bold))
                    
                    Spacer()
                }
                .padding(.top, 20)
                
                LazyVGrid(columns: layout, spacing: 5){
                    ForEach(orderList.prefix(10), id: \.self) { item in
                        VStack{
                            OrderTile(orderItem: item)
                            Divider()
                        }
                    }
                }
                .padding(.horizontal)
            }.padding(.bottom)
            
        }
        .onAppear {
            getMethod()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct MyOrdersScreen_Previews: PreviewProvider {
    static var previews: some View {
        MyOrdersScreen()
    }
}
