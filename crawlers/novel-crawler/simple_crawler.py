#!/usr/bin/env python
# -*- coding: utf-8 -*-

import urllib2
import csv
from bs4 import BeautifulSoup

class Crawler(object):
    def __init__(self, url_format):
        self.url_format = url_format

    def fetchTable(self, start, end=None, tableClass='table'):
        """
        Fetch a table on page.
        @start: the html page index
        @end: the html page index
        """
        if not end: end = start
        for i in range(start, end+1):
            url = self.url_format.format(i)
            print 'fetching {}...'.format(url)
            page = urllib2.urlopen(url)
            soup = BeautifulSoup(page.read())
            for table in soup.findAll('table', class_=tableClass):
                yield table

    def toCSV(self, data, filename):
        with open(filename, 'wb') as csvfile:
            # Credit: http://stackoverflow.com/questions/34481700/python-csv-write-to-file-unreadable-chinese-characters
            csvfile.write(u'\ufeff'.encode('utf8'))  # to read in excel
            writer = csv.writer(csvfile, dialect='excel')
            for d in data:
                row = [s.encode('utf-8') for s in d]
                writer.writerow(row)

def main():
    app = Application()
    app.get_piaotian_novel_list(1, 280)


class Application(object):
    def __init__(self):
        pass

    def get_piaotian_novel_list(self, start, end=None):
        url_format = 'http://www.piaotian.net/booktopallvisit/0/{}.html'
        crawler = Crawler(url_format)
        contents = []
        for table in crawler.fetchTable(start, end, 'grid'):
            for tr in table.findAll('tr'):
                tds = tr.findAll('td')
                if len(tds) == 6 and tds[-1].text == u'已完成':
                    contents.append(map(lambda x: x.text, tds))
        crawler.toCSV(contents, './novel-list.csv')


if __name__ == '__main__':
    main()