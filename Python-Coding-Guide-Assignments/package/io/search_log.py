"""
Create a function search_log that takes a log file and a search keyword as input.
The function should find and display all lines containing the search keyword.
"""

def search_log(log_file: str, search_keyword: str):
    """
    Search for lines containing the search keyword in a log file.

    Args:
        log_file (str): Path to the log file.
        search_keyword (str): The keyword to search for in the log file.
    """
    with open(log_file, 'r') as log:
        for line in log:
            if search_keyword in line:
                print(line.strip())

def main():
    """
    Test the search_log function with a sample log file and search keyword.
    """
    log_file = "sample.log"
    search_keyword = "ERROR"
    search_log(log_file, search_keyword)

if __name__ == "__main__":
    main()

