# validate_csv.py
import csv, sys
from pathlib import Path

paths = [Path(p) for p in sys.argv[1:]] or list(Path(".").glob("*.csv"))
for p in paths:
    with p.open(encoding="utf-8") as f:
        r = csv.reader(f)
        header = next(r)
        cols = len(header)
        bad = []
        for i, row in enumerate(r, start=2):
            if len(row) != cols:
                bad.append((i, len(row)))
        if bad:
            print(f"!! {p} -> mismatched rows (showing up to 20): {bad[:20]}")
        else:
            print(f"OK  {p} -> {cols} columns, all rows consistent")
