# exercises/load/scripts/load_breeders_json.py
#
# Goal: Read breeders.json into a pandas DataFrame.
#       Load the data exactly as it is — no renaming, no cleaning.

from pathlib import Path
import json
import pandas as pd

JSON_PATH = (Path(__file__).parent / "../raw/breeders.json").resolve()

# Step 1: Read the JSON file
with JSON_PATH.open("r", encoding="utf-8") as fh:
    raw = json.load(fh)

# Step 2: Convert to a DataFrame
# TODO: Use pd.json_normalize to create a DataFrame from the JSON data
# Hint: breeders_df = pd.json_normalize(raw)


# Step 3: Print to verify
# TODO: Print the first few rows and the shape
# Hint: print(breeders_df.head())
#        print(breeders_df.shape)