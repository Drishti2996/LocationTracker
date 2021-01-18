//
//  LocationTrackerAPIService.swift
//  TrackLocation
//
//  Created by Drishti Sharma on 19/01/21.
//

import Foundation

struct LTAPIServices {
    static func saveData(userLocationData: UserLocationData,
                         completionHandler: @escaping (Bool) -> Void) {
        let urlString = "<cloud url>"
        let startTime = userLocationData.time
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        let dict: [String : Any] = [
            "lat": userLocationData.latitude,
            "long": userLocationData.longitude,
            "timestamp": startTime.convertToString()
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        let parameters: [String: String] = [
            "body": jsonString
        ]
        let httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = httpBody
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let _ = data,
                  let response = response as? HTTPURLResponse,
                  error == nil else {
                completionHandler(false)
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                completionHandler(false)
                return
            }
            // its just 200 success response, no use of response body.
            completionHandler(true)
        }
        task.resume()
    }

}
