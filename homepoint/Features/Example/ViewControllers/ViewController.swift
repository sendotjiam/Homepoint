//
//  ViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 25/05/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

final class ViewController: UIViewController {

    let vm = ExampleViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        vm.successLogin.subscribe { print($0.element) }.disposed(by: bag)
        vm.successRegister.subscribe { print($0.element) }.disposed(by: bag)

        vm.register(model: RegisterRequestModel(email: "sendo1@mail.com", name: "sendo", password: "12345"))
        vm.login(model: LoginRequestModel(email: "sendo1@mail.com", password: "12345"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .defaultNav)
    }
    
    @IBAction func tap(_ sender: UIButton) {
        self.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(
            ViewController2(),
            animated: true
        )
        self.hidesBottomBarWhenPushed = false
    }
}
