function [X0,Y0,Z0,Umag0,theta,phi,omgX,omgY,omgZ] = read_input(input_filename,kick_id)
%READ_INPUT Takes two inputs, the desired filename and kick_id. Returns
%inital conditions X0,Y0,Z0,Umag0,theta,phi,omgX,omgY,omgZ corresponding to
%the file parameters and kick_id.
%Call Format: [X0,Y0,Z0,Umag0,theta,phi,omgX,omgY,omgZ] = read_input(input_filename,kick_id)
 param = importdata(input_filename,' ',5);
if any(kick_id == param.data(:,1))
    X0 = param.data(kick_id,2);
    Y0 = param.data(kick_id,3);
    Z0 = param.data(kick_id,4);
    Umag0 = param.data(kick_id,5);
    theta = param.data(kick_id,6);
    phi = param.data(kick_id,7);
    omgX = param.data(kick_id,8);
    omgY = param.data(kick_id,9);
    omgZ = param.data(kick_id,10);
else
    disp('Error: Invalid value for kick_id')
    X0 = NaN;
    Y0 = NaN;
    Z0 = NaN;
    Umag0 = NaN;
    theta = NaN;
    phi = NaN;
    omgX = NaN;
    omgY = NaN;
    omgZ = NaN;
end
end % function