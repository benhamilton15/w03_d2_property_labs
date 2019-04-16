DROP TABLE if EXISTS property;

CREATE TABLE property (
  id SERIAL4 PRIMARY KEY,
  address VARCHAR(255),
  value VARCHAR(255),
  number_of_bedrooms INT2,
  year_built INT2
);
