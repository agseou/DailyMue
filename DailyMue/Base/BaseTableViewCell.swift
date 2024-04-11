//
//  BaseTableViewCell.swift
//  DailyMue
//
//  Created by eunseou on 4/11/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell, BaseViewProtocol {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureView()
        setConstraints()
    }

    
    func configureHierarchy() { }
    func configureView() { }
    func setConstraints() { }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
