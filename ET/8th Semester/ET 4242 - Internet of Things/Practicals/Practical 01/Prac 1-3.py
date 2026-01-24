# Code for Practice Problem 3

import RPi.GPIO as gpio
import time
from tkinter import *

gpio.setwarnings(False)
gpio.setmode(gpio.BCM)
gpio.setup(18,gpio.OUT)
gpio.setup(14,gpio.OUT)
gpio.setup(15,gpio.OUT)
gpio.output(18,False)
gpio.output(14,False)
gpio.output(15,False)

root = Tk()
root.title('Check Button')

check1_var = BooleanVar()
check2_var = BooleanVar()
check3_var = BooleanVar()

def Update1():
	print('Command')
	if check1_var.get():
		gpio.output(18,True)
	else:
		gpio.output(18,False)
	
def Update2():
	print('Command')
	if check2_var.get():
		gpio.output(14,True)
	else:
		gpio.output(14,False)
	
def Update3():
	print('Command')
	if check3_var.get():
		gpio.output(15,True)
	else:
		gpio.output(15,False)
	
	
check1 = Checkbutton(root, text = 'D1', command = Update1, \
					 variable = check1_var, onvalue = True, offvalue = False)
check1.pack()
check2 = Checkbutton(root, text = 'D2', command = Update2, \
					 variable = check2_var, onvalue = True, offvalue = False)
check2.pack()
check3 = Checkbutton(root, text = 'D3', command = Update3, \
					 variable = check3_var, onvalue = True, offvalue = False)
check3.pack()

root.mainloop()

while True:
	
	time.sleep(3)

