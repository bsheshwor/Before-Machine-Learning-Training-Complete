"""
[map] Write a Python function square_numbers that takes a list of integers as
input and uses the map function to return a new list containing the square of each
element.
"""

#########################################################

from typing import List

def square_numbers(numbers: List[int]) -> List[int]:
    """
    Square each element in the input list using the map function.

    Args:
        numbers (List[int]): List of integers.
    
    Returns:
        List[int]: A new list containing the square of each element.
    """
    return list(map(lambda x: x**2, numbers))

def main():
    """
    Test the square_numbers function with a sample list of integers.
    """
    numbers = [9,2,6,4,5]
    squared_list = square_numbers(numbers)
    print(f"Squared list: {squared_list}")

if __name__ == "__main__":
    """
    Call the main function
    """
    main()
