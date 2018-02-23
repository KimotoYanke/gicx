# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Task.all.destroy_all
Subject.all.destroy_all
Homeroom.all.destroy_all

for d in 1...5
    homeroom = Homeroom.create(grade: 1, department: d)
    homeroom.subjects.create(name: '国語 I')
end

for g in 2...5
    for d in ['M', 'E', 'D', 'J', 'C']
        homeroom = Homeroom.create(grade:g, department:d)
        homeroom.subjects.create(name: '数学')
    end
end

Subject.all.each{|s|
    s.tasks.create(name: 'レポート', until: DateTime.parse('2020-01-01 12:00:00'))
}
