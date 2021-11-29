//
//  ListView.swift
//  BCPChallenge
//
//  Created by Raul Quispe on 27/11/21.
//

import UIKit
import SnapKit

public protocol ListViewDelegate: AnyObject {
    func listView(_ tableView: UITableView,_ indexPath: IndexPath) -> UITableViewCell
    func listViewDidSelect(_ indexPath: IndexPath)
}

public class ListView: UIView, UITableViewDelegate, UITableViewDataSource {
    public var delegate: ListViewDelegate?
    public var rowHeightSizes: [CGFloat]!
    public var sectionsRows: [Int]!
    public var numberSections: Int = 0
    let tableView = UITableView()
    public func numberOfSections(in tableView: UITableView) -> Int {
        return numberSections
    }
    public func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return sectionsRows[section]
    }
    public func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return delegate?.listView(tableView, indexPath) ?? UITableViewCell()
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeightSizes[indexPath.section]
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.listViewDidSelect(indexPath)
    }
    func createTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
       
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(24)
            make.bottom.equalToSuperview()
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
        }
        tableView.backgroundColor = .clear
    }
    public func register( cellClass: [AnyClass], identifiers: [String]) {
        createTableView()
        for index in 0...(cellClass.count - 1) {
            tableView.register(cellClass[index],
                               forCellReuseIdentifier: identifiers[index])
        }
        
    }
    public func reloadData() {
        tableView.reloadData()
        tableView.showsVerticalScrollIndicator = false
        setupUI()
    }
    public func setupUI() {
        self.backgroundColor = .clear
        self.layer.masksToBounds = true
    }
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
               let mask = CAShapeLayer()
               mask.path = path.cgPath
               self.layer.mask = mask
            }
    }
    public func deactivateScroll(){
        tableView.isScrollEnabled = false
    }

}
