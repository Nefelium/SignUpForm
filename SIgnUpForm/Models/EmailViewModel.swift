//
//  EmailViewModel.swift
//  SIgnUpForm
//
//  Created by admin on 15.12.2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import SwiftValidators

class EmailViewModel: BaseViewModel, Validable {
    
    let text = Variable("")
    var required: Bool
    var validable: Variable<Bool> = Variable(false)
    let placeholder: Variable<String?>
    let disposeBag = DisposeBag()
    
    init(placeholder: String, required: Bool, validable: Bool) {
        self.placeholder = Variable(placeholder)
        self.required = required
        self.validable = Variable(validable)
    }
    
    convenience init() {
        self.init(placeholder: "", required: false, validable: true)
    }
    
    convenience init(placeholder: String) {
        self.init(placeholder: placeholder, required: false, validable: true)
    }
    
    convenience init(placeholder: String, required: Bool) {
        self.init(placeholder: placeholder, required: required, validable: false)
        
        
        text.asDriver()
            .map({ Validator.isEmail().apply($0) })
            .drive(validable)
            .disposed(by: disposeBag)
        
    }
}
