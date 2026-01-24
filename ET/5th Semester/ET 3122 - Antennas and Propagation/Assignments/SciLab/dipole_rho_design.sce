// EN4333 Microwave Engineering
// Dipole antenna design for specific rho using Carter's formula
// 
// Upeka Premaratne, ENTC, University of Moratuwa (upeka@uom.lk) 2020/11/30
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

vswr_t = 1.5; // Target VSWR in dB

rho_t = (10^(vswr_t/10)-1)/(10^(vswr_t/10)+1); // Target rho

//rho = (z_L-z_0)/(z_L+z_0)

lambda =0.30;
u = 1;

a_4 = 10^(-2)*lambda;
a_3 = 10^(-3)*lambda;
a_2 = 10^(-4)*lambda;
a_1 = 10^(-5)*lambda;

l = 0.1:0.001:0.2; // section length (instead of total length of the antenna)
k = 2*%pi/lambda;

z0 = z0*ones(1,length(l));
z_1=antenna_zin(l,k,a_1);
z_2=antenna_zin(l,k,a_2);
z_3=antenna_zin(l,k,a_3);
z_4=antenna_zin(l,k,a_4);

r_1=z_rho(z_1,z0);
r_2=z_rho(z_2,z0);
r_3=z_rho(z_3,z0);
r_4=z_rho(z_4,z0);

disp("10^-5"); print_bw(l,r_1,rho_t);
disp("10^-4"); print_bw(l,r_2,rho_t);
disp("10^-3"); print_bw(l,r_3,rho_t);
disp("10^-2"); print_bw(l,r_4,rho_t);

figure(1);
scf();
plot(l,rho_t*ones(1,length(l)),'k--',l,r_1,'b',l,r_2,'r',l,r_3,'m',l,r_4,'k');
xlabel('$d/\lambda$',"fontsize", 4);
ylabel('$|\rho|$',"fontsize", 4);
xgrid(1);
L=legend('$\mbox{Required }|\rho|$','$10^{-5}\lambda$','$10^{-4}\lambda$','$10^{-3}\lambda$','$10^{-2}\lambda$',1);
L.font_size=4;
