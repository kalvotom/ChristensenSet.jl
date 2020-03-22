##
#
# ChristenseSet.jl Makefile
#

tests:
	julia --project=@. test/runtests.jl

documentation:
	julia --project=@. docs/make.jl
