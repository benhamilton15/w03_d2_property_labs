require_relative('models/property.rb')
require('pry-byebug')

# Property.delete_all()

house1 = Property.new(
  {
    'address' => '2 Notre Dame',
    'value' => '£3000000',
    'number_of_bedrooms' => '15',
    'year_built' => '1163'
  }
)

house2 = Property.new(
  {
    'address' => '37 Castle Terrace',
    'value' => '£1264738',
    'number_of_bedrooms' => '9',
    'year_built' => '2015'
  }
)

#
# house1.save()
# house2.save()

p Property.find(15)

# house1.delete()
