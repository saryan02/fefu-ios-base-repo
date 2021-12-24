//
//  Models.swift
//  fefuactivity
//
//  Created by wsr3 on 16.12.2021.
//

import Foundation

struct RegModel: Encodable{
    let login: String
    let password: String
    let confirmPassword: String
    let gender: Int
    let name: String
}

struct Gender: Decodable {
    let code: Int
    let name: String
}

struct LogModel: Encodable{
    let login: String
    let password: String
}

struct UserModelToken: Decodable {
    let token: String
    let user: UserModel
}

struct ErrorModel: Decodable {
    let errors: Dictionary<String, [String]>
}

struct UserModel: Decodable {
    let id: Int
    let login: String
    let name: String
}
