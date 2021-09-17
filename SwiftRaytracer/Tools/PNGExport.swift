// Created by Robert Bruinier

import Foundation

public func exportPNG(to path: URL, data: [UInt32]) {
    print("Exporting to PNG: \(path)")

    let pngData = try! encoder.encodeRGBUncompressed(data: imageData,
                                                     width: UInt32(width),
                                                     height: UInt32(height))

    pngData.withUnsafeBytes { pointer in
        let data = Data(bytes: pointer.baseAddress!, count: pointer.count)

        try! data.write(to: path)
    }
}
