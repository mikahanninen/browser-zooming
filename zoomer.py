from enum import Enum
from pynput_robocorp.keyboard import Key, Controller
from robot.libraries.BuiltIn import BuiltIn
from sys import platform


class ZoomDirection(Enum):
    up = "+"
    down = "-"


def get_operating_system_modifier_key():
    if platform == "darwin":
        return Key.cmd
    else:
        return Key.ctrl


def zooming(direction: ZoomDirection = ZoomDirection.up, zoom_count: int = 1):
    BuiltIn().log_to_console("Zooming '%s' %s times" % (direction.name, zoom_count))

    modifier_key = get_operating_system_modifier_key()
    zoom_value = zoom_count if direction == ZoomDirection.up else -1 * zoom_count
    keyboard = Controller()
    for _ in range(zoom_count):
        with keyboard.pressed(modifier_key):
            keyboard.press(direction.value)
            keyboard.release(direction.value)
    return zoom_value
