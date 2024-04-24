from faker import Faker
import sys

def generate_names(num_establishments, num_teachers, num_students):
    fake = Faker()
    with open('establishments_names.txt', 'w') as e_file, \
         open('teachers_names.txt', 'w') as t_file, \
         open('students_names.txt', 'w') as s_file:

        # Generate names for establishments
        for _ in range(num_establishments):
            e_file.write(f"{fake.name()}\n")

        # Generate names for teachers
        for _ in range(num_teachers):
            t_file.write(f"{fake.name()}\n")

        # Generate names for students
        for _ in range(num_students):
            s_file.write(f"{fake.name()}\n")

if __name__ == "__main__":
    num_establishments = int(sys.argv[1])
    num_teachers = int(sys.argv[2])
    num_students = int(sys.argv[3])
    generate_names(num_establishments, num_teachers, num_students)
