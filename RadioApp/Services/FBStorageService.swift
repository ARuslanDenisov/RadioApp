//
//  FBStorageService.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import Foundation
import FirebaseStorage
import Firebase
import UIKit
import Kingfisher

class FBStorageService: ObservableObject {
    static let shared = FBStorageService(); private init () { }
    let storage = Storage.storage()
    
    func uploadImage (image: UIImage,user: UserModel) async throws  {
        let storageRef = storage.reference().child("\(user.id)/\(user.id).jpg")
        let imageData = image.jpegData(compressionQuality: 0.5)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        if let data = imageData {
            do {
                let result = try await storageRef.putDataAsync(data, metadata: metadata)
            } catch {
                print("upload photo FBStorageService problem")
            }
            
        }
    }
    
    func downloadImage (user: UserModel ) async throws -> UIImage {
        
        let storageRef = storage.reference().child("\(user.id)/\(user.id).jpg")
        do {
            let data = try await storageRef.data(maxSize: 1 * 1024 * 1024)
            guard let image = UIImage(data: data) else { throw StorageErrors.badData}
            return image
        } catch {
            throw StorageErrors.badFetchData
        }
        
    }
    
    
    func deleteImage (user: UserModel) async throws {
        let storageRef = storage.reference().child("\(user.id)/\(user.id).jpg")
        do {
            try await storageRef.delete()
        } catch {
            throw StorageErrors.badDelete
        }
    }
}




enum StorageErrors: Error {
    case badData
    case badFetchData
    case badDelete
}
