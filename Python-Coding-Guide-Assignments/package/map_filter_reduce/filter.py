"""
[filter] Implement a function called filter_prime_numbers that takes a list of
integers as input and uses the filter function to return a new list containing only the
prime numbers
"""

#########################################################

from typing import List

def is_prime(n: int) -> bool:
    """
    Check if a given integer is a prime number.

    Args:
        n (int): The integer to check.

    Returns:
        bool: True if 'n' is prime, False otherwise.
    """
    if n < 2:
        return False
    
    for i in range(2, int(n**0.5) + 1):
        if n%i == 0:
            return False
    
    return True

def filter_prime_numbers(numbers: List[int]) -> List[int]:
    """
    Filter prime numbers from the input list.

    Args:
        numbers (List[int]): List of integers.

    Returns:
        List[int]: A new list containing only the prime numbers from 'numbers'.
    """
    return list(filter(is_prime, numbers))

def main():
    """
    Test the filter_prime_numbers function with a sample list of integers.
    """
    numbers = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    prime_numbers = filter_prime_numbers(numbers)
    print(f"Prime numbers: {prime_numbers}")

if __name__ == "__main__":
    """
    Call the main function
    """
    main()