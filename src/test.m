function times = test(test_sizes,NZR,error, repetitions)
  times = zeros(length(test_sizes),3);
  for n = test_sizes
    printf('n: %d\n', n);
    fflush(stdout);
    nzr = ceil(n*NZR)
    for rep = 1:repetitions
      printf('rep: %d\n', rep);
      fflush(stdout);
      A = getRSMMatrix(n, ceil(n*NZR));
      index = n-(test_sizes(1)) + 1;
      times(index,1) = n;
      for decomp = 2 : 3
        tic
        getEigenvalues(A,error,decomp);
        times(index,decomp) += toc;
      end
    end
  end
  times(:, 2:end) = times(:, 2:end) ./ repetitions;
  plotTimes(times);
end

function plotTimes(times)
  plot(times(:,1),times(:,2), 'linewidth', 3, times(:,1),times(:,3), 'linewidth', 3);
  set(gca, 'linewidth', 2, 'fontsize', 12);
  title('Benchmark de descomposiciones para el cálculo de autovalores');
  xlabel('Tamaño de la matriz (NxN)');
  ylabel('Tiempo (s)');
end
