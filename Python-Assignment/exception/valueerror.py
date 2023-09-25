"""
Write a Python program that takes a user input and converts it to an integer. Handle
the ValueError and display a custom error message when the input cannot be
converted to an integer.
"""

###################################################################

def convert_to_integer(user_input: str) -> int:
    """
    Convert user input to an integer.

    Args:
        user_input (str): The user input.

    Returns:
        int: The integer representation of the user input.

    Raises:
        ValueError: If the input cannot be converted to an integer.
    """
    try:
        return int(user_input)
    except ValueError:
        raise ValueError("Invalid input! Please enter a valid integer.")

def main():
    """
    Test the convert_to_integer function with user input.
    """
    user_input = input("Enter an integer: ")
    try:
        result = convert_to_integer(user_input)
        print(f"The converted integer is: {result}")
    except ValueError as e:
        print(e)

if __name__ == "__main__":
    main()