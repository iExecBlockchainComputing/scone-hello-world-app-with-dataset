
def read_file(filepath):
    with open(filepath, "r") as f:
        return f.read()

def write_file(path, data):
    with open(path, "w+") as f:
        f.write(data)

if __name__ == "__main__":
    data = read_file("/iexec_in/hello-world.txt")
    write_file("/scone/my-result.txt", data)
