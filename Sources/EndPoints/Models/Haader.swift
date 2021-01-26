//
//  File.swift
//  
//
//  Created by Raymund Catahay on 2021-01-24.
//

import Foundation

public protocol RequestHeaderOption { }

public typealias StandardHeaderOption = [String : String]

extension Dictionary: RequestHeaderOption where Key == String, Value == String { }
