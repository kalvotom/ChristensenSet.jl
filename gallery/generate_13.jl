##
#
# Generate all non-zero roots of polynomials with coefficients 1 or 3 of
# degree at most 22.
#
# Warning: this may take a while (a few hours in my case) and generate almost
#          5.6 GB file (352 321 541 roots).
#

using ChristensenSet

polynomials = PolynomialIterator([1.0, 3.0], 22)

@time find_roots!(polynomials, "ex13_Float64.dat")
