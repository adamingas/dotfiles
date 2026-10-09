#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = []
# ///
import argparse
import sys
from datetime import date

TEMPLATE = """# Week {week_number} - {date_str}

## Pending | +PENDING 


## Supercell

### New Supercell TODOs || project:supercell

### Notes 

## Zendesk

### New Zendesk TODOs || project:zendesk

### Notes

## Tomoro

### New Tomoro TODOs || project:tomoro


### Notes

"""


def parse_date(filename: str) -> date:
    """
    Parses a a date from the given filename in the format 'YYYY-MM-DD'.
    The filename format is expected to be '~/vimwiki/diary/YYYY-MM-DD.md'.
    """
    try:
        base_name = filename.split("/")[-1]
        date_str = base_name.split(".")[0]
        year, month, day = map(int, date_str.split("-"))
        return date(year, month, day)
    except Exception as e:
        print(f"Error parsing date from filename '{filename}': {e}", file=sys.stderr)
        raise


def main(filename: str) -> None:
    date = parse_date(filename)
    week_number = date.isocalendar().week
    date_str = date.strftime("%Y-%m-%d")
    content = TEMPLATE.format(week_number=week_number, date_str=date_str)
    print(content)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Diary Template Script")
    _ = parser.add_argument("filename")
    args = parser.parse_args()
    main(args.filename)
