import SwiftUI

final class RemoteImageURL: ObservableObject {
    @Published var data: Data = Data()
    
    init(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}

struct RemoteImageURLView: View {
    @ObservedObject var remoteImageURL: RemoteImageURL
    
    init(imageURL: String) {
        remoteImageURL = RemoteImageURL(imageURL: imageURL)
    }
    
    var body: some View {
        Image(uiImage: (remoteImageURL.data.isEmpty ? UIImage(named: "placeholder_film") : UIImage(data: remoteImageURL.data))!)
            .resizable()
            .aspectRatio(contentMode: remoteImageURL.data.isEmpty ? .fit : .fill)
    }
}
