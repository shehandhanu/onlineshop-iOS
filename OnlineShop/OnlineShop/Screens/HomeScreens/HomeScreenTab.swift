//
//  HomeScreenTab.swift
//  OnlineShop
//
//  Created by Shehan Dhanuddara on 2022-04-17.
//

import SwiftUI

struct HomeScreenTab: View {
    
    @State private var selection: Tab = .featured
    @State private var queryString : String = ""
    @State private var isSearchClicked : Bool = false

    enum Tab {
        case featured
        case list
    }
    
    var body: some View {
        
        TabView(selection: $selection) {
            HomeScreen()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tab.featured)

            MyOrdersScreen()
                .tabItem {
                    Label("My Orders", systemImage: "list.bullet")
                }
                .tag(Tab.list)
            
            CartScreen()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .tag(Tab.list)
            
            MoreScreen()
                .tabItem {
                    Label("More", systemImage: "table.badge.more")
                }
                .tag(Tab.list)
        }
//        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                HStack {
                    Button(action: {})
                    {
                        Image(systemName: "line.horizontal.3")
                    }.foregroundColor(Color.black)

                    Image("online_shop_logo_2")
                        .resizable()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 40, alignment: .center)
                        .padding(UIScreen.main.bounds.size.width/5)

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
//        .searchable(text: $queryString, placement: .navigationBarDrawer)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HomeScreenTab_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenTab()
    }
}
