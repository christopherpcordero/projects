import socket

target = input("Enter target ")
ports = [21,22,80,443]

for port in ports:
    try:
        sock = socket.socket()
        sock.settimeout(1)
        sock.connect((target,port))
        print(f" - Port {port} is open")
    except:
        pass
    finally:
        sock.close()
        