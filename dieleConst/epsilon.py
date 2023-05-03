import numpy as np 
epsilon_arr = []
d1 = np.loadtxt('./dipole.dat')
xdip = d1[:,1]
ydip = d1[:,2]
zdip = d1[:,3]
tdip = d1[:,4]



#<M>^2
#xdip_avgsq = np.square(np.mean(xdip))
#ydip_avgsq = np.square(np.mean(ydip))
#zdip_avgsq = np.square(np.mean(zdip))
#tdip_avgsq = np.square(np.mean(tdip))

#<M^2>
xdip_sqavg = np.mean(np.square(xdip))
ydip_sqavg = np.mean(np.square(ydip))
zdip_sqavg = np.mean(np.square(zdip))
tdip_sqavg = np.mean(np.square(tdip))

#num_x = xdip_sqavg-xdip_avgsq
#num_y = ydip_sqavg-ydip_avgsq
#num_z = zdip_sqavg-zdip_avgsq
#num_t = tdip_sqavg-tdip_avgsq

num_x = xdip_sqavg
num_y = ydip_sqavg
num_z = zdip_sqavg
num_t = tdip_sqavg


#rhs_x = (4*np.pi*num_x*3.33564e-30*3.33564e-30)/(3*(8.854187e-12)*(33224.781e-30)*(1.38064e-23)*300)
#rhs_y = (4*np.pi*num_y*3.33564e-30*3.33564e-30)/(3*(8.854187e-12)*(33224.781e-30)*(1.38064e-23)*300)
#rhs_z = (4*np.pi*num_z*3.33564e-30*3.33564e-30)/(3*(8.854187e-12)*(33224.781e-30)*(1.38064e-23)*300)
#rhs_t = (4*np.pi*num_t*3.33564e-30*3.33564e-30)/(3*(8.854187e-12)*(33224.781e-30)*(1.38064e-23)*300)

rhs_x = 1+((4*np.pi*num_x*pow(10,-36))/(3*(40077.044e-24)*(1.38064e-16)*300))
rhs_y = 1+((4*np.pi*num_y*pow(10,-36))/(3*(40077.044e-24)*(1.38064e-16)*300))
rhs_z = 1+((4*np.pi*num_z*pow(10,-36))/(3*(40077.044e-24)*(1.38064e-16)*300))
rhs_t = 1+((4*np.pi*num_t*pow(10,-36))/(3*(40077.044e-24)*(1.38064e-16)*300))


#rhs_x = (num_x*3.33564e-30*3.33564e-30)/(3*(8.854187e-12)*(33224.781e-30)*(1.38064e-23)*300)
#rhs_y = (num_y*3.33564e-30*3.33564e-30)/(3*(8.854187e-12)*(33224.781e-30)*(1.38064e-23)*300)
#rhs_z = (num_z*3.33564e-30*3.33564e-30)/(3*(8.854187e-12)*(33224.781e-30)*(1.38064e-23)*300)
#rhs_t = (num_t*3.33564e-30*3.33564e-30)/(3*(8.854187e-12)*(33224.781e-30)*(1.38064e-23)*300)

#rhs_arr.append(rhs_x)
#rhs_arr.append(rhs_y)
#rhs_arr.append(rhs_z)
#rhs_arr.append(rhs_t)

#epsilon_x = ((rhs_x*160)+161)/(161-rhs_x)
#epsilon_y = ((rhs_y*160)+161)/(161-rhs_y)
#epsilon_z = ((rhs_z*160)+161)/(161-rhs_z)
#epsilon_t = ((rhs_t*160)+161)/(161-rhs_t)

epsilon_x = rhs_x
epsilon_y = rhs_y
epsilon_z = rhs_z
epsilon_t = rhs_t


epsilon_arr.append(epsilon_x)
epsilon_arr.append(epsilon_y)
epsilon_arr.append(epsilon_z)
epsilon_arr.append(epsilon_t)

epsilon = np.transpose(epsilon_arr)
np.savetxt('epsilon.dat', epsilon)
#rhs = np.transpose(rhs_arr)
#np.savetxt('rhs.dat', rhs)
