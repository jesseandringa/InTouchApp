//
//  StorageManager.swift
//  InTouch
//
//  Created by jesse andringa on 3/8/23.
//
import FirebaseStorage
import Foundation

class StorageManager{
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    public enum StorageManagerError: Error{
        case failedToDownload
    }
    
    //Mark- Public:
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>)->Void){
        
    }
    
    public func downloadUserPost(with reference: String, completion: @escaping (Result<URL , StorageManagerError>)->Void) {
        bucket.child(reference).downloadURL(completion: { url, error in
            guard let url = url, error == nil else{
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(url))
        })
    }
}

enum UserPostType{
    case photo, video
}
public struct UserPost{
    let postType: UserPostType
}
