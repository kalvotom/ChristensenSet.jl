##
#
# Draw various histograms
#

using ChristensenSet

DATA_FILE = "ex1i_Float64.dat"

# set up images
images = (
  (RootsImage(-2.0-2.0im, 2.0+2.0im, 2000, 2000), "img1i_1.png", "img1i_1.tex"),
  (RootsImage(-1.0-1.0im, 0.0+0.0im, 2000, 2000), "img1i_2.png", "img1i_2.tex"),
  (RootsImage(-1.5-1.5im, -0.5-0.5im, 2000, 2000), "img1i_3.png", "img1i_3.tex"),
)

# fill images with roots
fill_images!(collect(map(first, images)), DATA_FILE)

# save images to disk
for img in images
  save_image(img[1], img[2], latex_filename=img[3])
  run(`pdflatex $(img[3])`)
end

@info "Done."
