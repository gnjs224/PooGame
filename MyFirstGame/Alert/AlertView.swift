//
//  AlertView.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/31.
//

import UIKit

class AlertView: UIView {
    
    let alertLabel = UILabel()
    let okayButton = UIButton()
    let cancelButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(text: String){
        setupAlertLabel()
        setupOkayButton()
        setupCancelButton()
        alertLabel.text = text
    }
    func setupAlertLabel() {
        addSubview(alertLabel)
        alertLabel.numberOfLines = 0
        alertLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(30)
        }
        
    }
    func setupOkayButton() {
        addSubview(okayButton)
        
        okayButton.setTitle("확인", for: .normal)
        
        okayButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview().offset(30)
        }
    }
    func setupCancelButton() {
        addSubview(cancelButton)
        
        cancelButton.setTitle("취소", for: .normal)
        
        cancelButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview().offset(-30)
        }
    }
}
