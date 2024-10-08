function [name, PID, dataOut1, dataOut2] = Spar_Analysis_Function(dataIn);
% + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
% +
% +  SE-160A:  Aerospace Structural Analysis I
% +
% +  Project: (1) Spar Analysis
% +
% +  Title:   Spar_Analysis_Function
% +  Author:  Student Name
% +  PID:     Student PID
% +  Revised: 01/29/2024
% +
% +  This function is the primary analysis function for the spar analysis 
% +  program.  All of the input data is brought into the function using 
% +  "dataIn". Next all the calculations are performed.  Finally, the 
% +  calculated results are written to "dataOut1" and "dataOut2", where 
% +  these two data sets are sent to the main program (p-code) where it is 
% +  written and plotted in an Excel output file.
% +
% +  SUMMARY OF SPAR ANALYSIS
% +
% +  A) SECTION PROPERTIES
% +     A.1) Section Properties (EA EIyy, EIzz, EIyz)
% +     A.2) Torsion Constant (GJ)
% +  B) LOADS
% +     B.1) Applied Concentrated Forces, Torque and Moment
% +     B.2) Distributed Aerodynamic Loads (lift, drag, moment)
% +     B.3) Spar Root Reactions - Axial, Shear, Torque, and Moment 
% +     B.4) Distributed Spar Internal Axial, Shear, Bend Moments, Torque
% +  C) INTERNAL STRESSES (Four Cross-Section Locations)
% +     C.1) Root Spar Axial Stress (sxx) and Shear Stress (txs)
% +     C.2) Allowable Stress, and Root Margin of Safety
% +     C.3) Distributed Spar Axial Stress (sxx)
% +     C.4) Distributed Spar Shear Stress (tau)
% +  D) SPAR TIP DISPLACEMENTS, TWIST, AND BENDING SLOPES
% +     D.1) Distributed Spar X-direction (Axial) Displacement 
% +     D.2) Distributed Spar Y-direction (Drag ) Displacement 
% +     D.3) Distributed Spar Z-direction (Lift ) Displacement 
% +     D.4) Distributed Spar Twist Rotation
% +     D.5) Distributed Spar Bending Slopes (dv/dx, dw/dx)
% +
% +  Input Data
% +     dataIn:           Packed input data (38)
% +       dataIn(01):     Number of Output Plot Data Points
% +       dataIn(02):     Spar Length (inch)
% +       dataIn(03):     Mean Cross-Section Radius (inch)
% +       dataIn(04):     Mean Cross-Section Thickness (inch)
% +       dataIn(05):     Material Density (lbf/in^3)
% +       dataIn(06):     Material Young's Modulus (Msi)
% +       dataIn(07):     Material Shear Modulus (Msi)
% +       dataIn(08):     Material Yield Strength - Tension (Ksi)
% +       dataIn(09):     Material Yield Strength - Compression (Ksi)
% +       dataIn(10):     Material Yield Strength - Shear (Ksi)
% +       dataIn(11):     Material Ultimate Strength - Tension (Ksi)
% +       dataIn(12):     Material Ultimate Strength - Compression (Ksi)
% +       dataIn(13):     Material Ultimate Strength - Shear (Ksi)
% +       dataIn(14):     Safety Factor - Yield
% +       dataIn(15):     Safety Factor - Ultimate
% +       dataIn(16):     First Load Location (x/L)
% +       dataIn(17):     Concentrated Force - X Direction (lb)
% +       dataIn(18):     Concentrated Force - Y Direction (lb)
% +       dataIn(19):     Concentrated Force - Z Direction (lb) 
% +       dataIn(20):     Concentrated Torque - About X Direction (lb-in)
% +       dataIn(21):     Concentrated Moment - About Y Direction (lb-in)
% +       dataIn(22):     Concentrated Moment - About Z Direction (lb-in)
% +       dataIn(23):     Second Load Location (x/L)
% +       dataIn(24):     Concentrated Force - X Direction (lb)
% +       dataIn(25):     Concentrated Force - Y Direction (lb)
% +       dataIn(26):     Concentrated Force - Z Direction (lb) 
% +       dataIn(27):     Concentrated Torque - About X Direction (lb-in)
% +       dataIn(28):     Concentrated Moment - About Y Direction (lb-in)
% +       dataIn(29):     Concentrated Moment - About Z Direction (lb-in)
% +       dataIn(30):     Aircraft Load Factor
% +       dataIn(31):     Drag Distribution - Constant (lb/in)
% +       dataIn(32):     Drag Distribution - rth order (lb/in)
% +       dataIn(33):     Drag Distribution - polynomial order
% +       dataIn(34):     Lift Distribution - Constant (lb/in)
% +       dataIn(35):     Lift Distribution - 2nd Order (lb/in)
% +       dataIn(36):     Lift Distribution - 4th Order (lb/in)
% +       dataIn(37):     Twist Moment Distribution - Constant (lb-in/in)
% +       dataIn(38):     Twist Moment Distribution - 1st Order (lb-in/in)
% +
% +  Output Data
% +     Name:             Name of author of this analysis function           
% +     PID:              UCSD Student ID number of author
% +     dataOut1:         Packed calculated output variable data
% +       dataOut1(01):   Axial   Stiffness EA   (lb)
% +       dataOut1(02):   Bending Stiffness EIyy (lb-in^2)   
% +       dataOut1(03):   Bending Stiffness EIzz (lb-in^2)   
% +       dataOut1(04):   Bending Stiffness EIyz (lb-in^2)   
% +       dataOut1(05):   Torsion Stiffness GJ   (lb-in^2)
% +       dataOut1(06):   Root Internal Force - X Direction (lb)
% +       dataOut1(07):   Root Internal Force - Y Direction (lb)
% +       dataOut1(08):   Root Internal Force - Z Direction (lb)
% +       dataOut1(09):   Root Internal Moment - about X Direction (lb-in)
% +       dataOut1(10):   Root Internal Moment - about Y Direction (lb-in)
% +       dataOut1(11):   Root Internal Moment - about Z Direction (lb-in)
% +       dataOut1(12):   Allowable Stress - Tension (lb/in^2)
% +       dataOut1(13):   Allowable Stress - Compression (lb/in^2)
% +       dataOut1(14):   Allowable Stress - Shear (lb/in^2)
% +       dataOut1(15):   Root Axial Stress - point A (lb/in^2)
% +       dataOut1(16):   Root Axial Stress - point B (lb/in^2)
% +       dataOut1(17):   Root Axial Stress - point C (lb/in^2)
% +       dataOut1(18):   Root Axial Stress - point D (lb/in^2)
% +       dataOut1(19):   Root Shear Stress xy - point A (lb/in^2)
% +       dataOut1(20):   Root Shear Stress xy - point B (lb/in^2)
% +       dataOut1(21):   Root Shear Stress xy - point C (lb/in^2)
% +       dataOut1(22):   Root Shear Stress xy - point D (lb/in^2)
% +       dataOut1(23):   Root Shear Stress xz - point A (lb/in^2)
% +       dataOut1(24):   Root Shear Stress xz - point B (lb/in^2)
% +       dataOut1(25):   Root Shear Stress xz - point C (lb/in^2)
% +       dataOut1(26):   Root Shear Stress xz - point D (lb/in^2)
% +       dataOut1(27):   Margin of Safety - point A
% +       dataOut1(28):   Margin of Safety - point B
% +       dataOut1(29):   Margin of Safety - point C
% +       dataOut1(30):   Margin of Safety - point D
% +       dataOut1(31):   Tip Diplacement  - X Direction (inch)
% +       dataOut1(32):   Tip Diplacement  - Y Direction (inch)
% +       dataOut1(33):   Tip Diplacement  - Z Direction (inch)
% +       dataOut1(34):   Tip Twist (degree)
% +       dataOut1(35):   Tip Bending Slope (dv/dx) (inch/inch)
% +       dataOut1(36):   Tip Bending Slope (dw/dx) (inch/inch)
% + 
% +     dataOut2:         Packed calculated output plot data
% +       column( 1):     X direction coordinate (inch)
% +       column( 2):     Applied distributed drag force (lb/in)   
% +       column( 3):     Aapplied distributed lift force (lb/in)   
% +       column( 4):     Applied distributed torque (lb-in/in)   
% +       column( 5):     Internal axial force  - Vx (lb)   
% +       column( 6):     Internal shear force  - Vy (lb)   
% +       column( 7):     Internal shear force  - Vz (lb)   
% +       column( 8):     Internal axial torque - Mx (lb-in)   
% +       column( 9):     Internal bending moment - My (lb-in)
% +       column(10):     Internal bending moment - Mz (lb-in) 
% +       column(11):     Axial Stress - point A (lb/in^2) 
% +       column(12):     Axial Stress - point B (lb/in^2) 
% +       column(13):     Axial Stress - point C (lb/in^2) 
% +       column(14):     Axial Stress - point D (lb/in^2) 
% +       column(15):     Shear Stress - point A (lb/in^2) 
% +       column(16):     Shear Stress - point B (lb/in^2) 
% +       column(17):     Shear Stress - point C (lb/in^2) 
% +       column(18):     Shear Stress - point D (lb/in^2)
% +       column(19):     Displacement - X Direction (inch) 
% +       column(20):     Displacement - Y Direction (inch) 
% +       column(21):     Displacement - z Direction (inch) 
% +       column(22):     Twist (degree)
% +       column(23):     Bending Slope (dv/dx) (inch/inch)
% +       column(24):     Bending Slope (dw/dx) (inch/inch)
% +
% + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +

% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#1): Unpack Input Data Array and Wwrite User Name and PID
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (1) Unpack Input Data and Write User Name and PID')

   nplot = dataIn( 1);   % number of output plot data points
   Lo    = dataIn( 2);   % Spar Length (inch)
   Ro    = dataIn( 3);   % Mean Cross-Section Radius (inch)
   to    = dataIn( 4);   % Mean Cross-Section Thickness (inch)
   rho   = dataIn( 5);   % Material Density (lbf/in^3)
   Eo    = dataIn( 6);   % Material Young's Modulus (Msi)
   Go    = dataIn( 7);   % Material Shear Modulus (Msi)
   Syt   = dataIn( 8);   % Material Yield Strength - Tension (Ksi)
   Syc   = dataIn( 9);   % Material Yield Strength - Compression (Ksi)
   Sys   = dataIn(10);   % Material Yield Strength - Shear (Ksi)
   Sut   = dataIn(11);   % Material Ultimate Strength - Tension (Ksi)
   Suc   = dataIn(12);   % Material Ultimate Strength - Compression (Ksi)
   Sus   = dataIn(13);   % Material Ultimate Strength - Shear (Ksi)
   SFy   = dataIn(14);   % Safety Factor - Yield
   SFu   = dataIn(15);   % Safety Factor - Ultimate
   x1L   = dataIn(16);   % First Load Location (x/L)
   Fx1   = dataIn(17);   % Concentrated Force - X Direction (lb)
   Fy1   = dataIn(18);   % Concentrated Force - Y Direction (lb)
   Fz1   = dataIn(19);   % Concentrated Force - Z Direction (lb)   
   Mx1   = dataIn(20);   % Concentrated Torque - About X Direction (lb-in)
   My1   = dataIn(21);   % Concentrated Moment - About Y Direction (lb-in)
   Mz1   = dataIn(22);   % Concentrated Moment - About Z Direction (lb-in)
   x2L   = dataIn(23);   % Second Load Location (x/L)
   Fx2   = dataIn(24);   % Concentrated Force - X Direction (lb)
   Fy2   = dataIn(25);   % Concentrated Force - Y Direction (lb)
   Fz2   = dataIn(26);   % Concentrated Force - Z Direction (lb)   
   Mx2   = dataIn(27);   % Concentrated Torque - About X Direction (lb-in)
   My2   = dataIn(28);   % Concentrated Moment - About Y Direction (lb-in)
   Mz2   = dataIn(29);   % Concentrated Moment - About Z Direction (lb-in)
   LF    = dataIn(30);   % Aircraft Load Factor
   py0   = dataIn(31);   % Drag Distribution - Constant (lb/in)
   pyr   = dataIn(32);   % Drag Distribution - rth order (lb/in)
   rth   = dataIn(33);   % Drag Distribution - polynomial order
   pz0   = dataIn(34);   % Lift Distribution - Constant (lb/in)
   pz2   = dataIn(35);   % Lift Distribution - 2nd Order (lb/in)
   pz4   = dataIn(36);   % Lift Distribution - 4th Order (lb/in)
   mx0   = dataIn(37);   % Twist Moment Distribution - Constant (lb-in/in)
   mx1   = dataIn(38);   % Twist Moment Distribution - 1st Order (lb-in/in)

% Define author name and PID (Write in your name and PID)    
   name  = {'Levi Stein'};
   PID   = {'A16791467'};

% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#2): Calculate the Section Properties
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (2) Calculate the Section Properties')
A = pi*((Ro+(to/2))^2 - (Ro-(to/2))^2);
EA = Eo*10^6*(pi*((Ro+(to/2))^2 - (Ro-(to/2))^2));
EIyy = Eo*10^6*((pi/4)*((Ro+(to/2))^4 - (Ro-(to/2))^4));
EIzz = EIyy;   
EIyz = 0;
GJ = Go*10^6*((pi/2)*((Ro+(to/2))^4 - (Ro-(to/2))^4));
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#3): Calculate Root Internal Stress Resultants for Applied
% .                Concentrated Forces and Applied Aerodynamic Loads
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (3) Calculate Root Stress Resultants for Applied Concentrated Loads and Aero Loads')
MX = @(x) mx0 + mx1*(x/Lo);
Vxo = Fx1 + Fx2;
PY = @(x) py0 + pyr*(x/Lo).^rth;
Vyo = Fy1 + Fy2 + py0*Lo + (pyr/(rth+1))*((Lo^(rth+1))/(Lo^rth));
PZ = @(x) pz0 + pz2*(x/Lo).^2 +pz4*(x/Lo).^4;
Vzo = Fz1 + Fz2 + pz0*(Lo) + (pz2)*((Lo^3)/(3*Lo^2)) + (pz4)*((Lo^5)/(5*Lo^4)) - LF*(rho*A*Lo);
Mxo = Mx1 + Mx2 + mx0*Lo + (mx1/Lo)*(Lo^2/2);
pzz =@(x) x.*(pz0 + pz2*(x/Lo).^2 +pz4*(x/Lo).^4);
LM = (pz0)*((Lo^2)/2) + (pz2/(Lo^2))*((Lo^4)/4) + (pz4/(Lo^4))*((Lo^6)/6);
Myo = LF*(rho*A*Lo)*(Lo/2) - LM + My1 + My2 - Fz1*(x1L*Lo) - Fz2*(x2L*Lo);
pyy = @(x) x.*(py0 + pyr*(x/Lo).^rth);
DM = py0*(Lo^2)/2 + pyr*(Lo^(rth+2))/((rth+2)*(Lo^rth));
Mzo = DM + Mz1 + Mz2 + Fy1*(x1L*Lo) + Fy2*(x2L*Lo);
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#4): Calculate Allowable Properties, Root Stresses and Margin
% .                of Safety
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (4) Calculate Allowable Properties, Root Stresses, and Margins of Safety')

S_allow_T = min([(Syt/SFy) (Sut/SFu)]);
S_allow_C = min([(Syc/SFy) (Suc/SFu)]);
S_allow_S = min([(Sys/SFy) (Sus/SFu)]);

Sxxo_A = (Eo*Myo/EIyy)*(Ro+(to/2))*10^3;
Sxxo_B = (Eo*Mzo/EIzz)*(Ro+(to/2))*10^3;
Sxxo_C = -1*(Eo*Myo/EIyy)*(Ro+(to/2))*10^3;
Sxxo_D = -1*(Eo*Mzo/EIzz)*(Ro+(to/2))*10^3;

J = ((pi/2)*((Ro+(to/2))^4 - (Ro-(to/2))^4));
Txyo_A = ((Vyo/(pi*Ro*to)) - (Mxo/J)*(Ro+(to/2)))*10^-3;
Txyo_B = 0;
Txyo_C = ((Vyo/(pi*Ro*to)) + (Mxo/J)*(Ro+(to/2)))*10^-3;
Txyo_D = 0;

Txzo_A = 0;
Txzo_B = ((Vzo/(pi*Ro*to)) - (Mxo/J)*(Ro+(to/2)))*10^-3;
Txzo_C = 0;
Txzo_D = ((Vzo/(pi*Ro*to)) + (Mxo/J)*(Ro+(to/2)))*10^-3;

MS_A = (S_allow_T/(sqrt(Sxxo_A^2 + 3*Txyo_A^2))) - 1;
MS_B = (S_allow_T/(sqrt(Sxxo_B^2 + 3*Txzo_B^2))) - 1;
MS_C = (S_allow_T/(sqrt(Sxxo_C^2 + 3*Txyo_C^2))) - 1;
MS_D = (S_allow_T/(sqrt(Sxxo_D^2 + 3*Txzo_D^2))) - 1;
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#5): Calculate the Data Arrays for Plotting
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (5) Calculate the Data Arrays for Future Plotting')
x = linspace(0,Lo,nplot);
for n = 1:nplot
    py(n) = PY(x(n));
    pz(n) = PZ(x(n));
    mx(n) = MX(x(n));
end

% if x1L > x2L
%     x1L = x2L;
%     x2L = x1L;
% end

Vx(1) = Vxo;
Vz(1) = Vzo;
Vy(1) = Vyo;
for n = 1:nplot 
    if x(n) > 0 && (x(n)/Lo) <= x1L
    Vx(n) = Vxo;
    Vy(n) = Vyo - py0*x(n) - (pyr/(rth+1))*((x(n)^(rth+1))/(Lo^rth)); 
    Vz(n) = Vzo - pz0*(x(n)) - (pz2)*((x(n)^3)/(3*Lo^2)) - (pz4)*((x(n)^5)/(5*Lo^4)) + (LF*rho*A*Lo*(x(n)/Lo));
    elseif (x(n)/Lo) > x1L && (x(n)/Lo) <= x2L
    Vx(n) = Vxo - Fx1;
    Vy(n) = Vyo - Fy1 - py0*x(n) - (pyr/(rth+1))*((x(n)^(rth+1))/(Lo^rth));
    Vz(n) = Vzo - Fz1 - pz0*(x(n)) - (pz2)*((x(n)^3)/(3*Lo^2)) - (pz4)*((x(n)^5)/(5*Lo^4)) + (LF*rho*A*Lo*(x(n)/Lo));
    elseif (x(n)/Lo) > x1L && (x(n)/Lo) > x2L
    Vx(n) = Vxo - Fx1 - Fx2;
    Vy(n) = Vyo - Fy1 - Fy2 - py0*x(n) - (pyr/(rth+1))*((x(n)^(rth+1))/(Lo^rth));
    Vz(n) = Vzo - Fz1 - Fz2 - pz0*(x(n)) - (pz2)*((x(n)^3)/(3*Lo^2)) - (pz4)*((x(n)^5)/(5*Lo^4)) + (LF*rho*A*Lo*(x(n)/Lo));
    end
