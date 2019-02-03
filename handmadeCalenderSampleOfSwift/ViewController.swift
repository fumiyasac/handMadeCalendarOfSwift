//
//  ViewController.swift
//  handmadeCalenderSampleOfSwift
//
//  Created by 酒井文也 on 2014/11/29.
//  Copyright (c) 2014年 just1factory. All rights reserved.
//

// TODO: 改めてレイアウトをちゃんと作り直す

import UIKit

//CALayerクラスのインポート
import QuartzCore

class ViewController: UIViewController {

    //メンバ変数の設定（配列格納用）
    var count: Int!
    var mArray: NSMutableArray!
    
    //メンバ変数の設定（カレンダー用）
    var now: Date!
    var year: Int!
    var month: Int!
    var day: Int!
    var maxDay: Int!
    var dayOfWeek: Int!
    
    //メンバ変数の設定（カレンダー関数から取得したものを渡す）
    var comps: DateComponents!
    
    //メンバ変数の設定（カレンダーの背景色）
    var calendarBackGroundColor: UIColor!
    
    //プロパティを指定
    @IBOutlet var calendarBar: UILabel!
    @IBOutlet var prevMonthButton: UIButton!
    @IBOutlet var nextMonthButton: UIButton!
    
    //カレンダーの位置決め用メンバ変数
    var calendarLabelIntervalX: Int!
    var calendarLabelX: Int!
    var calendarLabelY: Int!
    var calendarLabelWidth: Int!
    var calendarLabelHeight: Int!
    var calendarLableFontSize: Int!
    
    var buttonRadius: Float!
    
    var calendarIntervalX: Int!
    var calendarX: Int!
    var calendarIntervalY: Int!
    var calendarY: Int!
    var calendarSize: Int!
    var calendarFontSize: Int!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //現在起動中のデバイスを取得（スクリーンの幅・高さ）
        let screenWidth  = DeviseSize.screenWidth()
        let screenHeight = DeviseSize.screenHeight()
        
        //iPhone4s
        if screenWidth == 320 && screenHeight == 480 {
            
            calendarLabelIntervalX = 5;
            calendarLabelX         = 45;
            calendarLabelY         = 93;
            calendarLabelWidth     = 40;
            calendarLabelHeight    = 25;
            calendarLableFontSize  = 14;
            
            buttonRadius           = 20.0;
            
            calendarIntervalX      = 5;
            calendarX              = 45;
            calendarIntervalY      = 120;
            calendarY              = 45;
            calendarSize           = 40;
            calendarFontSize       = 17;
            
        //iPhone5またはiPhone5s
        } else if screenWidth == 320 && screenHeight == 568 {
            
            calendarLabelIntervalX = 5;
            calendarLabelX         = 45;
            calendarLabelY         = 93;
            calendarLabelWidth     = 40;
            calendarLabelHeight    = 25;
            calendarLableFontSize  = 14;
            
            buttonRadius           = 20.0;
            
            calendarIntervalX      = 5;
            calendarX              = 45;
            calendarIntervalY      = 120;
            calendarY              = 45;
            calendarSize           = 40;
            calendarFontSize       = 17;
            
        //iPhone6またはiPhone6sまたはiPhone7
        } else if screenWidth == 375 {
            
            calendarLabelIntervalX = 15;
            calendarLabelX         = 50;
            calendarLabelY         = 95;
            calendarLabelWidth     = 45;
            calendarLabelHeight    = 25;
            calendarLableFontSize  = 16;
            
            buttonRadius           = 22.5;
            
            calendarIntervalX      = 15;
            calendarX              = 50;
            calendarIntervalY      = 125;
            calendarY              = 50;
            calendarSize           = 45;
            calendarFontSize       = 19;
            
            self.prevMonthButton.frame = CGRect(x: 15, y: 438, width: calendarSize, height: calendarSize)
            self.nextMonthButton.frame = CGRect(x: 314, y: 438, width: calendarSize, height: calendarSize)
            
        //iPhone6+またはiPhone6s+またはiPhone7s+
        } else if screenWidth == 414 {
            
            calendarLabelIntervalX = 15;
            calendarLabelX         = 55;
            calendarLabelY         = 95;
            calendarLabelWidth     = 55;
            calendarLabelHeight    = 25;
            calendarLableFontSize  = 18;
            
            buttonRadius           = 25;
            
            calendarIntervalX      = 18;
            calendarX              = 55;
            calendarIntervalY      = 125;
            calendarY              = 55;
            calendarSize           = 50;
            calendarFontSize       = 21;
            
            self.prevMonthButton.frame = CGRect(x: 18, y: 468, width: calendarSize, height: calendarSize)
            self.nextMonthButton.frame = CGRect(x: 348, y: 468, width: calendarSize, height: calendarSize)
        }
        
