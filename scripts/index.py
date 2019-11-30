#!/usr/bin/env python3

import sys
import json
import pystache
from datetime import datetime as dt

template = open("scripts/stache_template.mustache").read()
renderer = pystache.Renderer()

input = sys.stdin.readline()
index_entries = json.loads(input)

for entry in index_entries:
    entry['date'] = dt.strptime(entry['date'], "%Y-%m-%d").strftime("%b %d, %Y")
    print(renderer.render(template, entry))
