"""
Implement a program that reads a CSV file named "data.csv," containing columns
"Name" and "Age." Create a new CSV file called "adults.csv" with only the rows of
individuals who are 18 years or older.
"""

import csv

def filter_adults(input_file: str, output_file: str):
    """
    Filter adults from a CSV file and create a new CSV file with the results.

    Args:
        input_file (str): Path to the input CSV file.
        output_file (str): Path to the output CSV file.
    """
    with open(input_file, 'r') as csv_file:
        reader = csv.DictReader(csv_file)
        adults_data = [row for row in reader if int(row['Age']) >= 18]

    with open(output_file, 'w', newline='') as csv_output:
        fieldnames = ['Name', 'Age']
        writer = csv.DictWriter(csv_output, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(adults_data)

def main():
    """
    Test the filter_adults function with "data.csv" as input and "adults.csv" as output.
    """
    input_file = "data.csv"
    output_file = "adults.csv"
    filter_adults(input_file, output_file)
    print(f"Filtered adults data written to '{output_file}'.")

if __name__ == "__main__":
    main()