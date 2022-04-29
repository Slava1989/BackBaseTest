//
//  ViewController.swift
//  BackBaseTest
//
//  Created by Veaceslav Chirita on 26.04.2022.
//

import UIKit

class CitiesViewController: UIViewController {
    var presenter: CityScreenPresenter?
    
    var tableBottomConstraint: NSLayoutConstraint?
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 10
        textField.placeholder = "Filter predicate"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always

        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()
    
    init(presenter: CityScreenPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        configureTableView()
        textField.delegate = presenter
        configureUI()
        
        presenter?.getCities() { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    @objc func keyboardWillAppear(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            return
        }
        
        let keyboardHeight = keyboardSize.size.height
        updateBottomConstraint(with: -keyboardHeight)
    }

    @objc func keyboardWillDisappear(_ notification: Notification) {
        updateBottomConstraint(with: 0)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func updateBottomConstraint(with value: CGFloat) {
        tableBottomConstraint?.constant = value
        tableBottomConstraint?.isActive = true
        view.layoutIfNeeded()
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .clear
        tableView.dataSource = presenter
        tableView.delegate = presenter
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: "CityTableViewCell")
    }
    
    private func configureUI() {
        view.addSubview(textField)
        view.addSubview(tableView)
        view.addSubview(indicatorView)
        
        tableBottomConstraint = NSLayoutConstraint(
            item: tableView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view.safeAreaLayoutGuide,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        tableBottomConstraint?.isActive = true

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            textField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor,constant: 10),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension CitiesViewController: CityScreenPresenterInput {
    func startIndicatorView() {
        indicatorView.startAnimating()
        indicatorView.isHidden = false
    }
    
    func stopIndicatorView() {
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
}