        //ボタンを角丸にする
        prevMonthButton.layer.cornerRadius = CGFloat(buttonRadius)
        nextMonthButton.layer.cornerRadius = CGFloat(buttonRadius)
        
        //現在の日付を取得する
        now = Date()
        
        //inUnit:で指定した単位（月）の中で、rangeOfUnit:で指定した単位（日）が取り得る範囲
        let calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let range: NSRange = (calendar as NSCalendar).range(of: NSCalendar.Unit.day, in:NSCalendar.Unit.month, for:now)
        
        //最初にメンバ変数に格納するための現在日付の情報を取得する
        comps = (calendar as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.weekday],from:now)
        
        //年月日と最後の日付と曜日を取得(NSIntegerをintへのキャスト不要)
        let orgYear: NSInteger      = comps.year!
        let orgMonth: NSInteger     = comps.month!
        let orgDay: NSInteger       = comps.day!
        let orgDayOfWeek: NSInteger = comps.weekday!
        let max: NSInteger          = range.length
        
        year      = orgYear
        month     = orgMonth
        day       = orgDay
        dayOfWeek = orgDayOfWeek
        maxDay    = max
        
        //空の配列を作成する（カレンダーデータの格納用）
        mArray = NSMutableArray()
        
        //曜日ラベル初期定義
        let monthName:[String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
        
        //曜日ラベルを動的に配置
        setupCalendarLabel(monthName as NSArray)
        
        //初期表示時のカレンダーをセットアップする
        setupCurrentCalendar()
    }
    
    //曜日ラベルの動的配置関数
    func setupCalendarLabel(_ array: NSArray) {
        
        let calendarLabelCount = 7
        
        for i in 0...6 {
            
            //ラベルを作成
            let calendarBaseLabel: UILabel = UILabel()
            
            //X座標の値をCGFloat型へ変換して設定
            calendarBaseLabel.frame = CGRect(
                x: calendarLabelIntervalX + calendarLabelX * (i % calendarLabelCount),
                y: calendarLabelY,
                width: calendarLabelWidth,
                height: calendarLabelHeight
            )
            
            //日曜日の場合は赤色を指定
            if i == 0 {
                
                //RGBカラーの設定は小数値をCGFloat型にしてあげる
                calendarBaseLabel.textColor = UIColor(
                    red: CGFloat(0.831), green: CGFloat(0.349), blue: CGFloat(0.224), alpha: CGFloat(1.0)
                )
            
            //土曜日の場合は青色を指定
            } else if i == 6 {
                
                //RGBカラーの設定は小数値をCGFloat型にしてあげる
                calendarBaseLabel.textColor = UIColor(
                    red: CGFloat(0.400), green: CGFloat(0.471), blue: CGFloat(0.980), alpha: CGFloat(1.0)
                )
                
            //平日の場合は灰色を指定
            } else {
                
                //既に用意されている配色パターンの場合
                calendarBaseLabel.textColor = UIColor.lightGray
                
            }
            
            //曜日ラベルの配置
            calendarBaseLabel.text = String(array[i] as! NSString)
            calendarBaseLabel.textAlignment = NSTextAlignment.center
            calendarBaseLabel.font = UIFont(name: "System", size: CGFloat(calendarLableFontSize))
            self.view.addSubview(calendarBaseLabel)
        }
    }
    
    //カレンダーを生成する関数
    func generateCalendar() {
        
        //タグナンバーとトータルカウントの定義
        var tagNumber = 1
        let total     = 42
        
        //祝祭日のメソッドを定義した祝祭日判定フラグ
        let holidayObject = CalculateCalendarLogic()
        var holidayFlag: Bool = false

        //7×6=42個のボタン要素を作る
        for i in 0...41 {
            
            //配置場所の定義
            let positionX   = calendarIntervalX + calendarX * (i % 7)
            let positionY   = calendarIntervalY + calendarY * (i / 7)
            let buttonSizeX = calendarSize;
            let buttonSizeY = calendarSize;
            
            //ボタンをつくる
            let button: UIButton = UIButton()
            button.frame = CGRect(
                x: positionX,
                y: positionY,
                width: buttonSizeX!,
                height: buttonSizeY!
            );
            
            //ボタンの初期設定をする
            if i < dayOfWeek - 1 {
                
                //日付の入らない部分はボタンを押せなくする
                button.setTitle("", for: UIControl.State())
                button.isEnabled = false
                holidayFlag = false
                
            } else if i == dayOfWeek - 1 || i < dayOfWeek + maxDay - 1 {
                
                //日付の入る部分はボタンのタグを設定する（日にち）
                button.setTitle(String(tagNumber), for: UIControl.State())

                //祝祭日の判定を行う
                holidayFlag = holidayObject.judgeJapaneseHoliday(year: year, month: month, day: tagNumber)

                button.tag = tagNumber
                tagNumber += 1

            } else if i == dayOfWeek + maxDay - 1 || i < total {
                
                //日付の入らない部分はボタンを押せなくする
                button.setTitle("", for: UIControl.State())
                button.isEnabled = false
                holidayFlag = false
            }
            
            //ボタンの配色の設定
            //日曜日または祝祭日(振替休日) => 赤色, 土曜日 => 青色, 平日 => グレー色
            //@remark:このサンプルでは正円のボタンを作っていますが、背景画像の設定等も可能です。
            if i % 7 == 0 || holidayFlag == true {
                calendarBackGroundColor = UIColor(
                    red: CGFloat(0.831), green: CGFloat(0.349), blue: CGFloat(0.224), alpha: CGFloat(1.0)
                )
            } else if i % 7 == 6 {
                calendarBackGroundColor = UIColor(
                    red: CGFloat(0.400), green: CGFloat(0.471), blue: CGFloat(0.980), alpha: CGFloat(1.0)
                )
            } else {
                calendarBackGroundColor = UIColor.lightGray
            }
            
            //ボタンのデザインを決定する
            button.backgroundColor = calendarBackGroundColor
            button.setTitleColor(UIColor.white, for: UIControl.State())
            button.titleLabel!.font = UIFont(name: "System", size: CGFloat(calendarFontSize))
            button.layer.cornerRadius = CGFloat(buttonRadius)
            
            //配置したボタンに押した際のアクションを設定する
            button.addTarget(self, action: #selector(ViewController.buttonTapped(_:)), for: .touchUpInside)
            
            //ボタンを配置する
            self.view.addSubview(button)
            mArray.add(button)
        }
        
    }
    
    //タイトル表記を設定する関数
    func setupCalendarTitleLabel() {
        calendarBar.text = String("\(year!)年\(month!)月のカレンダー")
    }
    
    //現在（初期表示時）の年月に該当するデータを取得する関数
    func setupCurrentCalendarData() {
        
        /*************
         * (重要ポイント)
         * 現在月の1日のdayOfWeek(曜日の値)を使ってカレンダーの始まる位置を決めるので、
         * yyyy年mm月1日のデータを作成する。
         * 後述の関数 setupPrevCalendarData, setupNextCalendarData も同様です。
         *************/
        let currentCalendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var currentComps: DateComponents = DateComponents()
        
        currentComps.year  = year
        currentComps.month = month
        currentComps.day   = 1
        
        let currentDate: Date = currentCalendar.date(from: currentComps)!
        recreateCalendarParameter(currentCalendar, currentDate: currentDate)
    }
    
    //前の年月に該当するデータを取得する関数
    func setupPrevCalendarData() {
        
        //現在の月に対して-1をする
        if month == 0 {
            year = year - 1
            month = 12
        } else {
            month = month - 1
        }
        
        //setupCurrentCalendarData()と同様の処理を行う
        let prevCalendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var prevComps: DateComponents = DateComponents()
        
        prevComps.year  = year
        prevComps.month = month
        prevComps.day   = 1
        
        let prevDate: Date = prevCalendar.date(from: prevComps)!
        recreateCalendarParameter(prevCalendar, currentDate: prevDate)
    }
    
    //次の年月に該当するデータを取得する関数
    func setupNextCalendarData() {
        
        //現在の月に対して+1をする
        if month == 12 {
            year = year + 1
            month = 1
        } else {
            month = month + 1
        }
        
        //setupCurrentCalendarData()と同様の処理を行う
        let nextCalendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var nextComps: DateComponents = DateComponents()
        
        nextComps.year  = year
        nextComps.month = month
        nextComps.day   = 1
        
        let nextDate: Date = nextCalendar.date(from: nextComps)!
        recreateCalendarParameter(nextCalendar, currentDate: nextDate)
    }
    
    //カレンダーのパラメータを再作成する関数
    func recreateCalendarParameter(_ currentCalendar: Calendar, currentDate: Date) {
        
        //引数で渡されたものをもとに日付の情報を取得する
        let currentRange: NSRange = (currentCalendar as NSCalendar).range(of: NSCalendar.Unit.day, in:NSCalendar.Unit.month, for:currentDate)
        
        comps = (currentCalendar as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.weekday],from:currentDate)
        
        //年月日と最後の日付と曜日を取得(NSIntegerをintへのキャスト不要)
        let currentYear: NSInteger      = comps.year!
        let currentMonth: NSInteger     = comps.month!
        let currentDay: NSInteger       = comps.day!
        let currentDayOfWeek: NSInteger = comps.weekday!
        let currentMax: NSInteger       = currentRange.length
        
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
             (mArray[i] as AnyObject).removeFromSuperview()
        }
        
        //配列に格納したボタンオブジェクトも削除する
        mArray.removeAllObjects()
    }
    
    //現在のカレンダーをセットアップする関数
    func setupCurrentCalendar() {
        
        setupCurrentCalendarData()
        generateCalendar()
        setupCalendarTitleLabel()
    }
    
    //カレンダーボタンをタップした時のアクション
    @objc func buttonTapped(_ button: UIButton) {
        
        //@todo:画面遷移等の処理を書くことができます。
        
        //コンソール表示
        print("\(year!)年\(month!)月\(button.tag)日が選択されました！")
    }
    
    //前の月のボタンを押した際のアクション
    @IBAction func getPrevMonthData(_ sender: UIButton) {
        prevCalendarSettings()
    }
    
    //次の月のボタンを押した際のアクション
    @IBAction func getNextMonthData(_ sender: UIButton) {
        nextCalendarSettings()
    }
    
    //左スワイプで前月を表示
    @IBAction func swipePrevCalendar(_ sender: UISwipeGestureRecognizer) {
        prevCalendarSettings()
    }
    
    //右スワイプで次月を表示
    @IBAction func swipeNextCalendar(_ sender: UISwipeGestureRecognizer) {
        nextCalendarSettings()
    }
    
    //前月を表示するメソッド
    func prevCalendarSettings() {
        removeCalendarButtonObject()
        setupPrevCalendarData()
        generateCalendar()
        setupCalendarTitleLabel()
    }
    
    //次月を表示するメソッド
    func nextCalendarSettings() {
        removeCalendarButtonObject()
        setupNextCalendarData()
        generateCalendar()
        setupCalendarTitleLabel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
