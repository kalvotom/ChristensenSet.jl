##
#
# Christensen set Julia package
#
# Tomáš Kalvoda, FIT CTU in Prague, 2018--2020
#


"""
A Julia package aimed at exploring the [Christensen's set](http://math.ucr.edu/home/baez/roots/).
"""
module ChristensenSet

using PolynomialRoots
using Images, FileIO
using Distributed, ProgressMeter

export PolynomialIterator
export RootsImage
export compute_roots!
export save_image, load_image, plot

include("PolynomialIterator.jl")
include("RootsPlot.jl")
include("Computations.jl")

end # module
