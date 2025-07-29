import hashlib
import os, requests, json,sys
from datetime import datetime

def main():
    ''''
        Main function to analyze files in a directory and report their details
        Will run entire C: drive if no directory is specified
    

    '''
    print('System File Analyzer')
    files = get_files( 'C:\\')
    print('Analyzing files in directory . . .\n')
    hashes = get_hash(files)
    print('Files hashed successfully. Sending to VirusTotal for analysis . . .\n')
    results = analyze_files(hashes)
    print('Analysis complete. Creating log file . . .\n')   


    #get_files(sys.argv[1] if len(sys.argv) > 1 else 'C:\\') 
    #print('Analyzing files in directory . . .\n')


    '''
        Iterate through directory get hash of each file send hash to VirusTotal API
        Get response from API and see if file is malicious or not
        If file is malicious, print details to console and log to file called 'malicious_files.log'
        Log file will contain the file path, hash, and the date/time of the scan

    '''

def get_files(directory):
    '''
        Get all files in a directory and return a list of file paths
        If no directory is specified, return all files in C: drive
    '''
    
    
    files = []
    for root, dirs, filenames in os.walk(directory):
        for filename in filenames:
            file_path = os.path.join(root, filename)
            if os.path.isfile(file_path):
                files.append(file_path)
    print(f"Found {len(files)} files in {directory}")
    return files

def get_hash(files):
    '''
        Get the hash of a file
        Args:
            files: list of file paths
        Returns:
            dict: file path and its hash
    '''
    hashes = {}
    for file in files:
        try:
            with open(file, 'rb') as f:
                #file_hash = hashlib.md5(f.read()).hexdigest()
                file_hash = hashlib.file_digest(f,"md5")
                hashes[file] = file_hash
        except Exception as e:
            print(f"Error reading file {file}: {e}")
    return hashes

def analyze_files(hashes):
    '''
        Analyze files using VirusTotal API
        Args:
            hashes: dict of file paths and their hashes
        Returns:
            dict: file path and its analysis result
    '''
    api_key = os.getenv("API_KEY")
    if not api_key:
        print("API_KEY environment variable is not set.")
        return {}

    headers = {
        "x-apikey": api_key
    }
    
    results = {}
    for file_path, file_hash in hashes.items():
        url = f"https://www.virustotal.com/api/v3/files/{file_hash}"
        response = requests.get(url, headers=headers)
        
        if response.status_code == 200:
            results[file_path] = response.json()
        else:
            print(f"Error analyzing {file_path}: {response.status_code} - {response.text}")
    
    return results

if __name__ == "__main__":
    main()