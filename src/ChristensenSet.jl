##
#
# Christensen set Julia package
#
# Tomáš Kalvoda, FIT CTU in Prague, 2018
#

"""
http://math.ucr.edu/home/baez/roots/
"""
module ChristensenSet

using PolynomialRoots
using Images, FileIO
using Distributed, ProgressMeter

export PolynomialIterator
export RootsImage
export compute_roots!, compute_roots_in_parallel!
export save_image, load_image

include("PolynomialIterator.jl")
include("RootsPlot.jl")
include("Computations.jl")

end # module
