import SwiftUI

struct LogoImage: View {
    var image: Image

    var body: some View {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
    }
}

struct LogoImage_Previews: PreviewProvider {
    static var previews: some View {
        LogoImage(image: Image("online_shop_logo"))
    }
}
