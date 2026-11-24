# Chapter Marker List

Build cumulative chapter timestamps from ordered segment durations.

## Run

In PowerShell 7+, run `./run.ps1 -InputFile ./example.txt`. Pass `-OutputFile ./result.txt` to save to a new file. Existing output files are protected.

## Example

One duration mm:ss | title per line. The bundled example output includes:

```text
2:30 Tutorial
```

## Limitations

Input records are read from a UTF-8 text file. Blank lines are skipped.

## Development

See [CONTRIBUTING.md](CONTRIBUTING.md) for checks and [CHANGELOG.md](CHANGELOG.md) for changes.

## License

[MIT License](LICENSE). Copyright (c) 2026 chapter-marker-list contributors.
