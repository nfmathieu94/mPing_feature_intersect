#!/usr/bin/env/ python3
import re
import pandas as pd

# Reading in table and resetting index 
gff = pd.read_table("../data/annotation/all.gff3")
gff = gff.reset_index(drop=False)

# Grabbing specific rows for the UTRs
pattern = re.compile(r".*UTR")
sub_gff = gff[gff["level_2"].str.match(pattern)]

def calculate_upstream(row):
    if row['level_6'] == '+':
        return row['level_3'] - 6000
    else:
        return row['level_4'] + 6000

# Apply the function to create the 'upstream' column
sub_gff['upstream'] = sub_gff.apply(calculate_upstream, axis=1)

print(sub_gff)
