/// Método de diferencias finitas para el problema vibratorio:
///     u'' + ω²u = 0,  u(0) = u₀,  u'(0) = 0,  t ∈ (0, T]
///
/// Solución exacta: u(t) = u₀ cos(ωt)
///
/// Compilar: rustc -o finite_differences_vibration finite_differences_vibration.rs
/// Ejecutar: ./finite_differences_vibration

fn finite_differences_vibration(u0: f64, omega: f64, t_final: f64, n: usize) -> Vec<f64> {
    let dt = t_final / n as f64;
    let mut u = vec![0.0; n + 1];

    u[0] = u0;
    u[1] = u0 - 0.5 * omega * omega * dt * dt * u0;

    for i in 1..n {
        u[i + 1] = 2.0 * u[i] - u[i - 1] - omega * omega * dt * dt * u[i];
    }

    u
}

fn main() {
    let u0: f64 = 1.0;
    let omega: f64 = 2.0 * std::f64::consts::PI;
    let t_final: f64 = 5.0;
    let n: usize = 500;

    let u = finite_differences_vibration(u0, omega, t_final, n);

    let dt = t_final / n as f64;
    let max_error = (0..=n)
        .map(|i| {
            let t_n = i as f64 * dt;
            let u_exact = u0 * (omega * t_n).cos();
            (u[i] - u_exact).abs()
        })
        .fold(0.0_f64, f64::max);

    println!(
        "Parámetros: u0={:.1}, ω={:.4}, T={:.1}, N={}",
        u0, omega, t_final, n
    );
    println!("Error máximo: {:.6e}", max_error);

    println!(
        "\n{:>10} {:>15} {:>15} {:>15}",
        "t", "numérica", "exacta", "error"
    );
    println!("{}", "-".repeat(60));
    for i in (0..=n).step_by(n / 10) {
        let t_n = i as f64 * dt;
        let u_exact = u0 * (omega * t_n).cos();
        println!(
            "{:10.4} {:15.8} {:15.8} {:15.2e}",
            t_n,
            u[i],
            u_exact,
            (u[i] - u_exact).abs()
        );
    }
}
