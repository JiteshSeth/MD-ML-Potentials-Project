import MDAnalysis as mda
from scipy.spatial.distance import cdist
import numpy as np

# Load the trajectory
u = mda.Universe('waters_dens1000.lmpsys', 'water_NPT_300_10.dcd')

# Get the number of water molecules
n_waters = len(u.select_atoms('name OW'))

# Set the charges of the water atoms
u.select_atoms('name OW').charges = -0.834
u.select_atoms('name HW1').charges = 0.417
u.select_atoms('name HW2').charges = 0.417

# Calculate the center of mass of each water molecule
coms = u.select_atoms('name OW').center_of_mass()

# Calculate the pairwise distances between the water molecules
dists = cdist(coms, coms)

# Calculate the average distance between water molecules
avg_dist = np.mean(dists[np.triu_indices(n_waters, k=1)])

# Calculate the permittivity of vacuum
epsilon_0 = 8.85418782e-12  # C^2/(N m^2)

# Calculate the dielectric constant
dielectric = 1 + 4 * np.pi * np.sum(dists < avg_dist) / (3 * n_waters * avg_dist**3 * epsilon_0)

print(f"Dielectric constant: {dielectric}")

