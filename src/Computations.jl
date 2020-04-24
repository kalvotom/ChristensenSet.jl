##
#
# Let's find those roots!
#


"""

    find_roots!(poly_iter, image)

Find all roots of polynomials generated by polynomial generator `poly_iter` and
draw these roots directly onto `image` (see `add_root!`).
Ignores zero as a root, it occurs too many times and is not that interesting.

This function heavily relies on `roots` from 
the [PolynomialRoots](https://github.com/giordano/PolynomialRoots.jl) package.
"""
function find_roots!(poly_iter::PolynomialIterator{S}, image::RootsImage{T}) where {S <: Number, T <: Real} 
  progress = Progress(length(poly_iter), 10)
  ϵ = careful_eps(T)

  for poly in poly_iter
    for z in roots(poly)
      if abs(z) > ϵ # ignore zero as a root.
        add_root!(image, z)
      end
    end
    next!(progress)
  end

  @info "$(Int(sum(image.data))) non-zero roots found."
end


"""

    find_roots!(poly_iter, filename)

Find all roots of polynomials generated by polynomial generator `poly_iter` and
save these roots into `filename` in binary form. Ignore zero as a root,
it occurs too many times and is not interesting.

This function heavily relies on `roots` from 
the [PolynomialRoots](https://github.com/giordano/PolynomialRoots.jl) package.
"""
function find_roots!(poly_iter::PolynomialIterator{S}, filename::AbstractString) where {S <: Number}
  counter = 0
  progress = Progress(length(poly_iter), 10)
  ϵ = careful_eps(S)

  open(filename, "w") do io
    for poly in poly_iter
      for z in roots(poly)
        if abs(z) > ϵ # ignore zero as a root.
          write(io, z)                  
          counter += 1
        end
      end
      next!(progress)
    end
  end

  @info "$counter non-zero roots found."
end

function careful_eps(T)
  if T <: Real
    return eps(T)
  elseif T <: Complex
    return eps(abs(T(0)))
  else
    error("Wrong type!")
  end
end


"""
TODO
"""
function compute_roots_in_parallel!(poly_iter::PolynomialIterator{S}, filename::AbstractString, batch_size) where {S <: Number}
  error("Not implemented yet.")
end
