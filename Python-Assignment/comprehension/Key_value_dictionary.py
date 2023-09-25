"""
[dictionary comprehension] Given two lists - one containing keys and another
containing values, create a dictionary using dictionary comprehension
"""

#########################################################

from typing import List

def create_dictionary(keys: List[str], values: List[str]) -> dict:
    """
    Create a dictionary using dictionary comprehension.

    Args:
        keys (List[str]): List of keys.
        values (List[str]): List of values.

    Returns:
        dict: The dictionary created from keys and values using dictionary comprehension.
    """
    return {k: v for k, v in zip(keys, values)}

def main():
    """
    Test the create_dictionary function with sample lists of keys and values.
    """
    keys = ["apple", "banana", "orange"]
    values = ["red", "yellow", "orange"]
    result_dict = create_dictionary(keys, values)
    print(f"Created dictionary: {result_dict}")

if __name__ == "__main__":
    main()