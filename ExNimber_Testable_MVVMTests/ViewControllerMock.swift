//
//  ViewControllerMock.swift
//  ExNimber_Testable_MVVMTests
//
//  Created by 윤제 on 11/21/23.
//

import UIKit
import RxCocoa
import RxSwift
@testable import ExNimber_Testable_MVVM

final class ViewControllerMock<T: ViewModelable>: Presentable {
    
    typealias ViewModelType = T
    
    var viewModel: ViewModelType
    var stateObservable: Observable<ViewModelType.State> {
        stateRelay
    }
    
    private let stateRelay = ReplaySubject<ViewModelType.State>.createUnbounded()
    
    init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        
        viewModel.output
            .observe(on: MainScheduler.instance)
            .bind(to: stateRelay)
    }
}
    
extension TViewModel.State: Equatable {
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case let (.updateTextList(lhsCount), .updateTextList(rhsCount)):
            return lhsCount == rhsCount
        default:
            return false
        }
    }
}
