##
#
# ChristenseSet.jl Makefile
#

tests:
	julia --color=yes --project=@. test/runtests.jl

documentation:
	julia --color=yes --project=@. docs/make.jl

computation:
	cd examples; julia --color=yes --project=@../. generate_one.jl

plots:
	cd examples; julia --color=yes --project=@../. ones_generate_plots.jl
