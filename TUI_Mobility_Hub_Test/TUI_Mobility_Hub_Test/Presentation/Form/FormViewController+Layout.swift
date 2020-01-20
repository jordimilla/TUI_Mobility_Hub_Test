//
//  FormViewController+Layout.swift
//  TUI_Mobility_Hub_Test
//
//  Created by Jordi Milla on 20/01/2020.
//  Copyright © 2020 Jordi Milla Catalan. All rights reserved.
//

import UIKit

extension FormViewController {
    
    func setUpUI() {
        setUpSubviews()
        setUpConstraints()
        setUpScrollViewProperties()
        setUpContainerViewProperties()
        setUpLabels()
        setUpTextFieldsProperties()
        setUpButtons()
    }
    
    func setUpSubviews() {
        view.addSubviewWithAutolayout(scrollView)
        scrollView.addSubviewWithAutolayout(containerView)
        containerView.addSubviewWithAutolayout(lblFrom)
        containerView.addSubviewWithAutolayout(lblTo)
        containerView.addSubviewWithAutolayout(textFieldFrom)
        containerView.addSubviewWithAutolayout(textFieldTo)
        containerView.addSubviewWithAutolayout(btnPlanTrip)
        containerView.addSubviewWithAutolayout(lblPrice)
        containerView.addSubviewWithAutolayout(btnGoToMap)
    }
    
    func setUpConstraints () {
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, leftConstant: 0)
        containerView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: view.rightAnchor, leftConstant: 0)
        lblFrom.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, topConstant: 64, leftConstant: 16, rightConstant: 26)
        textFieldFrom.anchor(top: lblFrom.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, topConstant: 24, leftConstant: 16, rightConstant: 26)
        textFieldFrom.anchor(heightConstant: 50)
        lblTo.anchor(top: textFieldFrom.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, topConstant: 32, leftConstant: 16, rightConstant: 16)
        textFieldTo.anchor(top: lblTo.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, topConstant: 32, leftConstant: 16, rightConstant: 16)
        textFieldTo.anchor(heightConstant: 50)
        btnPlanTrip.anchor(top: textFieldTo.bottomAnchor, topConstant: 40)
        btnPlanTrip.anchorCenterXToSuperview()
        btnPlanTrip.anchor(heightConstant: 50)
        btnPlanTrip.anchor(widthConstant: 295)
        lblPrice.anchor(top: btnPlanTrip.bottomAnchor, left: containerView.leftAnchor, bottom: btnGoToMap.topAnchor, right: containerView.rightAnchor, topConstant: 20, bottomConstant: 20)
        btnGoToMap.anchor(bottom: containerView.bottomAnchor)
        btnGoToMap.anchorCenterXToSuperview()
        btnGoToMap.anchor(heightConstant: 50)
        btnGoToMap.anchor(widthConstant: 295)
    }
    
    func setUpScrollViewProperties() {
        scrollView.backgroundColor = .white
    }
    
    func setUpContainerViewProperties() {
        containerView.backgroundColor = .white
    }
    
    func setUpLabels() {
        lblFrom.text = "texfield_placeholder_from".localized()
        lblTo.text = "texfield_placeholder_to".localized()
        lblPrice.text = "0"
        lblFrom.textColor = .black
        lblTo.textColor = .black
        lblPrice.textColor = .black
        lblPrice.textAlignment = .center
        lblFrom.font = .boldSystemFont(ofSize: 14)
        lblTo.font = .boldSystemFont(ofSize: 14)
        lblPrice.font = .boldSystemFont(ofSize: 60)
    }
    
    func setUpTextFieldsProperties() {
        textFieldFrom.delegate = self
        textFieldTo.delegate = self
        textFieldFrom.layer.borderColor = UIColor.black.cgColor
        textFieldTo.layer.borderColor = UIColor.black.cgColor
        textFieldFrom.layer.borderWidth = 1.0
        textFieldTo.layer.borderWidth = 1.0
    }
    
    func setUpButtons() {
        btnPlanTrip.setBackgroundColor(.black, for: .normal)
        btnGoToMap.setBackgroundColor(.black, for: .normal)
        btnPlanTrip.setTitle("button_plan_trip".localized(), for: .normal)
        btnGoToMap.setTitle("button_go_to_map".localized(), for: .normal)
        btnPlanTrip.layer.cornerRadius = 10
        btnPlanTrip.clipsToBounds = true
        btnGoToMap.layer.cornerRadius = 10
        btnGoToMap.clipsToBounds = true
        btnGoToMap.isEnabled = false
    }
}
