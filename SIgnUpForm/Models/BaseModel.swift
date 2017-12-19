//
//  BaseModel.swift
//  SIgnUpForm
//
//  Created by admin on 30.11.2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import RxSwift

protocol Model {
    static var className: String { get }
    var className: String { get }
}

extension Model {
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}

extension NSObject: Model {
}

protocol BaseViewModel: Model {
}

protocol Validable {
    var validable: Variable<Bool> { get }
    var required: Bool { get }
}
