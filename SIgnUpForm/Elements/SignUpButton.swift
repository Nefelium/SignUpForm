//
//  SignUpButton.swift
//  SIgnUpForm
//
//  Created by admin on 30.11.2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class SignUpButton: UITableViewCell, BaseTableCell {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var button: UIButton!
    var vm: BaseViewModel? {
        didSet {
            let vm = self.vm as! ButtonViewModel
            
            vm.isActive.asDriver()
                .drive(button.rx.isEnabled)
                .disposed(by: disposeBag)
            
            button.rx.tap
                .subscribe({ _ in
                    vm.buttonOk()
                }).disposed(by: disposeBag)
        }
    }
}
