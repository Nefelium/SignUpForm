//
//  TextField.swift
//  SIgnUpForm
//
//  Created by admin on 30.11.2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class TextField: UITableViewCell, BaseTableCell {
    
    @IBOutlet weak var textField: UITextField!
    
    let disposeBag = DisposeBag()
    
    var vm: BaseViewModel? {
        didSet {
            let vm = self.vm as! TextFieldViewModel
            textField.placeholder = vm.placeholder.value
            
            textField.rx.text.orEmpty.asDriver()
                .drive(vm.text)
                .disposed(by: disposeBag)
            
            vm.validable.asDriver()
                .map(TableViewModel.tableObject.color)
                .map({(self.textField, $0)})
                .drive(onNext: TableViewModel.tableObject.validityColor)
                .disposed(by: disposeBag)
        }
    }
    
   
}
