# Gutenberg CW

This is a shell script which

1. Fetches books in different languages from [Project Gutenberg][gutenberg]
2. Selects random lines from the books
3. Converts these lines to morse code in MP3 format at different speeds

This is useful for training CW on semi-random text: parts of sentences make
sense, but language changes continuously and within sentences.

## Usage

For the first time, use:

```bash
./genlib.sh new
```

This may take a while. After that, you can remove the `cache` directory (which
contains the entire Gutenberg catalogue listing) and simply use:

```bash
./genlib.sh
```

This will use the same books as before, but select different random lines. To
fetch new books, use `./genlib.sh new` again (which will need to download the
whole catalogue again, in case you removed it).

## Configuration

Options can be set at the top of the script:

### Book Settings
- `LANGS`: the languages to select books from
- `FILESPERLANG`: how many books to pick per language
- `LINECOUNT`: how many lines to select from all the books

### CW Settings
- `WPMS`: a list of the character speeds to generate
- `EWPMS`: a list of the effective character speeds (spacing speed)
- `FREQ`: the frequency tone
- `DURATION`: the duration per MP3 file in seconds (approximately; the sentence
  will be finished)

### MP3 Settings
- `AUTHOR`: the ID3 author tag
- `ALBUM`: the ID3 album tag (the WPM and EWPM are appended, such that an album
  title `CW Book` will become e.g. `CW Book (20/12 wpm)`)
- `TITLE`: the ID3 title tag (the nr. of the file is appended, such that a
  title `CW Book` will become e.g. `CW Book - 2`)
- `FILENAME`: the filename (the nr. is appended, such that a filename `book`
  will become e.g. `book0002.mp3`)

## Acknowledgements

Converting text to CW is done using Fabian Kurz's [ebook2cw][].

## Copyright and license

This script was written by [Camil Staps][cs] PD7LOL. It is hereby released into
the public domain.

[cs]: https://camilstaps.nl
[ebook2cw]: http://fkurz.net/ham/ebook2cw.html
[gutenberg]: http://www.gutenberg.org/wiki/Main_Page
