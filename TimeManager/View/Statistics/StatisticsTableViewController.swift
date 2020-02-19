//
//  StatisticsTableViewController.swift
//  TimeManager
//
//  Created by Oswaldo Maestra on 18/10/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit
import Charts

class StatisticsTableViewController: UITableViewController {

    @IBOutlet weak var lineChartView: LineChartView!
    
    var presenter: StatisticsPresenter? {
        didSet {
            presenter?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = StatisticsPresenter()
        
        setupChart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.loadPomodoros()
        updatePomodorosChart()
    }
    
    private func setupChart() {
        lineChartView.noDataText = "No data available."
        lineChartView.noDataTextColor = UIColor.lightGray
        lineChartView.backgroundColor = UIColor.white
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawLabelsEnabled = true
        lineChartView.legend.enabled = false
        lineChartView.dragEnabled = false
        lineChartView.pinchZoomEnabled = false
        lineChartView.doubleTapToZoomEnabled = false
        lineChartView.setScaleEnabled(false)
        
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.drawLabelsEnabled = true
        xAxis.drawLimitLinesBehindDataEnabled = true
        xAxis.avoidFirstLastClippingEnabled = true
        xAxis.valueFormatter = DateValueFormatter()
        xAxis.granularityEnabled = true
        xAxis.granularity = 1
        xAxis.drawGridLinesEnabled = false
    }
    
    func updatePomodorosChart() {
        // Define chart entries
        var entries = [ChartDataEntry]()
        
        guard let pomodoros = presenter?.pomodoros else { return }
        
        let groupedPomodoros = Dictionary(grouping: pomodoros) { (pomodoro) -> Date in
            let components = Calendar.current.dateComponents([.day, .year, .month], from: pomodoro.startDate ?? Date())
            
            return Calendar.current.date(from: components)!
        }
        
        for groupedPomodoro in groupedPomodoros.sorted(by: { $0.key < $1.key }) {
            let timeInterval = groupedPomodoro.key.timeIntervalSince1970
            let xValue = (timeInterval) / (3600 * 24)
            
            let yValue = groupedPomodoro.value.compactMap({ $0.duration }).reduce(0, +)
            let entry = ChartDataEntry(x: xValue, y: yValue)
            entries.append(entry)
        }
        
        let dataSet = LineChartDataSet(entries: entries, label: "Title")
        dataSet.mode = .cubicBezier
        dataSet.drawValuesEnabled = false
        
        let data = LineChartData()
        data.addDataSet(dataSet)
        
        lineChartView.data = data
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension StatisticsTableViewController: StatisticsViewDelegate {
    func updateUI() {
        updatePomodorosChart()
    }
}

open class DateValueFormatter: NSObject, IAxisValueFormatter {
    var dateFormatter : DateFormatter
    
    public override init() {
        //super.init()
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "dd/MM"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")! as TimeZone
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date2 = Date(timeIntervalSince1970 : (value * 3600 * 24))
        return dateFormatter.string(from: date2)
    }
}
