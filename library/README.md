# library.swf sources

Build with docker image jeko/airbuild:15.0

Build command
```sh
compc -compiler.as3 -source-path+=. -swf-version=15 -debug -optimize=false -compress=false -include-sources ClientBuff.as -include-sources Enums/ -include-sources Communication/ -output Main.swf -frames.frame Main 0
```
After build extract library.swf
```sh
unzip -o Main.swf library.swf
```