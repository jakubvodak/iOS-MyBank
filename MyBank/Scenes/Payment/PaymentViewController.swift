//
//  PaymentViewController.swift
//  MyBank
//
//  Created by Jakub Vodak on 17.07.2021.
//

import UIKit
import Combine

class PaymentViewController: UITableViewController {

    // MARK: - Variables
    
    var viewModel: PaymentViewModel!
    let senderAccountPicker = UIPickerView()
    
    // MARK: - Outlets
    
    @IBOutlet weak var txtSender: UITextField!
    @IBOutlet weak var txtReceiver: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    
    @IBOutlet weak var lblAmountAvailable: UILabel!
    @IBOutlet weak var lblAmountAvailableCurrency: UILabel!
    @IBOutlet weak var lblAmountSendCurrency: UILabel!
    
    // MARK: - Object Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureForm()
        
        txtReceiver.becomeFirstResponder()
    }

    private func configureView() {
     
        title = "Send Money"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(closeAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Confirm", style: .done, target: self, action: #selector(confirmAction))
        
        txtSender.inputView = senderAccountPicker
        senderAccountPicker.dataSource = self
        senderAccountPicker.delegate = self
    }
    
    private func configureForm() {
        
        if let sender = viewModel.transfer.sender,
           let balance = sender.balance,
           let number = sender.number,
           let name = sender.name {
            txtSender.text = "\(String(describing: number)) (\(String(describing: name)))"
            lblAmountAvailable.text = String(format: "%.0f", balance)
            lblAmountAvailableCurrency.text = sender.currency
            lblAmountSendCurrency.text = sender.currency
        }
    }
    
    // MARK: - Messages
    
    private func displayError(error: PaymentError) {
        let alert = UIAlertController(title: "Error", message: error.errorMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func displaySuccess() {
        let alert = UIAlertController(title: "Success", message: "Transfer completed", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { [weak self] _ in
            self?.closeAction()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Action
    
    @objc func closeAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func confirmAction() {
        
        //Store values
        viewModel.transfer.receiver = UInt(txtReceiver.text ?? String())
        viewModel.transfer.amount = Double(txtAmount.text ?? String())
        
        //Validation
        if let error = viewModel.transferFormError() {
            displayError(error: error)
        }
        else {
            //TODO store transfer
            displaySuccess()
        }
    }
    
    // MARK: - TableView
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            txtSender.becomeFirstResponder()
        case 1:
            txtReceiver.becomeFirstResponder()
        case 2:
            txtAmount.becomeFirstResponder()
        default:
            return
        }
    }

}

extension PaymentViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let accounts = viewModel.accounts else { return 0 }
        return accounts.count
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let accounts = viewModel.accounts else { return String() }
        return accounts[row].name
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let accounts = viewModel.accounts else { return }
        viewModel.transfer.sender = accounts[row]
        configureForm()
    }
}
