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
        User.current.markAsViewed(event)
    }

    func configureEventDetailTableView() {
        eventDetailTableView.onRefresh {(done) in
            self.refresh {
                done()
            }
        }
    }

    func refresh(_ completion: (() -> Void)? = nil) {
        self.event.refreshInPlace {(_) in
            self.configureDataSource()
            completion?()
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
                                                               padding: 0, imageColor: nil, tapHandler: self.coverPhotoPressed)
            self.eventDetailDataSource.insert(coverPhotoImageView, at: 0)
        }

        let eventDescriptionTextView = DataSourceTextView.make(text: event.description, icon: Icon.info.image)
        eventDescriptionTextView.textLabel.boldSubstring(event.category.name)

        let statusDescriptionTextView = DataSourceTextView.make(text: event.statusMessage, icon: Icon.clock.image)

        eventDetailDataSource = DataSource([
            eventDescriptionTextView,
            statusDescriptionTextView
        ])

        if let likeCountMessage = event.likeCountMessage {
            User.current.hasLiked(event: event) {(_, hasLikedEvent) in
                let hasLikedEvent = hasLikedEvent ?? false
                let icon: Icon = hasLikedEvent ? .like : .likeOutline
                let accessory: Icon? = hasLikedEvent ? nil : .chevronRight
                let likeCountTextView = DataSourceTextView.make(text: likeCountMessage,
                                                                 icon: icon.image,
                                                                 iconColor: .like,
                                                                 accessoryImage: accessory?.image,
                                                                 tapHandler: self.likeButtonPressed)

                self.eventDetailDataSource.insert(likeCountTextView, after: statusDescriptionTextView)
            }
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

    private func coverPhotoPressed(_ imageView: DataSourceImageView) {
        guard let image = imageView.imageView.image else {
            return
        }

        present(ViewImageViewController.make({
            $0.image = image
        }), animated: true)
    }

    private func getDirectionsButtonPressed(_ buttonView: DataSourceButtonView) {
        guard let mapsURL = event.mapsURL else {
            return
        }

        UIApplication.shared.open(mapsURL)
    }

    private func likeButtonPressed(_ textView: DataSourceTextView) {
        User.current.like(event: event) {(_, didLikeEvent) in
            guard didLikeEvent == true else {
                return
            }

            self.event.likeCount = NSNumber(value: self.event.likeCount.intValue + 1)
            if let likeCountMessage = self.event.likeCountMessage {
                textView.accessoryImageView?.image = nil
                textView.iconImageView?.image = Icon.like.image
                textView.textLabel.text = likeCountMessage
            }
        }
    }

    private func shareButtonPressed(_ buttonView: DataSourceButtonView) {
        guard let shareURL = event.shareURL else {
            return
        }

        let shareSheet = UIActivityViewController(activityItems: [shareURL], applicationActivities: nil)
        present(shareSheet, animated: true)
        User.current.registerShare(with: event)
    }
}
