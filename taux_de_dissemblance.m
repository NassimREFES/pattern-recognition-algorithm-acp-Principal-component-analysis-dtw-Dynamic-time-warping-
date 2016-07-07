function TD = taux_de_dissemblance( T, R )
    [rx ry] = size(R);
    [tx ty] = size(T);

    if rx ~= tx % n != m
        printf('pas possible d utiliser cette methode');
    else
    
    % -----------------------------------------------
    % taux de dissemblance
    % -----------------------------------------------
    
        D = zeros(ry, ty);
        D(1, 1) = dist_hammin(R(:, 1), T(:, 1));
        for i = 1 : ry
            for j = 2 : ty
                   D(i, j) = dist_hammin(R(:, i), T(:, j));
            end
        end

        flipud(D) 

        D(1, 1) = 2*D(1, 1); % Dpp(1, 1) = 2 * D(1, 1)
        D(2:ry, 1) = Inf;    % Dpp(1,j)=? ? pour j=2 � J

        for i = 1 : ry
            for j = 2 : ty
                if i == 1
                    D(i, j) = D(i, j-1)+D(i, j);
                else
                    a = D(i, j-1)+D(i, j);
                    b = D(i-1, j-1)+2*D(i, j);
                    c = D(i-1, j)+D(i, j);

                    D(i, j) = min(a, min(b, c));
                end

            end
        end   

        TD = D(ry, ty)/(ry+ty);
        
        D=flipud(D)
        
        % -----------------------------------------------
        % chemin de recalage
        % -----------------------------------------------
        
        count_res = 1;
        res = [];
        szD = size(D)
        comp = D(1, szD(2));
        res(count_res,:) = [1 , szD(2)];
        count_res = count_res + 1;
        
        i = 1;
        j = szD(2);
        
        while 1
            if i == szD(1) && j == 1
                break;
            end
            
            v = [i+1, j-1; i, j-1; i+1, j];
            
            if i+1 > szD(1)
                vv = D(i, j-1);
            else
                vv = [D(i+1, j-1); D(i, j-1); D(i+1, j)];
            end
            
            if size(vv, 1) == 1
                comp = vv(1);
                res(count_res, :) = v(2, :);
                count_res = count_res + 1;
                j = j - 1;
            else
                comp = min(vv(1), min(vv(2), vv(3)));

                for k = 1 : size(vv, 1)
                   if comp == vv(k)
                       res(count_res, :) = v(k, :);
                       count_res = count_res + 1;

                           if k == 1
                               i = i + 1;
                               j = j - 1;
                           elseif k == 2
                               j = j - 1;
                           elseif k == 3
                               i = i + 1;
                           end
                     end
                     break;
                  end
               end
        end
        chemin = flipud(res)
    end
end

