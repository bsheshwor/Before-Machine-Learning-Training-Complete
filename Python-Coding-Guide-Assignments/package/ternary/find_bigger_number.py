"""
Write a function find_bigger_number that takes three integers as input and uses a
ternary operator to return the larger number. If all numbers are equal, return
"Equal."
"""

#########################################################

def find_bigger_number(a: int, b: int, c: int) -> str:
    """
    Find the larger number among three integers using a ternary operator.

    Args:
        a (int): First integer.
        b (int): Second integer.
        c (int): Third integer.

    Returns:
        str: The larger number or "Equal" if all numbers are equal.
    """
    max_number = a if a >= b and a >= c else (b if b >= a and b >= c else c)
    return str(max_number) if max_number != a or max_number != b or max_number != c else "Equal"

def main():
    """
    Test the find_bigger_number function with a sample set of integers.
    """
    a, b, c = 5, 8, 3
    result = find_bigger_number(a, b, c)
    print(f"The larger number is: {result}")

if __name__ == "__main__":
    main()
