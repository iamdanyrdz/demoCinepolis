//
//  HandlErrorsTextFields.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import Foundation
import UIKit

public class HandlErrorsTextFields {
    public static func onFocusTextFields(yLimitacion: NSLayoutConstraint, yLimitacionConstant: Int, lblTitulo: UILabel, container: UIView, view: UIView){
        yLimitacion.constant = CGFloat(yLimitacionConstant)
        UIView.animate(withDuration: 0, animations: {
            lblTitulo.font = UIFont(name: "MyriadPro-Regular", size: 14)
            view.layoutIfNeeded()
        }, completion: {_ in
            container.layer.borderColor = UIColor(red: 5/255, green: 27/255, blue: 66/255, alpha: 1).cgColor
            container.layer.borderWidth = 2
            lblTitulo.textColor = UIColor(red: 5/255, green: 27/255, blue: 66/255, alpha: 1)
        })
    }
    
    public static func warningsTextFields(container: UIView, lblError: UILabel, error: String, lblTitulo: UILabel, view: UIView) {
        if error != "" {
            container.layer.borderColor = UIColor(red: 203/255, green: 60/255, blue: 74/255, alpha: 1).cgColor
            container.layer.borderWidth = 2
            lblTitulo.textColor = UIColor(red: 203/255, green: 60/255, blue: 74/255, alpha: 1)
            lblError.text = error
            UIView.animate(withDuration: 0, animations: {
                view.layoutIfNeeded()
            }, completion: {_ in
                lblError.isHidden = false
                container.layer.borderColor = UIColor(red: 203/255, green: 60/255, blue: 74/255, alpha: 1).cgColor
                lblTitulo.textColor = UIColor(red: 203/255, green: 60/255, blue: 74/255, alpha: 1)
            })
        }else {
            container.layer.borderColor = UIColor(red: 5/255, green: 27/255, blue: 67/255, alpha: 1).cgColor
            lblTitulo.textColor = UIColor(red: 5/255, green: 27/255, blue: 67/255, alpha: 1)
                UIView.animate(withDuration: 0, animations: {
                    view.layoutIfNeeded()
                }, completion: {_ in
                    lblError.isHidden = true
                    container.layer.borderColor = UIColor(red: 5/255, green: 27/255, blue: 67/255, alpha: 1).cgColor
                    lblTitulo.textColor = UIColor(red: 5/255, green: 27/255, blue: 67/255, alpha: 1)
                })
        }
    }
    
    public static func clearWarnings(container: UIView) {
        container.layer.cornerRadius = 10
        container.layer.borderColor = UIColor(red: 5/255, green: 27/255, blue: 66/255, alpha: 1).cgColor
        container.layer.borderWidth = 1.3
    }
    
    public static func onFocusErrorTextField(container: UIView){
        container.layer.cornerRadius = 10
        container.layer.borderColor = UIColor(red: 203/255, green: 60/255, blue: 74/255, alpha: 1).cgColor
        container.layer.borderWidth = 1.3
    }
    
    public static func onStaticTextField(container: UIView){
        container.layer.cornerRadius = 10
        container.layer.borderColor = UIColor(red: 194/255, green: 207/255, blue: 229/255, alpha: 1).cgColor
        container.layer.borderWidth = 1.3
    }
    
    public static func onFocusSuccesTextField(container: UIView) {
        container.layer.cornerRadius = 10
        container.layer.borderColor = UIColor(red: 118/255, green: 232/255, blue: 90/255, alpha: 1).cgColor
        container.layer.borderWidth = 1.3
    }
    
    public static func onFocusSuccesCodigoTextField(container: UIView) {
        container.layer.cornerRadius = 10
        container.layer.borderColor = UIColor(red: 16/255, green: 95/255, blue: 232/255, alpha: 1).cgColor
        container.layer.borderWidth = 1.3
    }
    
    public static func updateContador(currentNumero: Int, maxNumero: Int, label: UILabel) {
        label.text = "\(currentNumero)/\(maxNumero)"
    }
    
    public static func checkMaxLength(textField:UITextField!, maxLength:Int){
        if (textField.text!.count > maxLength) {
            textField.deleteBackward()
        }
    }
}
