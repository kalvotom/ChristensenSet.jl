##
#
# Generate all non-zero roots of polynomials with coefficients 1 or -1 of
# degree at most 25.
#
# Warning: this may take a while (a few hours in my case) and generate almost
#          50 GB file.
#

using ChristensenSet

polynomials = PolynomialIterator([-1.0, 1.0], 25)
image = RootsImage(-2.0-2.0im, 2.0+2.0im, 2000, 2000)
image_names = n -> "animation/img_$(lpad(string(n), 2, "0")).png"
DATA_FILE = "ones_Float64.dat"

if !isdir("animation")
  mkdir("animation")
end

@time animate_growth(polynomials, image, DATA_FILE, output_filename=image_names)
