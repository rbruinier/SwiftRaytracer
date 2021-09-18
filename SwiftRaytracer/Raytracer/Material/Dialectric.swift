// Created by Robert Bruinier

import Foundation

public struct Dialectric: Material {
    public let refraction: Double

    public func scatter(ray: Ray, intersection: Intersection, random: Random) -> (scatterRay: Ray, attenuation: Color3)? {
        let refractionRatio = intersection.frontFace ?  (1.0 / refraction) : refraction

        let unitDirection = ray.direction.normalized

        let cosTheta = min(Vector3.dotProduct(a: -unitDirection, b: intersection.normal), 1.0);
        let sinTheta = (1.0 - cosTheta * cosTheta).squareRoot();

        if (refractionRatio * sinTheta > 1.0)
            ||  (Self.reflectance(cosine: cosTheta, refractionRatio: refractionRatio) > random.fastDouble()) {
            let reflected = Vector3.reflect(a: ray.direction.normalized, b: intersection.normal)

            return (scatterRay: Ray(origin: intersection.position, direction: reflected), attenuation: .init(1))
        } else {
            let refracted = Vector3.refract(a: unitDirection, b: intersection.normal, etaiOverEtat: refractionRatio)

            return (scatterRay: Ray(origin: intersection.position, direction: refracted), attenuation: .init(1))
        }
    }

    private static func reflectance(cosine: Double, refractionRatio: Double) -> Double {
        var r0 = (1.0 - refractionRatio) / (1.0 + refractionRatio)

        r0 = r0 * r0;

        return r0 + (1.0 - r0) * pow((1.0 - cosine), 5.0);
    }
}

extension Material where Self == Dialectric {
    public static func dialectric(refraction: Double = 1.0) -> Material {
        return Dialectric(refraction: refraction)
    }
}
