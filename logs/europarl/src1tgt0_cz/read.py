import numpy,sys
with numpy.load(sys.argv[1]) as data:
    print(data[sys.argv[2]])

