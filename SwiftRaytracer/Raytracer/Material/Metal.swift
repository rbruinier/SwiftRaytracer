// Created by Robert Bruinier

public struct Metal: Material {
    public let albedo: Color3
    public let fuzz: Double

    public func scatter(ray: Ray, intersection: Intersection, random: Random) -> (scatterRay: Ray, attenuation: Color3)? {
        let reflected = Vector3.reflect(a: ray.direction.normalized, b: intersection.normal)
            + (fuzz * random.fastVector3InUnitSphere())

        if Vector3.dotProduct(a: reflected, b: intersection.normal) > 0 {
            return (scatterRay: Ray(origin: intersection.position, direction: reflected), attenuation: albedo)
        } else {
            return nil
        }
    }
}

extension Material where Self == Metal {
    public static func metal(albedo: Color3, fuzz: Double = 0.0) -> Material {
        return Metal(albedo: albedo, fuzz: fuzz)
    }
}
