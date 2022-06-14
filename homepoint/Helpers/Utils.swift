//
//  Utils.swift
//  homepoint
//
//  Created by Sendo Tjiam on 07/06/22.
//

import Foundation

enum OrderStatusType {
    /// OrderListVC
    case unpaid, packed, sent, arrived, rated, unconfirm
    /// HistoryVC
    case finished, failed
}

class LiveData<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T? {
        didSet {
            guard let theValue = value else {return}
            listener?(theValue)
        }
    }
    
    init(_ value: T? = nil) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        guard let theValue = value else {return}
        listener?(theValue)
    }
}
