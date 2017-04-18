# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

cat1 = Cat.create(birth_date: "2015/01/20", name: "Dallas", sex: "M", color: "Orange", description: "A tall cat." )
cat2 = Cat.create(birth_date: "2014/02/10", name: "Greg", sex: "M", color: "Brown", description: "A hairy cat." )
cat3 = Cat.create(birth_date: "2005/06/10", name: "Sarah", sex: "F", color: "Black", description: "An old cat." )

rental1 = CatRentalRequest.create(cat_id: 1, start_date: "2016/01/20", end_date: "2016/02/20", status: "APPROVED")
rental2 = CatRentalRequest.create(cat_id: 2, start_date: "2017/01/22", end_date: "2017/02/25", status: "APPROVED")
rental3 = CatRentalRequest.create(cat_id: 2, start_date: "2017/02/22", end_date: "2017/02/28", status: "DENIED")
