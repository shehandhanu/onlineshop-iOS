import SwiftUI

struct StartScreen: View {
    
    @State var goWhenTrue : Bool = false
    
    var body: some View {
        ScrollView{
            
            LogoImage(image: Image("online_shop_logo"))
                .offset(y: 20)
                .padding(.bottom, 50)
            
            VStack(alignment: .leading){
                
                Button {
                    print("Login")
                } label: {
                    NavigationLink(destination : LoginScreen()){
                        Text("LOGIN")
                            .frame(width: 300, height: 30)
                            .font(.system(size: 15))
                    }
                }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .tint(Color("theamBlue"))
                    .foregroundColor(.white)
                
                Button {
                    goWhenTrue = true
                    print(goWhenTrue)
                } label: {
                    NavigationLink(destination : SignUpScreen()){
                        Text("SIGNUP")
                            .frame(width: 300, height: 30)
                            .font(.system(size: 15))
                    }
                }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .foregroundColor(Color("theamBlue"))
                
                Button {
                    print("GUEST Login")
                } label: {
                    NavigationLink(destination : HomeScreenTab()){
                        Text("GUEST LOGIN")
                            .frame(width: 300, height: 30)
                            .font(.system(size: 15))
                    }
                    
                }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .foregroundColor(Color("theamBlue"))
                    .tint(Color.clear)
            }
            .padding(.bottom, 30)
            
            Spacer()
            
            BottomTextButton()
            
        }
        
    }
}

struct StartScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StartScreen()
                .previewLayout(.device)
                .previewDevice("iPhone 12 Pro")
        }
    }
}
