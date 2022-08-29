#!/bin/sh

if [ -z "$1" ]; then
    echo "usage: $0 FILE\n"
    echo "Generates the go source for this package from a SCOWL tarball release. New"
    echo "releases can be downloaded here: http://wordlist.aspell.net"
    exit 1
fi

TMP=$(mktemp -d)
echo "Extracting to $TMP"
tar --strip-components=1 -zxf "$1" -C "$TMP"

for PACKAGE in english american british britishz canadian australian; do
    echo "Writing $PACKAGE/$PACKAGE.go"
    rm -rf "$PACKAGE"
    mkdir -p "$PACKAGE"
    cat << EOF > "$PACKAGE/$PACKAGE.go"
package $PACKAGE

var Words []string = []string{
EOF

    find "$TMP/final" | grep -E '(english|$PACKAGE)-words' | xargs sort -m | awk '{print "`"$1"`," }' >> $PACKAGE/$PACKAGE.go
    echo "\n}\n" >> $PACKAGE/$PACKAGE.go
done

gofmt -w .
