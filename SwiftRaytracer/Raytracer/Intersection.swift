// Created by Robert Bruinier

public protocol Intersectable {
    func intersect(ray: Ray, tMin: Double, tMax: Double) -> Intersection?
}

public struct Intersection {
    public let t: Double
    public let position: Point3
    public let normal: Vector3
    public let material: Material
    public let frontFace: Bool

    public init(t: Double, position: Point3, normal: Vector3, material: Material, ray: Ray) {
        self.t = t
        self.position = position
        self.material = material

        frontFace = Vector3.dotProduct(a: ray.direction, b: normal) < 0

        self.normal = frontFace ? normal : -normal
    }
}
