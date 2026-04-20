# exercises/load/scripts/load_dog_breeds_csvs.py
#
# Goal: Read all dog-breeds-group-*.csv files from raw/dog-breeds/
#       into one combined DataFrame with a "group" column from the filename.
#
# These CSVs use | as a delimiter and , as the decimal separator.
# Load the data exactly as it is — no renaming, no cleaning.

from pathlib import Path
import pandas as pd

DATA_DIR = (Path(__file__).parent / "../raw/dog-breeds").resolve()

# Step 1: Find all CSV files matching the pattern
files = sorted(DATA_DIR.glob("dog-breeds-group-*.csv"))

# Step 2: Loop through files, read each one, add a group column, collect them
frames = []

for f in files:
    # Extract the group name from the filename
    # Example: "dog-breeds-group-herding" → "herding"
    group = f.stem.replace("dog-breeds-group-", "")

    # Read the CSV — note the delimiter and decimal separator
    df = pd.read_csv(f, sep="|", decimal=",", engine="python")

    # Add the group as a column (this is context from the filename, not a transformation)
    df["group"] = group

    frames.append(df)

# Step 3: Combine all DataFrames into one
# TODO: Use pd.concat to combine the list of DataFrames
# Hint: breed_df = pd.concat(frames, ignore_index=True)


# Step 4: Print to verify
# TODO: Print the first few rows and the shape
# Hint: print(breed_df.head())
#        print(breed_df.shape)