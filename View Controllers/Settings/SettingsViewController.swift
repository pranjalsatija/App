//
//  SettingsViewController.swift
//  App
//
//  Created by Pranjal Satija on 2/2/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import UI

final class SettingsViewController: UIViewController, ViewControllerMakeable {
    var settingsDataSource: DataSource!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBOutlet var settingsTableView: UITableView!
}

extension SettingsViewController {
    override func viewDidLoad() {
        settingsDataSource = DataSource([
            DataSourceButtonView.make(text: String.ButtonText.clearCache, tapHandler: clearCachesButtonPressed),
            DataSourceButtonView.make(text: String.ButtonText.logOut, tapHandler: logOutButtonPressed)
        ])

        settingsDataSource.bind(to: settingsTableView)
    }
}

extension SettingsViewController {
    private func clearCachesButtonPressed(_ button: DataSourceButtonView) {
        Core.clearFileCaches()
        showAlert(withTitle: String.AlertTitle.cachesCleared, message: String.AlertMessage.cachesCleared)
    }

    private func logOutButtonPressed(_ button: DataSourceButtonView) {
        User.current.logOut {(error) in
            if error != nil {
                self.showError()
            } else {
                self.showAlert(withTitle: String.AlertTitle.logOutSuccessful, message: String.AlertMessage.logOutSuccessful,
                               shouldAddDismissAction: false)

                Countdown.start(duration: 3) {
                    exit(0)
                }
            }
        }
    }
}
