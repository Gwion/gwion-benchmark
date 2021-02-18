#!/bin/bash

cat << EOF
gwion: latest
wren: $(wren --version)
lua: $(lua -v | cut -d" " -f2)
python: $(python --version [ cut -d" " -f2)
chuck: $(chuck --version 2>&1 | head -2 | tail -1 | cut -d " " -f 3-5)
ruby: $(ruby -v | cut -d" " -f2)
horse64: $(horse64 --short-version)
EOF
