//
//  LandingViewController.swift
//  AccionParser
//
//  Created by Anshuman Dahale on 17/11/22.
//

import UIKit

class LandingViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    fileprivate var user: User?
    var viewModel: LandingViewModelProtocol
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    init(nibName: String, viewModel: LandingViewModelProtocol) {
        self.viewModel = viewModel
        self.user = nil
        super.init(nibName: nibName, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.outputDelegate = self
        activityIndicator.startAnimating()
        viewModel.loadData()
    }
    
    func setupUI() {
        self.title = "User Items"
        self.navigationItem.backButtonTitle = ""
        self.configureTableView()
        self.view.addSubview(activityIndicator)
        activityIndicator.color = .gray
    }
    
    func configureTableView() {
        let nib = UINib(nibName: "UserTableViewCell",
                        bundle: Bundle.main)
        tableView.register(nib,
                           forCellReuseIdentifier: "userCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension LandingViewController: LandingViewModelOutput {
    func recievedData(user: User) {
        activityIndicator.stopAnimating()
        self.user = user
        tableView.reloadData()
    }
    
    func failedToLoadUserData(error: Error) {
        activityIndicator.stopAnimating()
        print(error)
    }
}

extension LandingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.user != nil) ? 1 : 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user?.items.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = user?.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! UserTableViewCell
        cell.configureWithItem(item: item)
        return cell
    }
}

extension LandingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = self.user?.items[indexPath.row] else { return }
        viewModel.showDetail(item: item)
    }
}
