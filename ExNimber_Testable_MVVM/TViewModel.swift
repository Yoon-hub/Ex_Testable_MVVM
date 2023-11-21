//
//  TViewModel.swift
//  ExNimber_Testable_MVVM
//
//  Created by 윤제 on 11/17/23.
//

import Foundation

import RxSwift
import RxCocoa

final class TViewModel: ViewModelable {
    
    enum Action {
        case uploadButtonTap(text: String)
        case removeText(IndexPath: IndexPath)
    }
    
    enum State {
        case clearTextField
    }
    
    struct Dependency {
        var textList: BehaviorRelay<[String]>
    }
    
    var dependency: Dependency
    
    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    var output: Observable<State> {
        outputSubject
    }
    
    private var outputSubject = PublishSubject<State>()
    
    func input(_ action: Action) {
        switch action {
        case .uploadButtonTap(let text):
            var value = dependency.textList.value
            value.append(text)
            dependency.textList.accept(value)
            outputSubject.onNext(.clearTextField)
        case .removeText(IndexPath: let indexPath):
            var value = dependency.textList.value
            value.remove(at: indexPath.row)
            dependency.textList.accept(value)
        }
    }
}
