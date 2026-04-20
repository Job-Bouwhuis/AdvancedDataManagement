# exercises/load/scripts/write_to_duckdb.py
#
# Goal: Import the DataFrames from the other two scripts
#       and write them as tables into a DuckDB database.
#
# This creates db/dogs.duckdb with two tables:
#   - dog_breeds   (from load_dog_breeds_csvs.py)
#   - breeders     (from load_breeders_json.py)

import duckdb
from pathlib import Path

DB_PATH = (Path(__file__).parent / "../db/dogs.duckdb").resolve()

# Step 1: Import the DataFrames from the other scripts
from load_dog_breeds_csvs import breed_df
from load_breeders_json import breeders_df

# Step 2: Connect to DuckDB (creates the file if it doesn't exist)
con = duckdb.connect(DB_PATH.as_posix())

# Step 3: Write the dog breeds DataFrame to a table
# TODO: Use con.execute to create a table called "dog_breeds" from breed_df
# Hint: con.execute("CREATE OR REPLACE TABLE dog_breeds AS SELECT * FROM breed_df")


# Step 4: Write the breeders DataFrame to a table
# TODO: Use con.execute to create a table called "breeders" from breeders_df
# Hint: con.execute("CREATE OR REPLACE TABLE breeders AS SELECT * FROM breeders_df")


# Step 5: Verify by printing row counts
# TODO: Print the count for each table
# Hint: print(con.execute("SELECT COUNT(*) AS n FROM dog_breeds").df())
#        print(con.execute("SELECT COUNT(*) AS n FROM breeders").df())


# Step 6: Close the connection
# TODO: con.close()