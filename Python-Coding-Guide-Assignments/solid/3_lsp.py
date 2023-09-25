"""
[Liskov Substitution Principle (LSP)] Download the python file from this link. In this
file, there is an implementation of a banking system for account handling. There is a
savings account and a checking account class. The checking account inherits the
savings account as both have the same functionality and the checking account allows
overdrafts (allow processing transactions even if there is not sufficient balance).
Redesign this program to follow the Liskov Substitution Principle (LSP) principle which
represents that “objects should be replaceable by their subtypes without altering
how the program works”.
"""

from abc import ABC, abstractmethod
from typing import Union

class Account(ABC):
    """
    Represents a generic bank account with a balance.
    """
    def __init__(self, balance: float) -> None:
        """
        Initialize an Account object.

        Parameters:
            balance (float): The initial balance of the account.
        """
        self.balance = balance

    @abstractmethod
    def withdraw(self, amount: float) -> None:
        """
        Abstract method to withdraw a given amount from the account.

        Parameters:
            amount (float): The amount to be withdrawn.

        Raises:
            ValueError: If the amount exceeds the account balance.
        """
        pass

class SavingsAccount(Account):
    """
    Represents a savings account which does not allow overdrafts.
    """
    def withdraw(self, amount: float) -> None:
        """
        Withdraw a given amount from the savings account.

        Parameters:
            amount (float): The amount to be withdrawn.

        Raises:
            ValueError: If the amount exceeds the account balance.
        """
        if amount <= self.balance:
            self.balance -= amount
            print(f"Withdrew ${amount}. Remaining balance: ${self.balance}")
        else:
            raise ValueError("Insufficient funds!")

class CheckingAccount(Account):
    """
    Represents a checking account which allows overdrafts up to a specified limit.
    """
    def __init__(self, balance: float, overdraft_limit: float) -> None:
        """
        Initialize a CheckingAccount object.

        Parameters:
            balance (float): The initial balance of the account.
            overdraft_limit (float): The maximum overdraft limit allowed for the account.
        """
        super().__init__(balance)
        self.overdraft_limit = overdraft_limit

    def withdraw(self, amount: float) -> None:
        """
        Withdraw a given amount from the checking account.

        Parameters:
            amount (float): The amount to be withdrawn.

        Raises:
            ValueError: If the amount exceeds the account balance + overdraft limit.
        """
        if amount <= self.balance + self.overdraft_limit:
            self.balance -= amount
            print(f"Withdrew ${amount}. Remaining balance: ${self.balance}")
        else:
            raise ValueError("Exceeds overdraft limit or insufficient funds!")

def perform_bank_actions(account: Account) -> None:
    """
    Perform bank actions like withdrawals on the account.

    Parameters:
        account (Account): The account on which actions will be performed.
    """
    try:
        account.withdraw(100)
        account.withdraw(200)
        account.withdraw(500)
    except ValueError as e:
        print(e)

if __name__ == "__main__":
    # Creating instances of SavingsAccount and CheckingAccount
    savings_account = SavingsAccount(500)
    checking_account = CheckingAccount(1000, overdraft_limit=200)

    # Performing actions on both accounts
    print("Performing actions on SavingsAccount:")
    perform_bank_actions(savings_account)

    print("\nPerforming actions on CheckingAccount:")
    perform_bank_actions(checking_account)

