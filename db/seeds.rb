# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

for d in 1...6
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
    s.tasks.create(name: 'レポート1', until: DateTime.parse('2020-01-01 12:00:00'))
    s.tasks.create(name: 'レポート2', until: DateTime.parse('2020-01-02 12:00:00'))
}

User.create(provider: 'email', uid: '15058', password: 'aaaaaaaa', homeroom_id: 14, number_in_class: 11)
User.create(provider: 'email', uid: '1', password: 'aaaaaaaa', homeroom_id: 0, subjects: [1,2,3,4,5,14])
