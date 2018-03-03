#!/usr/bin/env ruby

puts <<END
# Some examples of Enumerators and Enumerable
# author: David Charte
# license: MIT
# source: https://libreim.github.io/blog/2015/08/24/ruby-enumerators/

END

################################################################################
# Primes Enumerator
################################################################################
primes = Enumerator.new do |yielder|
  n = 2

  loop do
    yielder << n

    # Find next prime
    prime = false
    until prime
      n += 1

      prime = (2..Math.sqrt(n).floor).all? do |i|
        n % i != 0
      end
    end
  end
end

puts "First 10 primes:"
puts primes.take(10).to_s

################################################################################
# Fibonacci Enumerator
################################################################################
fibonacci = Enumerator.new do |yielder|
  a, b = 0, 1

  loop do
    yielder << a

    a, b = b, a + b
  end
end

puts "\nThe 200th element of the Fibonacci sequence:"
# Calculate 500 elements, retrieve last
puts fibonacci.take(200).drop(199)

################################################################################
# Enumerable Blog class
################################################################################
class Blog
  include Enumerable

  def initialize
    # The class uses any kind of internal collection
    @posts = [
      {
        :title => "Mean inequalities",
        :author => "Mario"
      },
      {
        :title => "Introduction to JavaScript",
        :author => "David"
      },
      {
        :title => "Genetic algorithms",
        :author => "Andrés"
      },
      {
        :title => "Introduction to Category Theory",
        :author => "Mario"
      }
    ]
  end

  # The each method should invoke 'yield' for every element
  def each
    @posts.each do |p|
      yield p[:title], p[:author]
    end
  end
end

libreim = Blog.new
puts "\nPosts authored by Mario:"
puts libreim.select { |tit, aut| aut == "Mario" }.map &:first
