//
//  ExNimber_Testable_MVVMTests.swift
//  ExNimber_Testable_MVVMTests
//
//  Created by 윤제 on 11/17/23.
//

import XCTest
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
                setUp(dependency: .init(textList: BehaviorRelay<[String]>(value: [])))
            }

            context("text 입력이 발생하면") {
                
                beforeEach {
                    viewModel.input(.uploadButtonTap(text: "test"))
                }
                
                it("textList에 text가 추가되고 textField가 clear된다") {
                    expect(viewController.stateObservable)
                        .first(timeout: timeoutSeconds)
                        .to(equal(.clearTextField))

                    expect(viewModel.dependency.textList.value.count)
                        .to(equal(1))
                }
            }
            
            context("test cell을 클릭하면") {
                beforeEach {
                    viewModel.input(.uploadButtonTap(text: "test"))
                    viewModel.input(.removeText(IndexPath: IndexPath(row: 0, section: 0)))
                }
                
                it("textList에 test삭제") {
                    
                    expect(viewModel.dependency.textList.value.count)
                        .to(equal(0))
                }
            }
        }
        
        
        
        
    }

}
