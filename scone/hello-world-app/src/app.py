# print to stdout
print("Hello from inside the enclave!")

# produce a result file
with open("/scone/my-result-file.txt", "w+") as result_file:
    result_file.write("It's dark over here!")
