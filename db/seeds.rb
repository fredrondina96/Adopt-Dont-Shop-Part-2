# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shelter1 = Shelter.create!(name: 'Mike\'s Shelter,', address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
shelter2 = Shelter.create!(name: 'Meg\'s Shelter', address: "150 Main Street", city: 'Hershey', state: 'PA', zip: "17033")

snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Athena', age: 1, sex: 'female', shelter: shelter1, description: 'butthead', adoption_status: "Pending Adoption")
sadie = Pet.create!(image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSCMW96soSsEyR2xziZ78kiJQieU7Ud_xSS56wzXUsrK5DOx2zz', name: 'Odell', age: 4, sex: "M", shelter: shelter2, description: 'good dog', adoption_status: "Adoptable")
dog1 = Pet.create!(image: 'https://www.rd.com/wp-content/uploads/2019/09/01_Doggie-dino-760x506.jpg', name: 'Sara', age: 3, sex: "Famale", shelter: shelter2, description: 'Is a Trisaratops', adoption_status: "Adoptable")
dog2 = Pet.create!(image: 'https://s7d2.scene7.com/is/image/PetSmart/5290431', name: 'Henry', age: 10, sex: "Male", shelter: shelter1, description: 'Has a good life', adoption_status: "Adoptable")
dog3 = Pet.create!(image: 'https://www.rover.com/blog/wp-content/uploads/2019/09/frisco-raptor-e1567812754551.jpg', name: 'Robert', age: 4, sex: "Female", shelter: shelter1, description: 'Loves the chase', adoption_status: "Adoptable")
dog3 = Pet.create!(image: 'https://www.rover.com/blog/wp-content/uploads/2019/09/41D19vlgwoL.jpg', name: 'Kathy', age: 2, sex: "Female", shelter: shelter1, description: 'Hates this damn costume', adoption_status: "Adoptable")

review1 = Review.create!(title: "Best Shelter EVER!", rating: "5", content: "I now have my best friend because of this place", shelter_id: shelter1.id)
