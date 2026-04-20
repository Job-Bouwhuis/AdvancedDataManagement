import os
import duckdb
import pandas as pd


# --------------------------------------------------
# Resolve paths relative to THIS file, not cwd
# --------------------------------------------------

LOAD_DIR = os.path.dirname(os.path.abspath(__file__))
BASE_DIR = os.path.abspath(os.path.join(LOAD_DIR, ".."))

RESOURCES_DIR = os.path.join(BASE_DIR, "resources")
RAW_DIR = os.path.join(RESOURCES_DIR, "raw")
DB_PATH = os.path.join(RESOURCES_DIR, "dogs.duckdb")

BREEDERS_JSON = os.path.join(RAW_DIR, "breeders.json")
BREEDERS_DOGS_JSON = os.path.join(RAW_DIR, "breeders_dogs.json")

# Example: Fetch data from an API (commented out, as not used)
# response = requests.get('https://api.example.com/breeders')
# breeders_data = response.json()
# df = pd.DataFrame(breeders_data)

# Step 1: Load the JSON data into a Pandas DataFrame from a file
df = pd.read_json(BREEDERS_JSON)

# Step 2: Delete the existing DuckDB database file if it exists
if os.path.exists(DB_PATH):
    os.remove(DB_PATH)

# Step 3: Connect to the DuckDB database
con = duckdb.connect(DB_PATH)

# Step 4: Create the breeders table with a JSON field for 'dogs'
con.execute("DROP TABLE IF EXISTS breeders")
# Load the DataFrame into a DuckDB table
con.execute("CREATE TABLE breeders AS SELECT * FROM df")

# Read in breeders_dogs.json
df = pd.read_json(BREEDERS_DOGS_JSON)

# Step 4: Create the breeders table with a JSON field for 'dogs'
con.execute("DROP TABLE IF EXISTS breeders_dogs")
# Load the DataFrame into a DuckDB table
con.execute("CREATE TABLE breeders_dogs AS SELECT * FROM df")

con.close()