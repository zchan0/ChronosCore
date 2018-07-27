//
//  Extensions.swift
//  Chronos
//
//  Created by Cencen Zheng on 2018/7/12.
//  Copyright © 2018 Cencen Zheng. All rights reserved.
//

public extension Int {
    var seconds: Measurement<UnitDuration> {
        return Measurement(value: Double(self), unit: UnitDuration.seconds)
    }
    
    var minutes: Measurement<UnitDuration> {
        return Measurement(value: Double(self), unit: UnitDuration.minutes)
    }
    
    var hours: Measurement<UnitDuration> {
        return Measurement(value: Double(self), unit: UnitDuration.hours)
    }
    
    var days: Measurement<UnitDuration> {
        return Measurement(value: Double(self) * 24, unit: UnitDuration.hours)
    }
    
    var weeks: Measurement<UnitDuration> {
        return Measurement(value: Double(self) * 24 * 7, unit: UnitDuration.hours)
    }
}

public extension Double {
    var seconds: Measurement<UnitDuration> {
        return Measurement(value: self, unit: UnitDuration.seconds)
    }
    
    var minutes: Measurement<UnitDuration> {
        return Measurement(value: self, unit: UnitDuration.minutes)
    }
    
    var hours: Measurement<UnitDuration> {
        return Measurement(value: self, unit: UnitDuration.hours)
    }
    
    var days: Measurement<UnitDuration> {
        return Measurement(value: self * 24, unit: UnitDuration.hours)
    }
    
    var weeks: Measurement<UnitDuration> {
        return Measurement(value: self * 24 * 7, unit: UnitDuration.hours)
    }
}
