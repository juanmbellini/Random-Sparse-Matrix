function [A eigenvalues] = getEigenvaluesForRSM(N, NZR, error, decomposition)
  A = getRSMMatrix(N, NZR);
  eigenvalues = calculateEigenvalues(A, error, getDecomposition(decomposition));
end

function decomposition = getDecomposition(decompositionNumber)
  decompositions = {
    @gramSchmidtQRDecomposition
    @modifiedGramSchmidtQRDecomposition
  };
  decomposition = decompositions{decompositionNumber};
end
