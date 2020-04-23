##
#
# ChristenseSet.jl Makefile
#

tests:
	julia --color=yes --project=@. test/runtests.jl

documentation:
	julia --color=yes --project=@. docs/make.jl
