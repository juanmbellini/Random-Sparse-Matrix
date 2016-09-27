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
