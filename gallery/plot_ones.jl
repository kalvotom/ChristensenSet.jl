##
#
# Draw various histograms
#

using ChristensenSet

DATA_FILE = "ones_Float64.dat"

# set up images
images = (
  (RootsImage(-2.0-2.0im, 2.0+2.0im, 2000, 2000), "ones.png", "ones.tex"),
  (RootsImage(0.8-0.2im, 1.2+0.2im, 2000, 2000), "ones_1.png", "ones_1.tex"),
  (RootsImage(0.5-0.15im, 0.8+0.15im, 2000, 2000), "ones_2.png", "ones_2.tex"),
  (RootsImage(-0.2+0.65im, 0.2+0.8im, 5333, 2000), "ones_3.png", "ones_3.tex"),
  (RootsImage(0.3+0.4im, 0.6+0.7im, 2000, 2000), "ones_4.png", "ones_4.tex"),
)

# fill images with roots
fill_images!(collect(map(first, images)), DATA_FILE)

# save images to disk
for img in images
  save_image(img[1], img[2], latex_filename=img[3])
  run(`pdflatex $(img[3])`)
end

@info "Done."
