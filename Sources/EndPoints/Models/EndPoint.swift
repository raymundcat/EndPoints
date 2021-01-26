//
//  File.swift
//  
//
//  Created by Raymund Catahay on 2021-01-24.
//

import Foundation

open class EndPoint<PathType: Path> {
    
    public let path: PathType
    
    required public init(path: PathType) {
        self.path = path
    }
    
    open var url: URL? { return nil }
    
    open var method: HTTPMethod { return .get }
    
    open var headers: [String : String] { [:] }
    
    open var urlParameter: URLParameter? { return nil }
    
    open var body: Body? { return nil }
}
