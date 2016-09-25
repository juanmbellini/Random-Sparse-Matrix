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
	A = zeros(N); 	% A holds the future NZR Matrix
	for columnIndex = 1 : N
		for i = 1 : NZR
			do
				rowIndex = ceil(rand() * N);		% Gets a random row to assign a number to it
			until (A(rowIndex, columnIndex) == 0)	% Repeat if the given row already holds a number
			do 
				A(rowIndex, columnIndex) = rand() * 2 - 1; 		% Gets a random number between -1 and 1
			until (A(rowIndex, columnIndex) != 0)				% Checks if the given number is zero;
		end
	end
	RSMMatrix = A;
end




function [Q R] = classicalQRDecomposition(matrix)
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


function [Q R] = modifiedQRDecomposition(matrix)
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




% Arnoldi iteration


function debug(string) 
	printf(string);
	fflush(stdout);
end
