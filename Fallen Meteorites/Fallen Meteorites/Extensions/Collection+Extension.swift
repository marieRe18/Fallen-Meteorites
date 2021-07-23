//
//  Collection+Extension.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 22.07.2021.
//

extension Collection {
    public subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
