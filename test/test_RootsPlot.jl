
@testset "RootsImage: constructor" begin
  img = RootsImage(-1.0-2.0im, 3.0+4.0im, 4, 4)

  @test size(img.data) == (4, 4)
  @test img.remin ≈ -1.0
  @test img.remax ≈  3.0
  @test img.immin ≈ -2.0
  @test img.immax ≈  4.0
end

@testset "RootsImage: add_root!" begin
  img = RootsImage(-1.0-1.0im, 1.0+1.0im, 2, 2)

  ChristensenSet.add_root!(img, -0.5-0.5im)

  @test img.data ≈ [1.0 0.0; 0.0 0.0]

  ChristensenSet.add_root!(img, 0.5+0.5im)

  @test img.data ≈ [1.0 0.0; 0.0 1.0]

  ChristensenSet.add_root!(img, -0.5+0.5im)

  @test img.data ≈ [1.0 1.0; 0.0 1.0]

  ChristensenSet.add_root!(img, -0.5+0.5im)

  @test img.data ≈ [1.0 2.0; 0.0 1.0]
end