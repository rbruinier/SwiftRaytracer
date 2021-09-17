// Created by Robert Bruinier

import Foundation

public func glassAndGoldenSpheresScene() -> Scene {
    var intersectables: [Intersectable] = []

    intersectables.append(Sphere(position: .init(0, -102, 0),
                                 radius: 100.0,
                                 material: .metal(albedo: .init(0.1, 0.1, 0.1), fuzz: 0.05)))

    intersectables.append(Sphere(position: .init(0, 0, 0),
                                 radius: 1.0,
                                 material: .dialectric(refraction: 1.5)))

    for i in 0 ..< 4 {
        let x = sin(degreesToRadians(45.0 + Double(i) * 90.0)) * 1.75
        let y = cos(degreesToRadians(45.0 + Double(i) * 90.0)) * 1.75

        intersectables.append(Sphere(position: .init(x, y, 0),
                                     radius: 0.7,
                                     material: .metal(albedo: .init(0.7, 0.5, 0.1), fuzz: 0.4)))
    }

    intersectables.append(Sphere(position: .init(0, 0, -1.75),
                                 radius: 0.7,
                                 material: .metal(albedo: .init(0.7, 0.5, 0.1), fuzz: 0.4)))

    intersectables.append(Sphere(position: .init(0, 0, 1.75),
                                 radius: 0.7,
                                 material: .metal(albedo: .init(0.7, 0.5, 0.1), fuzz: 0.4)))

    var camera = Camera(verticalFov: degreesToRadians(20))

    camera.origin = .init(-3, 3, 8)
    camera.lookAt = .init(1, 0.2, 0)
    camera.roll = degreesToRadians(10)
    camera.aperture = 1.0

    return Scene(intersectables: intersectables, camera: camera, skybox: { direction in
        let t = (0.5 * direction.y) + 1.0

        var color = lerp(Color3(1), Color3(0.5, 0.7, 1.0), t)

        var sun = clamp(Vector3.dotProduct(a: Vector3(-0.4, 0.7, -0.6).normalized, b: direction))

        sun = (pow(sun, 4.0) + 10.0 * pow(sun, 32.0))

        color += Vector3(1, 0.6, 0.1) * sun * 0.1

        return color
    })
}
