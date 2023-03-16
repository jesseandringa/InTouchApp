//
//  DatabaseManager.swift
//  InTouch
//
//  Created by jesse andringa on 3/8/23.
//

import FirebaseDatabase

class DatabaseManager{
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    /// Check if email and username are available
    /// - parameters
    ///     -username : string of username
    ///     -email: string of email
    public func canCreateNewUser(with userName: String, email: String, completion: (Bool)->Void){
        completion(true)
    }
    
    
    /// Insert user into Database
    /// - parameters
    ///     -username : string of username
    ///     -email: string of email
    ///     -completion: async callback for result if entry into database succeeded
    public func insertUserIntoDatabase(with email: String, userName: String, completion: @escaping (Bool)->Void){
        //email must not have "." in it
        //insert email with attached username into db
        let key = email.makeDatabaseKeySafe()
        database.child(key).setValue(["userName": userName]) { error, _ in
            if error == nil{
                //success
                completion(true)
                return
            }
            else{
                //failed
                completion(false)
                return
            }
        }
    }
    
    //Mark - private:
    

    
    
}
