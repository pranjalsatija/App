//
//  ViewProfileViewController.swift
//  App
//
//  Created by Pranjal Satija on 2/1/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import UI

final class ViewProfileViewController: UIViewController, ViewControllerMakeable {
    var user: User!
    var visits = [Visit]()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBOutlet var visitsTableView: TableView!
}

extension ViewProfileViewController {
    override func viewDidLoad() {
        visitsTableView.onRefresh {(done) in
            self.loadVisits(completion: done)
        }

        loadVisits()
    }

    private func loadVisits(completion: (() -> Void)? = nil) {
        user.getVisits {(_, visits) in
            guard let visits = visits else {
                self.showError()
                return
            }

            self.visits = visits
            self.visitsTableView.reloadData()
            completion?()
        }
    }
}

extension ViewProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        visits.isEmpty ? visitsTableView.showEmptyState() : visitsTableView.hideEmptyState()
        return visits.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: VisitCell.reuseIdentifier) as! VisitCell
        cell.configure(visit: visits[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let visit = visits[indexPath.row]
        visit.deleteEventually()
        visits.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        present(EventDetailViewController.make({
            $0.event = self.visits[indexPath.row].event
        }), animated: true)

        tableView.deselectRow(at: indexPath, animated: false)
    }
}
