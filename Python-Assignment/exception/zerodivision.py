"""
Write a Python program that takes two integers as input and performs division
(num1 / num2). Handle the ZeroDivisionError and display a custom error message
when the second number is zero.
"""

###################################################################

def perform_division(num1: int, num2: int) -> float:
    """
    Perform division (num1 / num2) and handle ZeroDivisionError.

    Args:
        num1 (int): The numerator.
        num2 (int): The denominator.

    Returns:
        float: The result of the division.

    Raises:
        ZeroDivisionError: If the second number (denominator) is zero.
    """
    if num2 == 0:
        raise ZeroDivisionError("Cannot divide by zero.")
    return num1 / num2

def main():
    """
    Test the perform_division function with two integers as input.
    """
    try:
        num1 = int(input("Enter the numerator: "))
        num2 = int(input("Enter the denominator: "))
        result = perform_division(num1, num2)
        print(f"The result of division is: {result}")
    except ValueError:
        print("Invalid input! Please enter valid integers.")
    except ZeroDivisionError as e:
        print(e)

if __name__ == "__main__":
    main()