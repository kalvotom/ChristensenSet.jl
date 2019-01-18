##
#
# Visualization and related functions
#

"""
Essentially a two dimensional histogram. 
"""
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

function plot(img::RootsImage{T}; mode=:sharp) where {T <: Real}
  if mode == :sharp
    output = (x -> min(1, x)).(img.data)
  elseif mode == :log_cutoff
    mean = sum(img.data) / length(img.data)
    output = (x -> log(1 + min(1.2 * mean, x))).(img.data)
    output = output / maximum(output)
  end
  
  return colorview(Gray, transpose(output))
end

function save_image(img::RootsImage{T}, filename::AbstractString; mode=:sharp, latex_filename=nothing) where {T <: Real}
  @info "Saving the image..."

  if mode == :sharp
    output = (x -> min(1, x)).(img.data)
  elseif mode == :log_cutoff
    mean = sum(img.data) / length(img.data)
    output = (x -> log(1 + min(1.2 * mean, x))).(img.data)
    output = output / maximum(output)
  end
  Images.save(filename, colorview(Gray, output))

  if latex_filename != nothing
    @info "Constructing the LaTeX file..."
    write_latex(img, filename, latex_filename)
  end
end

function load_image(img::RootsImage{T}, filename::AbstractString) where {T <: Real}
  progress = Progress(div(filesize(filename), sizeof(Complex{T})) + 1, 10)

  @info "Sifting through data..."

  open(filename) do io
    while !eof(io)
      z = read(io, Complex{T})
      add_root!(img, z)
      next!(progress)
    end
  end
end

function load_images(imgs::Array{RootsImage{T}}, filename::AbstractString) where {T <: Real}
  progress = Progress(div(filesize(filename), sizeof(Complex{T})) + 1, 10)

  @info "Sifting through data..."

  open(filename) do io
    while !eof(io)
      z = read(io, Complex{T})
      for img in imgs
        add_root!(img, z)
      end
      next!(progress)
    end
  end
end

function write_latex(img::RootsImage{T}, filename::AbstractString, latex_filename::AbstractString) where {T <: Real}
  open(latex_filename, "w") do io
    write(io, "\\documentclass{standalone}\n")
    write(io, "\\usepackage[T1]{fontenc}\n")
    write(io, "\\usepackage[utf8]{inputenc}\n")
    write(io, "\\usepackage{pgfplots}\n")
    write(io, "\\usepackage{lmodern}\n")
    write(io, "\\begin{document}\n")
    write(io, "\\begin{tikzpicture}\n")
    write(io, "  \\begin{axis}[enlarge limits=false, axis on top, xlabel={\$\\Re\$}, ylabel={\$\\Im\$}]\n")
    write(io, "     \\addplot graphics [xmin=$(img.remin), xmax=$(img.remax), ymin=$(img.immin), ymax=$(img.immax)] {$filename};\n")
    write(io, "  \\end{axis}\n")
    write(io, "\\end{tikzpicture}\n")
    write(io, "\\end{document}\n")
  end
end
