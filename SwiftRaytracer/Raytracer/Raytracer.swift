// Created by Robert Bruinier

import Foundation

public struct Raytracer {
    public let width: Int
    public let height: Int

    public let numberOfSamples: Int

    public var maxDepth: Int = 50

    func raytraceSlice(scene: Scene, minY: Int, maxY: Int, sliceIndex: Int, random: Random) -> [Color3] {
        let startDate = Date()

        print("Starting slice \(sliceIndex)")

        let sliceSice = maxY - minY

        var renderOutput: [Color3] = .init(repeating: .init(), count: width * sliceSice)

        var index = 0

        let deltaU = 1.0 / Double(width)
        let deltaV = 1.0 / Double(height)

        for y in minY ..< maxY {
            for x in 0 ..< width {
                var combinedColor = Color3()

                for _ in 0 ..< numberOfSamples {
                    let u: Double = (Double(x) + random.double()) * deltaU
                    let v: Double = 1.0 - ((Double(y) + random.double()) * deltaV)

                    let ray = scene.camera.getRay(u: u, v: v, random: random)

                    let color = raytrace(scene: scene, ray: ray, depth: 0, random: random)

                    combinedColor = combinedColor + color
                }

                let scale = 1.0 / Double(numberOfSamples)

                combinedColor.x = (combinedColor.x * scale)
                combinedColor.y = (combinedColor.y * scale)
                combinedColor.z = (combinedColor.z * scale)

                renderOutput[index] = combinedColor

                index += 1
            }
        }

        let duration = Date().timeIntervalSince(startDate)

        print("Rendering slice \(sliceIndex) took \(duration) seconds")

        return renderOutput
    }

    public func raytrace(scene: Scene, ray: Ray, depth: Int, random: Random) -> Color3 {
        if depth > maxDepth {
            return .init(0, 0, 0);
        }

        if let intersection = scene.intersect(ray: ray) {
            if let scatter = intersection.material.scatter(ray: ray, intersection: intersection, random: random) {
                let newRay = scatter.scatterRay

                return scatter.attenuation * raytrace(scene: scene, ray: newRay, depth: depth + 1, random: random)
            } else {
                return .init(0)
            }
        }

        return scene.skybox(ray.direction.normalized)
    }
}
