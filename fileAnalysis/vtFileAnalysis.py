#ChristopherCordero
#file analysis using VT api 
#REF: https://docs.virustotal.com/reference/file-info
#JUN2025
import requests,os, hashlib
from datetime import datetime,timezone


def get_fileHash(filePath):
    '''
        Get MD5 hash from file
        
        
        Args:
            filePath is the location and file that needs to be hashed 
        Returns:
            str - the hex of md5
    '''
    if not os.path.exists(filePath):
        print(f"ERROR: File: {filePath} does not exist")
        return None
    
    try:
        with open(filePath,"rb") as f:
            md5 = hashlib.file_digest(f,"md5")
        return md5.hexdigest()
    except PermissionError:
        print("ERROR: Access Denied")
        return None
    except Exception as e:
        print(f"Unexpected Error while hashing")
        return None

    
def create_log(response):
    '''
        Create log of response from VT
    '''
    if not response:
        print("Warning no response given by VT\n")
        return
    timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    logName = f"Analysis{timestamp}"
    logpath = fr"C:\Temp\FileAnalysisLogs\{logName}.txt"
    with open(logpath,"w") as f:
        f.write(response.text)
        
def analyze_file(md5Hash):
    '''
    Send hash to VT via API, get response back 
    Uses env variable of API KEY 
    
    Arg:
        takes md5 hash to send request to VT
        
    Returns:
        json response
    '''
    apiKey = os.getenv("API_KEY")
    if apiKey is None:
        raise ValueError("API_KEY is not set\n")
    url = "https://www.virustotal.com/api/v3/files/" + md5Hash
    headers = {
        "accept":"application/json",
        "x-apikey": apiKey
    }
    
    response = requests.get(url,headers=headers)
    
    data = response.json()
    mal_Value = data.get("last_analysis_stats",{}).get("malicious",0)
    print(f"File was detected Malicious by {mal_Value} vendors")
    return requests.get(url,headers=headers)

    
def main():
    '''
    Main function to run the analysis tool
    '''
    
    print("- "*3+ "File Analysis Tool" + " -"*3)
    
    filePath = input("Enter File path: \n")
    
    md5 = get_fileHash(filePath)
    if md5 is None:
        print("Failed to get hash of file\n")
        return
    print(f"MD5 Hash of {filePath} is {md5}")
    print("Sending to VirtualTotal for analysis .  . . \n")
    
    response = analyze_file(md5)
    if response is None:
        print("Failed to get analysis response")
        return
    print("VirtualTotal analysis complete. Creating log file . . .\n")
    create_log(response)
    print("Log created")
    
    
    print("- "*3 + "Analysis Complete" + " -"*3)

 
 
if __name__ == "__main__":
    main()

