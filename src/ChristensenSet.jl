##
#
# Christensen set Julia package
#
# Tomáš Kalvoda, FIT CTU in Prague, 2018--2020
#


"""
A Julia package aimed at exploring the [Christensen set](http://math.ucr.edu/home/baez/roots/) discovered by [Dan Christensen](http://jdc.math.uwo.ca/roots/).
"""
module ChristensenSet

using PolynomialRoots, Statistics
using Images, FileIO
using Distributed, ProgressMeter

export PolynomialIterator
export RootsImage
export find_roots!
export save_image, fill_image!, fill_images!, plot, animate_growth

include("PolynomialIterator.jl")
include("RootsPlot.jl")
include("Computations.jl")

end # module
