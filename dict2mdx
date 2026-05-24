#!/bin/bash

# Convert Lingvo DSL, Babylon BGL, Stardict, ZIM, etc dictionaries to MDict MDX (see input formats supported by https://github.com/ilius/pyglossary)
# 
# Dependencies:
# python3, sqlite3, pyglossary, mdict-utils
# optional dependency: dictzip (for unpacking .dz files)
# 
# Install all dependencies with:
# pip3 install pyglossary mdict-utils lxml polib PyYAML beautifulsoup4 html5lib PyICU libzim>=1.0 python-lzo prompt_toolkit

if command -v python3; then
    echo 'ok!'
else
    echo "ERROR: python not installed! Download and install from https://www.python.org/downloads"
    exit 1
fi

if command -v pyglossary; then
    echo 'ok!'
else
    echo "ERROR: pyglossary not installed! Run 'pip3 install pyglossary'"
    exit 1
fi

if command -v mdict; then
    echo 'ok!'
else
    echo "ERROR: mdict not found! Run 'pip3 install mdict-utils'!"
    exit 1
fi

if command -v sqlite3; then
    echo 'ok!'
else
    echo "ERROR: sqlite3 not found! Use the OS package manager to install!"
    exit 1
fi

if [[ "x" == "x$1" ]]; then
    printf "\n\nUSAGE: `basename $0` dictionary.dsl\n"
    exit 1
fi

src="$1"

if [[ "$src" =~ .*\.dz ]]; then
    echo 'Unpacking .dz file...'
    dictzip -k -d "$1"
    src="${1%.*}"
fi

db_file="${src%.*}.sqlite3"

if [ -e "$db_file" ]; then
    read -p "$db_file already exists! OVERWRITE? (y/n) " answer
    if [[ $answer =~ ^[Yy]$ ]]; then
        rm -v "$db_file"
    else
        exit 1
    fi
fi

pyglossary "$src" "$db_file" --write-format=AyanDictSQLite --sqlite

# Connect to the SQLite3 database
sqlite3 "$db_file" <<EOF
-- Step 1: Rename the columns in the 'entry' table
ALTER TABLE entry RENAME COLUMN term TO entry;
ALTER TABLE entry RENAME COLUMN article TO paraphrase;
-- Step 2: Rename the 'entry' table to 'mdx'
ALTER TABLE entry RENAME TO mdx;
-- Step 3: Drop the 'alt' and 'fuzzy3' tables
DROP TABLE IF EXISTS alt;
DROP TABLE IF EXISTS fuzzy3;
-- Step 4: Rename the 'name' column in the 'meta' table to 'title'
UPDATE meta SET key = 'title' WHERE key = 'name';
EOF

sqlite3 "$db_file" "SELECT value FROM meta WHERE key = 'title';" > title.html
cp title.html description.html

mdict --db-txt "$db_file"
mdict --title title.html --description description.html -a "$db_file".txt "${src%.*}.mdx"

echo 'All done!'
# read -r -p "Remove intermediary files? (y/n) " answer

rm -v "$db_file" "$db_file".txt title.html description.html
