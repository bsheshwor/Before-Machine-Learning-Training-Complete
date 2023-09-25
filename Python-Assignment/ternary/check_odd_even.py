"""
Write a Python function called check_odd_even that takes an integer as input and
uses a ternary operator to return "Even" if the number is even, and "Odd" if the
number is odd.
"""

#########################################################

def check_odd_even(number: int) -> str:
    """
    Check if a given integer is even or odd using a ternary operator.

    Args:
        number (int): The integer to check.

    Returns:
        str: "Even" if the number is even, "Odd" otherwise.
    """
    return "Even" if number % 2 == 0 else "Odd"

def main():
    """
    Test the check_odd_even function with a sample integer.
    """
    number = 5
    result = check_odd_even(number)
    print(f"The number {number} is {result}.")

if __name__ == "__main__":
    main()
