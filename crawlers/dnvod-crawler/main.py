#!/usr/bin/env python3
"""
Run DnvodCrawler and convert to json file eventually.

@author: Gaoping Huang
@since: Jan 16, 2018
"""

from dnvod_crawler import DnvodCrawler
from util import convert_csv_to_json


def main():
    try:
        dnvod = DnvodCrawler('anime', start_new=False)
        dnvod.run()
    finally:
        convert_csv_to_json('anime_list')


if __name__ == '__main__':
    main()