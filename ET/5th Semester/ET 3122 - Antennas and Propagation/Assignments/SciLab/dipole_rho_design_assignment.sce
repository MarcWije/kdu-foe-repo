// EN4333 Microwave Engineering
// ET3122 Antennas and Propagation - Assignment Hint
// Dipole antenna design for using Carter's formula
// --- Design of a cylindircal dipole antenna for a given rho and tube radius (as available in the open market) 
// 
// Upeka Premaratne, ENTC, University of Moratuwa (upeka@uom.lk) 2024/05/24
// Free to use, distribute and modify for educational purposes with attribution

function y=sine_integral_l(x)
    // Calculation of the sine integral Si(x)=\int_{0}^{x}\frac{sin(x)}{x}dx using the series by Havil 2003
    k=100; // Large k chosen to for better approximation of large x (k could have been small had x been small)
    [m,n]=size(x);
    si_sum = zeros(m,n);
    for i=1:k
        si_sum = si_sum+(-1)^(i-1)*x.^(2*i-1)/((2*i-1)*factorial(2*i-1));
    end
    y = si_sum;
endfunction

function y=sine_integral_u(x)
    // Calcultion of the sine integral si(x)=-\int_{x}^{\infty}\frac{sin(x)}{x}dx
    y = %pi/2-sine_integral_l(x);
endfunction

function y=cosine_integral(x)
    // Calculation of the cosine integral Si(x)=\int_{0}^{x}\frac{sin(x)}{x}dx using the series by Havil 2003
    em_constant = 0.5772156649; //Euler-Mascheroni constant
    k=100; // Large k chosen to for better approximation of large x (k could have been small had x been small)
    [m,n]=size(x);
    ci_sum = zeros(m,n);
    for i=1:k
        ci_sum = ci_sum+(-x.^2).^i/((2*i)*factorial(2*i));
    end
    y = em_constant*ones(m,n)+log(x)+ci_sum;
endfunction

function y=antenna_rm(l,k)
    // Resistive component of the dipole antenna
    em_constant = 0.5772156649;
    eta_0 = 120*%pi;
    [m,n]=size(l);
    x = k*l;
    y = eta_0/(2*%pi)*(em_constant*ones(m,n)+log(x)-cosine_integral(x)+0.5*sin(x).*(sine_integral_l(2*x)-2*sine_integral_l(x))+0.5*cos(x).*(em_constant*ones(m,n)+log(x/2)+cosine_integral(2*x)-2*cosine_integral(x)));
endfunction

function y=antenna_rin(l,k,y_t)
    [m,n]=size(l);
    x = k*l;
    y = min(antenna_rm(l,k)./(sin(x/2).^2),y_t*ones(m,n));
endfunction

function y=antenna_xm(l,k,a)
    // Reactive componant of the dipole antenna
    em_constant = 0.5772156649;
    eta_0 = 120*%pi;
    [m,n]=size(l);
    x = k*l;
    y = eta_0/(4*%pi)*(2*sine_integral_l(x)+cos(x).*(2*sine_integral_l(x)-sine_integral_l(2*x))-sin(x).*(2*cosine_integral(x)-cosine_integral(2*x)-cosine_integral(2*k*a^2*ones(m,n)./l)));
endfunction

function y=antenna_xin(l,k,a,y_t)
    [m,n]=size(l);
    x = k*l;
    y = max(min(antenna_xm(l,k,a)./(sin(x/2).^2),y_t*ones(m,n)),-y_t*ones(m,n));
endfunction

function z_in=antenna_zin(l,k,a)
    x = k*l;
    z_in = (antenna_rm(l,k)+%i*antenna_xm(l,k,a))./(sin(x/2).^2);
endfunction

function rho_p=z_rho(z_in,z0)
    rho = (z_in-z0)./(z_in+z0);
    rho_p = abs(rho);
endfunction

function print_bw(l,rho_p,rho_t)
k_p = find(rho_p<rho_t);
c = 3*10^8;
l_min = l(min(k_p));
l_max = l(max(k_p));

disp([l_min l_max]);
disp(0.5*[c/l_max c/l_min]);
endfunction

//em_constant = 0.5772156649;
c = 3*10^8;
z0 = 50; // Characteristic impedance of the transmission line

vswr_t = 2; // Target VSWR in dB

rho_t = (10^(vswr_t/10)-1)/(10^(vswr_t/10)+1); // Target rho

// In this problem, the radius of the cylindrical dipole is a constant 
a = 0.003;
f0 = 1.15*10^9; // Frequency of operation

lambda =c/f0; // Calculate the design wavelength

p = a/lambda; // p is the ratio between the radius of the tube and the wavelength (in previous problems, the radius of the cylindrical dipole was given in terms of the wavelength e.g. a=10^\lambda)

l = 0.1:0.001:0.2; // section length (instead of total length of the antenna)
k = 2*%pi/lambda; // calculate k based upon the design wavelength

z0 = z0*ones(1,length(l));
z_in=antenna_zin(l,k,a); // apply Carter's formula where l is an absolute value, k depends on the wavelength and a is a constant

r_0=z_rho(z_in,z0);

disp(vswr_t); disp(p); print_bw(l,r_0,rho_t);

figure(1);
scf();
plot(l,rho_t*ones(1,length(l)),'k--',l,r_0,'b');
xlabel('$l$',"fontsize", 4); // Section length 
ylabel('$|\rho|$',"fontsize", 4);
xgrid(1);
