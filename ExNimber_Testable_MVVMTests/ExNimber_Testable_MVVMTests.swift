//
//  ExNimber_Testable_MVVMTests.swift
//  ExNimber_Testable_MVVMTests
//
//  Created by 윤제 on 11/17/23.
//

import Foundation
import RxSwift
import RxCocoa
import Nimble
import Quick
import RxNimble
@testable import ExNimber_Testable_MVVM

final class ExNimber_Testable_MVVMTests: QuickSpec {
    override class func spec() {
        var viewModel: TViewModel!
        var viewController: ViewControllerMock<TViewModel>!
        let timeoutSeconds = TimeInterval(3)
        
        func setUp(dependency: TViewModel.Dependency) {
            viewModel = TViewModel(dependency: dependency)
            viewController = ViewControllerMock(viewModel: viewModel)
        }
        
        describe("Test 모듈의 ViewController에서") {
            beforeEach {
                setUp(dependency: .init())
            }

            context("text 입력이 발생하면") {
                
                beforeEach {
                    viewModel.input(.uploadButtonTap(text: "test"))
                }
                
                it("textList에 정상적으로 test 문자가 추가된다") {
                    let expectResult = TViewModel.State.updateTextList(["test"])
                    
                    expect(viewController.stateObservable)
                        .first(timeout: timeoutSeconds)
                        .toEventually(equal(expectResult))
                        
                }
            }
            
            context("test cell을 클릭하면") {
                beforeEach {
                    viewModel.input(.uploadButtonTap(text: "test"))
                    viewModel.input(.removeText(IndexPath: IndexPath(row: 0, section: 0)))
                }
                
                it("textList에 test삭제") {
                    
//                    expect(viewModel.dependency.textList.value.count)
//                        .to(equal(0))
                }
            }
        }
    }

}
