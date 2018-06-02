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
    let confirmAction = UIAlertAction(title: "Ok", style: .cancel) { _ in self.router?.unwindBack() }  // TODO: - Localise
    let alert = UIAlertController.generic(title: "Comment", message: "Your comment was successfully sent.", preferredStyle: .alert, actions: [confirmAction])  // TODO: - Localise
    alert.present(on: self)
  }
  
  func displayError(title: String?, message: String?) {
    let alert = UIAlertController.generic(title: title, message: message, preferredStyle: .alert)
    alert.present(on: self)
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
    router?.unwindBack()
  }
  
  @objc func sendTapped() {
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
    navigationItem.leftBarButtonItem = UIBarButtonItem.dismiss(target: self, selector: #selector(dismissButtonTapped))
    navigationItem.rightBarButtonItem = UIBarButtonItem.send(target: self, selector: #selector(sendTapped))
    navigationItem.rightBarButtonItem?.tintColor = .martianRed
  }
  
  func setupContentView() {
    view.addSubview(contentView)
    contentView.update(post.body)
    contentView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
  }
}
