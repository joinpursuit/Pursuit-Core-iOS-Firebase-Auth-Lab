//
//  AuthSession.swift
//  FirebaseAuthLab
//
//  Created by Ahad Islam on 3/12/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import Foundation
import FirebaseAuth

enum AuthError: Error {
    case authenticationError(Error)
    case noData
}

final class AuthSession {
    public static let current = AuthSession()
    private init () {}
    
    public func createNewUser(_ email: String, password: String, completion: @escaping (Result<AuthDataResult, AuthError>) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(.failure(.authenticationError(error)))
            } else if let result = result {
                completion(.success(result))
            } else {
                completion(.failure(.noData))
            }
            
        }
    }
    
    public func signExistingUser(_ email: String, password: String, completion: @escaping (Result<AuthDataResult, AuthError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(.failure(.authenticationError(error)))
            } else if let result = result {
                completion(.success(result))
            } else {
                completion(.failure(.noData))
            }
            
        }
    }
    

    
}
