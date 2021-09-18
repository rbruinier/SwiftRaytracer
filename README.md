# Swift Raytracer

Based on the book Ray tracing in One Weekend.

Work in progress.

## Concurrency

Uses as many cores as available to speed up rendering. Image is split up vertically in slices:

* number of slices = number of cores
* slice height = image height / number of slices

## Randomizer

Precalculates lookup tables with random values. This significantly speeds up the raytracing algorithm
as the real random generator is pretty slow.

## Example Output

![example image 1](Docs/Images/example01.png)
