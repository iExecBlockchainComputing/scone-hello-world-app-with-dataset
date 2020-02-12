
# open dataset file
with open("/iexec_in/hello-world.txt", "r") as dataset_file:
    data = dataset_file.read()

    # print dataset content to stdout
    print("Dataset content: " + data)

    # open result file and write dataset file content
    with open("/scone/my-result.txt", "w+") as result_file:
        result_file.write(data)


# print to stdout
print("Hello from inside the enclave!")

# write the content of the dataset to a result file
with open("/scone/my-result-file.txt", "w+") as result_file:
    result_file.write("It's dark over here!")
