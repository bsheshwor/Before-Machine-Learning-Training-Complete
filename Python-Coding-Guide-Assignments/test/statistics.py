"""
Design a function that takes a list of numerical data and performs calculations for mean,
median and standard deviation. Write unit tests to verify the correctness of the statistical
calculations for various inputs, including edge cases like an empty list or a list with one
element (Use unittest module).
"""

import math
from typing import List, Union

def calculate_statistic(data: List[Union[int, float]]) -> dict:
    """Calculate mean, median, and standard deviation of numerical data.

    Args:
        data (List[Union[int, float]]): List of numerical data.

    Returns:
        dict: A dictionary containing the calculated statistics: {'mean': mean_value, 'median': median_value, 'std_dev': std_dev_value}.
    """
    if not data:
        raise ValueError("Empty data list provided. Cannot calculate statistics.")

    n = len(data)
    mean_value = sum(data) / n

    sorted_data = sorted(data)
    median_index = n // 2

    if n % 2 == 0:
        median_value = (sorted_data[median_index - 1] + sorted_data[median_index]) / 2
    else:
        median_value = sorted_data[median_index]

    variance = sum((x - mean_value) ** 2 for x in data) / n
    std_dev_value = math.sqrt(variance)

    return {'mean': mean_value, 'median': median_value, 'std_dev': std_dev_value}
