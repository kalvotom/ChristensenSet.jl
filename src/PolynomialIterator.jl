##
#
# Polynomial iterators
#


"""

    PolynomialIterator(coefficients, degree)

Iterate over all polynomials with coefficients provided by array `coefficients`
and maximal degree `degree`.

Polynomials are represented by arrays of their coefficients from the lowest to
the highest order (as in the
[PolynomialRoots](https://github.com/giordano/PolynomialRoots.jl) package).
For example, the polynomial ``z^2 + 2z + 3`` corresponds to
the array `[3, 2, 1]`.

The constructor removes duplicate values from the `coefficients` array.
"""
struct PolynomialIterator{T <: Number}
  coefficients::Array{T, 1}   # array of coefficients
  degree::Int                 # maximal degree
  number_of_coefficients::Int # number of coefficients

  function PolynomialIterator(coefficients::Array{T, 1}, degree::Int) where {T <: Number}
    coeffs = unique(coefficients)

    # reject nonsensical input
    if length(coeffs) == 0 || coeffs == [T(0)]
      throw(
        ArgumentError("You have to provide at least one nonzero coefficient!")
      )
    end

    # push zero to the beginning
    if T(0) in coeffs
      filter!(x -> x != T(0), coeffs)
      prepend!(coeffs, T(0))
    end

    new{T}(coeffs, degree, length(coeffs))
  end
end


#
# Iterator interface
#
# see https://docs.julialang.org/en/v1/manual/interfaces/
#

"""

  iterate(iter)

Initialize the iterator by returning tuple consisting of a nonzero constant
polynomial and the iterator inner state.
"""
function Base.iterate(iter::PolynomialIterator{T}) where {T <: Number}
  if iter.coefficients[1] == T(0)
    return ([iter.coefficients[2]], [2])
  else
    return ([iter.coefficients[1]], [1])
  end

  return 
end


"""

  iterate(iter, state)

Return the next polynomial.
"""
function Base.iterate(iter::PolynomialIterator{T}, state::Array{Int, 1}) where {T <: Number}
  for j in 1:length(state)
    if state[j] < iter.number_of_coefficients
      state[j] += 1
      return ([iter.coefficients[j] for j in state], state)
    else
      state[j] = 1
    end
  end

  # increase the degree
  if length(state) == iter.degree + 1
    return nothing
  else
    if iter.coefficients[1] == T(0) # skip zero
      append!(state, 2)
    else
      append!(state, 1)
    end
    return ([iter.coefficients[j] for j in state], state)
  end
end


"""

    length(iter)

Total number of polynomials specified by the iterator `iter`.
"""
function Base.length(iter::PolynomialIterator{T}) where {T <: Number}
  noc = iter.number_of_coefficients
  if T(0) in iter.coefficients
    return noc ^ (iter.degree + 1) - 1
  elseif noc == 1
    iter.degree + 1
  else
    return noc * div(noc ^ (iter.degree + 1) - 1, noc - 1) 
  end
end
