import datetime


def time_now() -> None:
    """Prints the current date & time."""
    print(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
