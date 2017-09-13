import tarfile
if __name__ == '__main__':
    with tarfile.open("build/lua-5.3.4.tar.gz", "r:gz") as f:
        f.extractall("build/lua")