end
Mx(1) = Mxo;
My(1) = Myo;
Mz(1) = Mzo;
for n = 1:nplot 
    if x(n) > 0 && (x(n)/Lo) <= x1L 
    Mx(n) = Mxo - mx0*(x(n)) - (mx1/Lo)*((x(n)^2)/2);
    My(n) = Myo + Vzo*x(n) - pz0*((x(n)^2)/2) - (pz2/(Lo^2))*((x(n)^4)/12) - (pz4/(Lo^4))*((x(n)^6)/30) + (LF*rho*A*((x(n)^2)/2));
    Mz(n) = Mzo - Vyo*(x(n)) + py0*(x(n)^2)/2 + pyr*(x(n)^(rth+2))/((rth+1)*(rth+2)*(Lo^rth));
    elseif (x(n)/Lo) > x1L && (x(n)/Lo) <= x2L
    Mx(n) = Mxo - Mx1 - mx0*(x(n)) - (mx1/Lo)*((x(n)^2)/2);
    My(n) = Myo - My1 - Fz1*(x(n) - (x1L*Lo)) + Vzo*x(n) - pz0*((x(n)^2)/2) - (pz2/(Lo^2))*((x(n)^4)/12) - (pz4/(Lo^4))*((x(n)^6)/30) + (LF*rho*A*((x(n)^2)/2));
    Mz(n) = Mzo - Mz1 + Fy1*(x(n) - (x1L*Lo)) - Vyo*(x(n)) + py0*(x(n)^2)/2 + pyr*(x(n)^(rth+2))/((rth+1)*(rth+2)*(Lo^rth));
    elseif (x(n)/Lo) > x1L && (x(n)/Lo) > x2L
    Mx(n) = Mxo - Mx1 - Mx2 - mx0*(x(n)) - (mx1/Lo)*((x(n)^2)/2);
    My(n) = Myo - My1 - My2 - Fz1*(x(n) - (x1L*Lo)) - Fz2*(x(n) - (x2L*Lo)) + Vzo*x(n) - pz0*((x(n)^2)/2) - (pz2/(Lo^2))*((x(n)^4)/12) - (pz4/(Lo^4))*((x(n)^6)/30) + (LF*rho*A*((x(n)^2)/2));
    Mz(n) = Mzo - Mz1 - Mz2 + Fy1*(x(n) - (x1L*Lo)) + Fy2*(x(n) - (x2L*Lo)) - Vyo*x(n) + py0*((x(n)^2)/2) + pyr*(x(n)^(rth+2))/((rth+1)*(rth+2)*(Lo^rth));
    end
end

for n = 1:nplot
    Sxx_A(n) = (Eo*My(n)/EIyy)*(Ro+(to/2))*10^3;
    Sxx_B(n) = (Eo*Mz(n)/EIzz)*(Ro+(to/2))*10^3;
    Sxx_C(n) = -1*(Eo*My(n)/EIyy)*(Ro+(to/2))*10^3;
    Sxx_D(n) = -1*(Eo*Mz(n)/EIzz)*(Ro+(to/2))*10^3;

    Tau_A(n) = ((Vy(n)/(pi*Ro*to)) - (Mx(n)/J)*(Ro+(to/2)))*10^-3;
    Tau_B(n) = ((Vz(n)/(pi*Ro*to)) - (Mx(n)/J)*(Ro+(to/2)))*10^-3;
    Tau_C(n) = ((Vy(n)/(pi*Ro*to)) + (Mx(n)/J)*(Ro+(to/2)))*10^-3;
    Tau_D(n) = ((Vz(n)/(pi*Ro*to)) + (Mx(n)/J)*(Ro+(to/2)))*10^-3;
end

if x1L > 0
    i = find((x/Lo) == x1L);
else
    i = 1;
end

if x2L > 0 
    j = find((x/Lo) == x2L);
elseif x2L == 0
    x2L = 1;
else
    j = 1;
end


for n = 1:nplot
DvDx(n) = (Mzo*x(n) - Vyo*((x(n)^2)/2) + (py0/2)*((x(n)^3)/3) + pyr*(x(n)^(rth+3))/((rth+1)*(rth+2)*(rth+3)*(Lo^rth)))/EIyy;
DwDx(n) = -1*(Myo*x(n) + Vzo*((x(n)^2/2)) - pz0*((x(n)^3)/6) - (pz2/(Lo^2))*((x(n)^5)/60) - (pz4/(Lo^4))*((x(n)^7)/210) + (LF*rho*A*((x(n)^3)/6)))/EIzz;
Twist(n) = (360/(2*pi))*(Mxo*(x(n)) - mx0*(x(n)^2)/2 - (mx1/Lo)*((x(n)^3)/6))/GJ;
end

for n = 1:nplot 
    if x(n) > 0 && (x(n)/Lo) <= x1L 
    DvDx(n) = (Mzo*x(n) - Vyo*((x(n)^2)/2) + (py0/2)*((x(n)^3)/3) + pyr*(x(n)^(rth+3))/((rth+1)*(rth+2)*(rth+3)*(Lo^rth)))/EIyy;
    DwDx(n) = -1*(Myo*x(n) + Vzo*((x(n)^2/2)) - pz0*((x(n)^3)/6) - (pz2/(Lo^2))*((x(n)^5)/60) - (pz4/(Lo^4))*((x(n)^7)/210) + (LF*rho*A*((x(n)^3)/6)))/EIzz;
    Twist(n) = (360/(2*pi))*(Mxo*(x(n)) - mx0*(x(n)^2)/2 - (mx1/Lo)*((x(n)^3)/6))/GJ;
    elseif (x(n)/Lo) > x1L && (x(n)/Lo) <= x2L  %% need to fix this
    DvDxConti = (Mzo*(x1L*Lo) - Vyo*(((x1L*Lo)^2)/2) + (py0/2)*(((x1L*Lo)^3)/3) + pyr*((x1L*Lo)^(rth+3))/((rth+1)*(rth+2)*(rth+3)*(Lo^rth)))/EIyy - (Mzo*(x1L*Lo) - Mz1*(x1L*Lo) + Fy1*(((x1L*Lo)^2)/2) - Fy1*(x1L*Lo)*(x1L*Lo) - Vyo*(((x1L*Lo)^2)/2) + (py0/2)*(((x1L*Lo)^3)/3) + pyr*((x1L*Lo)^(rth+3))/((rth+1)*(rth+2)*(rth+3)*(Lo^rth)))/EIyy;
    DwDxConti = -1*(Myo*(x1L*Lo) + Vzo*(((x1L*Lo)^2/2)) - pz0*(((x1L*Lo)^3)/6) - (pz2/(Lo^2))*(((x1L*Lo)^5)/60) - (pz4/(Lo^4))*(((x1L*Lo)^7)/210) + (LF*rho*A*(((x1L*Lo)^3)/6)))/EIzz - (-1*(Myo*(x1L*Lo) - My1*(x1L*Lo) - Fz1*(((x1L*Lo)^2)/2) + Fz1*(x1L*Lo)*((x1L*Lo)) + Vzo*(((x1L*Lo)^2/2)) - pz0*(((x1L*Lo)^3)/6) - (pz2/(Lo^2))*(((x1L*Lo)^5)/60) - (pz4/(Lo^4))*(((x1L*Lo)^7)/210) + (LF*rho*A*(((x1L*Lo)^3)/6)))/EIzz);
