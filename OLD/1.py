#!/mnt/XVDF/usr/bin/python2.7

import re

r = open("mongo_help.html")

re_h = re.compile('(https://.*)[ \n]')

for l in r:
    if "https://" in l and "href" not in l:
        try:
            link0 = re_h.search(l).group(0)
            link0 = link0.strip()
            l_re = re.compile(r"" + link0)
            l2 = l_re.sub('<a href="' + link0 + '">' + link0 + '</a>', l)
            print l2
        except:
            print l,
            pass
    else:
            print l,
