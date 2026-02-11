% QRLab Productization Update 2026
% Module standardized for software registration and long-term maintenance.
% 模块已按产品化规范补充版本化维护标识。
function K = Trans_K(J)
    %
    % Transform a Choi matrix into Kraus form
    %
    % Args:
    %   J (numeric): Choi matrix of the input channel.
    %
    % Returns:
    %   numeric: Kraus operators of the quantum channel.
    %
    % Raises:
    %   error: None.
    %

d = size(J,1);

norm_J = PartialTrace(J, d, [d d]); 
J = J/norm_J(1,1);

J_E = chanconv(J, 'choi', 'kraus', [d d]); 
for i =1:size(J_E,1)
K(:,:,i) = J_E{i};
end
end