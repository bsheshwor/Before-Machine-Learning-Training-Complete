"""
[list comprehension] Given two lists of integers, create a list that contains the
product of each element of the first list with the corresponding element in the
second list using list comprehension.
"""

from typing import List

def create_product_list(list1: List[int], list2: List[int]) -> List[int]:
    """
    Create a list containing the product of each element of the first list with
    the corresponding element in the second list using list comprehension.

    Args:
        list1 (List[int]): The first list of integers.
        list2 (List[int]): The second list of integers.

    Returns:
        List[int]: The list containing the product of each element.
    """
    return [x * y for x, y in zip(list1, list2)]

def main():
    """
    Test the create_product_list function with sample lists of integers.
    """
    list1 = [1, 2, 3, 4, 5]
    list2 = [10, 20, 30, 40, 50]
    product_list = create_product_list(list1, list2)
    print(product_list)

if __name__ == "__main__":
    main()

    