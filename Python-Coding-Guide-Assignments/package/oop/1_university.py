"""
● Create a Python class to represent a University. The university should have
attributes like name, location, and a list of departments. Implement encapsulation to
protect the internal data of the University class. Create a Department class that
inherits from the University class. The Department class should have attributes like
department name, head of the department, and a list of courses offered. Implement
polymorphism by defining a common method for both the University and
Department classes to display their details.
"""

from typing import List

class University:
    """
    Class to represent a University.

    Attributes:
        name (str): The name of the university.
        location (str): The location of the university.
        _departments (List[str]): A private list of department names.
    """
    def __init__(self, name: str, location: str):
        self.name = name
        self.location = location
        self._departments: List[str] = []

    def add_department(self, department_name: str):
        """
        Add a department to the university.

        Args:
            department_name (str): The name of the department.
        """
        self._departments.append(department_name)

    def display_details(self):
        """
        Display the details of the university.
        """
        print(f"University Name: {self.name}")
        print(f"Location: {self.location}")
        print("Departments:")
        for department in self._departments:
            print(f"  - {department}")
        print()


class Department(University):
    """
    Class to represent a Department.

    Attributes:
        department_name (str): The name of the department.
        head_of_department (str): The head of the department.
        courses_offered (List[str]): A list of courses offered by the department.
    """
    def __init__(self, name: str, location: str, department_name: str, head_of_department: str):
        super().__init__(name, location)
        self.department_name = department_name
        self.head_of_department = head_of_department
        self.courses_offered: List[str] = []

    def add_course(self, course_name: str):
        """
        Add a course to the department.

        Args:
            course_name (str): The name of the course.
        """
        self.courses_offered.append(course_name)

    def display_details(self):
        """
        Display the details of the department.
        """
        super().display_details()
        print(f"Department Name: {self.department_name}")
        print(f"Head of Department: {self.head_of_department}")
        print("Courses Offered:")
        for course in self.courses_offered:
            print(f"  - {course}")
        print()


def main():
    """
    Test the University and Department classes.
    """
    university = University("Example University", "Cityville")
    university.add_department("Computer Science")
    university.add_department("Mathematics")

    department = Department("Example University", "Cityville", "Computer Science", "Dr. Smith")
    department.add_course("Programming 101")
    department.add_course("Data Structures")
    department.add_course("Algorithms")

    university.display_details()
    department.display_details()


if __name__ == "__main__":
    main()
