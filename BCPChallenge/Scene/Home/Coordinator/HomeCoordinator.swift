//
//  HomeCoordinator.swift
//  BCPChallenge
//
//  Created by Raul Quispe on 27/11/21.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var homeView: BrokerView?
    static let storyboardName = "Main"
    private var operationCoordinator: OperationCoordinator!
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    func start() {
        let storyboard = UIStoryboard(name: HomeCoordinator.storyboardName, bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: BrokerView.identifier)
        if let homeview = view as? BrokerView {
            homeview.delegate = self
            presenter.pushViewController(homeview, animated: false)
            self.homeView = homeview
        }
    }
}
extension HomeCoordinator: BrokerViewDelegate {

    func goToNext() {
        let coordinator = OperationCoordinator(presenter: presenter)
        coordinator.start()
        self.operationCoordinator = coordinator
    }
}

