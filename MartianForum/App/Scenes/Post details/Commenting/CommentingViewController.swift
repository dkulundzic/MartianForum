//
//  CommentingViewController.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

protocol CommentingDisplayLogic: class {
  func displaySuccessfulCommentPost(comment: Comment)
  func displayNetworkOperation(running: Bool)
  func displayError(title: String?, message: String?)
}

class CommentingViewController: UIViewController {
  typealias CommentPostHandler = ((Comment) -> Void)?
  var handler: CommentPostHandler
  var interactor: CommentingBusinessLogic?
  var router: CommentingRoutingLogic?
  private let contentView = CommentingContentView.autolayoutView()
  private let post: Post
  
  init(post: Post, handler: CommentPostHandler, delegate: CommentingRouterDelegate?) {
    self.post = post
    self.handler = handler
    super.init(nibName: nil, bundle: nil)
    let interactor = CommentingInteractor()
    let presenter = CommentingPresenter()
    let router = CommentingRouter()
    interactor.presenter = presenter
    presenter.viewController = self
    router.viewController = self
    router.delegate = delegate
    self.interactor = interactor
    self.router = router
    setupView()
    setupKeyboardObserving()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    contentView.textView.becomeFirstResponder()
  }
}

// MARK: - Display Logic
extension CommentingViewController: CommentingDisplayLogic {
  func displaySuccessfulCommentPost(comment: Comment) {
    handler?(comment)
    let confirmAction = UIAlertAction(title: "default_alert_cancel_title".localized(), style: .cancel) { _ in self.router?.unwindBack() }
    UIAlertController.generic(title: "comment_success_alert_title".localized(),
                              message: "comment_success_alert_message".localized(),
                              preferredStyle: .alert,
                              actions: [confirmAction])
      .present(on: self)
  }
  
  func displayNetworkOperation(running: Bool) {
    let barButton: UIBarButtonItem = running ? .loadingIndicator(): .send(target: self, selector: #selector(sendTapped))
    navigationItem.setRightBarButton(barButton, animated: true)
    navigationItem.leftBarButtonItem?.isEnabled = !running
  }
  
  func displayError(title: String?, message: String?) {
    UIAlertController
      .generic(title: title, message: message)
      .present(on: self)
  }
}

// MARK: - UITextViewDelegate
extension CommentingViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    navigationItem.rightBarButtonItem?.isEnabled = !textView.text.isEmpty
  }
}

// MARK: - Actions
private extension CommentingViewController {
  @objc func dismissButtonTapped() {
    contentView.textView.resignFirstResponder()
    router?.unwindBack()
  }
  
  @objc func sendTapped() {
    contentView.textView.resignFirstResponder()
    interactor?.postComment(contentView.textView.text, for: post)
  }
}

// MARK: - Private Methods
private extension CommentingViewController {
  func setupView() {
    view.backgroundColor = .white
    setupNavigationBar()
    setupContentView()
  }
  
  func setupNavigationBar() {
    navigationItem.largeTitleDisplayMode = .never
    navigationItem.leftBarButtonItem = .dismiss(target: self, selector: #selector(dismissButtonTapped))
    navigationItem.rightBarButtonItem = .send(target: self, selector: #selector(sendTapped))
    navigationItem.rightBarButtonItem?.tintColor = .martianRed
  }
  
  func setupContentView() {
    view.addSubview(contentView)
    contentView.update(post.body)
    contentView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
  }

  func setupKeyboardObserving() {
    _ = NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: nil) { [weak self] notification in
      guard let keyboardBounds = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
      self?.contentView.textView.contentInset.bottom = keyboardBounds.height
    }
    
    _ = NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: nil) { [weak self] _ in
      self?.contentView.textView.contentInset = .zero
    }
  }
}
