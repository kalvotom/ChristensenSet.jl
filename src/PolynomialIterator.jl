##
#
# Iterate over all polynomials with given coefficients.
#

"""

    PolynomialIterator(coefficients, degree)

Iterate over all polynomials with coefficients provided by array `coefficients`
and maximal degree `degree`.

Polynomials are represented by arrays of their coefficients from the lowest to
the highest order (as in `PolynomialsRoots` package).
For example ``z^2 + 2z + 3`` corresponds to `[3, 2, 1]`.
"""
struct PolynomialIterator{T <: Number}
  coefficients::Array{T, 1}   # array of coefficients
  degree::Int                 # maximal degree
  number_of_coefficients::Int # number of coefficients

  function PolynomialIterator(coefficients::Array{T, 1}, degree::Int) where {T <: Number}
    new{T}(coefficients, degree, length(coefficients))
  end
end

#
# Iterator interface
#
# see https://docs.julialang.org/en/v1/manual/interfaces/
#

function Base.iterate(iter::PolynomialIterator{T}) where {T <: Number}
  return ([iter.coefficients[1]], [1])
end

function Base.iterate(iter::PolynomialIterator{T}, state::Array{Int, 1}) where {T <: Number}
  for j in 1:length(state)
    if state[j] < iter.number_of_coefficients
      state[j] += 1
      return ([iter.coefficients[j] for j in state], state)
    else
      state[j] = 1
    end
  end

  if length(state) == iter.degree + 1
    return nothing
  else
    append!(state, 1)
    return ([iter.coefficients[j] for j in state], state)
  end
end

function Base.length(iter::PolynomialIterator{T}) where {T <: Number}
  return iter.number_of_coefficients ^ (iter.degree + 1)
end
