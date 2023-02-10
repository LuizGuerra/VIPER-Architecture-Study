//
//  Presenter.swift
//  VIPER-Architecture-Study
//
//  Created by Luiz Pedro Franciscatto Guerra on 28/10/22.
//

import Foundation

// Object
// protocol
// reference to the interactor, router, view

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidFetchUsers(with result: Result<[User], Error>)
}

class UserPresenter: AnyPresenter {
    var router: AnyRouter?
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsers()
        }
    }
    var view: AnyView?
    
    func interactorDidFetchUsers(with result: Result<[User], Error>) {
        switch result {
        case .success(let users): view?.update(with: users)
        case .failure: view?.update(with: "Something went wrong")
        }
    }
}
