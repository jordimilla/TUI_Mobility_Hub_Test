//
//  FormViewController.swift
//  TUI_Mobility_Hub_Test
//
//  Created by Jordi Milla on 20/01/2020.
//  Copyright © 2020 Jordi Milla Catalan. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {

    let scrollView = UIScrollView()
    let containerView = UIView()
    
    let lblFrom = UILabel()
    let lblTo = UILabel()
    let textFieldFrom = UITextField()
    let textFieldTo = UITextField()
    let btnPlanTrip = UIButton()
    let lblPrice = UILabel()
    let btnGoToMap = UIButton()
    
    private var viewModel: FormViewModel?
    var availableCities: Set<String>?
    
    //Mark: Static init
    static func instantiate(with params: FormParams) -> UIViewController? {
        
        let viewController = FormViewController()
        viewController.viewModel = FormViewModel(session: params.session(),
                                                           queue: params.queue(),
                                                           reachability: params.reachability())
    
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
        setUpUI()
        setTargets()
        bindOperations()
    }
    
    func setTargets() {
        btnPlanTrip.addTarget(self, action: #selector(plantTripPrice), for: .touchUpInside)
        btnGoToMap.addTarget(self, action: #selector(openMap), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let viewModel = viewModel {
            viewModel.requestConnections()
        }
    }
    
    private func bindOperations(){
           
           guard let viewModel = viewModel else {
               
               let error = Errors.unknownError
               displayAlert(title: error.title().localized(), message: error.message().localized())
               return
           }
           
           viewModel.reload = { cities in
               self.availableCities = cities
           }
           
           viewModel.displayError = { [weak self] error in
               
               guard let self = self else {
                   return
               }
               
               self.displayAlert(title: error.title().localized(), message: error.message().localized())
           }
           
           viewModel.displayCost = { [weak self] cost in
               
               guard let self = self else {
                   return
               }
               
               DispatchQueue.main.async {
                   self.lblPrice.text = cost
               }
           }
           
           viewModel.toggleMapButton = { [weak self] isEnabled in
               
               guard let self = self else {
                   return
               }
               
               DispatchQueue.main.async {
                   self.btnGoToMap.isEnabled = isEnabled
                   self.btnGoToMap.backgroundColor = isEnabled ? .black : .gray
               }
           }
       }
    
    @objc func plantTripPrice() {
        
        guard let start = textFieldFrom.text, let end = textFieldTo.text else {
            let error = Errors.unknownError
            displayAlert(title: error.title().localized(), message: error.message().localized())
            return
        }
        
        guard !start.isEmpty,!end.isEmpty else {
            let error = Errors.emptyFields
            displayAlert(title: error.title().localized(), message: error.message().localized())
            return
        }
        
        if let viewModel = viewModel {
            viewModel.requestPathAndCost(from: start, to: end)
        }
    }
    
    @objc func openMap() {
        
        guard let navigationController = navigationController else {
            
            let error = Errors.unknownError
            displayAlert(title: error.title().localized(), message: error.message().localized())
            return
        }
        
        guard let coordinates = viewModel?.coordinates else {
            let error = Errors.unknownError
            displayAlert(title: error.title().localized(), message: error.message().localized())
            return
        }
        
        let params = MapParams(coordinates: coordinates)
        
        guard let viewController = MapViewController.instantiate(with: params) else {
            let error = Errors.unknownError
            displayAlert(title: error.title().localized(), message: error.message().localized())
            return
        }
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension FormViewController: UITextFieldDelegate {
        
    func textFieldDidEndEditing(_ textField: UITextField) {

        //Check array of cities
        guard let cities = availableCities else {
            return
        }

        //Check current text
        guard let currentText = textField.text else {
            return
        }

        //Set the text to red if there is no match available
        guard cities.getMatch(for: currentText) != nil else {
            DispatchQueue.main.async {
                textField.textColor = .black
            }
            return
        }

        DispatchQueue.main.async {
            textField.textColor = .black
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        dismissKeyboard()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        //Check array of cities
        guard let cities = availableCities else {
            return true
        }

        //Check current text
        guard let currentText = textField.text else {
            return true
        }

        //Check range for the replacement string
        guard let range = Range(range, in: currentText) else {
            return true
        }

        //Remove the autocompletion bit from the text in order to use it for matching
        var newText = currentText.replacingCharacters(in: range, with: string).lowercased().capitalized
        newText.removeLast(currentText.count - range.upperBound.encodedOffset)

        //Check if there's any suggestion available in the array of cities
        guard var suggestion = cities.getMatch(for: newText) else {
            DispatchQueue.main.async {
                textField.text = newText
            }
            return true
        }

        //Remove the unused bit of the suggestion text
        suggestion.removeFirst(newText.count)

        DispatchQueue.main.async {
            textField.setAutocompleteAttributedText(text: newText,
                                                    suggestion: suggestion,
                                                    suggestionColor: .gray)
            textField.moveCaret(to: newText.count)
        }

        return false
    }
}
