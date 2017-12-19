//
//  TableViewModel.swift
//  SIgnUpForm
//
//  Created by admin on 03.12.2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class TableViewModel {
  
    static let tableObject = TableViewModel()
    var tableCells: [BaseViewModel]
    var tableCellsObject: BehaviorSubject<[BaseViewModel]>

    let isFormValid = Variable(false)
    let message = Variable<String?>(nil)
    let confirmButton = ButtonViewModel()
    let disposeBag = DisposeBag()

    init() {
    
    tableCells = [
            TextFieldViewModel(placeholder: "Name", required: true),
            TextFieldViewModel(placeholder: "Surname"),
            PhoneViewModel(required: true),
            EmailViewModel(placeholder: "E-Mail", required: true),
            TextFieldViewModel(placeholder: "Website"),
            confirmButton
        ]
        
        isFormValid.asDriver()
            .drive(confirmButton.isActive)
            .disposed(by: disposeBag)
        
        confirmButton.message.asDriver()
            .drive(message)
            .disposed(by: disposeBag)
        
        
// валидация
    let validable = tableCells.filter { (vm) -> Bool in
            guard let casted = vm as? Validable else {
                return false
            }
            return casted.required
        }.map({
            return ($0 as! Validable).validable.asObservable()
        })
        
        Observable.combineLatest(validable) { (vms: [Bool]) -> Bool in
            return vms.reduce(true) { $0 && $1 }
        }
        .bind(to: isFormValid)
        .disposed(by: disposeBag)
        
        tableCellsObject = BehaviorSubject(value: tableCells)
}
    
    // делаем красную рамку для невалидных полей
    func color(for bool: Bool) -> UIColor {
        return (bool ? UIColor.clear : UIColor.red)
    }
    
    func validityColor(for view: UIView, color: UIColor) {
        UITextField.animate(withDuration: 0.5, animations: {
            view.layer.borderColor = color.cgColor
            view.layer.borderWidth = 0.5
        })
    }

}

