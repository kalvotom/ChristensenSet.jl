##
#
# The actual computation
#

"""
Compute roots of polynomials generated by polynomial generator `poly_iter` and
draw these roots directly onto `image` (see `add_root!`). Ignore zero as a root,
it occurs too many times and is not interesting.

This function relies on `roots` from the `PolynomialRoots` package.
"""
function compute_roots!(poly_iter::PolynomialIterator{S}, image::RootsImage{T}) where {S <: Number, T <: Real} 
  for poly in poly_iter
    for z in roots(poly)
      if !isnan(z) && abs(z) > eps(T) # PolynomialRoots pad roots array with NaNs,
        add_root!(image, z)           # ignore zero as a root.
      end
    end
  end

  println("$(Int(sum(img.data))) roots found.")
end

"""
Compute roots of polynomials generated by polynomial generator `poly_iter` and
save these roots into `filename` in binary form. Ignore zero as a root,
it occurs too many times and is not interesting.

This function relies on `roots` from the `PolynomialRoots` package.
"""
function compute_roots!(poly_iter::PolynomialIterator{S}, filename::AbstractString) where {S <: Number}
  counter = 0

  open(filename, "w") do io
    for poly in poly_iter
      for z in roots(poly)
        if !isnan(z) && abs(z) > eps(S) # PolynomialRoots pad roots array with NaNs,
          write(io, z)                  # ignore zero as a root.
          counter += 1
        end
      end
    end
  end

  println("$counter roots found.")
end

function compute_roots_in_parallel!(poly_iter::PolynomialIterator{S}, filename::AbstractString, batch_size=4) where {S <: Number}
  iterator_state = iterate(poly_iter)
  results = fill(Future(), batch_size)
  counter = 0

  io = open(filename, "w")

  while iterator_state != nothing
    # run jobs
    for k in 1:batch_size
      results[k] = @spawn roots(iterator_state[1])
      iterator_state = iterate(poly_iter, iterator_state[2])

      if iterator_state == nothing
        break
        batch_size = k
      end
    end

    # write results
    for k in 1:batch_size
      for z in roots(fetch(results[k]))
        if !isnan(z) && abs(z) > eps(S) # PolynomialRoots pad roots array with NaNs,
          write(io, z)                  # ignore zero as a root.
          counter += 1
        end
      end
    end
  end

  close(io)

  println("$counter roots found.")
end
