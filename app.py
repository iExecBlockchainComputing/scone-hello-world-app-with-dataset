
with open("/iexec_in/hello-world.txt") as fin:
    with open("/scone/iexec_out/my-result.txt", "w+") as fout:
        data = fin.read()
        print(data)
        fout.write(data)

