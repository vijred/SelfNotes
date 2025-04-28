import random

class Animal:
    info = "All I know is Animal"

    def __init__(self, name):
        print("An animal is created")
        self.name = name

class Dog(Animal):
    info = "I know the animal is a dog"


    def __init__(self, name):
        print("A dog is created")
        super().__init__(name)
        self.lucky_number = random.randint(1,10)
        self.fur = ""


    def bark(self):
        print(f"woof! My name is {self.name} and my number is {self.lucky_number}")

class Bulldog(Dog):
    info = "I know the dog is a Bulldog"
    def __init__(self, name):
        print("A bulldog is created")
        super().__init__(name)

dog1 = Bulldog("Fido")
print(dog1.info)
