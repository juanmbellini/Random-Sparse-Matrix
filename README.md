## Random Sparse Matrix - MVMRAN or MATRAN

#### Uso

Lo primero que se debe hacer es incluir todos los archivos al workspace de octave.

Luego llamar a la función `getEigenvaluesForRSM` que recibe los siguientes parámetros:

`[A eigenvalues] = getEigenvaluesForRSM(N, NZR, error, decomposition)`

- N: dimensión NxN de la matriz
- NZR: valores distintos a zero de las columnas de la matriz a generar
- error: delta error al calcular los autovalores
- decomposition: método de decomposición a utilizar (1: Gram-Schmidt, 2: Gram-Schmidt modificado)

La función retorna la matríz utilizada y en `A` y los autovalores en `eigenvalues`.

#### Ejemplos de uso

`[A eigenvalues] = getEigenvaluesForRSM(10, 2, 0.0001, 2)`
