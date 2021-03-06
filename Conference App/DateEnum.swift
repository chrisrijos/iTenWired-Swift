//    Copyright (c) 2016, Izotx
//    All rights reserved.
//
//    Redistribution and use in source and binary forms, with or without
//    modification, are permitted provided that the following conditions are met:
//
//    * Redistributions of source code must retain the above copyright notice,
//    this list of conditions and the following disclaimer.
//    * Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
//    * Neither the name of Izotx nor the names of its contributors may be used to
//    endorse or promote products derived from this software without specific
//    prior written permission.
//
//    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//    ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
//    LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//    CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//    SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//    INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//    CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//    POSSIBILITY OF SUCH DAMAGE.


//  DateEnum.swift
//  Conference App
//  Created by Felipe Brito on 5/24/16.

enum DateEnum: String{
    case January
    case Feburary
    case March
    case April
    case May
    case June
    case July
    case Agust
    case September
    case October
    case November
    case December
    
    static func getMonth(i : Int) -> String{
        
        switch(i){
            
        case 1:     return DateEnum.January.rawValue
        case 2:     return DateEnum.Feburary.rawValue
        case 3:     return DateEnum.March.rawValue
        case 4:     return DateEnum.April.rawValue
        case 5:     return DateEnum.May.rawValue
        case 6:     return DateEnum.June.rawValue
        case 7:     return DateEnum.July.rawValue
        case 8:     return DateEnum.Agust.rawValue
        case 9:     return DateEnum.September.rawValue
        case 10:    return DateEnum.October.rawValue
        case 11:    return DateEnum.November.rawValue
        case 12:    return DateEnum.December.rawValue
        
        default: return ""
        }
    }
}