%     DvDxConti = DvDx(i) - (Mzo*x(i) - Mz1*x(i) + Fy1*((x(i)^2)/2) - Fy1*(x1L*Lo)*(x(i)) - Vyo*((x(i)^2)/2) + (py0/2)*((x(i)^3)/3) + pyr*(x(i)^(rth+3))/((rth+1)*(rth+2)*(rth+3)*(Lo^rth)))/EIyy;
%     DwDxConti = DwDx(i) - (-1*(Myo*x(i) - My1*x(i) - Fz1*((x(i)^2)/2) + Fz1*(x1L*Lo)*(x(i)) + Vzo*((x(i)^2/2)) - pz0*((x(i)^3)/6) - (pz2/(Lo^2))*((x(i)^5)/60) - (pz4/(Lo^4))*((x(i)^7)/210) + (LF*rho*A*((x(i)^3)/6)))/EIzz);
    DvDx(n) = DvDxConti + (Mzo*x(n) - Mz1*x(n) + Fy1*((x(n)^2)/2) - Fy1*(x1L*Lo)*(x(n)) - Vyo*((x(n)^2)/2) + (py0/2)*((x(n)^3)/3) + pyr*(x(n)^(rth+3))/((rth+1)*(rth+2)*(rth+3)*(Lo^rth)))/EIyy;
    DwDx(n) = DwDxConti + (-1*(Myo*x(n) - My1*x(n) - Fz1*((x(n)^2)/2) + Fz1*(x1L*Lo)*(x(n)) + Vzo*((x(n)^2/2)) - pz0*((x(n)^3)/6) - (pz2/(Lo^2))*((x(n)^5)/60) - (pz4/(Lo^4))*((x(n)^7)/210) + (LF*rho*A*((x(n)^3)/6)))/EIzz);
    Twist(n) = (360/(2*pi))*(Mxo*(x1L*Lo) - mx0*((x1L*Lo)^2)/2 - (mx1/Lo)*(((x1L*Lo)^3)/6))/GJ + (360/(2*pi))*(Mxo*(x(n)) - Mx1*(x(n)) - mx0*(x(n)^2)/2 - (mx1/Lo)*((x(n)^3)/6))/GJ - (360/(2*pi))*(Mxo*((x1L*Lo)) - Mx1*((x1L*Lo)) - mx0*((x1L*Lo)^2)/2 - (mx1/Lo)*(((x1L*Lo)^3)/6))/GJ;
    elseif (x(n)/Lo) > x1L && (x(n)/Lo) > x2L 
    DvDxContj = DvDxConti + (Mzo*(x2L*Lo) - Mz1*(x2L*Lo) + Fy1*(((x2L*Lo)^2)/2) - Fy1*(x1L*Lo)*((x2L*Lo)) - Vyo*(((x2L*Lo)^2)/2) + (py0/2)*(((x2L*Lo)^3)/3) + pyr*((x2L*Lo)^(rth+3))/((rth+1)*(rth+2)*(rth+3)*(Lo^rth)))/EIyy - (Mzo*(x2L*Lo) - Mz1*(x2L*Lo) - Mz2*(x2L*Lo) + Fy1*(((x2L*Lo)^2)/2) - Fy1*(x1L*Lo)*((x2L*Lo)) + Fy2*(((x2L*Lo)^2)/2) - Fy2*(x2L*Lo)*((x2L*Lo)) - Vyo*(((x2L*Lo)^2)/2) + (py0/2)*(((x2L*Lo)^3)/3) + pyr*((x2L*Lo)^(rth+3))/((rth+1)*(rth+2)*(rth+3)*(Lo^rth)))/EIyy;
    DwDxContj = DwDxConti + (-1*(Myo*(x2L*Lo) - My1*(x2L*Lo) - Fz1*(((x2L*Lo)^2)/2) + Fz1*(x1L*Lo)*((x2L*Lo)) + Vzo*(((x2L*Lo)^2/2)) - pz0*(((x2L*Lo)^3)/6) - (pz2/(Lo^2))*(((x2L*Lo)^5)/60) - (pz4/(Lo^4))*(((x2L*Lo)^7)/210) + (LF*rho*A*(((x2L*Lo)^3)/6)))/EIzz) - (-1*(Myo*(x2L*Lo) - My1*(x2L*Lo) - My2*(x2L*Lo) - Fz1*(((x2L*Lo)^2)/2) + Fz1*(x1L*Lo)*((x2L*Lo)) - Fz2*(((x2L*Lo)^2)/2) + Fz2*(x2L*Lo)*((x2L*Lo)) + Vzo*(((x2L*Lo)^2/2)) - pz0*(((x2L*Lo)^3)/6) - (pz2/(Lo^2))*(((x2L*Lo)^5)/60) - (pz4/(Lo^4))*(((x2L*Lo)^7)/210) + (LF*rho*A*(((x2L*Lo)^3)/6)))/EIzz);
