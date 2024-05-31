import os
from mutagen.mp3 import MP3
from mutagen.flac import FLAC, Picture
from mutagen.id3 import ID3, TIT2, TPE1, TCON, APIC

def get_files(folder, extensions):
    return [f for f in os.listdir(folder) if f.lower().endswith(extensions)]

def copy_tags(source, destination):
    # Load the MP3 file
    mp3 = MP3(source, ID3=ID3)

    # Load the FLAC file
    flac = FLAC(destination)

    # Copy the title tag
    if 'TIT2' in mp3:
        flac['title'] = mp3['TIT2'].text[0]

    # Copy the artist tag
    if 'TPE1' in mp3:
        flac['artist'] = mp3['TPE1'].text[0]

    # Copy the genre tag
    if 'TCON' in mp3:
        flac['genre'] = mp3['TCON'].text[0]

    # Copy the cover art
    if 'APIC:' in mp3:
        apic = mp3['APIC:']
        picture = Picture()
        picture.data = apic.data
        picture.type = 3  # Cover (front)
        picture.mime = apic.mime
        flac.clear_pictures()  # Clear existing pictures
        flac.add_picture(picture)

    # Save the FLAC file with the new tags
    flac.save()

def main():
    source_folder = input("Enter the source folder path: ")
    destination_folder = input("Enter the destination folder path: ")

    source_folder = os.path.abspath(source_folder)
    destination_folder = os.path.abspath(destination_folder)

    source_files = get_files(source_folder, ".mp3")
    destination_files = get_files(destination_folder, ".flac")

    for src_file in source_files:
        src_filename = os.path.splitext(src_file)[0]
        for dest_file in destination_files:
            dest_filename = os.path.splitext(dest_file)[0]
            if src_filename == dest_filename:
                src_path = os.path.join(source_folder, src_file)
                dest_path = os.path.join(destination_folder, dest_file)
                try:
                    copy_tags(src_path, dest_path)
                    print(f"Copied tags from {src_file} to {dest_file}")
                except:
                    print(f"Failed to copy tags from {src_file} to {dest_file}")

if __name__ == "__main__":
    main()
