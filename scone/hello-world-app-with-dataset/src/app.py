import os
import zipfile


# def unzip_dataset():
#     dataset_filepath = "/iexec_in/" + os.environ["IEXEC_DATASET_FILENAME"]
#     print("==> dataset: " + dataset_filepath)
#     with zipfile.ZipFile(dataset_filepath, 'r') as zip:
#         zip.extractall("/iexec_in")

def read_file(filepath):
    with open(filepath, "r") as f:
        return f.read()

def write_file(path, data):
    with open(path, "w+") as f:
        f.write(data)


if __name__ == "__main__":
    input_filepath = "/iexec_in/my-first-dataset/hello-world.txt"
    result_filepath = "/scone/my-result.txt"

    # unzip_dataset()
    print("### content of /iexec_in: " + os.listdir("/iexec_in"))

    data = read_file(input_filepath)
    write_file(result_filepath, data)
