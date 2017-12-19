//
//  TableViewModel.swift
//  SIgnUpForm
//
//  Created by admin on 30.11.2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit
import AKMaskField

class PhoneViewModel: BaseViewModel, Validable {
    
    let text = Variable("")
    var required: Bool
    var validable: Variable<Bool> = Variable(false)
    let disposeBag = DisposeBag()
    
    init(required: Bool, validable: Bool) {
        self.required = required
        self.validable = Variable(validable)
    }
    
    convenience init() {
        self.init(required: false, validable: true)
    }
    
    convenience init(required: Bool) {
        self.init(required: required, validable: false)
        
        let underline : Character = "_"
        text.asDriver()   
            .skip(1)
            .map({ $0.last! != underline })
            .drive(validable)
            .disposed(by: disposeBag)
 
    }
    
}
