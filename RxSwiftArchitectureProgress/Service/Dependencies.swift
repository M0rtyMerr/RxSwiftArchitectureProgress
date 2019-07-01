//
//  Dependencies.swift
//  RxSwiftArchitectureProgress
//
//  Created by Anton Nazarov on 01/07/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import class Foundation.JSONDecoder
import class RxSwift.SerialDispatchQueueScheduler

/// There is no place for production-like DI in this example, sorry
enum Dependencies {
    static let jsonDecoder = JSONDecoder().then {
        $0.keyDecodingStrategy = .convertFromSnakeCase
    }
    static let backgroundScheduler = SerialDispatchQueueScheduler(qos: .userInitiated)
    static let githubService = SearchServiceImpl(jsonDecoder: jsonDecoder, scheduler: Dependencies.backgroundScheduler)
    static let searchViewModel: SearchViewModel = SearchViewModelImpl(githubService: githubService)
}
