//
//  StandardHeacerEncoder.swift
//
//  Created by Raymund Catahay on 2019-01-14.
//

import Foundation

public class StandardHeaderEncoder {

    public static func encode(urlRequest: inout URLRequest,
                              with headers: [String : String]) {
        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
    }
}
