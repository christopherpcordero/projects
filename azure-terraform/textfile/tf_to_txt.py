import os
import sys

def main():
    #this script is intended change the .tf files to a .txt file
    #it takes the tf file path as an argument then places the .txt file in the same directory
    if len(sys.argv) != 2:
        print("Usage: python convert_tf_to_txt.py <path_to_tf_file>")
        sys.exit(1)
    tf_file_path = sys.argv[1]
    with open(tf_file_path, 'r') as tf_file:
        tf_content = tf_file.read()
    txt_file_path = os.path.splitext(tf_file_path)[0] + '.txt'
    with open(txt_file_path, 'w') as txt_file:
        txt_file.write(tf_content)

main()
    