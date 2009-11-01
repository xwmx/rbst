#!/usr/bin/env python

import sys
from optparse import OptionParser
from docutils.core import publish_parts

def main():
    p = OptionParser()
    
    p.add_option('--cloak_email_addresses', action="store_true", default=False)
    p.add_option('--strip_comments', action="store_true", default=False)
    p.add_option('--writer_name', default="html")
    p.add_option('--part', default="html_body")
    
    opts, args = p.parse_args()
    
    settings = {
        'file_insertion_enabled': False,
        'raw_enabled': False,
        'cloak_email_addresses': opts.cloak_email_addresses,
        'strip_comments': opts.strip_comments,
    }

    if len(args) == 1:
        try:
            content = open(args[0], 'r').read()
        except IOError:
            content = args[0]
    else:
        content = sys.stdin.read()

    parts = publish_parts(
        source=content,
        settings_overrides=settings,
        writer_name=opts.writer_name,
    )

    if opts.part in parts:
        return parts[opts.part]
    return ''

if __name__ == '__main__':
    print(main())