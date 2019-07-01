//
//  SearchServiceImpl.swift
//  RxSwiftArchitectureProgress
//
//  Created by Anton Nazarov on 01/07/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import class Foundation.JSONDecoder
import struct RxSwift.Single
import protocol RxSwift.SchedulerType
import RxCocoa

final class SearchServiceImpl: SearchService {
    private let jsonDecoder: JSONDecoder
    private let scheduler: SchedulerType

    init(jsonDecoder: JSONDecoder, scheduler: SchedulerType) {
        self.jsonDecoder = jsonDecoder
        self.scheduler = scheduler
    }

    func search(request: Request) -> Single<[Repository]> {
        return URLSession.shared.rx
            .data(request: URLRequest(url: request.url))
            .observeOn(scheduler)
            .map { [jsonDecoder] in try jsonDecoder.decode(Response<Repository>.self, from: $0) }
            .map { $0.items }
            .asSingle()
    }
}
