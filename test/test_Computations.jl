
@testset "Computations: find_root!" begin
  iterator = PolynomialIterator([1], 1)
  # => 1, 1 + x, only one root -1

  image = RootsImage(-1.5-1.0im, 1.5+1.5im, 3, 1)

  find_roots!(iterator, image)

  @test image.data[1,1] == 1.0
  @test image.data[2,1] == 0.0
  @test image.data[3,1] == 0.0
end