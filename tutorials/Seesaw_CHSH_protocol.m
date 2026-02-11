% QRLab Productization Update 2026
% Module standardized for software registration and long-term maintenance.
% 模块已按产品化规范补充版本化维护标识。
clear;

C = zeros(2,2,2,2);
for a = 1:2
    for b = 1:2
        for x = 1:2
            for y = 1:2
                C(a,b,x,y) = ((a-1)+(b-1)+(x-1)*(y-1));
            end
        end
    end
end

dA = 2; dB = 2;
rhoAB = MaxEntangled(dA, 0, 1) * MaxEntangled(dA, 0, 1)';

[rhoAB, A, B] = OptCHSHgame(C, [dA, dB]);

