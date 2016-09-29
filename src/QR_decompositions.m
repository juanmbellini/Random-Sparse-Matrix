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

function [Q R] = givensRotationQRDecomposition(A)
  m = rows(A);
  Q = eye(m);
  R = A;

  for j = 1:m
    for i = m:-1:(j+1)
      G = eye(m);
      [c, s] = givensrotation(R(i-1, j), R(i, j));
      G([i - 1, i], [i - 1, i]) = [c -s; s c];
      R = G' * R;
      Q = Q * G;
    end
  end
end

function [c s] = givensrotation(a, b)
  if (b == 0)
  c = 1;
  s = 0;
  else
    if (abs(b) > abs(a))
      r = a / b;
      s = 1 / sqrt(1 + r**2);
      c = s * r;
    else
      r = b / a;
      c = 1 / sqrt(1 + r**2);
      s = c * r;
    end
  end
end