%     DvDxContj = DvDx(j) - (Mzo*x(j) - Mz1*x(j) - Mz2*x(j) + Fy1*((x(j)^2)/2) - Fy1*(x1L*Lo)*(x(j)) + Fy2*((x(j)^2)/2) - Fy2*(x2L*Lo)*(x(j)) - Vyo*((x(j)^2)/2) + (py0/2)*((x(j)^3)/3) + pyr*(x(j)^(rth+3))/((rth+1)*(rth+2)*(rth+3)*(Lo^rth)))/EIyy;
%     DwDxContj = DwDx(j) - (-1*(Myo*x(j) - My1*x(j) - My2*x(j) - Fz1*((x(j)^2)/2) + Fz1*(x1L*Lo)*(x(j)) - Fz2*((x(j)^2)/2) + Fz2*(x2L*Lo)*(x(j)) + Vzo*((x(j)^2/2)) - pz0*((x(j)^3)/6) - (pz2/(Lo^2))*((x(j)^5)/60) - (pz4/(Lo^4))*((x(j)^7)/210) + (LF*rho*A*((x(j)^3)/6)))/EIzz);
    DvDx(n) = DvDxContj + (Mzo*x(n) - Mz1*x(n) - Mz2*x(n) + Fy1*((x(n)^2)/2) - Fy1*(x1L*Lo)*(x(n)) + Fy2*((x(n)^2)/2) - Fy2*(x2L*Lo)*(x(n)) - Vyo*((x(n)^2)/2) + (py0/2)*((x(n)^3)/3) + pyr*(x(n)^(rth+3))/((rth+1)*(rth+2)*(rth+3)*(Lo^rth)))/EIyy;
    DwDx(n) = DwDxContj + (-1*(Myo*x(n) - My1*x(n) - My2*x(n) - Fz1*((x(n)^2)/2) + Fz1*(x1L*Lo)*(x(n)) - Fz2*((x(n)^2)/2) + Fz2*(x2L*Lo)*(x(n)) + Vzo*((x(n)^2/2)) - pz0*((x(n)^3)/6) - (pz2/(Lo^2))*((x(n)^5)/60) - (pz4/(Lo^4))*((x(n)^7)/210) + (LF*rho*A*((x(n)^3)/6)))/EIzz);
    Twist(n) = (360/(2*pi))*(Mxo*(x1L*Lo) - mx0*((x1L*Lo)^2)/2 - (mx1/Lo)*(((x1L*Lo)^3)/6))/GJ + (360/(2*pi))*(Mxo*((x2L*Lo)) - Mx1*((x2L*Lo)) - mx0*((x2L*Lo)^2)/2 - (mx1/Lo)*(((x2L*Lo)^3)/6))/GJ - (360/(2*pi))*(Mxo*((x1L*Lo)) - Mx1*((x1L*Lo)) - mx0*((x1L*Lo)^2)/2 - (mx1/Lo)*(((x1L*Lo)^3)/6))/GJ + (360/(2*pi))*(Mxo*(x(n)) - Mx1*(x(n)) - Mx2*(x(n)) - mx0*(x(n)^2)/2 - (mx1/Lo)*((x(n)^3)/6))/GJ - (360/(2*pi))*(Mxo*((x2L*Lo)) - Mx1*((x2L*Lo)) - Mx2*((x2L*Lo)) - mx0*((x2L*Lo)^2)/2 - (mx1/Lo)*(((x2L*Lo)^3)/6))/GJ;
    end
end

Disp_X(1) = 0;
Disp_Y(1) = 0;
Disp_Z(1) = 0;

for n = 1:nplot
    Disp_X(n) = (Fx1*x(n))/(EA) + (Fx2*x(n))/(EA);
    Disp_Y(n) = (Mzo*((x(n)^2)/2) - (Vyo/2)*((x(n)^3)/3) + (py0/6)*((x(n)^4)/4) + pyr*(x(n)^(rth+4))/((rth+1)*(rth+2)*(rth+3)*(rth+4)*(Lo^rth)))/EIyy;
    Disp_Z(n) = -1*(Myo*((x(n)^2)/2) + Vzo*((x(n)^3/6)) - pz0*((x(n)^4)/24) - (pz2/(Lo^2))*((x(n)^6)/360) - (pz4/(Lo^4))*((x(n)^8)/1680) + (LF*rho*A*((x(n)^4)/24)))/EIzz;
end

