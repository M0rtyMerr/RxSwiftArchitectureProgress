//
//  SearchViewModel3.swift
//  RxSwiftArchitectureProgress
//
//  Created by Anton Nazarov on 8/16/19.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import struct RxCocoa.Driver
import struct Differentiator.SectionModel
import class RxRelay.PublishRelay

protocol SearchViewModel3 {
    typealias SectionType = SectionModel<String, SearchTableViewCellItem>

    var dataSource: Driver<[SectionType]> { get }
    var isLoading: Driver<Bool> { get }

    var search: PublishRelay<String> { get }
    var reachedBottom: PublishRelay<Void> { get }
    var selectItem: PublishRelay<SearchTableViewCellItem> { get }
}
