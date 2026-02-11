% QRLab Productization Update 2026
% Module standardized for software registration and long-term maintenance.
% 模块已按产品化规范补充版本化维护标识。
function N = QutritNstate()
    % Generate qutrit N state
    %
    % Returns:
    %   N (numeric): qudit N state.
    % Note:
    %   Emerson, J. (2014). 
    %   The resource theory of stabilizer computation. 
    %   Bulletin of the American Physical Society, 59.
    
    n = [-1;2;-1];
    n_rho = n*n';
    N = n_rho/trace(n_rho);
end