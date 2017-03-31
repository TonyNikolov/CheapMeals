//
//  Utils.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 3/31/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//

import Foundation

protocol OptionalString {}

extension String: OptionalString {}

extension Optional where Wrapped: OptionalString {
    var isNilOrEmpty: Bool {
        return ((self as? String) ?? "").isEmpty
    }
}
