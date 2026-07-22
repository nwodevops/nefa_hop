#!/usr/bin/env python3
"""Test: ¿Python corre en esta máquina?"""
import platform
import sys

print("OK: Python ejecuta")
print(f"version : {sys.version}")
print(f"exe     : {sys.executable}")
print(f"platform: {platform.platform()}")
print(f"cwd     : {__file__ if '__file__' in dir() else '.'}")

# smoke checks
assert 1 + 1 == 2
print("assert  : pass")
print("RESULT  : SUCCESS")
