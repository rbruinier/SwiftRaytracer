// Created by Robert Bruinier

public struct Ray {
    public var origin: Point3
    public var direction: Vector3

    public func point(at t: Double) -> Point3 {
        return origin + (t * direction)
    }
}
