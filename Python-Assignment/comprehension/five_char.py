"""
[list comprehension] Given a list of strings, create a new list that contains only 
thestrings with more than 5 characters using list comprehension.
"""

#########################################################

from typing import List

def filter_long_strings(strings: List[str]) -> List[str]:
    """
    Create a new list containing strings with more than 5 characters using list comprehension.

    Args:
        strings (List[str]): List of strings.

    Returns:
        List[str]: A new list containing strings with more than 5 characters.
    """
    return [s for s in strings if len(s) > 5]

def main():
    """
    Test the filter_long_strings function with a sample list of strings.
    """
    words = ["apple", "banana", "orange", "kiwi", "watermelon"]
    long_strings = filter_long_strings(words)
    print(f"Strings with more than 5 characters: {long_strings}")

if __name__ == "__main__":
    main()