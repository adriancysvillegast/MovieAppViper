//
//  AuthView.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 12/9/23.
//

import UIKit
import WebKit

protocol AuthViewDelegate: AnyObject {
    func didFailured(message: String)
}

class AuthView: UIViewController {

    // MARK: - Properties
    private let presenter: AuthPresentable
    
    init(presenter: AuthPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getToken()
        setUpView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    // MARK: - SetUpView
    
    private func setUpView() {
        view.backgroundColor = .systemBackground
    }
    // MARK: - Methods

}

extension AuthView: AuthViewDelegate {

    func didFailured(message: String){
        DispatchQueue.main.async {
            AlertHelper.showAlert(message: message, navigation: self)
        }
    }
}

