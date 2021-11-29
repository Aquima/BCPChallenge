//
//  MessageError.swift
//  BCPChallenge
//
//  Created by Raul on 29/11/21.
//

import Foundation
import UIKit
enum ServerError: Int {
    case unacceptable = 401
  // Throw in all other cases
    case unexpected = -1
}
struct MessageError {
    let title: String
    let message: String
    init(serverError: ServerError) {
        switch serverError {
        case .unacceptable:
            title = "Credenciles"
            message = "Las credenciales son incorrectas intentelo mas tarde."
        default:
            title = "Ha ocurrido un error."
            message = "Intentelo mas tarde"
        }
    }
}

