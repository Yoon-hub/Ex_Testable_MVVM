//
//  Presentable.swift
//  ExNimber_Testable_MVVM
//
//  Created by 윤제 on 11/17/23.
//

import Foundation

import RxSwift

protocol Presentable {
    associatedtype ViewModelType: ViewModelable
    
    var viewModel: ViewModelType {get}
    var stateObservable: Observable<ViewModelType.State> {get}
}
