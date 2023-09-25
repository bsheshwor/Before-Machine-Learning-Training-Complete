"""
[filter] Implement a function called filter_prime_numbers that takes a list of
integers as input and uses the filter function to return a new list containing only the
prime numbers
"""

#########################################################

from typing import List
from functools import reduce

def calculate_factorial(n: int) -> int:
    """
    Calculate the factorial of a given integer using the reduce function.

    Args:
        n (int): The integer for which factorial needs to be calculated.

    Returns:
        int: The factorial of 'n'.
        
    Raises:
        ValueError: If 'n' is negative.
    """
    if n < 0:
        raise ValueError("Factorial is not defined for negative numbers.")
    return reduce(lambda x, y: x * y, range(1, n+1), 1)

def main():
    """
    Test the calculate_factorial function with a sample integer
    """
    number = 5
    factorial = calculate_factorial(number)
    print(f"Factorial of (number): {factorial}")

if __name__ == "__main__":
    main()