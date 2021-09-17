// Created by Robert Bruinier

public struct Sphere: Intersectable {
    public let position: Point3
    public let radius: Double

    public let material: Material

    public func intersect(ray: Ray, tMin: Double, tMax: Double) -> Intersection? {
        let oc = ray.origin - position

        let a = ray.direction.lengthSquared
        let halfB = Vector3.dotProduct(a: oc, b: ray.direction)
        let c = oc.lengthSquared - (radius * radius)

        let discriminant = (halfB * halfB) - (a * c)

        if discriminant <= 0 {
            return nil
        }

        let t = (-halfB - discriminant.squareRoot()) / a;

        if t < tMin || t >= tMax {
            return nil
        }

        let pointOfIntersection = ray.point(at: t)
        let normal = (pointOfIntersection - position) / radius //.normalized

        return .init(t: t,
                     position: pointOfIntersection,
                     normal: normal,
                     material: material,
                     ray: ray)
    }
}
