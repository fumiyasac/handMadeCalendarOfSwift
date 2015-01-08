//
//  DeviseSize.swift
//  handmadeCalenderSampleOfSwift
//
//  Created by 酒井文也 on 2015/01/09.
//  Copyright (c) 2015年 just1factory. All rights reserved.
//

/**
 * 本コードは下記のURLのものを使用しています。
 * http://swift-salaryman.com/uiscreenutil.php
 *
 */

import UIKit

struct DeviseSize {
    
    //CGRectを取得
    static func bounds()->CGRect{
        return UIScreen.mainScreen().bounds;
    }
    
    //画面の横サイズを取得
    static func screenWidth()->Int{
        return Int( UIScreen.mainScreen().bounds.size.width);
    }
    
    //画面の縦サイズを取得
    static func screenHeight()->Int{
        return Int(UIScreen.mainScreen().bounds.size.height);
    }
}