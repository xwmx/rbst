#!/usr/bin/env python

try:
    import locale
    locale.setlocale(locale.LC_ALL, '')
except:
    pass

import sys
from transform import transform
from docutils.writers.latex2e import Writer

def main():
    return transform(writer=Writer(), part='whole')

if __name__ == '__main__':
    sys.stdout.write(main())
