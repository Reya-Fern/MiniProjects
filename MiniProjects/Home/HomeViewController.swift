//
//  ViewController.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 12/5/2569 BE.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var projectTableView: UITableView!

    let projects = ProjectType.allCases

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Constants.homeTitle.rawValue

        projectTableView.dataSource = self
        projectTableView.delegate = self
    }
}

//MARK: - Table
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        var config = cell.defaultContentConfiguration()
        let project = projects[indexPath.row]
        config.text = project.title
        cell.contentConfiguration = config
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let project = projects[indexPath.row]
        let storyboard = UIStoryboard(
            name: project.storyboardName,
            bundle: nil
        )

        let vc = storyboard.instantiateViewController(
            identifier: project.viewControllerID
        )

        navigationController?.pushViewController(
            vc,
            animated: true
        )
    }
}

