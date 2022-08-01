//
//  SearchResultVC.swift
//  Stock-App
//
//  Created by Aidyn Assan on 01.08.2022.
//

import UIKit

class SearchResultVC: UIViewController {
    
    var searchResults: [TableViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(StockTableViewCell.self,
                           forCellReuseIdentifier: StockTableViewCell.reuseId)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension SearchResultVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: StockTableViewCell.reuseId,
            for: indexPath) as! StockTableViewCell
        
        cell.configure(with: searchResults[indexPath.row], index: indexPath.row)
        
        return cell
    }
    
    
}
