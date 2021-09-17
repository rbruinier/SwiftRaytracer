// Created by Robert Bruinier

import Foundation

/**
 To boost performance random values are pre "calculated" and returned from lookup tables.
 */
public final class Random {
    private var generator = SystemRandomNumberGenerator()

    private var unitVectorsPool: [Vector3] = .init(repeating: .init(), count: 0x20000)
    private var inUnitSpherePool: [Vector3] = .init(repeating: .init(), count: 0x20000)

    private var unitVector2InXYPlanePool: [Vector2] = .init(repeating: .init(), count: 0x20000)

    private var unitVectorsPoolIndex: Int = 0
    private var inUnitSpherePoolIndex: Int = 0
    private var unitVector2InXYPlanePoolIndex: Int = 0

    private var doublePool: [Double] = .init(repeating: 0, count: 0x20000)

    private var doublePoolIndex = 0

    public init() {
        for i in 0 ..< 0x20000 {
            doublePool[i] = Double.random(in: 0 ... 1, using: &generator)
        }

        for i in 0 ..< 0x20000 {
            inUnitSpherePool[i] = vector3InUnitSphere()
            unitVectorsPool[i] = vector3InUnitSphere().normalized
            unitVector2InXYPlanePool[i] = vector2InUnitXYPlane()
        }
    }

    public func double() -> Double {
        doublePoolIndex = (doublePoolIndex + 1) & 0x1FFFF

        return doublePool[doublePoolIndex]
    }

    public func double(min: Double, max: Double) -> Double {
        return min + ((max - min) * double())
    }

    public func vector3() -> Vector3 {
        .init(double(), double(), double())
    }

    public func vector3(min: Double, max: Double) -> Vector3 {
        .init(double(min: min, max: max),
              double(min: min, max: max),
              double(min: min, max: max))
    }

    public func vector2() -> Vector2 {
        .init(double(), double())
    }

    public func vector2(min: Double, max: Double) -> Vector2 {
        .init(double(min: min, max: max),
              double(min: min, max: max))
    }

    public func vector2InUnitXYPlane() -> Vector2 {
        while true {
            let vector = vector2(min: -1, max: 1)

            if vector.lengthSquared < 1 {
                return vector
            }
        }
    }

    public func vector3InUnitSphere() -> Vector3 {
        while true {
            let vector = vector3(min: -1, max: 1)

            if vector.lengthSquared < 1 {
                return vector
            }
        }
    }

    public func unitVector3() -> Vector3 {
        return vector3InUnitSphere().normalized
    }

    public func fastVector2InUnitXYPlane() -> Vector2 {
        unitVector2InXYPlanePoolIndex = (unitVector2InXYPlanePoolIndex + 1) & 0x1FFFF

        return unitVector2InXYPlanePool[unitVector2InXYPlanePoolIndex]
    }

    public func fastVector3InUnitSphere() -> Vector3 {
        inUnitSpherePoolIndex = (inUnitSpherePoolIndex + 1) & 0x1FFFF

        return inUnitSpherePool[inUnitSpherePoolIndex]
    }

    public func fastUnitVector3() -> Vector3 {
        unitVectorsPoolIndex = (unitVectorsPoolIndex + 1) & 0x1FFFF

        return unitVectorsPool[unitVectorsPoolIndex]
    }
}
