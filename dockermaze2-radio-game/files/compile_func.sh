#!/bin/bash
gcc -m32 create_mac_func.c -masm=intel -fno-stack-protector -O0 -S
