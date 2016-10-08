function soln_str = parParse(soln_str,excId)
%changeCobraSolver('gurobi5','milp')
if isfield(soln_str,'points')
    if soln_str.points(840,1) > 0.124 && soln_str.points(840,1) < 0.203
    [m,n] = size(soln_str.points);
    model = soln_str;
    model = clearFermParams(model);
    newpoints = zeros(m,n);
    for j = 1:n
        fluxes = soln_str.points(excId, j);
        idx = [];
        for k = 1:length(fluxes)
            if fluxes(k) < 1e-4
                idx = [idx k];
            end
        end
        for f = 1:length(fluxes)
            if any(idx==f)
                continue
            elseif fluxes(f) < 0
                model = setParam(model,'ub',excId(f),fluxes(f)*0.95);
                model = setParam(model,'lb',excId(f),fluxes(f));
            else
                model = setParam(model,'lb',excId(f),fluxes(f)*0.95);
                model = setParam(model,'ub',excId(f),fluxes(f));
            end
        end
        %soln = optimizeCbModel(model,'max',0,0);
        soln = solveLP(model,1);
        try
            newpoints(:,j) = soln.x;
        catch
            fprintf('Infeasible problem from set %i distribution %i\n',i,j)
        end
    end
    soln_str.newpoints = newpoints;
    end
end

end