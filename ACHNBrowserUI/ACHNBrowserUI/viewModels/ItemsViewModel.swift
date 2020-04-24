//
//  ItemsViewModel.swift
//  ACHNBrowserUI
//
//  Created by Thomas Ricouard on 08/04/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import Foundation
import Combine

class ItemsViewModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var sortedItems: [Item] = []
    @Published var searchItems: [Item] = []
    @Published var searchText = ""
    
    private var itemCancellable: AnyCancellable?
    
    enum Sort: String, CaseIterable {
        case name, buy, sell, from, set
    }
    
    
    var categorie: Categories {
        didSet {
            sort = nil
            itemCancellable = Items.shared.$categories.sink { [weak self] items in
                guard let weakself = self else { return }
                self?.items = items[weakself.categorie] ?? []
            }
        }
    }
    
    var sort: Sort? {
        didSet {
            guard let sort = sort else { return }
            switch sort {
            case .name:
                let compare: (String, String) -> Bool = sort == oldValue ? (>) : (<)
                sortedItems = items.sorted{ compare($0.name, $1.name) }
            case .buy:
                let compare: (Int, Int) -> Bool = sort == oldValue ? (>) : (<)
                sortedItems = items.filter{ $0.buy != nil}.sorted{ compare($0.buy!, $1.buy!) }
            case .sell:
                let compare: (Int, Int) -> Bool = sort == oldValue ? (>) : (<)
                sortedItems = items.filter{ $0.sell != nil}.sorted{ compare($0.sell!, $1.sell!) }
            case .from:
                let compare: (String, String) -> Bool = sort == oldValue ? (>) : (<)
                sortedItems = items.filter{ $0.obtainedFrom != nil}.sorted{ compare($0.obtainedFrom!, $1.obtainedFrom!) }
            case .set:
                let compare: (String, String) -> Bool = sort == oldValue ? (>) : (<)
                sortedItems = items.filter{ $0.set != nil}.sorted{ compare($0.set!, $1.set!) }
            }
        }
    }
    
    private var searchCancellable: AnyCancellable?
    
    public init(categorie: Categories) {
        self.categorie = categorie
        searchCancellable = $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .map(items(with:))
            .sink(receiveValue: { [weak self] in self?.searchItems = $0 })

        itemCancellable = Items.shared.$categories.sink { [weak self] items in
            self?.items = items[categorie] ?? []
        }
    }

    private func items(with string: String) -> [Item] {
        items.filter {
            $0.name.lowercased().contains(string.lowercased())
        }
    }
}
