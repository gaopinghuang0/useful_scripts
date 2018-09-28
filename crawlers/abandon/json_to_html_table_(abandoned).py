# Abandon reason: use index.js instead

# convert json into html table
# author: Gaoping
# since: 2018/09/27

import os, sys
import json

def json_to_html_table(filename):
    table = '<table>'
    with open(filename) as f:
        data = json.load(f)
        table += gen_table_head(data[0])
        table += gen_table_body(data[1:])
    table += '</table>'
    save_as_html(table, os.path.basename(filename)+'.html')

def gen_table_head(header):
    thead = '<thead><tr>'
    for s in header:
        thead += '<th>'+(s or '')+'</th>'
    thead += '</tr></thead>'
    return thead

def gen_table_body(rows):
    tbody = '<tbody>'
    for row in rows:
        part = '<tr>'
        for s in row:
            part += '<td>'+(s or '')+'</td>'
        part += '</tr>'
        tbody += part
    tbody += '</tbody>'
    return tbody

def save_as_html(table, filename='index.html'):
    with open(filename, 'w') as f:
        f.write('<html><body>\n')
        f.write(table)
        f.write('</boby></html>\n')

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('Usage: ./{} filename'.format(__file__))

    filename = sys.argv[1]
    json_to_html_table(filename)