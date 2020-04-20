//
//  StopWatchViewController.swift
//  SwiftDemo
//
//  Created by Harlan on 2020/4/12.
//  Copyright © 2020 Harlan. All rights reserved.
//

import UIKit

class StopWatchViewController: UIViewController {

    fileprivate var mainStopwatch: Stopwatch = Stopwatch()
    fileprivate var lapStopwatch: Stopwatch = Stopwatch()
    fileprivate var isPlay: Bool = false
    fileprivate var laps: [String] = []
    
    // MARK: - UI
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var lapTimerLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var lapRestButton: UIButton!
    @IBOutlet weak var lapsTableView: UITableView!
    
    let identifier: String = "lapCell"
    
    // Block Setting Button UI
    let initCircleButton: (UIButton) -> Void = { button in
        button.layer.cornerRadius = 0.5 * button.bounds.size.height
        button.backgroundColor = UIColor.white
    }
    
    // MARK: - Lift Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initCircleButton(playPauseButton)
        initCircleButton(lapRestButton)
        lapRestButton.isEnabled = false
    }
    
    // MARK: - Action
    @IBAction func playPauseTimer(_ sender: Any) {
        lapRestButton.isEnabled = true
        changeButtonState(lapRestButton, title: "Reset", titleColor: .black)
        if !isPlay {
            unowned let weakSelf = self
            mainStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: #selector(updateMainTimer), userInfo: nil, repeats: true)
            RunLoop.main.add(mainStopwatch.timer, forMode: .common)
            
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: #selector(updateLapTimer), userInfo: nil, repeats: true)
            RunLoop.main.add(lapStopwatch.timer, forMode: .common)
            
            isPlay = true
            changeButtonState(playPauseButton, title: "Stop", titleColor: .red)
            
        }else {
            mainStopwatch.timer.invalidate()
            lapStopwatch.timer.invalidate()
            isPlay = false
            changeButtonState(playPauseButton, title: "Start", titleColor: .green)
            changeButtonState(lapRestButton, title: "Reset", titleColor: .black)
            if let text = lapTimerLabel.text {
                laps.append(text)
                lapsTableView.reloadData()
            }
        }
    }
    
    @IBAction func latResetTimer(_ sender: Any) {
        if !isPlay {
            resetMainTimer()
            resetLapTimer()
            changeButtonState(lapRestButton, title: "Lap", titleColor: .lightGray)
            lapRestButton.isEnabled = true
        }else {
            if let timerLabelText = timerLabel.text {
                laps.append(timerLabelText)
            }
            lapsTableView.reloadData()
            resetLapTimer()
            unowned let weakSelf = self
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: #selector(updateLapTimer), userInfo: nil, repeats: true)
            RunLoop.current.add(lapStopwatch.timer, forMode: .common)
        }
    }
    
    // MARK: - Private Methods
    private func changeButtonState(_ button: UIButton, title: String, titleColor: UIColor) {
        button.setTitle(title, for: UIControl.State())
        button.setTitleColor(titleColor, for: UIControl.State())
    }
    
    private func resetMainTimer() {
        resetTimer(mainStopwatch, label: timerLabel)
        laps.removeAll()
        lapsTableView.reloadData()
    }
    
    private func resetLapTimer() {
        resetTimer(lapStopwatch, label: lapTimerLabel)
    }
    
    private func resetTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.timer.invalidate()
        stopwatch.counter = 0.0
        label.text = "00:00:00"
    }
    
    @objc func updateMainTimer() {
        updateTimer(mainStopwatch, label: timerLabel)
    }
    
    @objc func updateLapTimer() {
        updateTimer(lapStopwatch, label: lapTimerLabel)
    }
    
    func updateTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.counter += 0.035
        var minutes: String = "\((Int)(stopwatch.counter / 60))"
        if Int(stopwatch.counter / 60) < 10 {
            minutes = "0\((Int)(stopwatch.counter / 60))"
        }
        // truncatingRemainder 使用浮点数取余
        var seconds: String = String(format: "%.2f", (stopwatch.counter.truncatingRemainder(dividingBy: 60)))
        if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
            seconds = "0" + seconds
        }
        label.text = minutes + ":" + seconds
    }
    
}

extension StopWatchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = laps[indexPath.row]
        return cell
    }
}
