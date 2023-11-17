//
//  Presentable.swift
//  ExNimber_Testable_MVVM
//
//  Created by 윤제 on 11/17/23.
//

import Foundation

import RxSwift

protocol ViewModelable {
    associatedtype Action // View로 부터 들어오는 Action
    associatedtype State // View 표시될 State?
    
    
    var output: Observable<State> {get}
    func input(_ action: Action) // View에서 호출할 액션
}
