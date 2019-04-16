require ('pg')
class Property

attr_reader :id
attr_accessor :address, :value, :number_of_bedrooms, :year_built

def initialize(options)
  @id = options['id'].to_i if options['id']
  @address = options['address']
  @value = options['value']
  @number_of_bedrooms = options['number_of_bedrooms'].to_i
  @year_built = options['year_built'].to_i
end

def save()
  db = PG.connect({dbname: 'property', host:'localhost'});
  sql = "INSERT INTO property (address, value, number_of_bedrooms, year_built) VALUES ($1, $2, $3, $4) RETURNING id;"
  values = [@address, @value, @number_of_bedrooms, @year_built]
  db.prepare("save", sql)
  property_hashes = db.exec_prepared("save", values)
  @id = property_hashes[0]['id']
  db.close()
end

def update()
  db = PG.connect({dbname: 'property', host:'localhost'});
  sql = "UPDATE property SET (address, value, number_of_bedrooms, year_built) = ($1, $2, $3, $4) WHERE id = $5;"
  values = [@address, @value, @number_of_bedrooms, @year_built, @id]
  db.prepare('update', sql)
  db.exec_prepared("update", values)
  db.close()
end

def Property.delete_all()
  db = PG.connect({dbname: 'property', host:'localhost'});
  sql = "DELETE FROM property;"
  db.prepare('delete_all', sql)
  db.exec_prepared("delete_all")
  db.close()
end

def delete()
  db = PG.connect({dbname: 'property', host:'localhost'});
  sql = "DELETE FROM property WHERE id = $1;"
  values = [@id]
  db.prepare('delete', sql)
  db.exec_prepared('delete', values)
  db.close()
end

def Property.find(id)
  db = PG.connect({dbname: 'property', host:'localhost'});
  sql ="SELECT * FROM property WHERE id = $1;"
  values = [id]
  db.prepare('find', sql)
  property_hashes = db.exec_prepared('find', values)
  property = property_hashes.map{|property_hash|Property.new(property_hash)}
  db.close()
  return property
end

def Property.find_by_address(address)
  db = PG.connect({dbname: 'property', host:'localhost'});
  sql ="SELECT * FROM property WHERE address = $1;"
  values = [address]
  db.prepare('find_by_address', sql)
  property_hashes = db.exec_prepared('find_by_address', values)
  property = property_hashes.map{|property_hash|Property.new(property_hash)}
  db.close()
  return property if property.length > 0
  return nil 
end



end
