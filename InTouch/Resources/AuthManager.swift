//
//  AuthManager.swift
//  InTouch
//
//  Created by jesse andringa on 3/8/23.
//

import FirebaseAuth


class AuthManager{
    static let shared = AuthManager()
    
    //Mark: -- Public
    public func loginUser(userName: String?, email: String?, password: String, completion: @escaping (Bool)->Void){
        if let userName = userName {
            Auth.auth().signIn(withEmail: userName, password: password){ authResult, error in
                guard authResult != nil, error == nil else{
                    completion(false)
                    return
                }
                completion(true)
                
            }
           
        }
        else if let email = email{
            Auth.auth().signIn(withEmail: email, password: password){ authResult, error in
                guard authResult != nil, error == nil else{
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        else{
            print("username and email null")
            completion(false)
        }
    }
    public func registerNewUser(userName: String, email: String, password: String, completion: @escaping (Bool)->Void){
        /**
            -check if email is available
            -check if username is available
         */
        DatabaseManager.shared.canCreateNewUser(with: userName, email: email){ canCreate in
            if canCreate{
//                --create account
//                -insert account to db
                Auth.auth().createUser(withEmail: email, password: password){ result, error in
                    guard error == nil, result != nil else {
                        //Firebase couldn't create account
                        print("couldn't create user")
                        completion(false)
                        
                        return
                    }
                    print("created User")
                    
                    DatabaseManager.shared.insertUserIntoDatabase(with: email, userName: userName){ inserted in
                        if inserted {
                            completion(true)
                            print("inserted!")
                            return
                        }
                        else{
                            completion(false)
                            print("not inserted!")
                            return
                        }
                    }
                }
            }
            else{
                //email or username is not available
                completion(false)
            }
        }
    }
    
    ///logout function to log out user and catch error if doesn't wor
    public func logOut(completion:(Bool)->Void){
        do{
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch{
            print(error)
            completion(false)
            return
        }
    }
    
}
