//
//  Kaia+URLResponse.swift
//  KaiaHealth_CaseStudy
//
//  Created by Muriel Sandel on 8/22/21.
//

import Foundation

extension URLResponse {
    var isStatusValid: Bool {
        guard let response = self as? HTTPURLResponse,
              (200...399).contains(response.statusCode) else {
            return false
        }

        return true
    }
}
