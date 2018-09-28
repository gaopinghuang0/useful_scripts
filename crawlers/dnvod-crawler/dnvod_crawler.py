#!/usr/bin/env python3
"""
DnvodCrawler class.
@author: Gaoping Huang
@since: Jan 16, 2018
"""

import time
import csv
import random

from urllib.request import Request, urlopen
from bs4 import BeautifulSoup


headers = { 'User-Agent':'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6' }  # pretend to be browser 

category_to_url = {
    'anime': 'http://www.dnvod.tv/Movie/List.aspx?CID=0%2c1%2c6&page={}'
}


class DnvodCrawler(object):
    def __init__(self, category, start_new=False):
        self.category = category
        self.uri = 'http://www.dnvod.tv'
        self.base_url = category_to_url[category]
        self.filename = '{}_list.csv'.format(category)
        self.finished_items = set() if start_new else self.load_finished()
        self.fout = open(self.filename, 'w' if start_new else 'a')
        if start_new:
            self.write_csv_headers()
        print('finished movies in total: ', len(self.finished_items))

    def fetch_content(self, url, repeat=1):
        for i in range(repeat):
            try:
                req = Request(url, headers=headers)
                res = urlopen(req)
                # print(res.read().decode('utf-8'))
                return BeautifulSoup(res.read(), "html5lib")
            except Exception as e:
                print(e)
                print(req)
                time.sleep(10)

    def load_finished(self):
        with open(self.filename, newline='\n') as csvfile:
            reader = csv.reader(csvfile, delimiter=',')
            finished_items = set((row[0] for row in reader))
            return finished_items

    def get_the_last_pagenum(self):
        first_page_url = self.base_url.format(1)
        content = self.fetch_content(first_page_url)
        for paginator in content.find_all('a', {'class': 'paginator'}):
            if paginator.get_text() == '尾页':
                try:
                    href = paginator['href']
                    pagenum = int(href.split('=')[-1])
                    return pagenum
                except:
                    print('Could not get last pagenum')
                    return 1

    def get_movie_list(self, url):
        content = self.fetch_content(url)
        for link in content.find_all('a'):
            if link.has_attr('href') and link['href'].startswith('/Movie/detail.aspx') and link.has_attr('title'):
                href = link.get('href')
                title = link.get('title')
                if href not in self.finished_items:
                    self.finished_items.add(href)
                    yield href, title

    def get_detail_for_movie(self, url):
        content = self.fetch_content(url)
        # first td of table.sharetable
        view_td = content.find('table', {'class': 'sharetable'}).find_all('td')[0]
        views = view_td.find('a').find('span').get_text()
        favorite = content.find('span', {'id': 'favrite'}).get_text()
        good = content.find('strong', {'id': 'good'}).get_text()
        bad = content.find('strong', {'id': 'bad'}).get_text()
        return {"views": views, "favorite": favorite, "good": good, "bad": bad}

    def save_to_file(self, href, title, detail):
        data = [href, title, detail['views'], detail['favorite'], detail['good'], detail['bad']]
        self.fout.write(','.join(data)+'\n')

    def write_csv_headers(self):
        self.fout.write(','.join(['href', 'title', 'views', 'favorite', 'good', 'bad'])+'\n')

    def run(self):
        """Save a list of movie items."""
        last_page_num = self.get_the_last_pagenum()
        print('total pages: ', last_page_num)
        count = 1
        for page_num in range(1, last_page_num+1):
            url = self.base_url.format(page_num)
            print(url)
            for href, title in self.get_movie_list(url):
                print(count, href, title)
                count += 1
                detail = self.get_detail_for_movie(self.uri+href)
                if detail:
                    self.save_to_file(href, title, detail)
                time.sleep(random.randint(4, 6))
            time.sleep(random.randint(5, 10))

        self.fout.close()

