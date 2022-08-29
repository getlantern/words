# Words

This go package contains embedded lists of English words, comparable to the list in `/usr/share/dict/words` on many UNIX platforms. This particular list is generated from the SCOWL project, the website for which can be found here:

http://wordlist.aspell.net

## Generating a new list

First, download a new tarball release from the above website. Then, run the generation script:

    $ gen.sh path/to/scowl.tar

