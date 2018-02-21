# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

for d in 1...5
    homeroom = Homeroom.create(grade: 1, department: d)
    homeroom.subjects.create(name: '国語 I', homeroom_id: 1)
end
for g in 2...5
    for d in ['M', 'E', 'D', 'J', 'C']
        Homeroom.create(grade:g, department:d)
    end
end

