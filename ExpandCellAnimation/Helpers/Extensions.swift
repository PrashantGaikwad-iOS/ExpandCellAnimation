//
//  Extensions.swift
//  ExpandCellAnimation
//
//  Created by Prashant G on 11/21/18.
//  Copyright © 2018 MyOrg. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheFromUrl(urlString: String) {
        self.image = nil
        if let movieImage = imageCache.object(forKey: urlString as AnyObject) {
            self.image = movieImage as? UIImage
            return
        }
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if let downloadImage = UIImage(data: data!) {
                    imageCache.setObject(downloadImage, forKey: urlString as AnyObject)
                    self.image = downloadImage
                }
            }
        }.resume()
    }
}
