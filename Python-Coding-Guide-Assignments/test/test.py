import unittest
from email_validator import is_valid_email
from statistics import calculate_statistic

class TestEmailValidation(unittest.TestCase):
    def test_valid_emails(self):
        self.assertTrue(is_valid_email("bsh@gmail.com"))
        self.assertTrue(is_valid_email("sam@yahoo.com"))
        self.assertTrue(is_valid_email("mich@outlook.com"))

    def test_invalid_emails(self):
        self.assertFalse(is_valid_email("invalid_email"))
        self.assertFalse(is_valid_email("homm@example.com"))
        self.assertFalse(is_valid_email("gumm@yopmail.com"))

class TestCalculateStatistics(unittest.TestCase):
    def test_mean_median_std_dev(self):
        data = [1, 2, 3, 4, 5]
        self.assertEqual(calculate_statistic(data), {'mean': 3.0, 'median': 3, 'std_dev': 1.4142135623730951})

    def test_empty_list(self):
        with self.assertRaises(ValueError):
            calculate_statistic([])

    def test_single_element_list(self):
        data = [10]
        self.assertEqual(calculate_statistic(data), {'mean': 10.0, 'median': 10, 'std_dev': 0.0})

if __name__ == "__main__":
    unittest.main()