for n = 1:nplot
    if x(n) > 0 && (x(n)/Lo) <= x1L
    Disp_X(n) = (Fx1*x(n))/(EA) + (Fx2*x(n))/(EA);
    Disp_Y(n) = (Mzo*((x(n)^2)/2) - (Vyo/2)*((x(n)^3)/3) + (py0/6)*((x(n)^4)/4) + pyr*(x(n)^(rth+4))/((rth+1)*(rth+2)*(rth+3)*(rth+4)*(Lo^rth)))/EIyy;
    Disp_Z(n) = -1*(Myo*((x(n)^2)/2) + Vzo*((x(n)^3/6)) - pz0*((x(n)^4)/24) - (pz2/(Lo^2))*((x(n)^6)/360) - (pz4/(Lo^4))*((x(n)^8)/1680) + (LF*rho*A*((x(n)^4)/24)))/EIzz;
    elseif (x(n)/Lo) > x1L && (x(n)/Lo) <= x2L
    Yconti = (Mzo*(((x1L*Lo)^2)/2) - (Vyo/2)*(((x1L*Lo)^3)/3) + (py0/6)*(((x1L*Lo)^4)/4) + pyr*((x1L*Lo)^(rth+4))/((rth+1)*(rth+2)*(rth+3)*(rth+4)*(Lo^rth)))/EIyy;
    Zconti = -1*(Myo*(((x1L*Lo)^2)/2) + Vzo*(((x1L*Lo)^3/6)) - pz0*(((x1L*Lo)^4)/24) - (pz2/(Lo^2))*(((x1L*Lo)^6)/360) - (pz4/(Lo^4))*(((x1L*Lo)^8)/1680) + (LF*rho*A*(((x1L*Lo)^4)/24)))/EIzz;
    Disp_X(n) = (Fx1*(x1L*Lo))/(EA) + (Fx2*(x1L*Lo))/(EA) + (Fx2*x(n))/(EA) - (Fx2*(x1L*Lo))/(EA);
    Disp_Y(n) = Yconti + DvDxConti*x(n) - DvDxConti*(x1L*Lo) + ((Mzo*((x(n)^2)/2) - Mz1*((x(n)^2)/2) + Fy1*((x(n)^3)/6) - Fy1*(x1L*Lo)*((x(n)^2)/2) - (Vyo/2)*((x(n)^3)/3) + (py0/6)*((x(n)^4)/4) + pyr*(x(n)^(rth+4))/((rth+1)*(rth+2)*(rth+3)*(rth+4)*(Lo^rth)))/EIyy) - ((Mzo*(((x1L*Lo)^2)/2) - Mz1*(((x1L*Lo)^2)/2) + Fy1*(((x1L*Lo)^3)/6) - Fy1*(x1L*Lo)*(((x1L*Lo)^2)/2) - (Vyo/2)*(((x1L*Lo)^3)/3) + (py0/6)*(((x1L*Lo)^4)/4) + pyr*((x1L*Lo)^(rth+4))/((rth+1)*(rth+2)*(rth+3)*(rth+4)*(Lo^rth)))/EIyy);
    Disp_Z(n) = Zconti + DwDxConti*x(n) - DwDxConti*(x1L*Lo) + (-1*(Myo*((x(n)^2)/2) - My1*((x(n)^2)/2) - Fz1*((x(n)^3)/6) + Fz1*(x1L*Lo)*((x(n)^2)/2) + Vzo*((x(n)^3)/6) - pz0*((x(n)^4)/24) - (pz2/(Lo^2))*((x(n)^6)/360) - (pz4/(Lo^4))*((x(n)^8)/1680) + (LF*rho*A*((x(n)^4)/24)))/EIzz) - (-1*(Myo*(((x1L*Lo)^2)/2) - My1*(((x1L*Lo)^2)/2) - Fz1*(((x1L*Lo)^3)/6) + Fz1*(x1L*Lo)*(((x1L*Lo)^2)/2) + Vzo*(((x1L*Lo)^3/6)) - pz0*(((x1L*Lo)^4)/24) - (pz2/(Lo^2))*(((x1L*Lo)^6)/360) - (pz4/(Lo^4))*(((x1L*Lo)^8)/1680) + (LF*rho*A*(((x1L*Lo)^4)/24)))/EIzz);
    elseif (x(n)/Lo) > x1L && (x(n)/Lo) > x2L
    Ycontj = Yconti + DvDxConti*(x2L*Lo) - DvDxConti*(x1L*Lo) + ((Mzo*(((x2L*Lo)^2)/2) - Mz1*(((x2L*Lo)^2)/2) + Fy1*(((x2L*Lo)^3)/6) - Fy1*(x1L*Lo)*(((x2L*Lo)^2)/2) - (Vyo/2)*(((x2L*Lo)^3)/3) + (py0/6)*(((x2L*Lo)^4)/4) + pyr*((x2L*Lo)^(rth+4))/((rth+1)*(rth+2)*(rth+3)*(rth+4)*(Lo^rth)))/EIyy) - ((Mzo*(((x1L*Lo)^2)/2) - Mz1*(((x1L*Lo)^2)/2) + Fy1*(((x1L*Lo)^3)/6) - Fy1*(x1L*Lo)*(((x1L*Lo)^2)/2) - (Vyo/2)*(((x1L*Lo)^3)/3) + (py0/6)*(((x1L*Lo)^4)/4) + pyr*((x1L*Lo)^(rth+4))/((rth+1)*(rth+2)*(rth+3)*(rth+4)*(Lo^rth)))/EIyy);
    Zcontj = Zconti + DwDxConti*(x2L*Lo) - DwDxConti*(x1L*Lo) + (-1*(Myo*(((x2L*Lo)^2)/2) - My1*(((x2L*Lo)^2)/2) - Fz1*(((x2L*Lo)^3)/6) + Fz1*(x1L*Lo)*(((x2L*Lo)^2)/2) + Vzo*(((x2L*Lo)^3)/6) - pz0*(((x2L*Lo)^4)/24) - (pz2/(Lo^2))*(((x2L*Lo)^6)/360) - (pz4/(Lo^4))*(((x2L*Lo)^8)/1680) + (LF*rho*A*(((x2L*Lo)^4)/24)))/EIzz) - (-1*(Myo*(((x1L*Lo)^2)/2) - My1*(((x1L*Lo)^2)/2) - Fz1*(((x1L*Lo)^3)/6) + Fz1*(x1L*Lo)*(((x1L*Lo)^2)/2) + Vzo*(((x1L*Lo)^3/6)) - pz0*(((x1L*Lo)^4)/24) - (pz2/(Lo^2))*(((x1L*Lo)^6)/360) - (pz4/(Lo^4))*(((x1L*Lo)^8)/1680) + (LF*rho*A*(((x1L*Lo)^4)/24)))/EIzz);
    Disp_X(n) = (Fx1*(x1L*Lo))/(EA) + (Fx2*(x1L*Lo))/(EA) + (Fx2*(x2L*Lo))/(EA) - (Fx2*(x1L*Lo))/(EA);
    Disp_Y(n) = Ycontj + DvDxContj*x(n) - DvDxContj*(x2L*Lo) + ((Mzo*((x(n)^2)/2) - Mz1*((x(n)^2)/2)  - Mz2*((x(n)^2)/2) + Fy1*((x(n)^3)/6) - Fy1*(x1L*Lo)*((x(n)^2)/2) + Fy2*((x(n)^3)/6) - Fy2*(x2L*Lo)*((x(n)^2)/2) - (Vyo/2)*((x(n)^3)/3) + (py0/6)*((x(n)^4)/4) + pyr*(x(n)^(rth+4))/((rth+1)*(rth+2)*(rth+3)*(rth+4)*(Lo^rth)))/EIyy) - ((Mzo*(((x2L*Lo)^2)/2) - Mz1*(((x2L*Lo)^2)/2)  - Mz2*(((x2L*Lo)^2)/2) + Fy1*(((x2L*Lo)^3)/6) - Fy1*(x1L*Lo)*(((x2L*Lo)^2)/2) + Fy2*(((x2L*Lo)^3)/6) - Fy2*(x2L*Lo)*(((x2L*Lo)^2)/2) - (Vyo/2)*(((x2L*Lo)^3)/3) + (py0/6)*(((x2L*Lo)^4)/4) + pyr*((x2L*Lo)^(rth+4))/((rth+1)*(rth+2)*(rth+3)*(rth+4)*(Lo^rth)))/EIyy);
    Disp_Z(n) = Zcontj + DwDxContj*x(n) - DwDxContj*(x2L*Lo) + (-1*(Myo*((x(n)^2)/2) - My1*((x(n)^2)/2) - My2*((x(n)^2)/2) - Fz1*((x(n)^3)/6) + Fz1*(x1L*Lo)*((x(n)^2)/2) - Fz2*((x(n)^3)/6) + Fz2*(x2L*Lo)*((x(n)^2)/2) + Vzo*((x(n)^3)/6) - pz0*((x(n)^4)/24) - (pz2/(Lo^2))*((x(n)^6)/360) - (pz4/(Lo^4))*((x(n)^8)/1680) + (LF*rho*A*((x(n)^4)/24)))/EIzz) - (-1*(Myo*(((x2L*Lo)^2)/2) - My1*(((x2L*Lo)^2)/2) - My2*(((x2L*Lo)^2)/2) - Fz1*(((x2L*Lo)^3)/6) + Fz1*(x1L*Lo)*(((x2L*Lo)^2)/2) - Fz2*(((x2L*Lo)^3)/6) + Fz2*(x2L*Lo)*(((x2L*Lo)^2)/2) + Vzo*(((x2L*Lo)^3/6)) - pz0*(((x2L*Lo)^4)/24) - (pz2/(Lo^2))*(((x2L*Lo)^6)/360) - (pz4/(Lo^4))*(((x2L*Lo)^8)/1680) + (LF*rho*A*(((x2L*Lo)^4)/24)))/EIzz);
    end
