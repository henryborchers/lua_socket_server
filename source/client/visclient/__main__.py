from visclient import client

def main():
    client.connect("localhost", 5555)


if __name__ == '__main__':
    main()
