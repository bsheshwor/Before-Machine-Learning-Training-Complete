"""
[set comprehension] Given a list of numbers, create a set using set
comprehension that contains only unique even numbers.
"""

#########################################################

from typing import List

def unique_even_numbers(numbers: List[int]) -> set:
    """
    Create a set containing unique even numbers using set comprehension.

    Args:
        numbers (List[int]): List of numbers.

    Returns:
        set: The set of unique even numbers.
    """
    return {n for n in numbers if n % 2 == 0}

def main():
    """
    Test the unique_even_numbers function with a sample list of numbers.
    """
    numbers = [1, 2, 3, 4, 5, 6, 7, 8, 8, 10, 11]
    unique_evens = unique_even_numbers(numbers)
    print(f"Set of unique even numbers: {unique_evens}")

if __name__ == "__main__":
    main()