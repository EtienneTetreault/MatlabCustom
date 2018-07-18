%solveur qui optimise les termes d'une fonction (ici une quadratique) pour réduire l'erreur carrée (curve fitting)
xReal = [1 2 3];
yReal = [1.1 4.5 8.7];

yCalc = @(p) p(1)*xReal.^2+p(2)
objectiveFunc = @(p) sum((yReal - yCalc(p)).^2);
p0 = [1, 0.04];  % It pays to have a realistic initial guess
p = fminsearch( objectiveFunc, p0 );