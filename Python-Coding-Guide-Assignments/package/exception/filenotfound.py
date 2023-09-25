"""
Implement a program that takes user input for a filename, opens the file in read
mode, and displays its contents. Handle the FileNotFoundError and display an error
message if the file is not found.
"""

###################################################################

def display_file_contents(filename: str) -> None:
    """
    Display the contents of a file.

    Args:
        filename (str): The name of the file to open and read.

    Raises:
        FileNotFoundError: If the file is not found.
    """
    try:
        with open(filename, 'r') as file:
            contents = file.read()
            print(contents)
    except FileNotFoundError:
        raise FileNotFoundError(f"File '{filename}' not found. Please check the file name and try again.")

def main():
    """
    Test the display_file_contents function with user input for the filename.
    """
    filename = input("Enter the filename: ")
    try:
        display_file_contents(filename)
    except FileNotFoundError as e:
        print(e)

if __name__ == "__main__":
    main()