"""
Create a function add_to_json that takes a filename and a dictionary as input. The
function should read the JSON data from the file, add the new dictionary to it, and
write the updated data back to the same file.
○ Sample Json:
[
{
"name": "Ram",
"age": 30
},
{
"name": "Sita",
"age": 25
}
]
"""

import json

def add_to_json(filename: str, new_dict: dict):
    """
    Add a new dictionary to a JSON file.

    Args:
        filename (str): Path to the JSON file.
        new_dict (dict): The dictionary to add to the JSON data.
    """
    with open(filename, 'r') as json_file:
        data = json.load(json_file)
        data.append(new_dict)

    with open(filename, 'w') as json_output:
        json.dump(data, json_output, indent=2)

def main():
    """
    Test the add_to_json function with a sample JSON file.
    """
    filename = "sample.json"
    new_data = {
        "name": "Laxman",
        "age": 28
    }
    add_to_json(filename, new_data)
    print(f"Updated JSON data written to '{filename}'.")

if __name__ == "__main__":
    main()