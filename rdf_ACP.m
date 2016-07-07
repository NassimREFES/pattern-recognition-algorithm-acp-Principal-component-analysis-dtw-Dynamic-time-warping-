% REFES NASSIM
% OULD MILOUD MOHAMED


clear all ; clc;
A=[8 1 0 ; 4 6 5 ; 6 8 7; 10 4 7 ;8 2 5; 0 3 6];

homo=input('(homogene=1, heterogene=2)>'); % est homogene

% centrer le tableau
g=zeros(3,1);
for i=1:size(A,2)
	g(i)= sum(A(:,i)) / size(A,1)  ;	
end

% X=X-g

X=[];
for i=1:size(A,2)
	for j=1:size(A,1)
		X(j,i)=A(j,i)-g(i);
	end
end

% calcule de la matrice variance covariance
% V = 1/N * X^T * X

X
V=(1/size(A,1) )*( transpose(X)*X ) ;

% determiner la metrique [homogene || heterogene]

M=[];
if (homo)
    M=eye(size(A,2) ,size(A,2));
else
    M = zeros(size(V,1), size(V,1));
    for i=1:size(V,1)
            M(i,i)=1/V(i,i);
    end
end

% recherche des axes principaux
% - calcule des valeurs propres

M
syms Y
YI = Y*eye(3,3);
VM = V*M;
S  = VM-YI;
% polynome caracteristique
eq = det(S);

eq

% solutions de Y
solutions = solve(eq);

% trier les valeurs propres par ordre decroissant
solutions = sort(solutions);
solutions = flipud(solutions);
solutions

% calcule de la qualite de representation
Q=[];
YP=[];

for i=1:size(solutions,1)
    Q(i) = sum(solutions(1:i))/sum(solutions);
    YP(i) = solutions(i);
    if(Q(i) >= 0.8)
        break;
    end
end

Q
YP

% calcule des vecteurs propres Uk
% VM*Uk = YP*Uk

syms x y z
Uk = [x; y; z];
Ck = [];

for i=1:size(YP, 2)
    VMUk = VM*Uk
    YiUk = YP(i)*Uk
    res = VMUk - YiUk;
    sol = solve(res(1), res(2), res(3));
    
    sol_coeffs = [coeffs(sol.x); coeffs(sol.y); coeffs(sol.z)];
    Un = (1 / sqrt(sum(sol_coeffs(:, 1).^2))) * sol_coeffs; 
    
    Ck(:,i) = X * Un;
end

Ck

% representation graphique
% size(YP, 2) : nombre des axes

if size(YP, 2) == 1
    plot(Ck(:, 1), '*')
elseif size(YP, 2) == 2
    plot(Ck(:, 1), Ck(:, 2), '*')
elseif size(YP, 2) == 3
    plot(Ck(:, 1), Ck(:, 2), Ck(:, 3), '*') 
else
    printf('n est pas gerable') 
end

