//
//  UIImageView.swift
//  CoffeeHUB
//
//  Created by Abdallah on 30/11/2022.
//

import UIKit


extension UIImageView{
    
    func setImage(_ imageURL : String , placeholderImage : UIImage){
        
        let cache           = NSCache<NSString , UIImage>()
        let imageFileName   = fileNameFrom(fileURL: imageURL)
        let cacheKey        = NSString(string: imageFileName)
        
        if let cacheImage = cache.object(forKey: cacheKey){
            image = cacheImage
            return
        }
        
        if fileExistAtPath(path: imageFileName){
            if let contenentOfFile = UIImage(contentsOfFile: fileInDocumentDirectory(fileName: imageFileName))!.imageByMakingWhiteBackgroundTransparent(){
                image = contenentOfFile
                cache.setObject(contenentOfFile, forKey: cacheKey)
            }else{ image = placeholderImage }
        }else{
            if imageURL != ""{
                let documentURL = URL(string: imageURL)
                let downloadQueue = DispatchQueue(label: "imageDownloadQueue")
                downloadQueue.async {
                    let data = NSData(contentsOf: documentURL!)
                    if data != nil{
                        saveFileLocally(fileData: data!, fileName: imageFileName)
                        DispatchQueue.main.async{
                            let onlineImage = UIImage(data: data! as Data)?.imageByMakingWhiteBackgroundTransparent()
                            self.image = onlineImage
                            if let onlineImage = onlineImage {
                                cache.setObject(onlineImage, forKey: cacheKey)
                            }
                        }
                    }else{
                        DispatchQueue.main.async{
                            self.image = placeholderImage
                        }
                    }
                }
            }else{ self.image = placeholderImage }
        }
    }
    
}


extension UIImage {
    
    func imageByMakingWhiteBackgroundTransparent() -> UIImage? {
        
        let image = UIImage(data: self.jpegData(compressionQuality: 1.0)!)!
        let rawImageRef: CGImage = image.cgImage!
        
        let colorMasking: [CGFloat] = [222, 255, 222, 255, 222, 255]
        UIGraphicsBeginImageContext(image.size);
        
        let maskedImageRef = rawImageRef.copy(maskingColorComponents: colorMasking)
        UIGraphicsGetCurrentContext()?.translateBy(x: 0.0,y: image.size.height)
        UIGraphicsGetCurrentContext()?.scaleBy(x: 1.0, y: -1.0)
        UIGraphicsGetCurrentContext()?.draw(maskedImageRef!, in: CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height))
        let result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return result
        
    }
    
    func decodedImage() -> UIImage {
        guard let cgImage = cgImage else { return self }
        let size = CGSize(width: cgImage.width, height: cgImage.height)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: cgImage.bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        context?.draw(cgImage, in: CGRect(origin: .zero, size: size))
        guard let decodedImage = context?.makeImage() else { return self }
        return UIImage(cgImage: decodedImage)
    }
    
}

