//
//  AlertViewController.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/31.
//

import UIKit

class AlertViewController: UIViewController {
    let alertView = AlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView.configure(text: "Asda")
        setupAlertView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    func setupAlertView() {
        view.addSubview(alertView)
        [alertView.cancelButton, alertView.okayButton].forEach{
            $0.addTarget(self, action: #selector(touchUpAlertButton(_:)), for: .touchUpInside)
        }
        alertView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(100)
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(300)
        }
    }
    
    @objc
    func touchUpAlertButton(_ sender: UIButton) {
        switch sender {
        case alertView.okayButton:
            // TODO: - 화면전환
            print(sender)
        case alertView.cancelButton:
            dismiss(animated: false)
        default:
            print("sender is not safe")
        }
    }
    


}
