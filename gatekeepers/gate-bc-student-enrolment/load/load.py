import os
import duckdb
import pandas as pd

# --------------------------------------------------
# Resolve paths relative to THIS file (not cwd)
# --------------------------------------------------

LOAD_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.abspath(os.path.join(LOAD_DIR, ".."))

RESOURCES_DIR = os.path.join(PROJECT_DIR, "resources")
RAW_DIR = os.path.join(RESOURCES_DIR, "raw")
DB_PATH = os.path.join(RESOURCES_DIR, "student_enrolment.duckdb")

ENROLMENTS_CSV = os.path.join(RAW_DIR, "student_enrolments.csv")
PROGRAMMES_CSV = os.path.join(RAW_DIR, "programmes.csv")

# --------------------------------------------------
# Load raw data with Pandas
# --------------------------------------------------

enrolments_df = pd.read_csv(
    ENROLMENTS_CSV,
    parse_dates=["enrolment_date"]
)

programmes_df = pd.read_csv(
    PROGRAMMES_CSV,
    parse_dates=["start_date"]
)

# --------------------------------------------------
# Recreate DuckDB database
# --------------------------------------------------

if os.path.exists(DB_PATH):
    os.remove(DB_PATH)

con = duckdb.connect(DB_PATH)

con.execute("DROP TABLE IF EXISTS raw_student_enrolments")
con.execute("DROP TABLE IF EXISTS raw_programmes")

con.execute("CREATE TABLE raw_student_enrolments AS SELECT * FROM enrolments_df")
con.execute("CREATE TABLE raw_programmes AS SELECT * FROM programmes_df")

con.close()

print("Student enrolment data loaded successfully.")
