"""
Create a function that validates email addresses based on following set of rules:
-Proper email format such as presence of “@”, no space in the address
-Presence of valid email providers such as yahoo, gmail and outlook. Make sure
there are no no disposable email providers such as yopmail.
Write unit tests to validate different email addresses against the rules, including valid and
invalid addresses (Use unittest module).
"""

import re
from typing import List

def is_valid_email(email: str) -> bool:
    """Validate email addresses based on specific rules.

    Args:
        email (str): The email address to validate.

    Returns:
        bool: True if the email is valid, False otherwise.
    """
    # Regular expression to validate email format
    email_pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    if not re.match(email_pattern, email):
        return False

    # Check if email provider is valid
    valid_providers = {'yahoo', 'gmail', 'outlook'}
    email_provider = email.split('@')[1].split('.')[0].lower()
    if email_provider not in valid_providers:
        return False

    # Check for disposable email providers
    disposable_providers = {'yopmail'}
    if email_provider in disposable_providers:
        return False

    return True
