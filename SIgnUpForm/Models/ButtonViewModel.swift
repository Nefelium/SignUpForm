//
//  ButtonViewModel.swift
//  SIgnUpForm
//
//  Created by admin on 30.11.2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ButtonViewModel: BaseViewModel {
    
    let isActive = Variable(false)
    var message = Variable<String?>(nil)
    
    func buttonOk() {
        message.value = "Successfully!"
    }
}

extension UIButton {
    @IBInspectable var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { return layer.cornerRadius }
    }
}
