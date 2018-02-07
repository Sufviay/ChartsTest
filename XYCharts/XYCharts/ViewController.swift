//
//  ViewController.swift
//  XYCharts
//
//  Created by 岁变 on 2018/1/31.
//  Copyright © 2018年 岁变. All rights reserved.
//

import UIKit
import Charts
import Foundation

class ViewController: UIViewController, ChartViewDelegate {
    
    //折线图
    let lineChartView: LineChartView = {
        $0.noDataText = "暂无统计数据" //无数据的时候显示
        $0.chartDescription?.enabled = false //是否显示描述
        $0.scaleXEnabled = false
        $0.scaleYEnabled = false
        
        $0.leftAxis.drawGridLinesEnabled = false //左侧y轴设置，不画线
        $0.rightAxis.drawGridLinesEnabled = false //右侧y轴设置，不画线
        $0.rightAxis.drawAxisLineEnabled = false
        $0.rightAxis.enabled = false
        $0.legend.enabled = true
        
        return $0

    }(LineChartView())
    
    
    // 柱状图
    let barChartView: BarChartView = {
        $0.noDataText = "暂无统计数据" //无数据的时候显示
        $0.chartDescription?.enabled = false //是否显示描述
        $0.scaleXEnabled = false
        $0.scaleYEnabled = false

        
        $0.leftAxis.drawGridLinesEnabled = false //左侧y轴设置，不画线
        $0.rightAxis.drawGridLinesEnabled = false //右侧y轴设置，不画线
        $0.rightAxis.drawAxisLineEnabled = false
        $0.rightAxis.enabled = false
        $0.legend.enabled = true
        
        return $0
    }(BarChartView())
    
    let xStr = ["体力", "智力", "情绪", "综合 "] //x轴类别项
    let values = [98.0, 70.3, 40.1, 18.2] //x轴对应的y轴数据

   
        

    override func viewDidLoad() {
        super.viewDidLoad()
        addBarChartView()
        addLineChartView()

    }
    
    //添加柱状图
    func addBarChartView() {
        barChartView.frame = CGRect(x: 0, y: 50, width: 200, height: 200)
        barChartView.center.x = self.view.center.x
        self.view.addSubview(barChartView)
        setBarChartViewData(xStr, values)
    }

    //添加折线图
    func addLineChartView() {
        lineChartView.frame = CGRect(x: 0, y: 300, width: 200, height: 200)
        lineChartView.center.x = self.view.center.x
        self.view.addSubview(lineChartView)
        setLineChartViewData(xStr, values)
    }
    
    
    //配置柱状图
    func setBarChartViewData(_ dataPoints: [String], _ values: [Double]) {
        //x轴样式
        let xAxis = barChartView.xAxis
        xAxis.labelPosition = .bottom //x轴的位置
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.drawGridLinesEnabled = false
        xAxis.granularity = 1.0
        xAxis.valueFormatter = self
        let xFormatter = IndexAxisValueFormatter()
        xFormatter.values = dataPoints

        var dataEntris: [BarChartDataEntry] = []
        for (idx, _) in dataPoints.enumerated() {
            let dataEntry = BarChartDataEntry(x: Double(idx), y: values[idx])
            dataEntris.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntris, label: "")
        let color = UIColor.red
        chartDataSet.colors = [color, color, color, color, color]
        let chartData = BarChartData(dataSet: chartDataSet)

        self.barChartView.data = chartData
        self.barChartView.animate(yAxisDuration: 0.4)
    }
    
    //配置折线图
    func setLineChartViewData(_ dataPoints: [String], _ values: [Double]) {
        
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottom //x轴的位置
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.drawGridLinesEnabled = false
        xAxis.granularity = 1.0
        xAxis.valueFormatter = self
        
        var dataEntris: [ChartDataEntry] = []
        for (idx, _) in dataPoints.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(idx), y: values[idx])
            dataEntris.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(values: dataEntris, label: "")
        //外圈
        lineChartDataSet.setCircleColor(UIColor.yellow)
        //内圈
        lineChartDataSet.circleHoleColor = UIColor.red
        //线条显示样式
        lineChartDataSet.colors = [UIColor.gray]
        
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        
        //设置x轴样式
        let xFormatter = IndexAxisValueFormatter()
        xFormatter.values = dataPoints
        
        self.lineChartView.animate(xAxisDuration: 0.4)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//注意：这里是签订一个类似于x轴样式的代理，显示需要的自定义字符串
//在扩展里实现
extension ViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return xStr[Int(value) % xStr.count]
    }
}



