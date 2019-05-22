import hashlib, sys, io
hashes=set()
input_stream = io.TextIOWrapper(sys.stdin.buffer, encoding='utf-8')
for line in sys.stdin.buffer:
    h=hashlib.md5(line).hexdigest()
    if h not in hashes:
        hashes.add(h)
        print(line.decode(),end='')
