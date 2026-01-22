import json
import UnityPy
from urllib import request
import sys
import struct
import os
import re

url = sys.argv[1]
version = ""
print("load " + url)
req = request.Request(url)
req.add_header('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:143.0) Gecko/20100101 Firefox/143.0')
contents = request.urlopen(req).read()
for match in re.finditer(b'[^\\x00-\\x1F\\x7F]{32,}', contents):
  try:
    decoded_string = match.group().decode('utf-8')
    if "UPDATING_HARD_CURRENCY_PRICE" in decoded_string and len(decoded_string) < 100:
      version = decoded_string[30:]
      break
  except UnicodeDecodeError:
    pass
print("Version " + version)
open("version.txt", "wb").write(version.encode())
env = UnityPy.load(contents)
for obj in env.objects:
  if obj.type.name == "TextAsset":
    data = obj.read()
    if data.name == "filehashing.mapping":
      print("Writing " + data.name)
      open("mapping.data", "wb").write(bytes(data.script))
      buf = UnityPy.streams.EndianBinaryReader(bytes(data.script) + struct.pack('B', 0), endian="<")
      t = buf.read_byte()
      data = {}
      while buf.Position < buf.Length:
        buf.read_byte()
        normal = buf.read_string_to_null()
        buf.read_byte()
        hashed = buf.read_string_to_null()
        data[normal] = hashed
      with open("mapping.json", "w") as out:
        json.dump(data, out)