import sys

from visclient import client

def main():
    try:
        client.connect("localhost", 5555)
    except ConnectionRefusedError:
        print("Unable to connect", file=sys.stderr)

if __name__ == '__main__':
    main()
