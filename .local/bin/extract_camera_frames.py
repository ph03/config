#!/usr/bin/env python3

import argparse

# <session> <output-folder>
# outputs <output-folder>/extrinsics/<video-name>.png for each <video-name>.mp4 in <session>

import os
import fnmatch
import subprocess

def find(pattern, path):
    result = []
    for root, dirs, files in os.walk(path):
        for name in files:
            if fnmatch.fnmatch(name, pattern):
                result.append(os.path.join(root, name))
    return result

def extractFrame(video, output):
    cmd = ['ffmpeg', '-i', 'file:{}'.format(video), '-vframes', '1', output]
    print(cmd)
    subprocess.call(cmd)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('session', type=str)
    parser.add_argument('output', type=str)
  
    args = parser.parse_args()

    print(args)

    files = [f for f in find('*.mp4', args.session) if 'transformation' not in f]

    print(files)

    output_dir = os.path.join(args.output, 'extrinsics')

    os.makedirs(output_dir, exist_ok=True)

    for f in files:
        image_name = os.path.join(output_dir, os.path.splitext(os.path.basename(f))[0]) + '.png'

        print('{} -> {}'.format(f, image_name))
        extractFrame(f, image_name)
  
if __name__ == "__main__":
    main()
