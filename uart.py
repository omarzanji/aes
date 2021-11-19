import serial 

s =serial.Serial('COM4', baudrate=115200, bytesize=8, )

s.write(b'\x32')
s.write(b'\x43')
s.write(b'\xf6')
s.write(b'\xa8')
s.write(b'\x88')
s.write(b'\x5a')
s.write(b'\x30')
s.write(b'\x8d')
s.write(b'\x31')
s.write(b'\x31')
s.write(b'\x98')
s.write(b'\xa2')
s.write(b'\xe0')
s.write(b'\x37')
s.write(b'\x07')
s.write(b'\x34')

for x in range(16):
    response = s.read().hex()
    print(response)