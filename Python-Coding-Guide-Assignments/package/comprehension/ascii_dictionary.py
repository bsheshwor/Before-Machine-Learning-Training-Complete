"""
[dictionary comprehension] Create a dictionary using dictionary comprehension
to represent the ASCII values of lowercase alphabets (a-z) where the keys are the
alphabets, and the values are their corresponding ASCII values.
○ Hint: use ord() function to get the ASCII value of each alphabet
"""

def create_ascii_dict():
    """
    Create a dictionary using dictionary comprehension to represent the ASCII values
    of lowercase alphabets (a-z).

    Returns:
        dict: The dictionary representing the ASCII values of lowercase alphabets.
    """
    ascii_dict = {chr(i): ord(chr(i)) for i in range(ord('a'), ord('z') + 1)}
    return ascii_dict

def main():
    """
    Test the create_ascii_dict function.
    """
    ascii_dict = create_ascii_dict()
    print(ascii_dict)

if __name__ == "__main__":
    main()