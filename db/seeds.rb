teacher1 = Teacher.create(name: "Mendel Pruss", password: "tom")
teacher2 = Teacher.create(name: "Zalmen Kazen", password: "tom")

subject1 = Subject.create(name: "Chumash")
subject2 = Subject.create(name: "Mishnayos")

student1 = Student.create(name: "Mendel Bannon")
student2 = Student.create(name: "Zali Simon")

subject2.students << student1
subject2.students << student2

subject1.students << student1


teacher1.subjects << subject2

teacher2.subjects << subject1
