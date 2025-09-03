# Jaffle Shop dbt Project

This repository contains a [dbt](https://www.getdbt.com/) project for the fictitious Jaffle Shop analytics built on top of [DuckDB](https://duckdb.org/).

## Requirements

- Python 3.12+
- [dbt-duckdb](https://github.com/dbt-labs/dbt-duckdb)

Install dependencies with:

```bash
pip install dbt-duckdb
```

## Usage

Run dbt commands using the provided `profiles.yml`:

```bash
dbt seed --profiles-dir .
dbt run --profiles-dir .
dbt test --profiles-dir .
```

The project uses a local DuckDB database stored at `warehouse.duckdb`.

## Project Structure

- `models/` – dbt models for staging and marts
- `seeds/` – seed CSV files
- `raw_stores.csv` – additional raw data
- `connect.py` and `validate_csv.py` – utility scripts

## License

This project is provided for educational purposes.
