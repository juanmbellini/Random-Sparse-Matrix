function plotTimes(times)
  plot(times(:,1),times(:,2), 'linewidth', 3, times(:,1),times(:,3), 'linewidth', 3);
  set(gca, 'linewidth', 2, 'fontsize', 12);
  title('Benchmark de descomposiciones para el cálculo de autovalores');
  xlabel('Tamaño de la matriz (NxN)');
  ylabel('Tiempo (s)');
  [legh,objh,outh,outm] = legend({"Modified Gram Schmidt","Givens Rotations"});
  set(objh,'linewidth',2);
end
