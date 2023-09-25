class Product:
    def __init__(self, name, price, quantity):
        self.name = name
        self.price = price
        self.quantity = quantity

    def get_total_price(self):
        return self.price * self.quantity

    def update_quantity(self, new_quantity):
        if new_quantity >= 0:
            self.quantity = new_quantity
        else:
            print("Invalid quantity value. Quantity cannot be negative.")

class ShoppingCart:
    def __init__(self):
        self.products = {}

    def add_product(self, product, quantity):
        if quantity >= 0:  # Prevent adding negative quantity to the cart
            if product in self.products:
                self.products[product] += quantity
            else:
                self.products[product] = quantity
        else:
            print("Invalid quantity value. Quantity cannot be negative.")

    def remove_product(self, product, quantity):
        if product in self.products:
            if quantity >= 0:  # Prevent removing negative quantity from the cart
                if self.products[product] <= quantity:
                    del self.products[product]
                else:
                    self.products[product] -= quantity
            else:
                print("Invalid quantity value. Quantity cannot be negative.")
        else:
            print("Product not found in the cart.")

    def get_total_cart_price(self):
        total_price = 0
        for product, quantity in self.products.items():
            total_price += product.get_total_price() * quantity
        return total_price

class Customer:
    def __init__(self, name, email):
        self.name = name
        self.email = email
        self.shopping_cart = ShoppingCart()

    def add_to_cart(self, product, quantity):
        self.shopping_cart.add_product(product, quantity)

    def remove_from_cart(self, product, quantity):
        self.shopping_cart.remove_product(product, quantity)

    def checkout(self):
        total_price = self.shopping_cart.get_total_cart_price()
        if total_price > 0:
            print(f"Checking out... Your total is ${total_price}.")
            self.shopping_cart.products = {}
        else:
            print("Your cart is empty. Nothing to checkout.")

# Test the e-commerce system
product1 = Product("Keyboard", 50, 2)
product2 = Product("Mouse", 30, 3)

customer = Customer("John Doe", "john.doe@example.com")
customer.add_to_cart(product1, 1)
customer.add_to_cart(product2, 2)
customer.checkout()

customer.add_to_cart(product1, -1)  # This should now give an error
customer.remove_from_cart(product2, 3)  # This should now give an error
