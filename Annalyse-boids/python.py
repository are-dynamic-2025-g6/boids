import matplotlib.pyplot as plt
plt.plot([18, 27, 53, 49, 59, 76, 107, 121, 146, 170, 169, 168, 159, 160, 171, 171, 183, 186, 176, 183, 182, 180, 191, 192, 184, 182, 184, 189, 183, 183, 182, 189, 186, 190, 178, 186, 187, 188, 191, 174, 180, 176, 191],color='blue',label="ALLIGNEMENT MAX(250)")
plt.plot([41, 60, 55, 35, 81, 87, 113, 95, 114, 85, 84, 129, 141, 69, 68, 104, 110, 113, 130, 70, 70, 105, 101, 120, 118, 118, 117, 128, 134, 139, 152, 133, 111, 143, 123, 125, 137, 162, 139, 137, 155, 84, 130, 109],color='green',label="ALLIGNEMENT MOY(125)")
plt.plot([59, 69, 76, 81, 104, 100, 56, 83, 108, 96, 66, 119, 108, 106, 78, 112, 105, 78, 63, 78, 126, 75, 103, 84, 74, 110, 75, 83, 85, 53, 75, 64, 68, 76, 115, 95, 113, 76, 92, 100, 57, 76, 102],color='red',label="ALLIGNEMENT MIN(10)")
plt.legend()
plt.title("Nombre d'oiseaux collés de 10 pixels")
plt.xlabel("Temps (en 5 secondes)")
plt.ylabel("Nombre d'oiseaux collés")
plt.show()
