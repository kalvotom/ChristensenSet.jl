##
#
# Visualization and related functions
#

struct RootsImage{T <: Real}
  remin::T
  remax::T
  immin::T
  immax::T
  height::Int
  width::Int
  hbin::T
  wbin::T
  data::Array{T, 2}

  function RootsImage(leftbottom::Complex{T}, topright::Complex{T}, width::Int, height::Int) where {T <: Real}
    remin = real(leftbottom)
    immin = imag(leftbottom)
    remax = real(topright)
    immax = imag(topright)
    new{T}(remin, remax, immin, immax, height, width, (remax - remin) / width, (immax - immin) / height, zeros(T, width, height))
  end
end

function add_root!(img::RootsImage{T}, z::Complex{T}) where {T <: Real}
  r = real(z); i = imag(z)

  if r < img.remin || r >= img.remax || i < img.immin || i >= img.immax
    # out of range, skipping...
    return
  end

  x = min(max(1, 1 + floor(Int64,(r - img.remin) / img.hbin)), img.width)
  y = min(max(1, 1 + floor(Int64,(i - img.immin) / img.wbin)), img.height)

  img.data[x, y] += T(1)
end

function save_image(img::RootsImage{T}, filename::AbstractString; mode=:sharp) where {T <: Real}
  if mode == :sharp
    output = (x -> min(1, x)).(img.data)
  elseif mode == :log_cutoff
    mean = sum(img.data) / length(img.data)
    output = (x -> log(1 + min(1.2 * mean, x))).(img.data)
    output = output / maximum(output)
  end
  Images.save(filename, colorview(Gray, output))
end

function load_image(img::RootsImage{T}, filename::AbstractString) where {T <: Real}
  open(filename) do io
    while !eof(io)
      z = read(io, Complex{T})
      add_root!(img, z)
    end
  end
end
