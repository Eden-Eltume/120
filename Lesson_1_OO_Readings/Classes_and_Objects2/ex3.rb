# We get the error because calling attr_reader on the instance variable makes it read-only
# To get the desired result we would have to call attr_writer or attr_accessor