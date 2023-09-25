"""
Implement a function called check_prime that takes a positive integer as input and
uses a ternary operator to determine if it's a prime number. Return "Prime" if it is,
otherwise "Not Prime.
"""

#########################################################

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
        if n % i == 0:
            return False
    return True

def check_prime(number: int) -> str:
    """
    Determine if a positive integer is prime using a ternary operator.

    Args:
        number (int): The positive integer to check.

    Returns:
        str: "Prime" if the number is prime, "Not Prime" otherwise.
    """
    return "Prime" if is_prime(number) else "Not Prime"

def main():
    """
    Test the check_prime function with a sample positive integer.
    """
    number = 17
    result = check_prime(number)
    print(f"The number {number} is {result}.")

if __name__ == "__main__":
    main()