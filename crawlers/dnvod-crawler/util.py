#!/usr/bin/env python3
import csv
import json

def convert_csv_to_json(filename):
    columns = ('href', 'title', 'views', 'favorite', 'good', 'bad')
    with open(filename+'.csv', 'r') as csvfile, open(filename+'.json', 'w') as jsonfile:
        reader = csv.DictReader(csvfile, columns)
        next(reader, None)  # skip the headers
        out = []
        for row in reader:
            for key in columns[2:]:
                row[key] = int(row[key])
            out.append(row)
        jsonfile.write(json.dumps(out))

if __name__ == '__main__':
    convert_csv_to_json('anime_list')
