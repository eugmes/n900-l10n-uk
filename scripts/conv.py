#! /usr/bin/python
from __future__ import print_function
import sys
import polib

def main(templ, trans, outf):
    print('Converting %s, %s' % (templ, trans), file=sys.stderr)
    templ_po = polib.pofile(templ)
    trans_po = polib.pofile(trans)

    for entry in trans_po:
        msgid = entry.msgid
        msgid_plural = entry.msgid_plural
        msgstr = entry.msgstr
        orig = templ_po.find(msgid).msgstr
        orig_plural = templ_po.find(msgid).msgstr_plural

        if msgid_plural:
            newid = msgid + '|' + msgid_plural
            entry.msgctxt = newid
            entry.msgid = orig_plural['0']
            entry.msgid_plural = orig_plural['1']
            if entry.msgstr_plural == orig_plural:
                entry.msgstr_plural = dict()
                entry.msgstr_plural[0] = ''
                entry.msgstr_plural[1] = ''
        else:
            entry.msgctxt = msgid
            entry.msgid = orig
            if msgstr == orig:
                entry.msgstr = ''

    trans_po.save(outf)

if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2], sys.argv[3])
