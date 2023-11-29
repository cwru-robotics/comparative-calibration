function bar_h = Cbar3(Z,C,b,y)
% Z - The data
% C - CData (if other then Z values)
% b - Minimum absolute value to keep colored
% y - y-axis values to order the data by

if nargin<2, C = Z; end
if nargin<3 || isempty(b), b = 0; end
Z(abs(Z)<b) = nan;
C(isnan(Z)) = nan;
if nargin<4 
    bar_h = bar3(Z);
else
    bar_h = bar3(y,Z);
end
cdata_sz = size(bar_h(1).CData);
z_color = repelem(C,6,4);
z_color = mat2cell(z_color,...
    cdata_sz(1),ones(1,size(Z,2))*cdata_sz(2));
set(bar_h,{'CData'},z_color.')
end
