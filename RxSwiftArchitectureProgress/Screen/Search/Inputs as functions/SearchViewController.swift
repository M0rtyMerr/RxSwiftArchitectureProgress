//
//  SearchViewController.swift
//  RxSwiftArchitectureProgress
//
//  Created by Anton Nazarov on 01/07/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import class RxDataSources.RxTableViewSectionedReloadDataSource
import Reusable
import RxSwift
import UIKit

final class SearchViewController: UIViewController, StoryboardBased {
    private let viewModel = Dependencies.searchViewModel
    private let disposeBag = DisposeBag()
    private let searchController = UISearchController(searchResultsController: nil).then {
        $0.dimsBackgroundDuringPresentation = false
    }
    private let footerActivityIndicator = UIActivityIndicatorView(style: .gray).then {
        $0.frame = CGRect(x: 0, y: 0, width: 0, height: 30)
    }
    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.do {
            $0.register(cellType: SearchTableViewCell.self)
            $0.tableFooterView = footerActivityIndicator
        }
        definesPresentationContext = true
        navigationItem.do {
            $0.searchController = searchController
            $0.hidesSearchBarWhenScrolling = false
        }
        bindInput()
        bindOutput()
    }
}

// MARK: - Bind
private extension SearchViewController {
    func bindInput() {
        // swiftlint:disable:next trailing_closure
        let dataSource = RxTableViewSectionedReloadDataSource<SearchViewModel.SectionType>(
            configureCell: { _, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SearchTableViewCell.self)
                cell.configure(item: item)
                return cell
            }
        )
        viewModel.dataSource.drive(tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        viewModel.isLoading.drive(footerActivityIndicator.rx.isAnimating).disposed(by: disposeBag)
    }

    func bindOutput() {
        searchController.searchBar.rx.text.orEmpty
            .skip(1)
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .bind(onNext: viewModel.search)
            .disposed(by: disposeBag)
        tableView.rx.reachedBottom(offset: 100.0).bind(onNext: viewModel.reachedBottom).disposed(by: disposeBag)
        tableView.rx.modelSelected(SearchTableViewCellItem.self).bind(onNext: viewModel.selectItem).disposed(by: disposeBag)
    }
}
