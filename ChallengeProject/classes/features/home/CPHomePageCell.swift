//
//  CPHomePageCell.swift
//  ChallengeProject
//
//  Created by 孙宁宁 on 2/4/2020.
//  Copyright © 2020 梁齐才. All rights reserved.
//

import UIKit
import SwiftCharts

class CPHomePageCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var openBtn: UIButton!
    @IBOutlet weak var chartsContainer: UIView!
    var chart: BarsChart?
    
    
    
    //MARK: actions
    var openClickBlock: ((CPHomePageCell) -> Void)?
    
    var cellModel: CPYearQuarterReportModel? {
        didSet {
            if let year = cellModel?.year {
                yearLabel.text = "\(year)"
            } else {
                yearLabel.text = "--"
            }
            openBtn.setTitle(cellModel?.isStateOpen ?? false ? "close" : "open", for: .normal)
            
            if cellModel?.isStateOpen ?? false {
                
                for one in  chartsContainer.subviews{
                    one.removeFromSuperview()
                }
                
                let chartConfig = BarsChartConfig(
                    valsAxisConfig: ChartAxisConfig(from: cellModel?.min ?? 0.0,
                                                    to: cellModel?.max ?? 0.0,
                                                    by: cellModel?.average ?? 0.0)
                )

                let frame = CGRect(x: 0, y: 00, width: UIScreen.main.bounds.size.width - 20, height: 187)
                
                var barModels: [(String, Double)] = []
                var index = 1
                for one in cellModel?.quarters ?? [] {
                    let m = ("Q\(index)",Double(one) ?? 0.0)
                    barModels.append(m)
                    index += 1
                }
                
                let chart = BarsChart(
                    frame: frame,
                    chartConfig: chartConfig,
                    xTitle: "volume",
                    yTitle: "quarter",
                    bars: barModels,
                    color: UIColor.red,
                    barWidth: 20
                )

                chartsContainer.addSubview(chart.view)
                self.chart = chart
                
//                pieChart.removeSlices()
//
//                var chartPoints :[PieSliceModel] = []
//                var index = 0
//
//                for one in cellModel?.quarters ?? [] {
//                    index = index + 1
//                    var color = Constant.colorGreen1
//                    if index == 2 {color = .brown}
//                    if index == 3 {color = .red}
//                    if index == 4 {color = .blue}
//
//                    print("\(Double(one) ?? 0.0)")
//
//                    let m = PieSliceModel(value: (Double(one) ?? 0.0),
//                                          color: color)
//                    chartPoints.append(m)
//
//                    pieChart.insertSlice(index: index - 1, model: m)
//                }
                
//                pieChart = PieChart.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//                chartView.addSubview(pieChart!)
//                pieChart!.snp.makeConstraints { (make) in
//                    make.left.top.right.bottom.equalToSuperview()
//                }
                
//                pieChart!.models = chartPoints
            }
            
        }
    }
    
    @IBAction func openClick(_ sender: UIButton) {
        openClickBlock?(self)
    }
}


extension CPYearQuarterReportModel {
    var homePageCellHeight: CGFloat {
        return isStateOpen ? 228.0 : 41.0
    }
}
