//
//  EventDetailViewController.swift
//  App
//
//  Created by Pranjal Satija on 1/26/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import UI

final class EventDetailViewController: UIViewController, ViewControllerMakeable {
    var event: Event!
    var eventDetailDataSource: DataSource!


    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


    @IBOutlet var eventDetailTableView: TableView!
    @IBOutlet var titleLabel: UILabel!
}

extension EventDetailViewController {
    override func viewDidLoad() {
        titleLabel.text = event.title
        configureDataSource()
        configureEventDetailTableView()
    }

    func configureEventDetailTableView() {
        eventDetailTableView.onRefresh {(done) in
            self.event.refreshInPlace {(_) in
                self.configureDataSource()
                done()
            }
        }
    }
}

extension EventDetailViewController {
    @IBAction func reportButtonPressed() {
        let actionSheet = UIAlertController(title: String.ActionSheetTitle.report, message: String.ActionSheetMessage.report,
                                            preferredStyle: .actionSheet)

        for reason in Report.Reason.all {
            actionSheet.addAction(UIAlertAction(title: reason.name, style: .default) {(_) in
                User.current.report(self.event, reason: reason)
                actionSheet.dismiss(animated: true)
                self.showAlert(withTitle: String.AlertTitle.eventReported, message: String.AlertMessage.eventReported)
            })
        }

        actionSheet.addAction(.dismiss(actionSheet))
        present(actionSheet, animated: true)
    }
}

extension EventDetailViewController {
    func configureDataSource() {
        event.getCoverPhoto {(_, image) in
            guard let image = image else {
                return
            }

            let maxHeight = min(self.view.frame.width, self.view.frame.height) * (9 / 16)
            let coverPhotoImageView = DataSourceImageView.make(image: image, contentMode: .scaleAspectFill, maxHeight: maxHeight,
                                                               padding: 0, imageColor: nil)
            self.eventDetailDataSource.insert(coverPhotoImageView, at: 0)
        }

        eventDetailDataSource = DataSource([
            DataSourceTextView.make(text: event.category.name + " - " + event.eventDescription, icon: Icon.info.image),
            DataSourceTextView.make(text: event.statusMessage, icon: Icon.clock.image)
        ])

        if let likeCountMessage = event.likeCountMessage {
            let visitCountTextView = DataSourceTextView.make(text: likeCountMessage, icon: Icon.like.image, iconColor: .like)
            eventDetailDataSource.append(visitCountTextView)
        }

        if let visitCountMessage = event.visitCountMessage {
            let visitCountTextView = DataSourceTextView.make(text: visitCountMessage, icon: Icon.social.image)
            eventDetailDataSource.append(visitCountTextView)
        }

        let shareText = User.current.isAt(event) ? String.ButtonText.inviteFriends : String.ButtonText.shareEvent
        let shareButton = DataSourceButtonView.make(text: shareText, tapHandler: shareButtonPressed)
        eventDetailDataSource.append(shareButton)

        let getDirectionsText = String.ButtonText.getDirections
        let getDirectionsButton = DataSourceButtonView.make(text: getDirectionsText, tapHandler: getDirectionsButtonPressed)
        eventDetailDataSource.append(getDirectionsButton)

        eventDetailDataSource.bind(to: eventDetailTableView)
    }

    private func getDirectionsButtonPressed(_ buttonView: DataSourceButtonView) {
        guard let mapsURL = event.mapsURL else {
            return
        }

        UIApplication.shared.open(mapsURL)
    }

    private func shareButtonPressed(_ buttonView: DataSourceButtonView) {
        guard let shareURL = event.shareURL else {
            return
        }

        let shareSheet = UIActivityViewController(activityItems: [shareURL], applicationActivities: nil)
        present(shareSheet, animated: true)
    }
}
