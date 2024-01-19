# frozen_string_literal = false

# the game progress will be serialized using JSON
require 'json'

module BasicSerializable
  # methods needed: basic file-reading/writing methods, serializing methods
  #
  @@serializer = JSON


  def read_from(file_path)
    File.open(file_path, 'r')
  end

  def write_to(file_path)
    File.open(file_path, 'w')
  end

  def get_answer(file_path)
    file = read_from(file_path)
    # the answer for the game must be a word between 5 and 12 characters
    eligibles = file.each.with_object([]) do |word, arr|
      if word.length > 5 && word.length < 12
        arr.push(word)
      end
    end
    eligibles.sample
  end

  def save_to_file(file_path, obj_string)
    file = write_to(file_path)
    file.write obj_string
  end

  # find a way to connect the serializing method to the file-writing method

  def serialize
    obj = {}
    instance_variables.map do |var|
      obj[var] = instance_variable_get(var)
    end
    @@serializer.dump obj
  end

  def deserialize(string)
    obj = @@serializer.parse(string)
    obj.each_key do |key|
      instance_variable_set(key, obj[key])
    end
  end
end
