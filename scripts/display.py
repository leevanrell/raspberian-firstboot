#!/usr/bin/env python

import RPi.GPIO as GPIO
import sys
from time import sleep

GPIO.setmode(GPIO.BCM)

toggle = sys.argv[1]

GPIO.setup(23, GPIO.OUT)
GPIO.setup(24, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

#GPIO is high when disp is off and GPIO low when off, inverting because that seems more logical
light_state = not GPIO.input(24) 

#will flip relay if told to turn on display and display is off or 
#if told to turn off the display and the display is on
if (toggle == "turnon" and light_state == GPIO.LOW) or (toggle == "turnoff" and light_state == GPIO.HIGH):
	GPIO.output(23, GPIO.HIGH)
	sleep(0.5)
	GPIO.output(23, GPIO.LOW)
	sleep(1.5) # wait for display to turn off
GPIO.cleanup()
