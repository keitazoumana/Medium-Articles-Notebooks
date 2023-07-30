from reloading import reloading
from time import sleep

@reloading
def compute_square_root(n):

    squared_value = n**2
    print(f"Square value: {squared_value}  for n: {n}")
    return squared_value


if __name__ == "__main__":

    for n in range(20):
        squared_value = compute_square_root(n)
        sleep(1)
