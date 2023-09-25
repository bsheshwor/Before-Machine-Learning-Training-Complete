# Python Coding Guide Assignments Documentation
---
This repository contains the documentation for the Python Coding Guide Assignments. Each section covers different aspects of software design principles, design patterns, coding conventions, unit testing, debugging, linting, and code formatting.

# SOLID Principles
## 1. Single-Responsibility Principle (SRP)

The Single-Responsibility Principle (SRP) emphasizes that a class should have only one reason to change. In the context of our assignment, we implement a library catalog system using Python classes Book and LibraryCatalog. The Book class represents a single book with attributes like Title, Author, ISBN, Genre, and Availability. The LibraryCatalog class manages the collection of books and provides functionalities to add books and retrieve book details. By adhering to SRP, we ensure that each class is responsible for one specific task, keeping the code clean and maintainable.


## 2. Open-Closed Principle (OCP)

The Open-Closed Principle (OCP) states that software entities should be open for extension but closed for modification. In the OCP assignment, we have a Product class that calculates the total price of a list of products based on their prices. We want to introduce a discount feature without modifying the existing class. By applying the OCP, we redesign the code to allow extension through new classes or modules, avoiding direct changes to the Product class. This enhances code reusability and makes it easier to accommodate future changes.


## 3. Liskov Substitution Principle (LSP)

The Liskov Substitution Principle (LSP) states that objects of a superclass should be replaceable with objects of a subclass without altering the program's correctness. In the LSP assignment, we have a banking system with SavingsAccount and CheckingAccount classes. The CheckingAccount inherits from SavingsAccount but allows overdrafts. To adhere to LSP, we ensure that any functionality provided by the SavingsAccount remains unchanged in the CheckingAccount. Subtypes should not alter the behavior of the program when used in place of their parent types.


## 4. Interface Segregation Principle (ISP)

The Interface Segregation Principle (ISP) states that a client should not be forced to depend on interfaces it does not use. In the ISP assignment, we have an interface PaymentProcessor with methods for processing payments and refunds. We create two classes OnlinePaymentProcessor and PaymentProcessorRefund to demonstrate how to segregate the interfaces based on client needs. By adhering to ISP, we make sure that classes depend only on the methods they use, avoiding unnecessary dependencies and ensuring that interfaces serve clients efficiently.


## 5. Dependency Inversion Principle (DIP)

The Dependency Inversion Principle (DIP) states that abstractions should not depend on details; instead, details should depend on abstractions. In the DIP assignment, we have a NotificationService class that directly depends on the EmailSender class. To follow DIP, we introduce an abstraction (interface) for the notification service, which allows us to switch implementations without modifying the NotificationService. This principle promotes decoupling and flexibility in the codebase.


# Design Patterns
## 1. Factory Design Pattern

The Factory Design Pattern provides an interface for creating objects without specifying their concrete classes. In our assignment, we build a logging system using the Factory Pattern. The LoggerFactory class generates different types of loggers (e.g., FileLogger, ConsoleLogger, DatabaseLogger) based on user requirements. By using this pattern, we decouple the logging system from the application, making it easy to add new logger types without modifying existing code.


## 2. Builder Design Pattern

The Builder Design Pattern separates the construction of complex objects from their representation. In the assignment, we design a document generator using the Builder Pattern. The DocumentBuilder class allows creating documents of various types (e.g., PDF, HTML, Plain Text) by implementing builder methods to format content and structure accordingly. This pattern allows us to create different document formats without tightly coupling the document generation logic.


## 3. Singleton Design Pattern

The Singleton Design Pattern ensures a class has only one instance and provides a global access point to that instance. In our assignment, we implement a configuration manager using the Singleton Pattern. The ConfigurationManager class reads configuration settings from a file and ensures that there is only one instance of it throughout the application's lifecycle. This pattern prevents multiple redundant reads of the configuration file and simplifies access to configuration settings.

# Coding Conventions

In this assignment, we create a Python program to manage student records while adhering to PEP8 coding guidelines. We ensure proper indentation, line length, and prescriptive naming conventions for packages, modules, classes, functions, and variables. We also use NumPy Docstrings to provide clear and concise documentation for each function, improving code readability and maintainability.

# Unittest

In the Unittest assignment, we focus on writing unit tests to validate specific functionalities of our code. We have two sections:

## 1. Email Validation

We create a function to validate email addresses based on certain rules like proper format and valid providers (e.g., yahoo, gmail, outlook). We write unit tests to verify different email addresses, including valid and invalid ones, to ensure our validation function works as intended.

## 2. Statistical Calculations

We design a function to calculate mean, median, and standard deviation from a list of numerical data. We write unit tests to check the correctness of these statistical calculations for various inputs, including edge cases like an empty list or a list with one element.

# Debugging

In this assignment, we debug an e-commerce system using Python Debugger (pdb). We identify and handle cases where the logic for adding or removing products from the cart fails. We prevent negative quantities and non-existent products from being added or removed.

# Linting and Code Formatting

Bisheshwor NIn the Linting and Code Formatting assignment, we use the "pylint" and "Flake8" tools to identify and fix problems in previous assignments. We ensure that our code adheres to coding conventions, including proper indentation, line length, naming conventions, source file encoding, and NumPy Docstrings. We create a package containing organized scripts for each assignment to improve code clarity and maintainability.eupane. Happy learning!

```
Bisheshwor Neupane. Happy learning!
```