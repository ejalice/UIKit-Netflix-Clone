//
//  extensions.swift
//  Netflix Clone
//
//  Created by eunji on 2022/07/14.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
