// EN4333 Microwave Engineering
// ET3212 Microwave Engineering
//
// Microstrip Characteristic Impedance Feasibility
//
// Upeka Premaratne, ENTC, University of Moratuwa (upeka@uom.lk) 2025/04/26
// Free to use, distribute and modify for educational purposes with attribution

mu_0 = 4*%pi*10^(-7);
ep_0 = 8.854*10^(-12);

wh_n = 0.1:0.001:0.8; // w/h ratio range for a narrow microstrip
wh_w = 1.5:0.001:5; // w/h ratio range for a wide microstrip
// The ranges for each category are chosen such that any potential solution is uniquly in either the narrow or wide approximation

ep_r = 4.3;

t = 0.6*10^(-3);
h = 2.5*10^(-3);

n_n = length(wh_n);

h_n_axis = h*ones(1,n_n);
w_n_axis = h*wh_n;
t_n_axis = t*ones(1,n_n);

// Digiocomo et al. model for narrow microstrips (w<h)
z_n_cosh = 120/sqrt(0.475*ep_r+1.4)*acosh((3*h_n_axis)./(0.8*w_n_axis+t_n_axis)); // Inverse hypobolic cosine
z_n_ln = 120/sqrt(0.475*ep_r+1.4)*log((6*h_n_axis)./(0.8*w_n_axis+t_n_axis));     // Natural logarithm

n_w = length(wh_w);

h_w_axis = h*ones(1,n_w);
w_w_axis = h*wh_w;

// Assoudorian and Rimai model for wide microstrips (w>>h)
z_w = 120*%pi/sqrt(ep_r)*h_w_axis./w_w_axis;

// Plot the feasible characteristic impedances according to each model
figure(1);
clf();
a_fig = gca();
a_fig.tight_limits="on";
a_fig.data_bounds=[0.1,0; max(wh_w),200];
plot(wh_n,z_n_cosh,wh_n,z_n_ln,wh_w,z_w);
xgrid(1);
xlabel('w/h ratio');
ylabel('$\Omega$');
legend('Narrow (hypobolic cosine)','Narrow (natural logarithm)','Wide Approximation');
