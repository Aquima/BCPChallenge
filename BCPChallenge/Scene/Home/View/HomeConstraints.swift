//
//  HomeConstraints.swift
//  BCPChallenge
//
//  Created by Raul Quispe on 27/11/21.
//

import UIKit

class HomeConstraints {
    static func dashboardListView(_ child: ListView, _ reference: UIView, _ safeArea: UILayoutGuide) {
        child.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(reference.snp.bottom).offset(110)
            make.bottom.equalTo(safeArea.snp.bottom)
            make.leading.equalTo(5)
            make.trailing.equalTo(-5)
        }
    }
}
