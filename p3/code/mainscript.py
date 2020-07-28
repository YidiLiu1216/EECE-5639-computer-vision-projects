import cv2
import numpy as np
import matplotlib.pyplot as plt
leftimage = cv2.imread("cast-left.jpg")
hsv = cv2.cvtColor(leftimage, cv2.COLOR_BGR2HSV)
m,n,k=leftimage.shape
r,g,b = cv2.split(leftimage)
r, g, b = r/255.0, g/255.0, b/255.0
H = np.zeros((m,n),np.float32)
S = np.zeros((m,n), np.float32)
V = np.zeros((m,n), np.float32)
HSV=np.zeros((m,n,3), np.float32)
for i in range(0, m):
        for j in range(0, n):
            mx = max((b[i, j], g[i, j], r[i, j]))
            mn = min((b[i, j], g[i, j], r[i, j]))
            V[i, j] = mx
            if V[i, j] == 0:
                S[i, j] = 0
            else:
                S[i, j] = (V[i, j] - mn) / V[i, j]
            if mx == mn:
                H[i, j] = 0
            elif V[i, j] == r[i, j]:
                if g[i, j] >= b[i, j]:
                    H[i, j] = (60 * ((g[i, j]) - b[i, j]) / (V[i, j] - mn))
                else:
                    H[i, j] = (60 * ((g[i, j]) - b[i, j]) / (V[i, j] - mn))+360
            elif V[i, j] == g[i, j]:
                H[i, j] = 60 * ((b[i, j]) - r[i, j]) / (V[i, j] - mn) + 120
            elif V[i, j] == b[i, j]:
                H[i, j] = 60 * ((r[i, j]) - g[i, j]) / (V[i, j] - mn) + 240
            H[i,j] = H[i,j] / 2

HSV[:,:,0]=H[:,:]
HSV[:,:,1]=S[:,:]
HSV[:,:,2]=V[:,:]
new_rgb=cv2.cvtColor(hsv, cv2.COLOR_HSV2BGR)
plt.ion()
plt.imshow(new_rgb)
plt.ioff()
plt.show()
