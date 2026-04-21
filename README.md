# maskfile

A tiny CLI tool to disguise file extensions without touching the file content.

Nothing fancy.
Just renaming.

Done properly, with a bit of structure.

`maskfile` lets you take a file like:

```bash
myapp.exe
```
and turn it into:

```bash
notes.txt
```

Same file. Same bytes. Different label/extension.

Later, you restore it back. No data loss, no corruption.

## Why this exists

Sometimes you need to:

- Move files between systems that behave differently based on extensions
- Avoid accidental execution of binaries (.exe, .sh, etc.)
- Test how tools detect file types (extension vs actual content)
- Experiment with file handling in controlled environments

## How it works

No encoding. No compression. No tricks.

- Copies the file
- Changes the filename
- Optionally verifies checksum

That’s it.

The actual file type is still determined by:

- file headers (magic bytes)
- OS / tool detection logic


## Installation
```bash
chmod +x maskfile.sh
./maskfile.sh
```

or:

```bash
bash maskfile.sh wrap file.zip file.txt
```

## Usage

`wrap` (disguise extension)
```bash
./maskfile.sh wrap archive.zip file.txt
unwrap (restore original form)
./maskfile.sh unwrap file.txt archive.zip
```


verify integrity/`sha256`
```bash
./maskfile.sh sha256 archive.zip
./maskfile.sh sha256 file.txt
```

If hashes match -> you're good.


## Important notes

This tool does not convert file formats,
This tool does not provide security or encryption
This tool does not hide the real file type from analysis tools

*Tools like file will still detect the original format.*

## Use responsibly

This tool is intended for:

- development
- testing
- learning
- controlled file workflows

Not for:

- misleading users
- bypassing restrictions
- distributing disguised executables

If a system enforces rules, respect them.
