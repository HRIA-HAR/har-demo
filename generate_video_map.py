#!/usr/bin/env python3

import os
import json

def generate_video_map():
    video_map = {}
    base_dir = "har_dataset_movies"
    
    for action_dir in sorted(os.listdir(base_dir)):
        action_path = os.path.join(base_dir, action_dir)
        if os.path.isdir(action_path):
            # Get all webp files in this directory
            files = []
            for file in sorted(os.listdir(action_path)):
                if file.endswith('.webp'):
                    files.append(file)
            
            if files:
                video_map[action_dir] = files
    
    return video_map

def generate_js_object(video_map):
    js_lines = ["                    const videoMap = {"]
    
    for action, files in video_map.items():
        js_lines.append(f"                        '{action}': {json.dumps(files)},")
    
    js_lines.append("                    };")
    return '\n'.join(js_lines)

if __name__ == "__main__":
    video_map = generate_video_map()
    js_object = generate_js_object(video_map)
    print(js_object)
