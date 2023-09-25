"""
[Open-Closed Principle (OCP)] Download the python file from this link. Suppose we
have a Product class that represents a generic product, and we want to calculate the
total price of a list of products. Initially, the Product class only has a price attribute, and
we can calculate the total price of products based on their prices.
Now, let's say we want to add a discount feature, where some products might have a
discount applied to their prices. To add this feature, we would need to modify the
existing Product class and the calculate_total_price function, which violates the
Open/Closed Principle. Redesign this program to follow the Open-Closed Principle
(OCP) which represents “Software entities (classes, modules, functions, etc.) should be
open for extension, but closed for modification.”
"""

from typing import List

class Product:
    """
    Represents a generic product with a price attribute.
    """
    def __init__(self, price: float):
        """
        Initialize a Product object.

        Parameters:
            price (float): The price of the product.
        """
        self.price = price

    def calculate_price(self) -> float:
        """
        Calculate the price of the product.

        Returns:
            float: The price of the product.
        """
        return self.price

class DiscountedProduct(Product):
    """
    Represents a discounted product with a discount applied to the original price.
    """
    def __init__(self, price: float, discount: float):
        """
        Initialize a DiscountedProduct object.

        Parameters:
            price (float): The original price of the product.
            discount (float): The discount percentage (0 to 1) applied to the price.
        """
        super().__init__(price)
        self.discount = discount

    def calculate_price(self) -> float:
        """
        Calculate the discounted price of the product.

        Returns:
            float: The discounted price of the product.
        """
        return self.price * (1 - self.discount)

def calculate_total_price(products: List[Product]) -> float:
    """
    Calculate the total price of a list of products.

    Parameters:
        products (List[Product]): A list of Product objects.

    Returns:
        float: The total price of all products.
    """
    total_price = 0
    for product in products:
        total_price += product.calculate_price()
    return total_price

def main():
    # Using the calculate_total_price function with a list of products
    products = [Product(100), DiscountedProduct(50, 0.1), Product(75)]
    print("Total Price:", calculate_total_price(products))

if __name__ == "__main__":
    main()
