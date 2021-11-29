//
//  OperationCoordinator.swift
//  BCPChallenge
//
//  Created by Raul Quispe on 27/11/21.
//

import UIKit

class OperationCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var operationView: OperationView?
    static let storyboard = "Operation"
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    func start() {
        let storyboard = UIStoryboard(name: OperationCoordinator.storyboard, bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: OperationView.identifier)
        if let operationView = view as? OperationView {
            operationView.delegate = self
            presenter.pushViewController(operationView, animated: true)
            self.operationView = operationView
        }
    }
}
extension OperationCoordinator: OperationViewDelegate {
    func goToBack() {
        self.presenter.popViewController(animated: true)
    }
}