end


% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#6): Pack Calculated Data into the "dataOut1" Array size: (36)
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (6) Pack the Calculated Data into Array: dataOut1')

     dataOut1(01) = EA;              % Axial   Stiffness (lb)
     dataOut1(02) = EIyy;            % Bending Stiffness (lb-in^2)   
     dataOut1(03) = EIzz;            % Bending Stiffness (lb-in^2)   
     dataOut1(04) = EIyz;            % Bending Stiffness (lb-in^2)   
     dataOut1(05) = GJ;              % Torsion Stiffness (lb-in^2)
     dataOut1(06) = Vxo;             % Root Internal Force - X Direction (lb)
     dataOut1(07) = Vyo;             % Root Internal Force - Y Direction (lb)
     dataOut1(08) = Vzo;             % Root Internal Force - Z Direction (lb)
     dataOut1(09) = Mxo;             % Root Internal Moment - about X Direction (lb-in)
     dataOut1(10) = Myo;             % Root Internal Moment - about Y Direction (lb-in)
     dataOut1(11) = Mzo;             % Root Internal Moment - about Z Direction (lb-in)
     dataOut1(12) = S_allow_T;       % Allowable Stress - Tension (Ksi)
     dataOut1(13) = S_allow_C;       % Allowable Stress - Compression (Ksi)
     dataOut1(14) = S_allow_S;       % Allowable Stress - Shear (Ksi)
     dataOut1(15) = Sxxo_A;          % Root Axial Stress - point A (Ksi)
     dataOut1(16) = Sxxo_B;          % Root Axial Stress - point B (Ksi)
     dataOut1(17) = Sxxo_C;          % Root Axial Stress - point C (Ksi)
     dataOut1(18) = Sxxo_D;          % Root Axial Stress - point D (Ksi)
     dataOut1(19) = Txyo_A;          % Root Shear Stress xy - point A (ksi)   
     dataOut1(20) = Txyo_B;          % Root Shear Stress xy - point B (ksi)
     dataOut1(21) = Txyo_C;          % Root Shear Stress xy - point C (ksi)
     dataOut1(22) = Txyo_D;          % Root Shear Stress xy - point D (ksi)
     dataOut1(23) = Txzo_A;          % Root Shear Stress xz - point A (ksi)
     dataOut1(24) = Txzo_B;          % Root Shear Stress xz - point B (ksi)
     dataOut1(25) = Txzo_C;          % Root Shear Stress xz - point C (ksi)
     dataOut1(26) = Txzo_D;          % Root Shear Stress xz - point D (ksi)
     dataOut1(27) = MS_A;            % Margin of Safety - point A
     dataOut1(28) = MS_B;            % Margin of Safety - point B
     dataOut1(29) = MS_C;            % Margin of Safety - point C
     dataOut1(30) = MS_D;            % Margin of Safety - point D
     dataOut1(31) = Disp_X(nplot);   % Tip Diplacement - Y Direction (inch)
     dataOut1(32) = Disp_Y(nplot);   % Tip Diplacement - Y Direction (inch)
     dataOut1(33) = Disp_Z(nplot);   % Tip Diplacement - Z Direction (inch)
     dataOut1(34) = Twist(nplot);    % Tip Twist (degree)
     dataOut1(35) = DvDx(nplot);     % Tip Bending Slope (dv/dx) (inch/inch)
     dataOut1(36) = DwDx(nplot);     % Tip Bending Slope (dw/dx) (inch/inch)

% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#7): Pack the plot data arrays into "dataOut2" 
% .                matrix size: (nplot,23)  
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (7) Pack the Calculated Plot Data into Array: dataOut2')

   for i = 1:nplot;
     dataOut2(i, 1) = x(i);          % x-location (inch)
     dataOut2(i, 2) = py(i);         % drag force (lb/in)
     dataOut2(i, 3) = pz(i);         % lift force (lb/in)
     dataOut2(i, 4) = mx(i);         % distributed torque (lb-in/in)
     dataOut2(i, 5) = Vx(i);         % Internal axial force - Vx (lb)
     dataOut2(i, 6) = Vy(i);         % Internal shear force - Vy (lb)
     dataOut2(i, 7) = Vz(i);         % Internal shear force - Vz (lb)
     dataOut2(i, 8) = Mx(i);         % Internal axial force - Mx (lb-in)
     dataOut2(i, 9) = My(i);         % Internal shear force - My (lb-in)
     dataOut2(i,10) = Mz(i);         % Internal shear force - Mz (lb-in)
     dataOut2(i,11) = Sxx_A(i);      % Axial Stress - Point A (Ksi)
     dataOut2(i,12) = Sxx_B(i);      % Axial Stress - Point B (Ksi)
     dataOut2(i,13) = Sxx_C(i);      % Axial Stress - Point C (Ksi)
     dataOut2(i,14) = Sxx_D(i);      % Axial Stress - Point D (Ksi)
     dataOut2(i,15) = Tau_A(i);      % Shear Stress - Point A (Ksi)
     dataOut2(i,16) = Tau_B(i);      % Shear Stress - Point B (Ksi)
     dataOut2(i,17) = Tau_C(i);      % Shear Stress - Point C (Ksi)
     dataOut2(i,18) = Tau_D(i);      % Shear Stress - Point D (Ksi)
     dataOut2(i,19) = Disp_X(i);     % Displacement - X Direction (inch)
     dataOut2(i,20) = Disp_Y(i);     % Displacement - Y Direction (inch)
     dataOut2(i,21) = Disp_Z(i);     % Displacement - Z Direction (inch)
     dataOut2(i,22) = Twist(i);      % Spar Twist (degree)
     dataOut2(i,23) = DvDx(i);       % Bending Slope (dv/dx) (inch/inch)
     dataOut2(i,24) = DwDx(i);       % Bending Slope (dw/dx) (inch/inch)
   
   end;
   
% end

%  End of Function: SE160A_1_sparAnalysis
%  ------------------------------------------------------------------------

