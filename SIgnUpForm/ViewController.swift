//
//  ViewController.swift
//  SIgnUpForm
//
//  Created by admin on 30.11.2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel = TableViewModel()
    let disposeBag = DisposeBag()
    
    let cellMap = [
        TextFieldViewModel.className  : TextField.className,
        PhoneViewModel.className : PhoneField.className,
        ButtonViewModel.className : SignUpButton.className,
        EmailViewModel.className : EmailField.className
    ]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.message.asDriver()
            .filter({ $0 != nil })
            .drive(onNext: self.showAlert)
            .disposed(by: disposeBag)
        
        viewModel.tableCellsObject.observeOn(MainScheduler.instance) //выстраиваем интерфейс
            .bind(to: tableView.rx.items) ({ table, row, tvc in
                let vm = self.viewModel.tableCells[row]
                let reuseId = self.cellMap[vm.className]
                
                var cell = self.tableView.dequeueReusableCell(withIdentifier: reuseId!) as! BaseTableCell & UITableViewCell
                cell.vm = vm
                return cell
            }).disposed(by: disposeBag)
    }
    
    
    func showAlert(message: String?) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .`default`))
        self.present(alert, animated: true)
    }

    

}
