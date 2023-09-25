"""
Implement a program that reads user input for a password. Create a custom
exception WeakPasswordError to handle cases where the password is shorter
than 8 characters.
○ Hint: WeakPasswordError that inherits Exception class
"""

class WeakPasswordError(Exception):
    """
    Custom exception for weak passwords (passwords shorter than 8 characters).
    """
    pass

def check_password_strength(password: str):
    """
    Check the strength of a password and raise WeakPasswordError if it's too weak.

    Args:
        password (str): The password to check.
    """
    if len(password) < 8:
        raise WeakPasswordError("Password is too weak. It should be at least 8 characters.")

def main():
    """
    Test the password strength with user input.
    """
    try:
        password = input("Enter your password: ")
        check_password_strength(password)
        print("Password is strong.")
    except WeakPasswordError as e:
        print(e)

if __name__ == "__main__":
    main()