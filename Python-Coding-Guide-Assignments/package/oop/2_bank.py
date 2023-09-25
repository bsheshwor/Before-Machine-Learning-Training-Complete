"""
Build a Python class to represent a simple banking system. Create a class for a
BankAccount, and another for Customer. The BankAccount class should have a
constructor to initialize the account details (account number, balance, account type).
The Customer class should have a constructor to set the customer's details (name,
age, address) and create a BankAccount object for each customer. Implement a
destructor for both classes to display a message when objects are destroyed
"""

class BankAccount:
    """
    Class to represent a Bank Account.

    Attributes:
        account_number (int): The account number of the bank account.
        balance (float): The balance of the bank account.
        account_type (str): The type of the bank account.
    """
    def __init__(self, account_number: int, balance: float, account_type: str):
        self.account_number = account_number
        self.balance = balance
        self.account_type = account_type

    def __del__(self):
        """
        Destructor to display a message when a BankAccount object is destroyed.
        """
        print(f"Bank Account with account number {self.account_number} is destroyed.")


class Customer:
    """
    Class to represent a Customer.

    Attributes:
        name (str): The name of the customer.
        age (int): The age of the customer.
        address (str): The address of the customer.
        bank_account (BankAccount): The BankAccount object associated with the customer.
    """
    def __init__(self, name: str, age: int, address: str, account_number: int, balance: float, account_type: str):
        self.name = name
        self.age = age
        self.address = address
        self.bank_account = BankAccount(account_number, balance, account_type)

    def __del__(self):
        """
        Destructor to display a message when a Customer object is destroyed.
        """
        print(f"Customer {self.name} with account number {self.bank_account.account_number} is no longer a customer.")


def main():
    """
    Test the BankAccount and Customer classes.
    """
    customer1 = Customer("John Doe", 30, "123 Main Street", 123456, 1000.0, "Savings")
    customer2 = Customer("Jane Smith", 25, "456 Oak Avenue", 789012, 5000.0, "Checking")


if __name__ == "__main__":
    main()
