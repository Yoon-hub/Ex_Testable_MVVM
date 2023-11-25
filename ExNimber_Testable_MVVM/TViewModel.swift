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
        case updateTextList([String])
    }
    
    struct Dependency {
        
    }
    
    var textList = BehaviorRelay<[String]>(value: [])
    
    let dependency: Dependency
    
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
            var value = textList.value
            value.append(text)
            textList.accept(value)
            outputSubject.onNext(.updateTextList(value))
        case .removeText(IndexPath: let indexPath):
            var value = textList.value
            value.remove(at: indexPath.row)
            textList.accept(value)
            outputSubject.onNext(.updateTextList(value))
        }
    }
}
