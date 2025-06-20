# Password Toolbox

### Author: Christopher Cordero  
### Date: May 2025  
### Reference: [Pwned Passwords API](https://haveibeenpwned.com/API/v3#PwnedPasswords)

## Overview

The Password Toolbox is a command-line utility designed to support secure password creation and evaluation in accordance with [NIST SP 800-63B](https://pages.nist.gov/800-63-3/sp800-63b.html) digital identity guidelines. It provides three core tools:

1. **Password Generator**  
2. **Password Strength Checker**  
3. **Password Leak Checker** via [Have I Been Pwned](https://haveibeenpwned.com/)

The toolbox is ideal for personal use, security training environments, or integration into internal security awareness programs.

---

## Features

### 🔐 Password Generator
- Creates strong, randomized passwords of user-defined length (minimum 8 characters).
- Includes upper/lowercase letters, digits, and special characters.

### 📊 Password Strength Checker
- Evaluates passwords using composition rules based on NIST SP 800-63B.
- Provides actionable suggestions for improvement.

### 🛡️ Password Leak Checker
- Uses the [Have I Been Pwned](https://haveibeenpwned.com/API/v3#PwnedPasswords) API to verify whether a password has appeared in known breaches.
- SHA-1 hashes are checked using the privacy-preserving k-Anonymity model.

---

## Dependencies

Ensure the following Python packages are installed:

```bash
pip install requests maskpass