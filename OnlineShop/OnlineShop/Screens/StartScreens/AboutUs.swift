

import SwiftUI

struct AboutUs: View {
    
    @Environment(\.presentationMode) var presentationMode
    var image = Image("team")
    
    var body: some View {
        
        NavigationView {
            VStack{
                Spacer()
                image
                    .resizable()
                    .overlay {
                        TextOverlay()
                    }
                    .frame(alignment: .top)
                Spacer()
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum")
                    .foregroundColor(.black)
                    .padding(.bottom, 100)
                Spacer()
            }
                .listStyle(.inset)
                .padding()
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading){
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Label("User Profile", systemImage: "chevron.backward")
                        }
                    }
                }
                .navigationTitle("About Us")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct TextOverlay: View {

    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                Text("Shehan Dhanuddara")
                    .font(.title)
                    .bold()
                Text("IT19167206")
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct AboutUs_Previews: PreviewProvider {
    static var previews: some View {
        AboutUs()
    }
}
