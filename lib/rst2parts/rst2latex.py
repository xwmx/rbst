#!/usr/bin/env python

try:
    import locale

    locale.setlocale(locale.LC_ALL, "")
except:
    pass

import codecs
import sys
from transform import transform
from docutils.writers.latex2e import Writer


def main():
    return transform(writer=Writer(), part="whole")


if __name__ == "__main__":
    # Python 2 wants an encoded string for unicode, while Python 3 views an
    # encoded string as bytes and asks for a string. Solution via:
    # http://stackoverflow.com/a/24104423
    if sys.version_info[0] < 3:
        UTF8Writer = codecs.getwriter("utf8")
        sys.stdout = UTF8Writer(sys.stdout)
    sys.stdout.write(main())
