#! /bin/sh

set -e
for file in *.po
do
  ./conv.py ../n900-locales-extras-20101005/po/en_US/LC_MESSAGES/$file $file `basename $file .po`.mangled-po
done
