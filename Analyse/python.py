import matplotlib.pyplot as plt

def k_means(points, k):
    import random
    from collections import defaultdict

    centroids = random.sample(points, k)
    
    clusters = defaultdict(list)
    
    while True:
        clusters.clear()
        
        for point in points:
            closest_centroid = min(centroids, key=lambda centroid: (point[0] - centroid[0]) ** 2 + (point[1] - centroid[1]) ** 2)
            clusters[closest_centroid].append(point)
        
        new_centroids = []
        for centroid, assigned_points in clusters.items():
            if assigned_points: 
                new_centroid = (sum(x for x, y in assigned_points) / len(assigned_points),
                                sum(y for x, y in assigned_points) / len(assigned_points))
                new_centroids.append(new_centroid)
            else:
                new_centroids.append(centroid) 
        
        if new_centroids == centroids:
            break
        
        centroids = new_centroids
    
    point_to_cluster = {point: i for i, centroid in enumerate(centroids) for point in clusters[centroid]}
    
    return point_to_cluster

def combine_group(coord_dict, threshold):
    from collections import defaultdict

    combined_groups = {}
    group_extremes = {}

    for coord, group_number in coord_dict.items():
        if isinstance(group_number, list):
            group_number = group_number[0]  

        if group_number not in combined_groups:
            combined_groups[group_number] = [coord]
            group_extremes[group_number] = [coord[0], coord[0], coord[1], coord[1]] 
        else:
            combined_groups[group_number].append(coord)
            group_extremes[group_number][0] = min(group_extremes[group_number][0], coord[0]) 
            group_extremes[group_number][1] = max(group_extremes[group_number][1], coord[0])
            group_extremes[group_number][2] = min(group_extremes[group_number][2], coord[1]) 
            group_extremes[group_number][3] = max(group_extremes[group_number][3], coord[1])  

    parent_map = {}  

    def find(group):
        
        if group not in parent_map:
            return group
        parent_map[group] = find(parent_map[group])  
        return parent_map[group]

    def union(group1, group2):
        root1 = find(group1)
        root2 = find(group2)
        if root1 != root2:
            parent_map[root2] = root1  
    group_keys = list(group_extremes.keys())

    for i in range(len(group_keys)):
        for j in range(i + 1, len(group_keys)):
            g1, g2 = group_keys[i], group_keys[j]
            ext1, ext2 = group_extremes[g1], group_extremes[g2]

            if (abs(ext1[1] - ext2[0]) <= threshold and abs(ext1[0] - ext2[1]) <= threshold) and \
               (abs(ext1[3] - ext2[2]) <= threshold and abs(ext1[2] - ext2[3]) <= threshold):
                union(g1, g2)

    merged_groups = defaultdict(list)

    for group, coords in combined_groups.items():
        root = find(group)
        merged_groups[root].extend(coords)

    return len(merged_groups)  # Retourne le nombre de groupes après fusion

    

# Test case for combine_group function
test_groups = {
    (1, 2): 1,  # Group 1
    (2, 3): 1,  # Group 1
    (3, 4): 2,  # Group 2 (close to Group 1)
    (4, 5): 2,  # Group 2 (close to Group 1)
    (10, 10): 3,  # Group 3 (far from others)
    (11, 11): 3,  # Group 3 (far from others)
}

threshold = 3  

