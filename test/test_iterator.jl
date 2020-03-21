
@testset "Polynomial iterator: edge cases" begin
  iterator = PolynomialIterator([3, 4], 0)

  @test iterate(iterator) == ([3], [1])
  @test iterate(iterator, [1]) == ([4], [2])
  @test iterate(iterator, [2]) == nothing
end

@testset "Polynomial iterator: variable vector length" begin
  iterator = PolynomialIterator([3, 4], 1)

  @test iterate(iterator) == ([3], [1])
end

@testset "Polynomial iterator: simple test" begin
  iterator = PolynomialIterator([1, 2], 1)
  polynomial, state = iterate(iterator)

  @test polynomial == [1]

  polynomial, state = iterate(iterator, state)
  @test polynomial == [2]

  polynomial, state = iterate(iterator, state)
  @test polynomial == [1, 1]

  polynomial, state = iterate(iterator, state)
  @test polynomial == [2, 1]

  polynomial, state = iterate(iterator, state)
  @test polynomial == [1, 2]

  polynomial, state = iterate(iterator, state)
  @test polynomial == [2, 2]

  @test iterate(iterator, state) == nothing
end
