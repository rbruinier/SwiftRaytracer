// Created by Robert Bruinier

import Foundation

public struct Vector2 {
    public var x: Double
    public var y: Double

    public init() {
        self.x = 0
        self.y = 0
    }

    public init(_ v: Double) {
        self.x = v
        self.y = v
    }

    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }

    public init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }

    public static func - (a: Self, b: Self) -> Self {
        return .init(x: a.x - b.x, y: a.y - b.y)
    }

    public static func + (a: Self, b: Self) -> Self {
        return .init(x: a.x + b.x, y: a.y + b.y)
    }

    public static func * (a: Self, b: Self) -> Self {
        return .init(x: a.x * b.x, y: a.y * b.y)
    }

    public static func / (a: Self, b: Self) -> Self {
        return .init(x: a.x / b.x, y: a.y / b.y)
    }

    public static func -= (a: inout Self, b: Self) {
        a.x -= b.x
        a.y -= b.y
   }

    public static func += (a: inout Self, b: Self) {
        a.x += b.x
        a.y += b.y
    }

    public static func *= (a: inout Self, b: Self) {
        a.x *= b.x
        a.y *= b.y
    }

    public static func /= (a: inout Self, b: Self) {
        a.x /= b.x
        a.y /= b.y
    }

    public static func * (a: Double, b: Self) -> Self {
        return .init(x: a * b.x, y: a * b.y)
    }

    public static func * (a: Self, b: Double) -> Self {
        return .init(x: a.x * b, y: a.y * b)
    }

    public static func / (a: Self, b: Double) -> Self {
        return .init(x: a.x / b, y: a.y / b)
    }

    public static func dotProduct(a: Self, b: Self) -> Double {
        return (a.x * b.x) + (a.y * b.y)
    }

    public var length: Double {
        return ((x * x) + (y * y)).squareRoot()
    }

    public var lengthSquared: Double {
        return (x * x) + (y * y)
    }

    public var normalized: Self {
        let length = ((x * x) + (y * y)).squareRoot()

        if length == 0.0 {
            return self
        }

        return self * (1.0 / length)
    }

    public var isNearZero: Bool {
        let nearZero: Double = 1e-8

        return (fabs(x) < nearZero) && (fabs(y) < nearZero)
    }
}
