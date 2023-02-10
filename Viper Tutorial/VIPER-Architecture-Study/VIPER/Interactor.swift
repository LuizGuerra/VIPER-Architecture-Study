//
//  Interactor.swift
//  VIPER-Architecture-Study
//
//  Created by Luiz Pedro Franciscatto Guerra on 28/10/22.
//

import Foundation

// Object
// protocol
// reference to presenter
// API calls

enum FetchError: Error {
    case failed
}

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getUsers()
}

class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsers() {
        let stringUrl = "https://jsonplaceholder.typicode.com/users"
        guard let url = URL(string: stringUrl) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self, let data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(
                    with: .failure(FetchError.failed))
                return
            }
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                self.presenter?.interactorDidFetchUsers(
                    with: .success(entities))
            } catch  {
                self.presenter?.interactorDidFetchUsers(
                    with: .failure(error))
            }
        }
        
        task.resume()
    }
}
