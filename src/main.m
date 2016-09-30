function [A eigenvalues] = getEigenvaluesForRSM(N, NZR, error, decomposition)
  A = getRSMMatrix(N, NZR);
  eigenvalues = calculateEigenvalues(A, error, getDecomposition(decomposition));
end

function decomposition = getDecomposition(decompositionNumber)
  decompositions = {
    @gramSchmidtQRDecomposition
    @modifiedGramSchmidtQRDecomposition
    @givensRotationQRDecomposition
  };
  decomposition = decompositions{decompositionNumber};
end

function [A eigen] = getEigenvalues(A,error,decomposition)
  eigenvalues = calculateEigenvalues(A, error, getDecomposition(decomposition));
end
