//
//  URLSession+Extension.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/07.
//

import Foundation

extension URLSession {
    
//    func lolLeagueTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTask {
//        return self.codableTask(with: url, completionHandler: completionHandler)
//    }
    
//    func lOLESportsTask(with url: URL, completionHandler: @escaping (LOLESports?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//        return self.codableTask(with: url, completionHandler: completionHandler)
//    }
//
//    func lOLBracketTask(with url: URL, completionHandler: @escaping (LOLBracket?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//        return self.codableTask(with: url, completionHandler: completionHandler)
//    }
    
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
}
