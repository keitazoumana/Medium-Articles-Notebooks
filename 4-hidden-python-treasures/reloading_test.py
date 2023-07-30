from reloading import reloading
from time import sleep

for i in reloading(range(20)):
    print("Loop iteration:", i)
    sleep(1)
