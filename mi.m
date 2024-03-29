function I=mi(A,B,varargin) 

if nargin>=3
    L=varargin{1};
else
    L=256;
end

A=double(A); 
B=double(B); 
     
na = hist(A(:),L); 
na = na/sum(na);

nb = hist(B(:),L); 
nb = nb/sum(nb);

n2 = hist2(A,B,L); 
n2 = n2/sum(n2(:));

I=sum(minf(n2,na'*nb)); 

% -----------------------

function y=minf(pab,papb)

I=find(papb(:)>1e-12 & pab(:)>1e-12); % function support 
y=pab(I).*log2(pab(I)./papb(I));
