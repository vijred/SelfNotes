# Practice for map function

class Student:
    def __init__(self, name, score):
        self.name = name
        self.score = score

students = [Student("Joe", 0.46), Student("Amy", 0.72), Student("Mark", 0.88), Student("Zach", 0.75), Student("Jane", 0.84), Student("Sarah", 0.63)]


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



#map 
numbers = [1,2,3,4,5]
print(list(map( lambda x:x*5 ,numbers)))

# Reduce 
numbers = [1,2,3,4,5]
from functools import reduce
print(reduce( lambda total, inumber: inumber * total  ,numbers, 1))
print(reduce( lambda total, inumber: inumber * total  ,numbers))

# Filter 
numbers = [1,2,3,4,5]
print(list(filter(lambda x: x%2 == 0, numbers)))
