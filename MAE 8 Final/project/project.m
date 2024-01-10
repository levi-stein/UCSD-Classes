clear all;
close all;
clc;
format long;
name = 'Levi Stein';
id = 'A16791467';
hw_num = 'project';
%% Load parameters
load('field.mat');
load('goal.mat');
%% Task 1
cs = 'krbgcmy'; 
defender_color = 'bgmcr';
i = 1;
% Find first 7 trajectories
for kID = 1:7
   [X0,Y0,Z0,Umag0,theta,phi,omgX,omgY,omgZ] = read_input('SteinLevi_input_parameter.txt',kID);
   [T{kID},X{kID},Y{kID},Z{kID},U{kID},V{kID},W{kID}] = soccer(X0,Y0,Z0,Umag0,theta,phi,omgX,omgY,omgZ);
end
figure('unit','in','position',[1 2 14 5]); hold on;
% Plot first 7 trajectories
for kID = 1:7
   plot3(X{kID},Y{kID},Z{kID},cs(i),'LineWidth',1);
   legend_string1{i} = sprintf('Kick ID #%d',i);
   plot3(X{kID}(end),Y{kID}(end),Z{kID}(end),[cs(i) 'o'],'MarkerFaceColor',cs(i))
   i = i + 1;
end
% Plot layout
T1_all_vec = [T{1} T{2} T{3} T{4} T{5} T{6} T{7}];
plot3(field.X,field.Y,field.Z,'go','MarkerSize',2); % plot field
plot3(goal.Xpost,goal.Ypost,goal.Zpost,'k-','LineWidth',3); % plot goal post
plot3(goal.Xnet,goal.Ynet,goal.Znet,'co','MarkerSize',2); % plot goal net
% Render defenders' surface
for nd = 1:5
    [Dx,Dy,Dz] = defender(nd,max(T1_all_vec));
    surf(Dx,Dy,Dz,'FaceColor',defender_color(nd), 'EdgeColor','none'); 
end
% Plot specifics
xlabel('x (m)');ylabel('y (m)');zlabel('z (m)');title('Magnus Effect Due to Varying omgZ')
box on; grid on;
legend(legend_string1{1},'',legend_string1{2},'',legend_string1{3}...
    ,'',legend_string1{4},'',legend_string1{5},'',legend_string1{6}...
    , '',legend_string1{7});
view(3); hold off;

%% Task 2A
% Find kicks 8-13
for kID = 8:13
   [X0,Y0,Z0,Umag0,theta,phi,omgX,omgY,omgZ] = read_input('SteinLevi_input_parameter.txt',kID);
   [T{kID},X{kID},Y{kID},Z{kID},U{kID},V{kID},W{kID}] = soccer(X0,Y0,Z0,Umag0,theta,phi,omgX,omgY,omgZ);
end
figure('unit','in','position',[1 2 14 5]); hold on;
% Plot kicks 8-13
i = 1;
for kID = 8:13
   plot3(X{kID},Y{kID},Z{kID},cs(i),'LineWidth',1);
   legend_string2{i} = sprintf('Kick ID #%d',i+7);
   plot3(X{kID}(end),Y{kID}(end),Z{kID}(end),[cs(i) 'o'],'MarkerFaceColor',cs(i))
   i = i + 1;
end
% Plot layout
T2_all_vec = [T{8} T{9} T{10} T{11} T{12} T{13}];
plot3(field.X,field.Y,field.Z,'go','MarkerSize',2); % plot field
plot3(goal.Xpost,goal.Ypost,goal.Zpost,'k-','LineWidth',3); % plot goal post
plot3(goal.Xnet,goal.Ynet,goal.Znet,'co','MarkerSize',2); % plot goal net
% Render defenders' surface
for nd = 1:5
    [Dx,Dy,Dz] = defender(nd,max(T{9}));
    surf(Dx,Dy,Dz,'FaceColor',defender_color(nd), 'EdgeColor','none'); 
