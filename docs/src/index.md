
# ChristensenSet.jl Documentation

*A computation of Christensen sets in Julia.*

```@contents
```

## What is a Christensen set?

Let us consider a finite set of complex numbers ``K`` and a positive integer ``n``.
Then the Christensen set ``C_{K, n}`` is the set of all roots of univariate polynomials with coefficients from ``K`` and degree at most ``n``.
It is a subset of the complex plane and it is easy to visualize its density.

This Julia package is motivated by the [John Baez's article](http://math.ucr.edu/home/baez/roots/) and [Dan Christensen's experiments](http://jdc.math.uwo.ca/roots/).
It employs the [PolynomialRoots.jl](https://github.com/giordano/PolynomialRoots.jl) package for root finding.

## Polynomial iterator

```@docs
PolynomialIterator
```

## Roots image

```@docs
RootsImage
```

## Computing roots

```@docs
find_roots!
```

## Ploting

```@docs
save_image
fill_image!
fill_images!
plot
```

## Index

```@index
```
