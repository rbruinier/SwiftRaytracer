// Created by Robert Bruinier

import Foundation
import MicroPNG

let nrOfCores = ProcessInfo.processInfo.processorCount

print("Will utilize all \(nrOfCores) cores available to speed up rendering")

let width = 1024 >> 0
let height = 576 >> 0
let numberOfSamples = 1234

let coreSliceSize = height / nrOfCores

var dispatchGroup = DispatchGroup()
var dispatchQueue = DispatchQueue(label: "raytracerQueue", qos: .userInitiated, attributes: .concurrent)

let startDate = Date()

// precalculate random values for each thread to bump performance
let randoms: [Random] = (0 ..< nrOfCores).map { _ in
    return Random()
}

var sliceOutputs: [[Color3]] = .init(repeating: [], count: nrOfCores)

print("Scheduling rendering of slices")

for core in 0 ..< nrOfCores {
    dispatchQueue.async(group: dispatchGroup) {
        let random = randoms[Int(core)]

        let scene = glassAndGoldenSpheresScene()

        let raytracer = Raytracer(width: width, height: height, numberOfSamples: numberOfSamples)

        sliceOutputs[Int(core)] = raytracer.raytraceSlice(scene: scene, minY: core * coreSliceSize, maxY: (core + 1) * coreSliceSize, sliceIndex: Int(core), random: random)
    }
}

dispatchGroup.wait()

let renderOutput: [Color3] = sliceOutputs.flatMap { $0 }

let imageData: [UInt32] = renderOutput.map { renderOutput in
    var color = renderOutput

    color = max(color - 0.004, 0.0)

    color = (color * (6.2 * color + 0.5))
        / (color * (6.2 * color + 1.7) + 0.06)

    let r: UInt32 = UInt32(color.x * 255.0) & 0xFF
    let g: UInt32 = UInt32(color.y * 255.0) & 0xFF
    let b: UInt32 = UInt32(color.z * 255.0) & 0xFF

    return (r << 16) + (g << 8) + (b << 0)
}

let duration = Date().timeIntervalSince(startDate)

print("Total rendering time is \(duration) seconds")

let encoder = MicroPNG()

let exportPath = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Desktop/test.png")

exportPNG(to: exportPath, data: imageData)
