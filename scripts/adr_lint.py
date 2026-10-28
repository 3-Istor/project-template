#!/usr/bin/env python3
"""Check the ADRs in docs/adr: names, statuses, dates and replacement links.

Usage: scripts/adr_lint.py [docs/adr]
Exit code 1 when an error is found.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

STATUSES = {"proposed", "accepted", "superseded", "deprecated", "rejected"}
FILE_RE = re.compile(r"^(\d{4})-[a-z0-9]+(?:-[a-z0-9]+)*\.md$")
DATE_RE = re.compile(r"^\d{4}-\d{2}-\d{2}$")
SKIP = {"README.md", "TEMPLATE.md"}


def front_matter(text: str) -> dict[str, str] | None:
    if not text.startswith("---\n"):
        return None
    end = text.find("\n---", 4)
    if end == -1:
        return None
    fields: dict[str, str] = {}
    for line in text[4:end].splitlines():
        line = line.split("#", 1)[0].rstrip()
        key, sep, value = line.partition(":")
        if sep and key.strip():
            fields[key.strip()] = value.strip().strip('"').strip("'")
    return fields


def numbers(value: str) -> list[str]:
    """'0003', '3', '[0003, 0004]' -> ['0003', '0004']."""
    return [n.zfill(4) for n in re.findall(r"\d+", value)]


def main() -> int:
    adr_dir = Path(sys.argv[1] if len(sys.argv) > 1 else "docs/adr")
    if not adr_dir.is_dir():
        print(f"error: {adr_dir} does not exist")
        return 1

    errors: list[str] = []
    adrs: dict[str, dict[str, str]] = {}
    files: dict[str, str] = {}

    for path in sorted(adr_dir.glob("*.md")):
        if path.name in SKIP:
            continue
        match = FILE_RE.match(path.name)
        if not match:
            errors.append(f"{path.name}: name must be NNNN-short-title.md (lowercase, dashes)")
            continue
        num = match.group(1)
        if num in files:
            errors.append(f"{path.name}: number {num} already used by {files[num]}")
            continue
        files[num] = path.name
        fields = front_matter(path.read_text(encoding="utf-8"))
        if fields is None:
            errors.append(f"{path.name}: missing '---' front matter (copy TEMPLATE.md)")
            continue
        status = fields.get("status", "")
        if status not in STATUSES:
            errors.append(f"{path.name}: status '{status}' must be one of {', '.join(sorted(STATUSES))}")
        if not DATE_RE.match(fields.get("date", "")):
            errors.append(f"{path.name}: date must be YYYY-MM-DD")
        adrs[num] = fields

    for num, fields in adrs.items():
        name = files[num]
        for old in numbers(fields.get("supersedes", "")):
            if old not in adrs:
                errors.append(f"{name}: supersedes {old}, which does not exist")
                continue
            if adrs[old].get("status") != "superseded":
                errors.append(f"{files[old]}: replaced by {num}, so its status must be 'superseded'")
            if num not in numbers(adrs[old].get("superseded_by", "")):
                errors.append(f"{files[old]}: add 'superseded_by: {num}'")
        if fields.get("status") == "superseded":
            newer = numbers(fields.get("superseded_by", ""))
            if not newer:
                errors.append(f"{name}: status 'superseded' needs 'superseded_by: NNNN'")
            for new in newer:
                if new not in adrs:
                    errors.append(f"{name}: superseded_by {new}, which does not exist")
                elif num not in numbers(adrs[new].get("supersedes", "")):
                    errors.append(f"{files[new]}: add 'supersedes: {num}'")

    for msg in errors:
        print(f"error: {msg}")
    print(f"{len(adrs)} ADRs checked · {len(errors)} errors")
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
