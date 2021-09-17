// Created by Robert Bruinier

import Foundation

public struct Vector3 {
    public var x: Double
    public var y: Double
    public var z: Double

    public init() {
        self.x = 0
        self.y = 0
        self.z = 0
    }

    public init(_ v: Double) {
        self.x = v
        self.y = v
        self.z = v
    }

    public init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }

    public init(_ x: Double, _ y: Double, _ z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }

    public static func - (a: Self, b: Self) -> Self {
        return .init(x: a.x - b.x, y: a.y - b.y, z: a.z - b.z)
    }

    public static func + (a: Self, b: Self) -> Self {
        return .init(x: a.x + b.x, y: a.y + b.y, z: a.z + b.z)
    }

    public static func * (a: Self, b: Self) -> Self {
        return .init(x: a.x * b.x, y: a.y * b.y, z: a.z * b.z)
    }

    public static func / (a: Self, b: Self) -> Self {
        return .init(x: a.x / b.x, y: a.y / b.y, z: a.z / b.z)
    }

    public static func -= (a: inout Self, b: Self) {
        a.x -= b.x
        a.y -= b.y
        a.z -= b.z
    }

    public static func += (a: inout Self, b: Self) {
        a.x += b.x
        a.y += b.y
        a.z += b.z
    }

    public static func *= (a: inout Self, b: Self) {
        a.x *= b.x
        a.y *= b.y
        a.z *= b.z
    }

    public static func /= (a: inout Self, b: Self) {
        a.x /= b.x
        a.y /= b.y
        a.z /= b.z
    }

    public static prefix func - (a: Self) -> Self {
        return .init(-a.x, -a.y, -a.z)
    }

    public static func * (a: Double, b: Self) -> Self {
        return .init(x: a * b.x, y: a * b.y, z: a * b.z)
    }

    public static func * (a: Self, b: Double) -> Self {
        return .init(x: a.x * b, y: a.y * b, z: a.z * b)
    }

    public static func + (a: Self, b: Double) -> Self {
        return .init(x: a.x + b, y: a.y + b, z: a.z + b)
    }

    public static func - (a: Self, b: Double) -> Self {
        return .init(x: a.x - b, y: a.y - b, z: a.z - b)
    }

    public static func / (a: Self, b: Double) -> Self {
        return .init(x: a.x / b, y: a.y / b, z: a.z / b)
    }

    public static func dotProduct(a: Self, b: Self) -> Double {
        return (a.x * b.x) + (a.y * b.y) + (a.z * b.z)
    }

    public static func crossProduct(a: Self, b: Self) -> Self {
        return .init(x: (a.y * b.z) - (a.z * b.y),
                     y: (a.z * b.x) - (a.x * b.z),
                     z: (a.x * b.y) - (a.y * b.x))
    }

    public static func reflect(a: Self, b: Self) -> Self {
        return a - (2.0 * Self.dotProduct(a: a, b: b) * b)
    }

    public static func refract(a: Self, b: Self, etaiOverEtat: Double) -> Self {
        let cosTheta = min(Self.dotProduct(a: -a, b: b), 1.0)

        let rOutPerp = etaiOverEtat * (a * cosTheta * b)
        let rOutParallel = -(abs(1.0 - rOutPerp.lengthSquared).squareRoot()) * b

        return rOutPerp + rOutParallel
    }

    public var length: Double {
        return ((x * x) + (y * y) + (z * z)).squareRoot()
    }

    public var lengthSquared: Double {
        return (x * x) + (y * y) + (z * z)
    }

    public var normalized: Self {
        let length = ((x * x) + (y * y) + (z * z)).squareRoot()

        if length == 0.0 {
            return self
        }

        return self * (1.0 / length)
    }

    public var isNearZero: Bool {
        let nearZero: Double = 1e-8

        return (fabs(x) < nearZero) && (fabs(y) < nearZero) && (fabs(z) < nearZero)
    }
}

public func max(_ a: Vector3, _ b: Double) -> Vector3 {
    return .init(max(a.x, b),
                 max(a.y, b),
                 max(a.z, b))
}
