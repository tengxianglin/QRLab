% QRLab Productization Update 2026
% Module standardized for software registration and long-term maintenance.
% 模块已按产品化规范补充版本化维护标识。
function T = QubitTstate()
    % Generate qubit T state
    %
    % Returns:
    %   T (numeric): qubit T state.
    % Note:
    %   Emerson, J. (2014). 
    %   The resource theory of stabilizer computation. 
    %   Bulletin of the American Physical Society, 59.
    
    t = 1/sqrt(2)*[1;exp(1i*pi/4)];
    T = t * t';
end