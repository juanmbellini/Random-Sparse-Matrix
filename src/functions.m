function RSMMatrix = getRSMMatrix(N, NZR)
	if (floor(N) != N)
		printf('Dimension N must be integer\n');
		return;
	end
	if (floor(NZR) != NZR)
		printf('NZR value must be integer\n');
		return;
	end
	if (N <= 0)
		printf('Dimension N must be greater than 0\n');
		return;
	end
	if (NZR < 0)
		printf('NZR value must be at least 0\n');
		return;
	end
	if N < NZR
		printf('Dimension N cannot be less than NZR value\n');
		return;
	end
	RSMMatrix = generateRSM(N, NZR);
end

% N can be between 46300 and 46400
function RSMMatrix = generateRSM(N, NZR)
	A = zeros(N);  % A holds the future NZR Matrix
	for columnIndex = 1 : N
		for i = 1 : NZR
			do
				rowIndex = ceil(rand() * N);		    % Gets a random row to assign a number to it
			until (A(rowIndex, columnIndex) == 0)	% Repeat if the given row already holds a number
			do
				A(rowIndex, columnIndex) = rand() * 2 - 1;  % Gets a random number between -1 and 1
			until (A(rowIndex, columnIndex) != 0)				  % Checks if the given number is zero;
		end
	end
	RSMMatrix = A;
end

function [Q R] = gramSchmidtQRDecomposition(matrix)
	Q = matrix;
	for i = 1 : columns(matrix)
		for j = 1 : (i - 1)
			scalarProduct = matrix(:, i)' * Q(:, j);
			Q(:, i) -= scalarProduct * Q(:, j);
		end
		Q(:, i) /= norm(Q(:, i));
	end
	R = Q' * matrix;
end

function [Q R] = modifiedGramSchmidtQRDecomposition(matrix)
	Q = matrix;
	cols = columns(matrix);
	for i = 1 : cols
		R(i, i) = norm(matrix(:, i));
		Q(:, i) = matrix(:, i) / R(i, i);
		for j = i + 1 : cols
			R(i, j) =  matrix(:, j)' * Q(:, i);
			matrix(:, j) -=  R(i, j) * Q(:, i);
		end
	end
end

function eigenvalues = calculateEigenvalues(A, error)
  eigenvalues = [];
  n = columns(A);
  current = 0;
  do
    previousA = A;
    [Q R] = modifiedGramSchmidtQRDecomposition(A);
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
