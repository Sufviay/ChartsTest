
//
//  BaseProtocol.swift
//  XYCharts
//
//  Created by 岁变 on 2018/2/1.
//  Copyright © 2018年 岁变. All rights reserved.
//

import Foundation

public protocol Then {}

extension Then where Self: Any {
    
    public func then_Any( block: (inout Self) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
}

extension Then where Self: AnyObject {
    public func then( block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Then {}


