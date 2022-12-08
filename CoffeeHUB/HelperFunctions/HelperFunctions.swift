//
//  HelperFunctions.swift
//  CoffeeHUB
//
//  Created by Abdallah on 30/11/2022.
//

import Foundation

//#error(" but the _ at the first on the image name file")

func fileNameFrom (fileURL : String)->String{
    let name = fileURL.components(separatedBy: "%").last
    let name1 = name?.components(separatedBy: "?").first
    let name2 = name1?.components(separatedBy: ".").first
    return name2!
}

func saveFileLocally (fileData : NSData,fileName : String){
    let docURL = getDocumentURL().appendingPathComponent(fileName, isDirectory: false)
    fileData.write(to: docURL, atomically: true)
}

func getDocumentURL()->URL{
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
}

func fileInDocumentDirectory(fileName : String) -> String {
    return getDocumentURL().appendingPathComponent(fileName).path
}

func  fileExistAtPath(path : String)->Bool{
    return FileManager.default.fileExists(atPath: fileInDocumentDirectory(fileName: path ))
}
