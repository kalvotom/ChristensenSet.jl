##
#
# Generate all non-zero roots of polynomials with coefficients 1 or -1 of
# degree at most 25.
#
# Warning: this may take a while (a few hours in my case) and generate almost
#          50 GB file (3 221 224 897 roots).
#

using ChristensenSet

polynomials = PolynomialIterator([-1.0, 1.0], 25)

@time find_roots!(polynomials, "ones_Float64.dat")
