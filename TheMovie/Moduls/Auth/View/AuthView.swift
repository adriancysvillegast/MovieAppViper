//
//  AuthView.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 12/9/23.
//

import UIKit
import WebKit

protocol AuthViewDelegate: AnyObject {
    func successGuestSection(message: String)
    func didFailured(message: String)
}

class AuthView: UIViewController {
    
    // MARK: - Properties
    private let presenter: AuthPresentable
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 9
        return button
    }()
    
    private lazy var aImageBackground: UIImageView = {
        let aImageView = UIImageView()
        aImageView.contentMode = .scaleAspectFill
        aImageView.image = UIImage(named: "background-image")
        return aImageView
    }()
    
    private lazy var aOverlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.7
        return view
    }()
    
    init(presenter: AuthPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        aImageBackground.frame = view.bounds
        aOverlayView.frame = view.bounds
        signInButton.frame = CGRect(
            x: 20,
            y: view.frame.height-50-view.safeAreaInsets.bottom,
            width: view.frame.width-40,
            height: 50
        )
    }
    
    // MARK: - SetUpView
    
    private func setUpView() {
        view.backgroundColor = .systemBackground
        view.addSubview(aImageBackground)
        view.addSubview(aOverlayView)
        view.addSubview(signInButton)
        
        signInButton.addTarget(self, action: #selector(getGuestSecction), for: .touchUpInside)
    }
    // MARK: - Methods
    @objc func getGuestSecction() {
        self.presenter.getGuestSection()
    }
    
    func navToHome() {
        let vc = TabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

}

extension AuthView: AuthViewDelegate {
    func successGuestSection(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Important", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Continue",
                                          style: .default,
                                          handler: { _ in
                self.navToHome()
            }))
            self.present(alert, animated: true)
        }
    }
    
    
    func didFailured(message: String){
        DispatchQueue.main.async {
            AlertHelper.showAlert(message: message, navigation: self)
        }
    }
}

