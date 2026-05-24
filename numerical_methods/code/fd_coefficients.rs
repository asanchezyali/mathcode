/// Cálculo de coeficientes de diferencias finitas mediante el sistema de Vandermonde.
///
/// Entrada: orden de derivada k, punto de evaluación x0, plantilla z
/// Salida:  coeficientes c tales que c·u ≈ u^(k)(x0)
///
/// Referencia: R.J. LeVeque, Finite Difference Methods for ODEs and PDEs, §1.5
///
/// Compilar: rustc -O -o fd_coefficients fd_coefficients.rs

fn factorial(n: usize) -> f64 {
    (1..=n).fold(1.0, |acc, i| acc * i as f64)
}

fn fd_coefficients(k: usize, x0: f64, z: &[f64]) -> Vec<f64> {
    let n = z.len();
    assert!(k < n, "Se requieren al menos k+1 puntos en la plantilla");

    // Construir la matriz de Vandermonde escalada
    let mut a = vec![0.0; n * n];
    let mut b = vec![0.0; n];
    b[k] = 1.0;

    for (j, &zj) in z.iter().enumerate() {
        let delta = zj - x0;
        let mut power = 1.0;
        for row in 0..n {
            a[row * n + j] = power / factorial(row);
            power *= delta;
        }
    }

    // Eliminación gaussiana con pivoteo parcial
    for col in 0..n {
        let pivot = (col..n)
            .max_by(|&r1, &r2| {
                a[r1 * n + col]
                    .abs()
                    .partial_cmp(&a[r2 * n + col].abs())
                    .unwrap()
            })
            .unwrap();

        if pivot != col {
            for j in 0..n {
                a.swap(col * n + j, pivot * n + j);
            }
            b.swap(col, pivot);
        }

        for row in (col + 1)..n {
            let f = a[row * n + col] / a[col * n + col];
            for j in col..n {
                a[row * n + j] -= f * a[col * n + j];
            }
            b[row] -= f * b[col];
        }
    }

    // Sustitución hacia atrás
    let mut c = vec![0.0; n];
    for i in (0..n).rev() {
        let sum: f64 = ((i + 1)..n).map(|j| a[i * n + j] * c[j]).sum();
        c[i] = (b[i] - sum) / a[i * n + i];
    }

    c
}

fn main() {
    println!("=================================================================");
    println!("Coeficientes de diferencias finitas (sistema de Vandermonde)");
    println!("=================================================================");

    let h: f64 = 1.0;

    // Ejemplo 1
    let z = vec![0.0, h];
    let c = fd_coefficients(1, 0.0, &z);
    println!("\n1) Diferencia progresiva (k=1, n=2)");
    println!("   Coeficientes: {:?}", c);

    // Ejemplo 2
    let z = vec![-h, 0.0, h];
    let c = fd_coefficients(1, 0.0, &z);
    println!("\n2) Diferencia centrada (k=1, n=3)");
    println!("   Coeficientes: {:?}", c);

    // Ejemplo 3
    let c = fd_coefficients(2, 0.0, &z);
    println!("\n3) Segunda derivada centrada (k=2, n=3)");
    println!("   Coeficientes: {:?}", c);

    // Ejemplo 4
    let z = vec![-2.0 * h, -h, 0.0, h, 2.0 * h];
    let c = fd_coefficients(3, 0.0, &z);
    println!("\n4) Tercera derivada centrada (k=3, n=5)");
    println!("   Coeficientes: {:?}", c);

    // Ejemplo 5
    let c = fd_coefficients(4, 0.0, &z);
    println!("\n5) Cuarta derivada centrada (k=4, n=5)");
    println!("   Coeficientes: {:?}", c);

    // Verificación: u(x) = cos(x), u''(0) = -1
    println!("\n=================================================================");
    println!("Verificación: u(x) = cos(x), u''(0) = -1");
    println!("=================================================================");
    for &n_pts in &[10, 100, 1000] {
        let hv = 1.0 / n_pts as f64;
        let zv = vec![-hv, 0.0, hv];
        let cv = fd_coefficients(2, 0.0, &zv);
        let approx: f64 = cv.iter().zip(zv.iter()).map(|(&ci, &zi)| ci * zi.cos()).sum();
        let error = (approx - (-1.0)).abs();
        println!(
            "   h = {:.0e}:  aprox = {:.10},  error = {:.6e}",
            hv, approx, error
        );
    }
}
