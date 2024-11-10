//
//  ImageCacheService.swift
//  RecipeApp
//
//  Created by Mit Sheth on 11/8/24.
//

import SwiftUI

struct ImageView: View {
    let imageUrl: URL
    let placeholderImage: UIImage?
    
    @State private var loadedImage: UIImage?
    @State private var isLoading = false
    
    var body: some View {
        Group {
            if let image = loadedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Image(uiImage: placeholderImage ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay {
                        if isLoading {
                            ProgressView()
                        }
                    }
            }
        }
        .onAppear {
            loadAndCacheImage()
        }
    }
    
    private func loadAndCacheImage() {
        guard loadedImage == nil && !isLoading else { return }
        isLoading = true
        
        UIImageView().load(url: imageUrl, placeholder: placeholderImage) { image in
            loadedImage = image
            isLoading = false
        }
    }
}

extension UIImageView {
    func load(url: URL, placeholder: UIImage?, cache: URLCache? = nil, completion: @escaping (UIImage?) -> Void) {
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        
        // Check if the image data is already cached
        if let cachedData = cache.cachedResponse(for: request)?.data,
           let cachedImage = UIImage(data: cachedData) {
            DispatchQueue.main.async {
                self.image = cachedImage
                completion(cachedImage)
            }
            return
        }
        
        // Set placeholder while loading
        self.image = placeholder
        
        // Download image if not in cache
        var task: URLSessionTask?
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self, weak task] (data, response, error) in
            task?.cancel()
            task = nil
            
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode,
                  let downloadedImage = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            // Cache the downloaded image data
            let cachedData = CachedURLResponse(response: httpResponse, data: data)
            cache.storeCachedResponse(cachedData, for: request)
            
            DispatchQueue.main.async {
                self?.image = downloadedImage
                completion(downloadedImage)
            }
        }
        task = dataTask
        dataTask.resume()
    }
}
