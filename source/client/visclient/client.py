import telnetlib
import sys
import threading
import queue

class ServerConnection(threading.Thread):

    def __init__(self, server, port, *args, **kwargs):
        self.server = server
        self.port = port
        self._return_buffer = []
        self._outgoing_queue = queue.Queue()
        super().__init__(*args, **kwargs)

    def send(self, data):
        self._outgoing_queue.put(data)

    def run(self):
        print("running")
        with telnetlib.Telnet(self.server, port=self.port, timeout=2) as tn:
            try:
                tn.read_until(b"Client connected\n")
                while True:
                    while True:
                        message = tn.read_lazy()
                        if message:
                            self._return_buffer.append(message)
                            print(self._return_buffer)
                        else:
                            break
                    if self._outgoing_queue.unfinished_tasks:
                        message = self._outgoing_queue.get()
                        out_going = "{}\n".format(message).encode()
                        print(out_going)
                        tn.write(out_going)
                        self._outgoing_queue.task_done()

                    else:
                        pass
            except Exception as f:
                print("Error: {}".format(f), file=sys.stderr)
                # response = tn.read_all().decode('ascii')
                tn.write(b"shutdown\n")
                raise
def connect(server, port):
    foo = ServerConnection(server, port)
    foo.start()
    foo.send("foo")
    while True:
        response =input(">")
        foo.send(response)
        if response.strip() == "shutdown":
            foo.join()
            break

    # with telnetlib.Telnet(server, port=port, timeout=2) as tn:
    #     try:
    #         tn.read_until(b"Client connected\n")
    #         print("Connected")
    #         while True:
    #             value = "{}\n".format(input(">").strip()).encode()
    #             print("sending {}".format(value))
    #             tn.write(value)
    #             # tn.write("{}\n".format(value))
    #             print("sent")
    #             print("Reading all")
    #             message = tn.read_some()
    #             # message = tn.read_all()
    #             # print("Read everything")
    #             print("{}\n".format(message.strip().decode('ascii')))
    #     except BrokenPipeError as e:
    #         print("connection closed")
    #     except Exception as f:
    #         print("Error: {}".format(f), file=sys.stderr)
    #         response = tn.read_all().decode('ascii')
    #         tn.write(b"shutdown\n")
    #         raise
