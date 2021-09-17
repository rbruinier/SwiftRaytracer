// Created by Robert Bruinier

public typealias Point3 = Vector3
public typealias Color3 = Vector3

public typealias Point2 = Vector2

public func degreesToRadians(_ degrees: Double) -> Double {
    return (degrees / 180.0) * Double.pi
}

public func clamp(_ value: Double) -> Double {
    return min(max(value, 0.0), 1.0)
}

public func clamp(_ value: Vector3) -> Vector3 {
    return .init(x: clamp(value.x),
                 y: clamp(value.y),
                 z: clamp(value.z))
}

public func lerp(_ a: Vector3, _ b: Vector3, _ t: Double) -> Vector3 {
    return a + ((b - a) * clamp(t))
}
