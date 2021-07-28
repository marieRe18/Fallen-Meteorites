//
//  UIImage+Extension.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 28.07.2021.
//

import UIKit

extension UIImage {
    func imageMagnyfied(by multiplier: CGFloat) -> UIImage {
        let width = self.size.width * multiplier
        let height = self.size.height * multiplier
        let size = CGSize(width: width, height: height)

        return imageWith(newSize: size)
    }

    func imageWith(newSize: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: newSize).image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }

        return image.withRenderingMode(.alwaysOriginal)
    }
}
