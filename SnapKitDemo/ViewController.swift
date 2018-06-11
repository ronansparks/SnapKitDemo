//
//  ViewController.swift
//  SnapKitDemo
//
//  Created by Ronan on 6/11/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITextFieldDelegate {

    lazy var animationBox = UIView()
    var scale = 1.0
    
    var topConstraint: Constraint?
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        centeredOrangeBox()
//
//        bottomRightGreenBox()
//
//        twoEqualBars()
//
//        twoInsetBoxes()
//
//        setupGesture()
//        setupAnimationBox()
        
        
        setupLogIn()
    }
    
    //MARK: Centered Boxes
    func centeredOrangeBox() {
        let box = UIView()
        box.backgroundColor = .orange
        view.addSubview(box)
        
        box.snp.makeConstraints { (make) in
            make.size.equalTo(100)
            make.center.equalTo(view)
        }
    }
    
    //MARK: Bottom-Right Box
    func bottomRightGreenBox() {
        let box = UIView()
        box.backgroundColor = .green
        view.addSubview(box)
        
        box.snp.makeConstraints { (make) in
            make.size.equalTo(100)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    //MARK: Top Bars
    func twoEqualBars() {
        let orangeBar = UIView()
        orangeBar.backgroundColor = .orange
        view.addSubview(orangeBar)
        
        orangeBar.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        }
        
        let greenBar = UIView()
        greenBar.backgroundColor = .green
        view.addSubview(greenBar)
        
        greenBar.snp.makeConstraints { (make) in
            make.width.height.equalTo(orangeBar)
            make.top.equalTo(orangeBar.snp.bottom)
            make.left.equalTo(orangeBar)
        }
    }
    
    //MARK: Bottom-Left Boxes
    func twoInsetBoxes() {
        let bigBox = UIView()
        bigBox.backgroundColor = .orange
        view.addSubview(bigBox)
        
        bigBox.snp.makeConstraints { (make) in
            make.size.equalTo(100)
            make.left.bottom.equalToSuperview()
        }
        
        let smallBox = UIView()
        smallBox.backgroundColor = .green
        bigBox.addSubview(smallBox)
        
        smallBox.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(10, 15, 20, 25))
        }
    }
    
    // Animation
    func setupGesture() {
        let tapSingle = UITapGestureRecognizer(target: self, action: #selector(tapSingleDid))
        tapSingle.numberOfTapsRequired = 1
        tapSingle.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapSingle)
    }
    
    @objc func tapSingleDid() {
        scale += 0.5
        view.setNeedsUpdateConstraints()
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func setupAnimationBox() {
        animationBox.backgroundColor = .yellow
        view.addSubview(animationBox)
        
        animationBox.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.width.height.equalTo(100 * scale).priority(250)
            make.width.height.lessThanOrEqualTo(view.snp.width)
            make.width.height.lessThanOrEqualTo(view.snp.height)
        }
        
    }
    
    override func updateViewConstraints() {
        animationBox.snp.updateConstraints { (make) in
            make.width.height.equalTo(100 * scale).priority(250)
        }
        
        super.updateViewConstraints()
    }
}

extension ViewController {
    func setupLogIn() {
//        let titleLabel = UILabel()
//        titleLabel.text = "Awesome SnapKit"
//        view.addSubview(titleLabel)
//        titleLabel.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.top.equalToSuperview().offset(100)
//        }
        
        let inputBox = UIView()
        inputBox.layer.borderColor = UIColor.gray.cgColor
        inputBox.layer.borderWidth = 1
        inputBox.layer.cornerRadius = 4
        view.addSubview(inputBox)
        inputBox.snp.makeConstraints { (make) in
            make.height.equalTo(81)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            self.topConstraint = make.centerY.equalTo(view).constraint
        }
        
        let seperateLine = UIView()
        seperateLine.backgroundColor = .black
        inputBox.addSubview(seperateLine)
        seperateLine.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.centerY.equalToSuperview()
        }

        let usernameTextField = UITextField()
        usernameTextField.placeholder = "Username"
        usernameTextField.delegate = self
        inputBox.addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.height.equalTo(40)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }

        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.delegate = self
        inputBox.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalTo(40)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }

        let logInButton = UIButton()
        logInButton.setTitle("Log In", for: .normal)
        logInButton.setTitleColor(.black, for: .normal)
        logInButton.addTarget(self, action: #selector(logInButtonTapped(sernder:)), for: .touchUpInside)
        view.addSubview(logInButton)
        logInButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(inputBox.snp.bottom).offset(20)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.topConstraint?.update(offset: -125)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func logInButtonTapped(sernder: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.topConstraint?.update(offset: 0)
            self.view.layoutIfNeeded()
        }
    }
    
}