first_system = [(293.061, 567.4088), (983.3396, 502.8655), (696.2479, 260.6815), (891.8813, 556.3931), (1080.405, 199.8979), (83.42854, 126.6661), (665.5933, 229.5149), (680.0582, 297.6876), (1103.271, 204.0292), (997.733, 415.7564), (811.5782, 151.5894), (824.7712, 336.0817), (695.3533, 244.3429), (1027.998, 463.7168), (408.5079, 85.87587), (775.5316, 223.2143), (808.7097, 303.3677), (839.438, 355.6392), (292.6178, 166.1056), (1086.3, 391.57), (412.7418, 579.1378), (311.7853, 189.7912), (1094.73, 402.6056), (869.3704, 390.9096), (765.6664, 147.5292), (314.1698, 202.0878), (924.1949, 542.9967), (1063.181, 442.212), (960.8962, 438.2795), (134.8874, 487.4179), (809.9532, 307.6709), (294.847, 280.1116), (992.8422, 424.395), (405.1531, 72.36119), (261.8398, 593.3248), (1014.694, 454.7583), (708.6136, 288.8114), (1106.21, 379.9399), (779.9985, 183.6585), (935.181, 429.4768), (111.6357, 125.7848), (1022.967, 441.687), (419.7192, -103.4395), (720.5264, 240.3215), (385.9841, 181.2229), (315.8881, 145.6467), (763.1237, 261.7226), (1077.198, 192.6461), (691.0666, 272.6954), (831.0958, 333.9855), (360.4125, 457.9713), (711.262, 273.4803), (319.1727, 569.7268), (967.3261, 404.5963), (415.4776, 578.7839), (800.0028, 215.6601), (355.7708, 430.7114), (449.2556, 65.40056), (790.6077, 168.9601), (35.36368, -53.437), (396.0622, 47.36446), (423.3727, 82.8041), (1027.42, 548.4858), (284.6956, 548.4016), (655.7416, 280.2457), (1005.965, 157.6109), (1100.276, 422.5463), (315.3332, 491.8779), (1045.052, 453.3404), (477.01, 594.8911), (821.9285, 212.3877), (1088.428, 404.8625), (451.4329, 563.1199), (328.6029, 175.3812), (268.4081, 133.1023), (718.8421, 282.4825), (952.6205, 403.2849), (333.5689, 548.0718), (873.9713, 541.0994), (1039.949, 161.4421), (316.0538, 302.6834), (778.9557, 83.80274), (910.6041, 402.9547), (626.6553, 292.5647), (606.4885, 248.8935), (802.0894, 358.9317), (419.4414, 82.03244), (785.7932, 335.7347), (721.2216, 429.391), (753.1945, 195.6228), (1087.659, 233.1405), (870.3732, 398.956), (359.1543, 563.582), (73.56291, -67.77236), (1076.314, 226.5165), (463.256, 106.0736), (323.5685, 103.5117), (1007.652, 490.5986), (386.3805, -83.58135), (630.6541, 264.6831), (339.9098, 174.1343), (299.0414, 139.7366), (323.4031, 254.3246), (257.967, 164.1733), (507.2658, 88.85835), (1088.058, 259.1331), (1014.284, 406.2888), (591.3248, 173.8268), (984.8833, 554.6103), (590.2927, 217.394), (448.0973, 84.48803), (287.84, 520.8018), (377.2476, 49.47237), (227.843, 151.4944), (747.204, 73.80396), (765.5469, 113.7774), (381.0187, 586.73), (867.7913, 561.6059), (810.5678, 266.5437), (813.8691, 350.4748), (818.2246, 323.6054), (477.3515, 560.2394), (791.334, 224.0397), (714.2914, 261.2443), (357.9326, 566.5574)]
dictionnaire = k_means(first_system,3)
combined = combine_group(test_groups, threshold)
print("Combined Groups:", combined)
#print(dictionnaire)

plt.plot([18, 27, 53, 49, 59, 76, 107, 121, 146, 170, 169, 168, 159, 160, 171, 171, 183, 186, 176, 183, 182, 180, 191, 192, 184, 182, 184, 189, 183, 183, 182, 189, 186, 190, 178, 186, 187, 188, 191, 174, 180, 176, 191],color='blue',label="ALLIGNEMENT MAX(250)")
plt.plot([41, 60, 55, 35, 81, 87, 113, 95, 114, 85, 84, 129, 141, 69, 68, 104, 110, 113, 130, 70, 70, 105, 101, 120, 118, 118, 117, 128, 134, 139, 152, 133, 111, 143, 123, 125, 137, 162, 139, 137, 155, 84, 130, 109],color='green',label="ALLIGNEMENT MOY(125)")
plt.plot([59, 69, 76, 81, 104, 100, 56, 83, 108, 96, 66, 119, 108, 106, 78, 112, 105, 78, 63, 78, 126, 75, 103, 84, 74, 110, 75, 83, 85, 53, 75, 64, 68, 76, 115, 95, 113, 76, 92, 100, 57, 76, 102],color='red',label="ALLIGNEMENT MIN(10)")
plt.legend()
plt.title("Nombre d'oiseaux collés de 10 pixels")
plt.xlabel("Temps (en 5 secondes)")
plt.ylabel("Nombre d'oiseaux collés")
plt.show()
