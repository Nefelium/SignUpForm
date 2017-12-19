//
//  EmailField.swift
//  SIgnUpForm
//
//  Created by admin on 15.12.2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class EmailField: UITableViewCell, BaseTableCell {
    
    @IBOutlet weak var email: UITextField!
    
    let disposeBag = DisposeBag()
    
    var vm: BaseViewModel? {
        didSet {
            let vm = self.vm as! EmailViewModel
            email.placeholder = vm.placeholder.value
            
            email.rx.text.orEmpty.asDriver()
                .drive(vm.text)
                .disposed(by: disposeBag)
            
            vm.validable.asDriver()
                .map(TableViewModel.tableObject.color)
                .map({(self.email, $0)})
                .drive(onNext: TableViewModel.tableObject.validityColor)
                .disposed(by: disposeBag)
        }
    }
    
}
