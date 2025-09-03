# connect_and_export.py
# Run:  conda activate dbt-env
#       python connect_and_export.py

import duckdb
from pathlib import Path
import csv

# ---- CONFIG ----
#DB_PATH = r"/Users/manss/Desktop/Case Project/warehouse.duckdb"  # adjust path if needed
DB_PATH = Path(__file__).parent / "warehouse.duckdb"
OUT_DIR = Path(".")  # where CSVs will be written
OUT_DIR.mkdir(parents=True, exist_ok=True)

def dump(con, table, fname):
    df = con.execute(f"SELECT * FROM {table}").df()
    path = OUT_DIR / "csv" / fname
    df.to_csv(path, index=False, encoding="utf-8", quoting=csv.QUOTE_MINIMAL)
    print(f"✔ Saved {fname} ({len(df)} rows)")

def main():
    print("Connecting to DuckDB...")
    con = duckdb.connect(DB_PATH)

    # Export dbt marts directly
    marts = {
        "main_marts.fct_orders":       "fct_orders.csv",
        "main_marts.fct_order_items":  "fct_order_items.csv",
        "main_marts.dim_customers":    "dim_customers.csv",
        "main_marts.orders_fact":      "orders_fact.csv",
        "main_marts.monthly_summary":  "monthly_summary.csv",
        "main_marts.customer_pareto":  "customer_pareto.csv",
    }

    for table, fname in marts.items():
        dump(con, table, fname)

    print("\nAll exports complete. These CSVs are ready for Looker Studio 🚀")

if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        import traceback
        print("ERROR during export:")
        traceback.print_exc()