end
% Plot specifics
xlabel('x (m)');ylabel('y (m)');zlabel('z (m)');title('Geometry Effect on Final Position')
box on; grid on;
legend(legend_string2{1},'',legend_string2{2},'',legend_string2{3}...
    ,'',legend_string2{4},'',legend_string2{5},'',legend_string2{6});
view(3); hold off;
%% Task 2B
for kID = 8:13
    PE{kID-7} = 0.4*9.81*Z{kID};
    KE{kID-7} = 0.5*0.4*(U{kID}.^2+V{kID}.^2+W{kID}.^2);
end
figure;
for kID = 8:13
    subplot(2,3,kID-7); hold on;
    plot(T{kID},PE{kID-7},'-k')
    plot(T{kID},KE{kID-7},'--r')
    legend('PE','KE');
    xlabel('Time (s)');ylabel('Energy (J)');
    title(sprintf('Kick #%d',kID));
    box on; grid on;
end
%% Task 2C
% Create cell array for kicks 14-100
for kID = 14:100
    [X0,Y0,Z0,Umag0,theta,phi,omgX,omgY,omgZ] = read_input('SteinLevi_input_parameter.txt',kID);
    [T{kID},X{kID},Y{kID},Z{kID},U{kID},V{kID},W{kID}] = soccer(X0,Y0,Z0,Umag0,theta,phi,omgX,omgY,omgZ);
end

% Create sim_res
for kID = 8:13
    sim_res(kID-7).kick_ID = kID;
    sim_res(kID-7).final_time = max(T{kID});
    ind = find(Z{kID} == max(Z{kID}));
    sim_res(kID-7).max_height_location = [X{kID}(ind) Y{kID}(ind) Z{kID}(ind)];
    sim_res(kID-7).final_location = [X{kID}(end) Y{kID}(end) Z{kID}(end)];
    sim_res(kID-7).travel_distance = sum(sqrt(diff(X{kID}).^2 + diff(Y{kID}).^2 + diff(Z{kID}).^2));
end
%% Task 2D
fid = fopen('report.txt','w');
fprintf(fid,'Levi Stein \nA16791467\nkick_ID, final_time (s), travel_distance (m)');
for kID = 8:13
    fprintf(fid,'\n%d   \t %15.9e \t %15.9e',kID,sim_res(kID-7).final_time,sim_res(kID-7).travel_distance);
end
fclose(fid);
%% Task 3
for kID = 14:100
    if Y{kID}(end) > max(field.Y) && X{kID}(end) > min(goal.Xpost) && X{kID}(end) < max(goal.Xpost) && Z{kID}(end) < max(goal.Zpost)
        GOAL = kID;
    end
end
clc;
figure('unit','in','position',[1 2 14 5]); hold on;
plot3(X{GOAL},Y{GOAL},Z{GOAL},'-k','LineWidth',1);
plot3(X{GOAL}(end),Y{GOAL}(end),Z{GOAL}(end),'ok','MarkerFaceColor','k');
plot3(field.X,field.Y,field.Z,'go','MarkerSize',2); % plot field
plot3(goal.Xpost,goal.Ypost,goal.Zpost,'k-','LineWidth',3); % plot goal post
plot3(goal.Xnet,goal.Ynet,goal.Znet,'co','MarkerSize',2); % plot goal net
for nd = 1:5
    [Dx,Dy,Dz] = defender(nd,max(T{GOAL}));
    surf(Dx,Dy,Dz,'FaceColor',defender_color(nd), 'EdgeColor','none'); 
end
xlabel('x (m)');ylabel('y (m)');zlabel('z (m)');title('KICK 34')
box on; grid on;
view(3); hold off;
%% Task IV: Submission
p1a = evalc('help read_input');
p1b = evalc('help soccer');
p1c = 'See figure 1';
p2a = 'See figure 2';
p2b = 'See figure 3';
p2c = sim_res(1);
p2d = sim_res(2);
p2e = sim_res(3);
p2f = sim_res(4);
p2g = sim_res(5);
p2h = sim_res(6);
p2i = evalc('type report.txt');
p3a = 'See figure 4';
