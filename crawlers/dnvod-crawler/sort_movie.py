#!/usr/bin/env python3
"""
Sort the csv file by a given key.
Since we have an index.html, this function is less useful now.

@author: Gaoping Huang
@since: Jan 16, 2018
"""

import csv
import sys

def sort_by_key(category, key_index):
    filename = '{}_list.csv'.format(category)
    with open(filename, newline='\n') as csvfile:
        reader = csv.reader(csvfile, delimiter=',')
        reader = sorted(reader, key=lambda x: int(x[key_index+2]), reverse=True)
        for row in reader:
            print(', '.join([row[1], row[key_index+2]]))


def main():
    sortable_keys = ['views', 'favorite', 'good', 'bad']
    if len(sys.argv) < 2:
        key = 'good'
    else:
        key = sys.argv[1]
    sort_by_key('anime', sortable_keys.index(key))


if __name__ == '__main__':
    main()