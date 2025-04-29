class Student:
    def __init__(self, name, score):
        self.name = name
        self.score = score
    def __repr__(self):
        return f"{self.name} scored {self.score}"

students = [Student("Joe", 0.36), Student("Amy", 0.75), Student("Mark", 0.88), Student("Zach", 0.75), Student("Jane", 0.84), Student("Sarah", 0.65)]


student_result = []
for istudent in students:
    if istudent.score > 0.7:
        student_result.append(f"{istudent.name} passed")
    else:
        student_result.append(f"{istudent.name} failed")

student_result = []
for istudent in students:
    student_result.append(f"{istudent.name} passed")  if istudent.score > 0.7 else student_result.append(f"{istudent.name} failed")

print(student_result)

print(list(map(lambda x: f"{x.name} passed" if x.score > 0.2 else f"{x.name} passed" ,students)))

print(students[3])

# Challenge
# Use map to mulltiply all these numbers by 5

numbers = [1,2,3,4,5]

print(list(map( lambda x:x*5 ,numbers)))
