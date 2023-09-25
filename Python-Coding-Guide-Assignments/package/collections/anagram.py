"""
Given an array of strings (str), group the anagrams together. You can return the
answer in any order.
An Anagram is a word or phrase formed by rearranging the letters of a different
word or phrase, typically using all the original letters exactly once.
"""

from typing import List, Dict

def group_anagrams(strs: List[str]) -> List[List[str]]:
    """
    Group the anagrams together in the given array of strings.

    An Anagram is a word or phrase formed by rearranging the letters of a different
    word or phrase, typically using all the original letters exactly once.

    Args:
        strs (List[str]): The array of strings.

    Returns:
        List[List[str]]: The grouped anagrams.
    """
    anagram_groups: Dict[str, List[str]] = {}

    for word in strs:
        sorted_word = ''.join(sorted(word))
        if sorted_word in anagram_groups:
            anagram_groups[sorted_word].append(word)
        else:
            anagram_groups[sorted_word] = [word]

    return list(anagram_groups.values())

def main():
    """
    Test the group_anagrams function.
    """
    input_strings = ["eat", "tea", "tan", "ate", "nat", "bat"]
    grouped_anagrams = group_anagrams(input_strings)
    print(grouped_anagrams)

if __name__ == "__main__":
    main()
