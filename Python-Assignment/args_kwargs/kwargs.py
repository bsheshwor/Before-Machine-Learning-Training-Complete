"""
[**kwargs] Write a Python function calculate_total_cost that calculates the total
cost of items purchased from a store. The function should accept multiple keyword
arguments, where the key is the item name, and the value is the item's price. The
function should return the total cost of all items.
"""

#########################################################

from typing import Union, Dict

def calculate_total_cost(**kwargs: Union[str, int, float]) -> Union[int, float]:
    """
    Calculate the total cost of items purchased from a store.

    Args:
        **kwargs (str: int or float): Keyword arguments where the key is the item name
                                      and the value is the item's price.

    Returns:
        float or int: The total cost of all items.
    """
    return sum(kwargs.values())

def main():
    """
    Test the calculate_total_cost function with various item prices.
    """
    items = {
        "apple": 0.5,
        "banana": 0.3,
        "orange": 0.4,
        "grapes": 1.2,
        "milk": 1.0
    }
    total_cost = calculate_total_cost(**items)
    print(f"Total cost of items: ${total_cost:.2f}")

if __name__ == "__main__":
    """
    Call the main function
    """
    main()