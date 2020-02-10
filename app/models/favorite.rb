class Favorite
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  def add_pet(id)
    @contents[id.to_s] = count_of(id) + 1
  end

  def favorite_count
    if self.contents == nil
      "0"
    else
      self.contents.values.sum
    end
  end

  def pet_check(pet_id)
      if self.contents[pet_id] == 1
        return true
      else false
    end
  end

  def all_pets
    pets = []
    @contents.map do |pet_id, amount|
      pets << Pet.find(pet_id)
    end
    pets
  end

  def count_of(id)
    @contents[id.to_s].to_i
  end
end
