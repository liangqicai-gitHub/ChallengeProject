//
//  CPHomePage.swift
//  ChallengeProject
//
//  Created by 孙宁宁 on 2/4/2020.
//  Copyright © 2020 梁齐才. All rights reserved.
//

import UIKit
import MJRefresh

class CPHomePage: BasePage {

    private var tableview :UITableView!
    private var offset = 10
    private var yearData: [CPYearQuarterReportModel] = []
    
    override var title: String? {
        get { return "list of data" }
        set { super.title = newValue}
    }
    
    
    //MARK: life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        initVarsAndViews()
        loadData(true)
    }
    
    private final func initVarsAndViews() {
        tableview = UITableView(frame: .zero, style: .plain)
        tableview.estimatedRowHeight = 0.0
        tableview.estimatedSectionFooterHeight = 0.0
        tableview.estimatedSectionHeaderHeight = 0.0
        tableview.separatorStyle = .none
        tableview.register(UINib(nibName: "CPHomePageCell", bundle: nil), forCellReuseIdentifier: CPHomePageCell.description())
        
        
        tableview.mj_header = MJRefreshGifHeader(refreshingBlock: { [weak self] in
            self?.loadData(true)
        })
        
        tableview.mj_footer = MJRefreshBackStateFooter(refreshingBlock: { [weak self] in
            self?.loadData(false)
        })
        
        
        view.addSubview(tableview!)
        tableview!.snp.makeConstraints({ (make) in
            make.top.equalTo(lqcTop)
            make.left.right.bottom.equalToSuperview()
        })
        
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    
    //MARK: network
    private final func loadData(_ isRefresh: Bool) {
        if offset == 10 { view.hud_showLoading() }
        
        let block = { [weak self] (httpResponse: HttpClientResponse<[CPQuarterReportModel]>) in
            guard let sself = self else { return }
            sself.view.hud_hideLoading()
            sself.tableview.mj_header.endRefreshing()
            sself.tableview.mj_footer.endRefreshing()
            
            switch httpResponse {
            case .success(let data):
                
                if isRefresh {
                    sself.offset = 10
                    sself.yearData.removeAll()
                }
                
                sself.offset += data.result?.count ?? 0
                sself.yearData.generateNewYearModel(data.result ?? [])
                sself.tableview.reloadData()
                
                CPHomeDataCaheTool.insert(data.result ?? [])
                
            case .failure(let err):
                sself.view.hud_showToast(err.errorMsg)
                
                CPHomeDataCaheTool.select(offset: sself.offset, limit: 10) { (data) in
                    if isRefresh {
                        sself.offset = 10
                        sself.yearData.removeAll()
                    }
                    
                    sself.offset += data.count
                    sself.yearData.generateNewYearModel(data)
                    sself.tableview.reloadData()
                    
                    sself.view.hud_showToast("这是缓存数据")
                }
            }
        }
        
        CPDataStoresearchAPI.getdata(offset: offset,
                                     limit: 10,
                                     block: block)
    }
    
    
}



extension CPHomePage: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yearData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CPHomePageCell.description(), for: indexPath) as! CPHomePageCell
        cell.cellModel = yearData[indexPath.row]
        cell.openClickBlock = { [weak self] (sender: CPHomePageCell) in
            guard let senderIndex = self?.tableview.indexPath(for: sender) else {return}
            sender.cellModel?.isStateOpen = !(sender.cellModel?.isStateOpen ?? false)
            self?.tableview.reloadRows(at: [senderIndex], with: .automatic)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return yearData[indexPath.row].homePageCellHeight
    }
    
}

