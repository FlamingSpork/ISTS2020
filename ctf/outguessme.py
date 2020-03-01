from mt19937predictor import MTP
import socket

#pip install mersenne-twister-predictor
#nc 129.21.228.181 8006

def main():
	predictor = MTP()
	
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	s.connect(("129.21.228.181", 8006))
	
	for i in range(624):
		for j in range(4):
			s.sendall(b'2147483647') #half of the max
			result = repr(s.recv(1024))
			if "Good" in result:
				#worth a shot
				print(result)
				return
		#print("Nice try. The number was " + str(secretNumber))
		data = repr(s.recv(1024))
		num = int(data.split(" ")[-1])
		print("Acquired random number #",i,":",num)
		predictor.setrandombits(x, 32)
	print("***Your next line is:", predictor.getrandbits(32) )

main()
