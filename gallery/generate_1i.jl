##
#
# Generate all non-zero roots of polynomials with coefficients 1 or 3 of
# degree at most 22.
#
# Warning: this may take a while (a few hours in my case) and generate almost
#          3.6 GB file containing 1 043 915 665 roots.
#

using ChristensenSet

polynomials = PolynomialIterator([1.0, 1.0im, -1.0, -1.0im], 12)

@time find_roots!(polynomials, "ex1i_Float64.dat")
