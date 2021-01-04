#!/usr/bin/env python

import argparse
from datetime import datetime, timedelta, timezone
from email.utils import parsedate_to_datetime

from bs4 import BeautifulSoup
from feedgen.feed import FeedGenerator
import requests


def main():
    parser = argparse.ArgumentParser()
    # url: https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/
    parser.add_argument('--url', required=True)
    parser.add_argument('--name', required=True)
    parser.add_argument('--file-suffix', required=True)
    parser.add_argument('--output')
    params = parser.parse_args()

    records, last_modified = get_records(params.url, params.file_suffix)
    feed = generate_atom_feed(records, params.url, params.name, last_modified)
    if params.output is None:
        print(feed.decode('utf-8'))
    else:
        with open(params.output, 'wb') as f:
            f.write(feed)


def get_records(url, file_suffix):
    resp = requests.get(url)
    last_modified = parsedate_to_datetime(resp.headers['Last-Modified'])
    soup = BeautifulSoup(resp.text, features='html.parser')

    records = []
    for li in soup.select('ul[class=directorycontents] li'):
        span = li.select_one('span[class=file]')
        if span is None:
            # maybe directory
            continue
        filename = span.text
        if not filename.endswith(file_suffix):
            # maybe repo metadata
            continue
        fileurl = '{}{}'.format(url, filename)
        filesize = li.select_one('span[class=size]').text
        filedate = datetime.strptime(li.select_one('span[class=date]').text, '%Y-%m-%d %H:%M')
        filedate = filedate.replace(tzinfo=timezone.utc)  # assume GMT
        records.append((filename, fileurl, filesize, filedate))
    return records, last_modified


def generate_atom_feed(records, url, name, last_modified):
    assert len(records) != 0

    fg = FeedGenerator()
    fg.title(name)
    fg.id(url)
    for rec in records:
        (filename, fileurl, filesize, filedate) = rec
        fe = fg.add_entry()
        fe.title('File: {}'.format(filename))
        fe.id(fileurl)
        fe.link(href=url)
        fe.content('''\
Date: {}
Size: {}
URL: {}'''.format(filedate.strftime('%Y-%m-%d %H:%M'), filesize, fileurl))
        fe.updated(filedate)

    fg.updated(last_modified)
    return fg.atom_str(pretty=True)


if __name__ == '__main__':
    main()
