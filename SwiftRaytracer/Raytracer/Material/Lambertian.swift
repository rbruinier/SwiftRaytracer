// Created by Robert Bruinier

public struct Lambertian: Material {
    public let albedo: Color3

    public func scatter(ray: Ray, intersection: Intersection, random: Random) -> (scatterRay: Ray, attenuation: Color3)? {
        var direction = (intersection.normal + random.fastUnitVector3())

        if direction.isNearZero {
            direction = intersection.normal
        }

        let scattered = Ray(origin: intersection.position, direction: direction)

        return (scatterRay: scattered, attenuation: albedo)
    }
}

extension Material where Self == Lambertian {
    public static func lambertian(albedo: Color3) -> Material {
        return Lambertian(albedo: albedo)
    }
}
