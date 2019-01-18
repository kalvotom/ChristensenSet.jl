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
  progress = Progress(length(poly_iter), 10)

  for poly in poly_iter
    for z in roots(poly)
      if !isnan(z) && abs(z) > eps(T) # PolynomialRoots pad roots array with NaNs,
        add_root!(image, z)           # ignore zero as a root.
      end
    end
    next!(progress)
  end

  @info "$(Int(sum(image.data))) roots found."
end

"""
Compute roots of polynomials generated by polynomial generator `poly_iter` and
save these roots into `filename` in binary form. Ignore zero as a root,
it occurs too many times and is not interesting.

This function relies on `roots` from the `PolynomialRoots` package.
"""
function compute_roots!(poly_iter::PolynomialIterator{S}, filename::AbstractString) where {S <: Number}
  counter = 0
  progress = Progress(length(poly_iter), 10)

  open(filename, "w") do io
    for poly in poly_iter
      for z in roots(poly)
        if !isnan(z) && abs(z) > eps(S) # PolynomialRoots pad roots array with NaNs,
          write(io, z)                  # ignore zero as a root.
          counter += 1
        end
      end
      next!(progress)
    end
  end

  @info "$counter roots found."
end

"""
TODO
"""
function compute_roots_in_parallel!(poly_iter::PolynomialIterator{S}, filename::AbstractString, batch_size) where {S <: Number}
  results = fill(Future(), batch_size)
  counter = 0
  w = 1
  first_run = true

  io = open(filename, "w")

  @info "Computing..."

  for poly in poly_iter
    # spin up workers
    if first_run
      results[w] = @spawn roots(poly)
    end

    # write results
    if w == batch_size
      for k in 1:batch_size
        for z in roots(fetch(results[k]))
          if !isnan(z) && abs(z) > eps(S) # PolynomialRoots pad roots array with NaNs,
            write(io, z)                  # ignore zero as a root.
            counter += 1
          end
        end
        results[k] = @spawn roots(poly)
      end
      first_run = false
      w = 1
    else
      w += 1
    end
  end

  @info "Saving last results..."

  for k in 1:(w-1)
    for z in roots(fetch(results[k]))
      if !isnan(z) && abs(z) > eps(S) # PolynomialRoots pad roots array with NaNs,
        write(io, z)                  # ignore zero as a root.
        counter += 1
      end
    end
  end

  close(io)

  @info "$counter roots found."
end
