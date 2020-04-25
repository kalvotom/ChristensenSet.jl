##
#
# Draw various histograms
#

using ChristensenSet

DATA_FILE = "ex13_Float64.dat"

# set up images
images = (
  (RootsImage(-2.0-2.0im, 2.0+2.0im, 2000, 2000), "img13_1.png", "img13_1.tex"),
  (RootsImage(-1.0-0.0im, 0.0+1.0im, 2000, 2000), "img13_2.png", "img13_2.tex"),
  (RootsImage(-0.78-1.8im, 0.22-0.8im, 2000, 2000), "img13_3.png", "img13_3.tex"),
  (RootsImage(-0.78-1.6im, -0.28-1.1im, 2000, 2000), "img13_4.png", "img13_4.tex"),
)

# fill images with roots
fill_images!(collect(map(first, images)), DATA_FILE)

# save images to disk
for img in images
  save_image(img[1], img[2], latex_filename=img[3])
  run(`pdflatex $(img[3])`)
end

@info "Done."
