##
#
# ChristenseSet.jl Makefile
#

tests:
	julia --color=yes --project=@. test/runtests.jl

documentation:
	julia --color=yes --project=@. docs/make.jl

computation: gallery/ones_Float64.dat gallery/ex13_Float64.dat gallery/ex1i_Float64.dat

gallery/ones_Float64.dat:
	julia --color=yes --project=@. -r 'cd("gallery"); include("generate_one.jl")'
gallery/ex13_Float64.dat:
	julia --color=yes --project=@. -e 'cd("gallery"); include("generate_13.jl")'

gallery/ex1i_Float64.dat:
	julia --color=yes --project=@. -e 'cd("gallery"); include("generate_1i.jl")'

plots:
	julia --color=yes --project=@. -e 'cd("gallery"); include("plot_ones.jl")'
	julia --color=yes --project=@. -e 'cd("gallery"); include("plot_13.jl")'
	julia --color=yes --project=@. -e 'cd("gallery"); include("plot_1i.jl")'
