
using ChristensenSet

if !isdir("animation")
  mkdir("animation")
end

steps = 100
coefficients(n) = [-1.0, 1 + n * (1.0im - 1)/steps ]
image_names(n) = "animation/img_def_$(lpad(string(n), 3, "0")).png"

ChristensenSet.animate_deformation(coefficients, image_names, steps)
