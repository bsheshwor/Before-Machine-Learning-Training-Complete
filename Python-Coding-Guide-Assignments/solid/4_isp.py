"""
[Interface Segregation Principle (ISP)] Download the python file from this link.
Suppose we have an interface called PaymentProcessor that defines methods for
processing payments and refunds.
Then we have a class called OnlinePaymentProcessor that implements the PaymentProcessor interface. However,
some parts of our system only need to process payments and do not handle refunds.
Redesign this program to follow the Interface Segregation Principle (ISP) principle
which represents that “Clients should not be forced to depend upon methods that
they do not use. Interfaces belong to clients, not to hierarchies.” (Hint: Create two
different classes in which one class use interfaces for process payment and another
class can process and refund payment both)
"""

from abc import ABC, abstractmethod

class PaymentProcessor(ABC):
    """
    Abstract base class defining methods for processing payments and refunds.
    """
    @abstractmethod
    def process_payment(self, amount: float) -> None:
        """
        Abstract method to process a payment.

        Parameters:
            amount (float): The amount to be processed for payment.
        """
        pass

class PaymentRefunder(ABC):
    """
    Abstract base class defining methods for processing refunds.
    """
    @abstractmethod
    def process_refund(self, amount: float) -> None:
        """
        Abstract method to process a refund.

        Parameters:
            amount (float): The amount to be processed for refund.
        """
        pass

class OnlinePaymentProcessor(PaymentProcessor):
    """
    Class implementing PaymentProcessor to process payments.
    """
    def process_payment(self, amount: float) -> None:
        """
        Process a payment.

        Parameters:
            amount (float): The amount to be processed for payment.
        """
        print(f"Processing payment of ${amount}")

class OnlinePaymentRefunder(PaymentRefunder):
    """
    Class implementing PaymentRefunder to process refunds.
    """
    def process_refund(self, amount: float) -> None:
        """
        Process a refund.

        Parameters:
            amount (float): The amount to be processed for refund.
        """
        print(f"Processing refund of ${amount}")

def main():
    # Example usage of OnlinePaymentProcessor for processing payments
    payment_processor = OnlinePaymentProcessor()
    payment_processor.process_payment(100)

    # Example usage of OnlinePaymentRefunder for processing refunds
    payment_refunder = OnlinePaymentRefunder()
    payment_refunder.process_refund(50)

if __name__ == "__main__":
    main()

