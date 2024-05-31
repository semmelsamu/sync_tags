# sync_tags

> Python script that synchronises tags between similar audio files in different
> folders.

## Why?

I use this script for my DJ library backup. I only export MP3 files to my USB
stick to ensure compatibility even for old CDJs, but i still store the original
lossless files on my hard drive. If i update the tags, e.g. the genre, i don't
want to manually change it again on the lossless file. Enter this script.

## Features

Copies tags "title", "artist", "genre", and the first cover art from audio files
in one folder to audio files with the same name in another folder.

## Support

Currently supported are

- **Source:** MP3
- **Destination:** FLAC

## Requirements

This script uses [mutagen](https://mutagen.readthedocs.io/en/latest/).

```bash
pip install mutagen
```

## Usage

```bash
python sync_tags.py
```
