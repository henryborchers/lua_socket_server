import telnetlib

import sys


def connect(server, port):
    print("Connecting")
    tn = telnetlib.Telnet(server, port=port)
    try:
        tn.read_until(b"Client connected\n")
        while True:
            value = input(">")
            print("sending {}".format(value))
            tn.write("{}\n".format(value).encode())
            print("{}".format(tn.read_all().decode('ascii')))
    except BrokenPipeError as e:
        print("connection closed")
    except Exception as f:
        print("Error: {}".format(f), file=sys.stderr)
        response = tn.read_all().decode('ascii')
        tn.write(b"shutdown\n")
        raise