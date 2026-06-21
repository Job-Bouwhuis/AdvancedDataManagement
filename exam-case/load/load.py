import duckdb
from pathlib import Path
import re

db_path = 'f1.duckdb'
con = duckdb.connect(db_path)
con.execute("CREATE SCHEMA IF NOT EXISTS raw;")

# Get all files
raw_dir = Path('raw')
files = list(raw_dir.glob('*'))

def get_file_info(filename):
    """Extract info from filename using regex pattern matching"""
    name = filename.name
    
    year_match = re.search(r'^(\d{4})', name)
    year = year_match.group(1) if year_match else None
    
    circuit_match = re.search(r'^(\d{8})_(.+?) Grand Prix_', name)
    if circuit_match:
        circuit = circuit_match.group(2).strip()
    else:
        # Fallback: try to find anything before " Grand Prix"
        circuit_match = re.search(r'(.+?) Grand Prix', name)
        if circuit_match:
            circuit = circuit_match.group(1).strip()
        else:
            circuit = 'Unknown'

    print(f"Circuit: {circuit}")
    
    if 'Race_laps' in name:
        file_type = 'laps'
    elif 'Race_weather' in name:
        file_type = 'weather'
    elif 'Race_session_results' in name:
        file_type = 'session_results'
    elif 'Race_race_control_messages' in name:
        file_type = 'race_control'
    else:
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

# First, create empty tables if they don't exist
for file in files:
    if file.suffix not in ['.csv', '.json'] or file.name == 'schedule.txt':
        continue
    
    year, circuit, file_type = get_file_info(file)
    
    if not year:
        print(f"  Skipping {file.name}")
        continue
    
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
    
    exists = con.execute(f"""
        SELECT COUNT(*) FROM information_schema.tables 
        WHERE table_name = '{table_name}'
    """).fetchone()[0] > 0
    
    if not exists:
        if file.suffix == '.csv':
            con.execute(f"""
                CREATE TABLE {table_name} AS 
                SELECT 
                    *,
                    '' AS race_year,
                    '' AS circuit,
                    '' AS race_id,
                    '' AS source_file
                FROM read_csv('{file}', auto_detect=True)
                LIMIT 0
            """)
        else:
            con.execute(f"""
                CREATE TABLE {table_name} AS 
                SELECT 
                    *,
                    '' AS race_year,
                    '' AS circuit,
                    '' AS race_id,
                    '' AS source_file
                FROM read_json_auto('{file}')
                LIMIT 0
            """)
    
    print(f"  Loading {file.name} -> {table_name}")
    
    if file.suffix == '.csv':
        con.execute(f"""
            INSERT INTO {table_name}
            SELECT 
                *,
                '{year}' AS race_year,
                '{circuit}' AS circuit,
                '{year}-{circuit}' AS race_id,
                '{file.name}' AS source_file
            FROM read_csv('{file}', auto_detect=True)
        """)
    else: 
        con.execute(f"""
            INSERT INTO {table_name}
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

print("\nDistinct circuits loaded:")
for table in tables:
    circuits = con.execute(f"SELECT DISTINCT circuit FROM {table[0]} ORDER BY circuit").fetchall()
    if circuits:
        print(f"  {table[0]}: {[c[0] for c in circuits]}")

con.close()
print(f"\nDatabase successfully created at {db_path}")