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
