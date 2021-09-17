// Created by Robert Bruinier

public protocol Material {
    func scatter(ray: Ray, intersection: Intersection, random: Random) -> (scatterRay: Ray, attenuation: Color3)?
}
