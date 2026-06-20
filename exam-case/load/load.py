import duckdb
from pathlib import Path
import re

# Connect to a new database file
db_path = 'f1_loaded.duckdb'
con = duckdb.connect(db_path)
con.execute("CREATE SCHEMA IF NOT EXISTS raw;")

# Get all files
raw_dir = Path('raw')
files = list(raw_dir.glob('*'))

# Function to extract info from filename
def get_file_info(filename):
    """Extract info from filename using regex pattern matching"""
    name = filename.name
    
    # Extract year (first 4 digits)
    year_match = re.search(r'(\d{4})', name)
    year = year_match.group(1) if year_match else None
    
    # Extract circuit using generic pattern - look for anything before "Grand Prix"
    circuit_match = re.search(r'(.+?) Grand Prix', name)
    if circuit_match:
        circuit = circuit_match.group(1).strip()
    else:
        # If no "Grand Prix" found, try to extract circuit from filename
        # Look for patterns like "_Italian_" or "_Azerbaijan_" etc.
        circuit_pattern = r'_(.+?)_'
        circuit_match = re.search(circuit_pattern, name)
        if circuit_match:
            circuit = circuit_match.group(1).strip()
        else:
            circuit = 'Unknown'
    
    # Extract file type
    if 'laps' in name.lower():
        file_type = 'laps'
    elif 'weather' in name.lower():
        file_type = 'weather'
    elif 'session_results' in name.lower():
        file_type = 'session_results'
    elif 'race_control' in name.lower():
        file_type = 'race_control'
    else:
        file_type = 'unknown'
    
    return year, circuit, file_type

# Load all files
print("Loading data into DuckDB...")

for file in files:
    if file.suffix not in ['.csv', '.json'] or file.name == 'schedule.txt':
        continue
    
    year, circuit, file_type = get_file_info(file)
    
    if not year:
        print(f"  Skipping {file.name}")
        continue
    
    # Map to table name
    if file_type == 'laps':
        table_name = 'raw_lap_times'
    elif file_type == 'weather':
        table_name = 'raw_weather'
    elif file_type == 'race_control':
        table_name = 'raw_race_control'
    elif file_type == 'session_results':
        table_name = 'raw_session_results'
    else:
        table_name = f'raw_{file_type}'
    
    print(f"  Loading {file.name} -> {table_name}")
    
    # Create table
    if file.suffix == '.csv':
        con.execute(f"""
            CREATE OR REPLACE TABLE {table_name} AS 
            SELECT 
                *,
                '{year}' AS race_year,
                '{circuit}' AS circuit,
                '{year}-{circuit}' AS race_id,
                '{file.name}' AS source_file
            FROM read_csv('{file}', auto_detect=True)
        """)
    else:  # JSON
        con.execute(f"""
            CREATE OR REPLACE TABLE {table_name} AS 
            SELECT 
                *,
                '{year}' AS race_year,
                '{circuit}' AS circuit,
                '{year}-{circuit}' AS race_id,
                '{file.name}' AS source_file
            FROM read_json_auto('{file}')
        """)

print("\nLoading complete!")
print("\nTables created:")
tables = con.execute("SHOW TABLES;").fetchall()
for table in tables:
    count = con.execute(f"SELECT COUNT(*) FROM {table[0]}").fetchone()[0]
    print(f"  {table[0]}: {count} rows")

con.close()
print(f"\nDatabase successfully created at {db_path}")