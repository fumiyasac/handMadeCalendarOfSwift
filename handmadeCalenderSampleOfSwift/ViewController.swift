//
//  ViewController.swift
//  handmadeCalenderSampleOfSwift
//
//  Created by 酒井文也 on 2014/11/29.
//  Copyright (c) 2014年 just1factory. All rights reserved.
//

import UIKit

//CALayerクラスのインポート
import QuartzCore

class ViewController: UIViewController {

    //メンバ変数の設定（配列格納用）
    var count: Int!
    var mArray: NSMutableArray!
    
    //メンバ変数の設定（カレンダー用）
    var now: NSDate!
    var year: Int!
    var month: Int!
    var day: Int!
    var maxDay: Int!
    var dayOfWeek: Int!
    
    //メンバ変数の設定（カレンダー関数から取得したものを渡す）
    var comps: NSDateComponents!
    
    //メンバ変数の設定（カレンダーの背景色）
    var calendarBackGroundColor: UIColor!
    
    //プロパティを指定
    @IBOutlet var calendarBar: UILabel!
    @IBOutlet var prevMonthButton: UIButton!
    @IBOutlet var nextMonthButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //ボタンを角丸にする
        prevMonthButton.layer.cornerRadius = 5.0
        nextMonthButton.layer.cornerRadius = 5.0
        
        //現在の日付を取得する
        now = NSDate()
        
