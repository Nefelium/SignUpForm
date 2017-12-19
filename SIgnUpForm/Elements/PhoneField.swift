//
//  PhoneField.swift
//  SIgnUpForm
//
//  Created by admin on 30.11.2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import AKMaskField

class PhoneField: UITableViewCell, BaseTableCell {
    
    @IBOutlet weak var phoneField: AKMaskField!
     let disposeBag = DisposeBag()
    
    var vm: BaseViewModel? {
        didSet {
            let vm = self.vm as! PhoneViewModel
        
                phoneField.rx.text.orEmpty.asDriver()
                .drive(vm.text)
                .disposed(by: disposeBag)
            
            vm.validable.asDriver()
                .map(TableViewModel.tableObject.color)
                .map({(self.phoneField, $0)})
                .drive(onNext: TableViewModel.tableObject.validityColor)
                .disposed(by: disposeBag)
        }
    }
    
}
