function eigenvalues = calculateEigenvalues(A, error, decomposition)
  eigenvalues = [];
  n = columns(A);
  current = 0;
  do
    previousA = A;
    [Q R] = decomposition(A);
    A = R * Q;
    if (condition(error, A(n - current, n - current - 1), A(n - current - 1, n - current - 1), A(n - current, n - current)))
      eigenvalues(n - current, 1) = A(n - current, n - current);
      A = A(1:n - current - 1, 1:n - current - 1);
      current++;
    elseif (condition(error, A(n - current -1, n - current - 2), A(n - current - 1, n - current - 1), A(n - current - 2, n - current - 2)))
      [r1 r2] = getValues(A, n, current);
      eigenvalues(n - current - 1, 1) = r1;
      eigenvalues(n - current, 1) = r2;
      A = A(1:n - current - 2, 1:n - current - 2);
      current += 2;
    end
  until (current >= n - 2)

  if (current == n - 2)
    [r1 r2] = getValues(A, n, current);
    eigenvalues(n - current - 1, 1) = r1;
    eigenvalues(n - current, 1) = r2;
    A = A(1:n - current - 2, 1:n - current - 2);
  elseif (current == n - 1)
    eigenvalues(1) = A(1, 1);
  end
end

function bool = condition(error, value1, value2, value3)
  bool = abs(value1) < (error * (abs(value2) + abs(value3)));
end

function [r1 r2] = getValues(A, n, current)
  w = A(n - current - 1, n - current - 1);
  x = A(n - current - 1, n - current);
  y = A(n - current, n - current - 1);
  z = A(n - current, n - current);
  rootValues = roots([1 -(w+z) (w*z)-(x*y)]);
  r1 = rootValues(1);
  r2 = rootValues(2);
end
