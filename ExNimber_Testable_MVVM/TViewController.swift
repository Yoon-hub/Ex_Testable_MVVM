//
//  ViewController.swift
//  ExNimber_Testable_MVVM
//
//  Created by 윤제 on 11/17/23.
//

import UIKit

import RxSwift
import RxCocoa

class TViewController: UIViewController, Presentable {
    
    typealias ViewModelType = TViewModel // 구체적인 viewModel 지정
    
    let viewModel: ViewModelType
    
    var stateObservable: Observable<ViewModelType.State> {
        stateSubject
    }
    
    private let stateSubject = PublishSubject<ViewModelType.State>()
    
    let disposeBag = DisposeBag()
    
    // MARK: Init
    init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .purple
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        return tableView
        
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .yellow
        return textField
    }()
    
    let upLoadButton: UIButton = {
        let button = UIButton()
        button.setTitle("업로드", for: .normal)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUI()
        bind()
    }
    
    private func setUI() {
        [tableView, textField, upLoadButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.textField.topAnchor),
            
            textField.topAnchor.constraint(equalTo: self.tableView.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.upLoadButton.leadingAnchor),
            textField.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            upLoadButton.heightAnchor.constraint(equalToConstant: 50),
            upLoadButton.widthAnchor.constraint(equalToConstant: 50),
            upLoadButton.leadingAnchor.constraint(equalTo: self.textField.trailingAnchor),
            upLoadButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            upLoadButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        viewModel.dependency.textList
            .bind(to: tableView.rx.items(cellIdentifier: "CustomTableViewCell", cellType: CustomTableViewCell.self)) { index, element, cell in
                cell.customLabel.text = element
            }
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        viewModel.output
            .bind(to: stateSubject)
            .disposed(by: disposeBag)
        
        stateSubject
            .observe(on: MainScheduler.instance)
            .bind(with: self) { ss, state in
                ss.handleOutput(state)
            }
            .disposed(by: disposeBag)
        
        
        upLoadButton.rx.tap
            .bind(with: self) { vc, _ in
                vc.viewModel.input(.uploadButtonTap(text: vc.textField.text ?? ""))
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .bind(with: self) { vc, indexPath in
                vc.viewModel.input(.removeText(IndexPath: indexPath))
            }
            .disposed(by: disposeBag)
        
    }
    
    private func handleOutput(_ state: ViewModelType.State) {
        switch state {
        case .clearTextField:
            textField.text = ""
        }
    }

}



final class CustomTableViewCell: UITableViewCell {
    // 셀에 표시될 레이블을 정의합니다.
    let customLabel = UILabel()

    // 셀의 스타일과 레이아웃을 초기화합니다.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // 레이블을 셀에 추가합니다.
        contentView.addSubview(customLabel)

        // 레이블의 레이아웃을 설정합니다.
        customLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            customLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
