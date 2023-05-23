import json
import UnityPy
from urllib import request
import sys
import struct
import os

url = sys.argv[1]
print("load " + url)
contents = request.urlopen(url).read()
env = UnityPy.load(contents)
for obj in env.objects:
  if obj.type.name == "TextAsset":
    data = obj.read()
    print(data.name)
    if data.name == "filehashing.mapping":
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
