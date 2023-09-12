//
//  ViewController.swift
//  Coordinator
//
//  Created by iOS Developer (KolesaGroup) on 11.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var onChangeFlow: ((Int) -> Void)?
    
    private lazy var tv: UITableView = {
        $0.delegate = self
        $0.dataSource = self
        
        
        return $0
    }(UITableView())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        view.addSubview(tv)
        tv.frame = view.bounds
        
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onChangeFlow?(indexPath.row)
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    
    
}
