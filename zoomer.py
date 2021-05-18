from enum import Enum
from pynput_robocorp.keyboard import Key, Controller
from robot.libraries.BuiltIn import BuiltIn


class ZoomDirection(Enum):
    up = "+"
    down = "-"


def zooming(direction: ZoomDirection = ZoomDirection.up, zoom_count: int = 1):
    BuiltIn().log_to_console("Zooming '%s' %s times" % (direction.name, zoom_count))

    zoom_value = zoom_count if direction == ZoomDirection.up else -1 * zoom_count
    keyboard = Controller()
    for _ in range(zoom_count):
        with keyboard.pressed(Key.ctrl):
            keyboard.press(direction.value)
            keyboard.release(direction.value)
    return zoom_value
