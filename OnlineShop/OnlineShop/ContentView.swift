import SwiftUI

struct ContentView: View {
    
    let userDefaults = UserDefaults.standard
    var loged : Bool = false
    
    init() {
        print("work 1")
        if(userDefaults.string(forKey: "Token") != nil){
            self.loged = true
        }
    }
    
    var body: some View {
        NavigationView{
            if !loged {
                StartScreen()
            } else {
                HomeScreenTab()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
