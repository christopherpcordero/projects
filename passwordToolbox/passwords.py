#ChristopherCordero
#password tool box
#REF: https://haveibeenpwned.com/API/v3#PwnedPasswords
#MAY2025

import string, random, hashlib, requests, maskpass

MIN_PW_LEN = 8


def password_Generator():
    '''
        Password Generator IAW NIST SP 800-63B guidelines
    '''
    print("\n")
    print("-"*25)
    print("PASSWORD GENERATOR\n")

    
    while True:
        length = int(input("Enter desired length: "))
        if length >= MIN_PW_LEN:
            print("Password:")
            print(''.join(random.choices(string.ascii_letters + string.digits + string.punctuation, k=length)))
            break
        else:
            print("Too Short\n")
        
def check_password_strength():
    '''
        Password Strength Check IAW NIST SP 800-63B guidelines
        
        entropy calculation
        minimun 8 
    '''
    print("\n")
    print("-"*25)
    print("PASSWORD CHECKER\n")
    print("This will check how strong your password is in accordance with NIST\n")
    
    
    while True:
        
        pw = maskpass.askpass(prompt="Enter Password: \n",mask="*")
        suggestions = []
        
        if len(pw) < MIN_PW_LEN:
            suggestions.append(f"- Password is too short")
        
        hasLower = any(c.islower() for c in pw)
        hasUpper = any(c.isupper() for c in pw)
        hasDigit = any(c.isdigit() for c in pw)
        hasSpecial = any(c in string.punctuation for c in pw)
        
        if not hasLower:
            suggestions.append(f"- Password must include a lower case character")
        if not hasUpper:
            suggestions.append(f"- Password must include an upper case character")
        if not hasDigit:
            suggestions.append(f"- Password must include a digit")
        if not hasSpecial:
            suggestions.append(f"- Password must include a special character")
        
        if not suggestions:
            print("Your password is COMPLIANT\n")
            break
        else:
            print("Your password is NOT COMPLIANT\n")
            for s in suggestions:
                print(s)
            print("\n")
         
        

def check_password_leak():
    '''
        Password leak check via HAVEIBEENPWNED API
        
        
    '''
    print("\n")
    print("-"*25)
    print("PASSWORD PWN CHECKER\n\n")
    print("This will check if your password has been compromised\n via haveibeenpwned\n")
    
    pw = maskpass.askpass(prompt="Enter Password: \n",mask="*")
    
    h = hashlib.new('sha1')
    encode_pw = pw.encode()
    h.update(encode_pw)
    hash_pw = h.hexdigest()
    
    url =   "https://api.pwnedpasswords.com/range/"
    substring = hash_pw[:5]
    full_url = url + substring
    
    
    response = requests.get(full_url)
    returned_hashes = response.text.splitlines()
    suff_returned_hashes = hash_pw[5:].upper()
    
    found = any(suff_returned_hashes in line for line in returned_hashes)
    if found:
        print("PWNED!!! Be advised you the password generator\n")
    else:
        print("Congrats your password has not been pwned\n")
       
        

def main():
    
   '''
        Main function setting up the program to give user the choice on which tool to user
        
   '''
   while True:
        print("-"*35)
        print("PASSWORD TOOLBOX")
        print("\nPick an option:")
        print("1. Password Generator")
        print("2. Password Strength Check")
        print("3. Password Leak Check")
        print("-"*35)
        
        
        choice = input("Enter your choice:")
        
        if choice == "1":
            password_Generator()
        elif choice == "2":
            check_password_strength()
        elif choice == "3":
            check_password_leak()
        else:
            break   
            
            
if __name__ == "__main__":
    main()
    
    