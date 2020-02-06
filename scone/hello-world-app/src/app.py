# print to stdout
print("Hello from inside the enclave!")

# produce a result file in /scone
with open("/scone/my-result.txt", "w+") as result_file:
    result_file.write("It's dark over here!")
