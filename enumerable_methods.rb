# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
module Enumerable
  # ############################################################################

  # ***************************     my_each     ********************************

  # ############################################################################

  def my_each
    return to_enum(:my_each) unless block_given?

    ind = 0

    while ind != to_a.length
      yield to_a[ind]
      ind += 1
    end

    self
  end

  # ############################################################################

  # ***********************     my_each_with_endex     *************************

  # ############################################################################

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    index = 0

    my_each do |el|
      yield(el, index)
      index += 1
    end

    self
  end

  # ############################################################################

  # ***************************     my_select     ******************************

  # ############################################################################

  def my_select
    return to_enum(:my_select) unless block_given?

    filtered = []

    if instance_of?(Hash)
      filtered = {}

      my_each do |el|
        key = el [0]
        value = el [1]
        filtered [key] = value if yield(el[0])
      end

      filtered

    else

      filtered = []

      my_each do |el|
        filtered.push(el) if yield(el)
      end
    end

    filtered
  end

  # ############################################################################

  # ***************************     my_all     *********************************

  # ############################################################################

  def my_all?(arg = nil, &block)
    output = false

    filtered_array = if !arg # no arguments

                       block_given? ? my_select(&block) : my_select { |el| el }
                     elsif arg.is_a?(Regexp)

                       my_select { |el| arg == el }

                     elsif arg.is_a?(Class)
                       # if argument is not empty then checking if arg is Class or object value
                       my_select { |el| el.class <= arg }
                     else
                       my_select { |el| el == arg }
                     end
    output = true if filtered_array == to_a
    output
  end

  # ############################################################################

  # ***************************     my_any     *********************************

  # ############################################################################

  def my_any?(arg = nil, &block)
    output = false

    filtered_array = if !arg # no arguments

                       block_given? ? my_select(&block) : my_select { |el| el }
                     elsif arg.is_a?(Regexp)

                       my_select { |el| arg == el }

                     elsif arg.is_a?(Class)
                       # if argument is not empty then checking if arg is Class or object value
                       my_select { |el| el.class <= arg }
                     else
                       my_select { |el| el == arg }
                     end
    output = true unless filtered_array.to_a.empty?
    output
  end

  # ############################################################################

  # ***************************     my_none     ********************************

  # ############################################################################

  def my_none?(arg = nil, &block)
    output = false

    filtered_array = if !arg

                       block_given? ? my_select(&block) : my_select { |el| el }
                     elsif arg.is_a?(Regexp)

                       my_select { |el| arg == el }

                     elsif arg.is_a?(Class)
                       my_select { |el| el.class <= arg }
                     else
                       my_select { |el| el == arg }
                     end

    output = true if filtered_array.to_a.empty?
    output
  end

  # ############################################################################

  # ***************************     my_count     *******************************

  # ############################################################################

  def my_count(num = nil)
    if num
      selected = my_select { |el| el == num }
      selected.length
    else
      return to_a.length unless block_given?

      count = 0

      my_each do |el|
        yield(el) && count += 1
      end
      count
    end
  end

  # ############################################################################

  # ***************************     my_map     *********************************

  # ############################################################################

  def my_map(proc_block = nil)
    return to_enum(:my_map) unless block_given?

    new_arr = []

    if proc_block.instance_of?(Proc) and block_given?
      my_each { |el| new_arr.push(proc_block.call(el)) }
    else
      my_each { |el| new_arr.push(yield(el)) }
    end

    new_arr
  end

  # ############################################################################

  # ***************************     my_inject     ******************************

  # ############################################################################

  def my_inject(my_arg = nil, sym = nil)
    if (my_arg.is_a?(Symbol) || my_arg.is_a?(String)) && (!my_arg.nil? && sym.nil?)
      sym = my_arg
      my_arg = nil
    end

    if !block_given? && !sym.nil?
      my_each { |elt| my_arg = my_arg.nil? ? elt : my_arg.send(sym, elt) }
    else
      my_each { |elt| my_arg = my_arg.nil? ? elt : yield(my_arg, elt) }
    end
    my_arg
  end
end

def multiply_els(arr)
  arr.my_inject { |acc, cn| acc * cn }
end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
