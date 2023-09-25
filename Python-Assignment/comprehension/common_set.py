"""
● [set comprehension] Given two strings, write a Python program to create a set
using set comprehension that contains all the characters that are common in both
strings.
"""

def common_characters_set(str1: str, str2: str) -> set:
    """
    Create a set using set comprehension containing all the characters that are common
    in both input strings.

    Args:
        str1 (str): The first input string.
        str2 (str): The second input string.

    Returns:
        set: The set containing common characters.
    """
    return {char for char in str1 if char in str2}

def main():
    """
    Test the common_characters_set function with sample strings.
    """
    string1 = "hello"
    string2 = "world"
    common_chars = common_characters_set(string1, string2)
    print(common_chars)

if __name__ == "__main__":
    main()