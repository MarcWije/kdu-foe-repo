// EN4333 Microwave Engineering
// EN3312 Antennas and Propagation
// Arbitrary dipole radiation pattern plot
// 
// Upeka Premaratne, ENTC, University of Moratuwa (upeka@uom.lk) 2020/11/20
// Free to use, distribute and modify for educational purposes with attribution


function E = dipole_rad_pattern(L,k,theta)
    // Function to plot dipole radiation pattern for a given length and k
    E = (cos(k*L*cos(theta))-cos(k*L)*ones(1,length(theta)))./sin(theta);
endfunction

lambda = 1; // Wavelength of input signal
k = 2*%pi/lambda;

theta = 2*%pi*(0.001:0.001:0.999);

n = 0.50; // Number of wavelengths
L = n*lambda; // Length of dipole

E = dipole_rad_pattern(L,k,theta); // Radiation pattern plot

figure(1);
clf();
polarplot(theta,abs(E));

