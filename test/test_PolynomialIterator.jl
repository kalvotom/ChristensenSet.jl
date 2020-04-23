
@testset "Polynomial iterator: constructor" begin
  @test_throws ArgumentError PolynomialIterator([0.0], 1)
  @test_throws ArgumentError PolynomialIterator(zeros(Float64, 0), 1)

  iterator = PolynomialIterator([1, 1, 1], 0)
  @test iterator.coefficients == [1]

  iterator = PolynomialIterator([1, 0, 2], 0)
  @test iterator.coefficients == [0, 1, 2]
end

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

@testset "Polynomial iterator: do not use zero as leading coefficient" begin
  iterator = PolynomialIterator([0, 1], 2)
  polynomial, state = iterate(iterator)

  @test polynomial == [1]

  polynomial, state = iterate(iterator, state)
  @test polynomial == [0, 1]

  polynomial, state = iterate(iterator, state)
  @test polynomial == [1, 1]

  polynomial, state = iterate(iterator, state)
  @test polynomial == [0, 0, 1]

  polynomial, state = iterate(iterator, state)
  @test polynomial == [1, 0, 1]

  polynomial, state = iterate(iterator, state)
  @test polynomial == [0, 1, 1]

  polynomial, state = iterate(iterator, state)
  @test polynomial == [1, 1, 1]

  @test iterate(iterator, state) == nothing
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

@testset "Polynomial iterator: length" begin
  iterator = PolynomialIterator([1, 2, 3], 0)

  @test length(iterator) == 3

  iterator = PolynomialIterator([1, 2], 1)

  @test length(iterator) == 6

  iterator = PolynomialIterator([1, 2, 3], 2)

  @test length(iterator) == 39

  iterator = PolynomialIterator([0, 1], 1)

  @test length(iterator) == 3

  iterator = PolynomialIterator([1], 2)

  @test length(iterator) == 3

  # paranoid tests...

  # w/o zero
  counter = 0
  iter = PolynomialIterator([1, 2], 3)

  println(length(iter))

  for p in iter
    counter += 1
  end

  @test counter == length(iter)

  # w/ zero
  counter = 0
  iter = PolynomialIterator([0, 1, 2], 2)

  for p in iter
    counter += 1
  end

  @test counter == length(iter)
end
