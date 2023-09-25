"""
Create a Python program that manages student records. The program should have the
following functionalities:
-Create a function that can add new students to the records with their student_id,
name, age, and grade. The records should be saved to “json” file and each time
new record is added, it should be saved to same “json” file
-Allow searching for a student by student_id or name. The data should return age
and grade from the saved file.
-Allow updating a student's information by using student_id or name(age or grade)
Ensure to follow PEP8 Coding Guidelines for following criterias:
- Proper Indentation
- Maximum Line Length
- Prescriptive Naming conventions (Package and Module Names, Class Names,
- Exception Names, Global Variable Names, Function and Variable Names, Method
- Names and Instance Variables, Constants)
- Source File Encoding while accessing the JSON file
- Add NumPy Docstring to each function
"""

import json
from typing import Dict, Union, List

FILENAME = "student_records.json"

def save_records(records: List[Dict[str, Union[str, int]]]) -> None:
    """Save the student records to a JSON file."""
    with open(FILENAME, "w") as file:
        json.dump(records, file)

def load_records() -> List[Dict[str, Union[str, int]]]:
    """Load student records from the JSON file."""
    try:
        with open(FILENAME, "r") as file:
            return json.load(file)
    except FileNotFoundError:
        return []

def add_student(student_id: str, name: str, age: int, grade: str) -> None:
    """Add a new student to the records with their details."""
    records = load_records()
    records.append({
        "student_id": student_id,
        "name": name,
        "age": age,
        "grade": grade
    })
    save_records(records)

def search_student(query: Union[str, int]) -> List[Dict[str, Union[str, int]]]:
    """Search for a student by student_id or name and return their details."""
    records = load_records()
    found_students = []
    for student in records:
        if str(query) in student["student_id"] or str(query).lower() in student["name"].lower():
            found_students.append({
                "age": student["age"],
                "grade": student["grade"]
            })
    return found_students

def update_student_info(query: Union[str, int], age: int = None, grade: str = None) -> None:
    """Update a student's age or grade by using student_id or name."""
    records = load_records()
    for student in records:
        if str(query) in student["student_id"] or str(query).lower() in student["name"].lower():
            if age is not None:
                student["age"] = age
            if grade is not None:
                student["grade"] = grade
    save_records(records)

def main() -> None:
    """Main function to interact with the student records."""
    print("Welcome to the Student Records Management System!")

    while True:
        print("\nOptions:")
        print("1. Add a new student")
        print("2. Search for a student")
        print("3. Update student information")
        print("4. Exit")

        choice = input("Enter your choice (1/2/3/4): ")

        if choice == "1":
            student_id = input("Enter student ID: ")
            name = input("Enter student name: ")
            age = int(input("Enter student age: "))
            grade = input("Enter student grade: ")
            add_student(student_id, name, age, grade)
            print("Student added successfully!")
        elif choice == "2":
            query = input("Enter student ID or name to search: ")
            found_students = search_student(query)
            if found_students:
                for student in found_students:
                    print(f"Age: {student['age']}, Grade: {student['grade']}")
            else:
                print("No students found.")
        elif choice == "3":
            query = input("Enter student ID or name to update: ")
            option = input("Enter 'A' to update age or 'G' to update grade: ").upper()
            if option == "A":
                age = int(input("Enter updated age: "))
                update_student_info(query, age=age)
            elif option == "G":
                grade = input("Enter updated grade: ")
                update_student_info(query, grade=grade)
            else:
                print("Invalid option.")
        elif choice == "4":
            print("Exiting the program. Goodbye!")
            break
        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    main()
