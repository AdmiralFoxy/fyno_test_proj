//
//  ViewState.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 16.06.2024.
//

import Foundation

enum ViewState: Equatable {
    
    case idle
    case loading
    case onSuccess
    case onError(message: String)
    
}
