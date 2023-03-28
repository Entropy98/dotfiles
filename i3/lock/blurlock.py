import pyautogui
import os
from PIL import Image, ImageFilter

im0 = pyautogui.screenshot()
im1 = im0.filter(ImageFilter.GaussianBlur(15))
im1.save('/tmp/blurlock.png')
os.popen('i3lock -i /tmp/blurlock.png')
