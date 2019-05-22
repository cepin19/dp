#!/bin/bash
tr  '\t' '\n'  | tr ' ' '\n' | sort | uniq -c | sort -nr  | head -n 100
