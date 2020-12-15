require 'rspec'
require '../enumerable_methods'
require 'colorize'

describe Enumerable do
  let(:array) { [1, 3, 5, 7] }
  let(:string_array) { %w[cat dog yam egg] }
  let(:range) { (1..5) }

  describe '#my_each' do
    it 'It returns multiplcation of the array' do
      result = []
      array.my_each { |e| result << e * 2 }
      expect(result).to eq([2, 6, 10, 14])
    end

    it 'it should return enumerator if block is not given' do
      expect(array.my_each).to be_an Enumerator
    end
  end

  describe '#my_each' do
    it 'returns element index' do
      result = []
      array.my_each_with_index { |_e, index| result << index }
      expect(result).to eq([0, 1, 2, 3])
    end

    it 'it should return enumerator if block is not given' do
      expect(array.my_each_with_index).to be_an Enumerator
    end
  end

  describe '#my_select' do
    it 'returns element index' do
      result = []
      array.my_select { |e| result << e * 2 }
      expect(result).to eq([2, 6, 10, 14])
    end

    it 'it should return enumerator if block is not given' do
      expect(array.my_select).to be_an Enumerator
    end

    it 'returns element equal to 3' do
      result = array.my_select { |e| e == 3 }
      expect(result).to eq([3])
    end

    it 'returns even elements' do
      result = array.my_select(&:even?)
      expect(result).to eq([])
    end
  end

  describe '#my_all?' do
    it 'returns the predicate of all odd numbers' do
      result = array.my_all?(&:odd?)
      expect(result).to be_truthy
    end

    it 'checks if all elements are divisible by 5' do
      result = array.my_all? { |e| (e % 5).zero? }
      expect(result).to be_falsey
    end

    it 'checks if all elements has a length of 3' do
      result = string_array.my_all? { |e| e.length == 3 }
      expect(result).to be_truthy
    end
  end

  describe '#my_any?' do
    it 'returns the predicate of all odd numbers' do
      result = array.my_any?(&:odd?)
      expect(result).to be_truthy
    end

    it 'checks if all elements are divisible by 5' do
      result = array.my_any? { |e| (e % 5).zero? }
      expect(result).to be_truthy
    end

    it 'checks if all elements has a length of 3' do
      result = string_array.my_any? { |e| e.length == 3 }
      expect(result).to be_truthy
    end
  end

  describe '#my_count' do
    it 'it should return number of elements in array' do
      expect(array.my_count).to eq(4)
    end

    it 'Returns number of element divisble by 2' do
      result = array.my_count(&:even?)
      expect(result).to eq(0)
    end

    it 'Returns the number of time a number exists' do
      result = array.my_count(7)
      expect(result).to eq(1)
    end
  end

  describe '#my_map' do
    it 'multiplies all elements in an array by 3' do
      expect(array.my_map { |el| el * 3 }).to eq([3, 9, 15, 21])
    end

    it 'multiplies all elements in a range by 5' do
      expect(range.my_map { |el| el * 5 }).to eq([5, 10, 15, 20, 25])
    end
  end

  describe '[my_inject tests] >'.bold.blue do
    it 'my_inject block parsing.' do
      expect(arr_in.my_inject { |i, j| i + j }).to eq(arr_in.inject { |i, j| i + j })
    end
    it 'my_inject block parsing with parameter.' do
      expect(arr_in.my_inject(10) { |i, j| i + j }).to eq(arr_in.inject(10) { |i, j| i + j })
    end
    it 'my_inject symbol parsing without block.' do
      expect(arr_in.my_inject(:*)).to eq(arr_in.inject(:*))
    end
    it 'my_inject range & multi arguments parsing without block.' do
      expect(enum_in.my_inject(10, :*)).to eq(enum_in.inject(10, :*))
    end
    it 'my_inject range & block parsing.' do
      expect(enum_in.my_inject(4) { |prod, n| prod * n }).to eq(enum_in.inject(4) { |prod, n| prod * n })
    end
  end
end
