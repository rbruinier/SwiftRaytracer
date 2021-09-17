// Created by Robert Bruinier

public struct Scene {
    public let intersectables: [Intersectable]
    public let camera: Camera
    public let skybox: (_ rayDirection: Vector3) -> Color3

    public func intersect(ray: Ray) -> Intersection? {
        var closestIntersection: Intersection?

        for intersectable in intersectables {
            if let intersection = intersectable.intersect(ray: ray, tMin: 0.001, tMax: closestIntersection?.t ?? Double.greatestFiniteMagnitude) {
                closestIntersection = intersection
            }
        }

        return closestIntersection
    }
}
