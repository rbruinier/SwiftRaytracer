// Created by Robert Bruinier

import Foundation

public struct Camera {
    public var origin: Point3 = .init(0, 0, 0) {
        didSet {
            updateConstants()
        }
    }

    public var lookAt: Point3 = .init(0, 0, 0) {
        didSet {
            updateConstants()
        }
    }

    public var roll: Double = 0 {
        didSet {
            updateConstants()
        }
    }

    public var verticalFov: Double {
        didSet {
            updateConstants()
        }
    }

    public var aspectRatio: Double = 16.0 / 9.0 {
        didSet {
            updateConstants()
        }
    }

    public var aperture: Double = 2.0 {
        didSet {
            updateConstants()
        }
    }

    private var focusDistance: Double = 1.0
    private var lensRadius: Double = 0.0

    private(set) var viewportHeight: Double = 2.0
    private(set) var viewportWidth: Double = 2.0 * 16.0 / 9.0

    private var lowerLeftCorner: Point3 = .init(0)

    private var horizontal: Vector3 = .init(0)
    private var vertical: Vector3 = .init(0)

    public init(verticalFov: Double = degreesToRadians(90.0)) {
        self.verticalFov = verticalFov

        self.updateConstants()

    }

    public func getRay(u: Double, v: Double, random: Random) -> Ray {
        let randomXY = lensRadius * random.fastVector2InUnitXYPlane()

        let offset = Vector3(u * randomXY.x, v * randomXY.y, 0)

        return .init(origin: origin + offset,
                     direction: lowerLeftCorner + (u * horizontal) + (v * vertical) - origin - offset)
    }

    private mutating func updateConstants() {
        let h = tan(verticalFov * 0.5)

        viewportHeight = 2.0 * h
        viewportWidth = aspectRatio * viewportHeight

        let w = (origin - lookAt).normalized
        let tempU = Vector3.crossProduct(a: .init(0, 1, 0), b: w).normalized
        let tempV = Vector3.crossProduct(a: w, b: tempU)

        let u = cos(roll) * tempU - sin(roll) * tempV
        let v = sin(roll) * tempU + cos(roll) * tempV

        focusDistance = (origin - lookAt).length

        horizontal = focusDistance * viewportWidth * u
        vertical = focusDistance * viewportHeight * v

        lowerLeftCorner = origin - (horizontal * 0.5) - (vertical * 0.5) - (focusDistance * w)

        lensRadius = aperture * 0.5
    }
}