        //inUnit:で指定した単位（月）の中で、rangeOfUnit:で指定した単位（日）が取り得る範囲
        var calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        var range: NSRange = calendar.rangeOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit:NSCalendarUnit.CalendarUnitMonth, forDate:now)
        
        //最初にメンバ変数に格納するための現在日付の情報を取得する
        comps = calendar.components(NSCalendarUnit.CalendarUnitYear|NSCalendarUnit.CalendarUnitMonth|NSCalendarUnit.CalendarUnitDay|NSCalendarUnit.CalendarUnitWeekday,fromDate:now)
        
        //年月日と最後の日付と曜日を取得(NSIntegerをintへのキャスト不要)
        var orgYear: NSInteger      = comps.year
        var orgMonth: NSInteger     = comps.month
        var orgDay: NSInteger       = comps.day
        var orgDayOfWeek: NSInteger = comps.weekday
        var max: NSInteger          = range.length
        
        year      = orgYear
        month     = orgMonth
        day       = orgDay
        dayOfWeek = orgDayOfWeek
        maxDay    = max
        
        //空の配列を作成する（カレンダーデータの格納用）
        mArray = NSMutableArray()
        
        //曜日ラベル初期定義
        var monthName:[String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
        
        //曜日ラベルを動的に配置
        setupCalendarLabel(monthName)
        
        //初期表示時のカレンダーをセットアップする
        setupCurrentCalendar()
    }
    
    //曜日ラベルの動的配置関数
    func setupCalendarLabel(array: NSArray) {
        
        var calendarLabelCount = 7
        
        for i in 0...6{
            
            //ラベルを作成
            var calendarBaseLabel: UILabel = UILabel()
            
            //X座標の値をCGFloat型へ変換して設定
            calendarBaseLabel.frame = CGRectMake(CGFloat(15 + 50 * (i % calendarLabelCount)), 50, 45, 25)
            
            //日曜日の場合は赤色を指定
            if(i == 0){
                
                //RGBカラーの設定は小数値をCGFloat型にしてあげる
                calendarBaseLabel.textColor = UIColor(
                    red: CGFloat(0.831), green: CGFloat(0.349), blue: CGFloat(0.224), alpha: CGFloat(1.0)
                )
            
            //土曜日の場合は青色を指定
            }else if(i == 6){
                
                //RGBカラーの設定は小数値をCGFloat型にしてあげる
                calendarBaseLabel.textColor = UIColor(
                    red: CGFloat(0.400), green: CGFloat(0.471), blue: CGFloat(0.980), alpha: CGFloat(1.0)
                )
                
            //平日の場合は灰色を指定
            }else{
                
                //既に用意されている配色パターンの場合
                calendarBaseLabel.textColor = UIColor.lightGrayColor()
                
            }
            
            //曜日ラベルの配置
            calendarBaseLabel.text = String(array[i] as NSString)
            calendarBaseLabel.textAlignment = NSTextAlignment.Center
            calendarBaseLabel.font = UIFont(name: "System", size: CGFloat(16))
            self.view.addSubview(calendarBaseLabel)
        }
    }
    
    //カレンダーを生成する関数
    func generateCalendar(){
        
        //タグナンバーとトータルカウントの定義
        var tagNumber = 1
        var total     = 42
        
        //7×6=42個のボタン要素を作る
        for i in 0...41{
            
            //配置場所の定義
            var positionX   = 15 + 50 * (i % 7);
            var positionY   = 80 + 50 * (i / 7);
            var buttonSizeX = 45;
            var buttonSizeY = 45;
            
            //ボタンをつくる
            var button: UIButton = UIButton()
            button.frame = CGRectMake(
                CGFloat(positionX),
                CGFloat(positionY),
                CGFloat(buttonSizeX),
                CGFloat(buttonSizeY)
            );
            
            //ボタンの初期設定をする
            if(i < dayOfWeek - 1){
                
                //日付の入らない部分はボタンを押せなくする
                button.setTitle("", forState: .Normal)
                button.enabled = false
                
            }else if(i == dayOfWeek - 1 || i < dayOfWeek + maxDay - 1){
                
                //日付の入る部分はボタンのタグを設定する（日にち）
                button.setTitle(String(tagNumber), forState: .Normal)
                button.tag = tagNumber
                tagNumber++
                
            }else if(i == dayOfWeek + maxDay - 1 || i < total){
                
                //日付の入らない部分はボタンを押せなくする
                button.setTitle("", forState: .Normal)
                button.enabled = false
                
            }
            
            //ボタンの配色の設定
            //@remark:このサンプルでは正円のボタンを作っていますが、背景画像の設定等も可能です。
            if(i % 7 == 0){
                calendarBackGroundColor = UIColor(
                    red: CGFloat(0.831), green: CGFloat(0.349), blue: CGFloat(0.224), alpha: CGFloat(1.0)
                )
            }else if(i % 7 == 6){
                calendarBackGroundColor = UIColor(
                    red: CGFloat(0.400), green: CGFloat(0.471), blue: CGFloat(0.980), alpha: CGFloat(1.0)
                )
            }else{
                calendarBackGroundColor = UIColor.lightGrayColor()
            }
            
            //ボタンのデザインを決定する
            button.backgroundColor = calendarBackGroundColor
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            button.titleLabel!.font = UIFont(name: "System", size: CGFloat(19))
            button.layer.cornerRadius = 22.5
            
            //配置したボタンに押した際のアクションを設定する
            button.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
            
            //ボタンを配置する
            self.view.addSubview(button)
            mArray.addObject(button)
        }
        
    }
    
    //タイトル表記を設定する関数
    func setupCalendarTitleLabel() {
        calendarBar.text = String("\(year)年\(month)月のカレンダー")
    }
    
    //現在（初期表示時）の年月に該当するデータを取得する関数
    func setupCurrentCalendarData() {
        
        /*************
         * (重要ポイント)
         * 現在月の1日のdayOfWeek(曜日の値)を使ってカレンダーの始まる位置を決めるので、
         * yyyy年mm月1日のデータを作成する。
         * 後述の関数 setupPrevCalendarData, setupNextCalendarData も同様です。
         *************/
        var currentCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        var currentComps: NSDateComponents = NSDateComponents()
        
        currentComps.year  = year
        currentComps.month = month
        currentComps.day   = 1
        
        var currentDate: NSDate = currentCalendar.dateFromComponents(currentComps)!
        recreateCalendarParameter(currentCalendar, currentDate: currentDate)
    }
    
    //前の年月に該当するデータを取得する関数
    func setupPrevCalendarData() {
        
        //現在の月に対して-1をする
        if(month == 0){
            year = year - 1;
            month = 12;
        }else{
            month = month - 1;
        }
        
        //setupCurrentCalendarData()と同様の処理を行う
        var prevCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        var prevComps: NSDateComponents = NSDateComponents()
        
        prevComps.year  = year
        prevComps.month = month
        prevComps.day   = 1
        
        var prevDate: NSDate = prevCalendar.dateFromComponents(prevComps)!
        recreateCalendarParameter(prevCalendar, currentDate: prevDate)
    }
    
    //次の年月に該当するデータを取得する関数
    func setupNextCalendarData() {
        
        //現在の月に対して+1をする
        if(month == 12){
            year = year + 1;
            month = 1;
        }else{
            month = month + 1;
        }
        
        //setupCurrentCalendarData()と同様の処理を行う
        var nextCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        var nextComps: NSDateComponents = NSDateComponents()
        
        nextComps.year  = year
        nextComps.month = month
        nextComps.day   = 1
        
        var nextDate: NSDate = nextCalendar.dateFromComponents(nextComps)!
        recreateCalendarParameter(nextCalendar, currentDate: nextDate)
    }
    
    //カレンダーのパラメータを再作成する関数
    func recreateCalendarParameter(currentCalendar: NSCalendar, currentDate: NSDate) {
        
        //引数で渡されたものをもとに日付の情報を取得する
        var currentRange: NSRange = currentCalendar.rangeOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit:NSCalendarUnit.CalendarUnitMonth, forDate:currentDate)
        
        comps = currentCalendar.components(NSCalendarUnit.CalendarUnitYear|NSCalendarUnit.CalendarUnitMonth|NSCalendarUnit.CalendarUnitDay|NSCalendarUnit.CalendarUnitWeekday,fromDate:currentDate)
        
        //年月日と最後の日付と曜日を取得(NSIntegerをintへのキャスト不要)
        var currentYear: NSInteger      = comps.year
        var currentMonth: NSInteger     = comps.month
        var currentDay: NSInteger       = comps.day
        var currentDayOfWeek: NSInteger = comps.weekday
        var currentMax: NSInteger       = currentRange.length
        
        year      = currentYear
        month     = currentMonth
        day       = currentDay
        dayOfWeek = currentDayOfWeek
        maxDay    = currentMax
    }
    
    //表示されているボタンオブジェクトを一旦削除する関数
    func removeCalendarButtonObject() {
        
        //ビューからボタンオブジェクトを削除する
        for i in 0..<mArray.count {
             mArray[i].removeFromSuperview()
        }
        
        //配列に格納したボタンオブジェクトも削除する
        mArray.removeAllObjects()
    }
    
    //現在のカレンダーをセットアップする関数
    func setupCurrentCalendar() {
        
        setupCurrentCalendarData()
        generateCalendar()
        setupCalendarTitleLabel()
        
        //コンソール表示
        println("カレンダーが表示されました！")
    }
    
    //前の月のボタンを押した際のアクション
    @IBAction func getPrevMonthData(sender: UIButton) {
        
        removeCalendarButtonObject()
        setupPrevCalendarData()
        generateCalendar()
        setupCalendarTitleLabel()
        
        //コンソール表示
        println("前の月のボタンが押されました！")
    }
    
    //次の月のボタンを押した際のアクション
    @IBAction func getNextMonthData(sender: UIButton) {
        
        removeCalendarButtonObject()
        setupNextCalendarData()
        generateCalendar()
        setupCalendarTitleLabel()
        
        //コンソール表示
        println("次の月のボタンが押されました！")
    }
    
    //カレンダーボタンをタップした時のアクション
    func buttonTapped(button: UIButton){
        
        //@todo:画面遷移等の処理を書くことができます。
        
        //コンソール表示
        println("\(year)年\(month)月\(button.tag)日が選択されました！")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
