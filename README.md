handMadeCalendarOfSwift
=======================

 ライブラリを使わないカレンダーサンプル(Swift)

HandMadeCalendar（Swift版）  

### ■ 概要

ライブラリを使わずにボタンとラベルで実装したシンプルなカレンダーです。  

### ■ 動作

1. 表示されているカレンダーをクリックすると、Xcodeのデバッグエリアに選択したカレンダーの年月日が表示されます。  
2. func buttonTapped(button: UIButton)...の中に処理を記載することで、画面遷移等の処理の追記が容易にできます。  
3. ボタン「Next Month」「Prev Month」を押すとでページング処理が行われます。  
4. 上のラベルでは、どの年月のカレンダーを見ているかが表示されます。  

### ■ 処理の説明

1. はじめに、現在（初期表示時）の日付を取得する。  
2. その後、カレンダーの始まる位置を決定するためにカレンダーの選択月の1日（yyyy年mm月1日）のデータを取得する。  
データが取得出来たら、それを元にカレンダーの表示位置を計算して日付が入ったボタンを画面上に追加する。  
3. ページング処理を行った際は、年と月のメンバ変数を変えた上で②の処理を行う。  

### ■ 検証シミュレータ

以下のシミュレータでの動作およびレイアウトの検証を行っています。  

+ iPhone4s
+ iPhone5
+ iPhone5s
+ iPhone6
+ iPhone6 plus
+ iPhone SE
+ iPhone7
+ iPhone7 plus


対応させる場合は下記を参考にして頂ければと思います。  

1.  曜日表示ラベルの調整  
(ViewController.swift)  
calendarBaseLabel.frameのCGReckMake内の数値を変更しての調整が可能です。  

2. カレンダーボタンの調整  
(ViewController.swift)  
下記の変数部分の数値を変更しての調整が可能です。  

```
var positionX   = 15 + 50 * (i % 7)
var positionY   = 80 + 50 * (i / 7)
var buttonSizeX = 45
var buttonSizeY = 45
```

※ボタンサイズを変更の際は下記の部分の数値の変更も行って下さい。  

```
button.layer.cornerRadius = 22.5
```

（きれいな正円にする場合は、[ボタンサイズ÷2]を設定して下さい ）  

### ■ ちなみにこんな使い方ができます

1. 日本の祝日への対応  
2. 画面遷移をして次の行き先へ日付の値を引き継ぐ  
3. 色や背景などデザインのカスタマイズ  
[※参考](http://tech.eversense.co.jp/38)  
その他色々ご活用下さい！  

### ■ 祝祭日の対応について

祝祭日の対応をさせる場合は下記のような実装を行って頂ければ対応可能です。
（このサンプルでは日本の祝祭日を全て計算値で行っています。また2000年以前の昔の祝日やハッピーマンデー法も考慮しています）

```
/* CalculateCalendarLogic.swift */
public func judgeJapaneseHoliday(year: Int, month: Int, day: Int) -> Bool {

    /**
     *
     * 祝日になる日を判定する
     * (引数) year: Int, month: Int, day: Int
     * weekdayIndexはWeekdayのenumに該当する値(0...6)が入る
     * ※1. カレンダーロジックの参考：http://p-ho.net/index.php?page=2s2
     * ※2. 書き方（タプル）の参考：http://blog.kitoko552.com/entry/2015/06/17/213553
     * ※3. [Swift] 関数における引数/戻り値とタプルの関係：http://dev.classmethod.jp/smartphone/swift-function-tupsle/
     *
     */

     // 実装は実際のクラスを参照して頂ければ幸いです。
}

/* ViewController.swift */
//structのインスタンスを作成
let holidayObject = CalculateCalendarLogic()
var holidayFlag: Bool = false

...

//使用する際は引数を入れての判定を行う
holidayFlag = holidayObject.judgeJapaneseHoliday(2016, month: 1, day: 1)
//年と月と日を引数に設定するだけでその日が祝日であるかを判定してくれます。
print("2016年1月1日：\(holidayFlag)") ==> 2016年1月1日：true
```

### ■ ライセンス等

特に使用制限はありませんので、どなた様でもご自由にお使い頂くことができます。

### ■ 更新履歴など

ミスやリファクタリング等のご要望等があればご遠慮なくお申し付け下さい。
（現在はAutoLayout対応 ＆ XCTest対応版のサンプルの作成中です）

+ 2016/09/22: Swift3対応ブランチを追加しました。
+ 2016/05/01: 日本の祝祭日への対応をしたstructを追加しました。
+ 2015/01/08: 暫定的なマルチデバイス対応を上記のエミュレータにて検証しています。

### ■ 作者より

まだまだ甘い部分があるかもしれませんが、その際はPull Request等を送っていただければ幸いです。アプリ開発の中でこのサンプルが少しでもお役にたつ事ができれば嬉しい限りです。
