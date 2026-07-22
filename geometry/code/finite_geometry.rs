/// Verificación computacional de los axiomas de un plano proyectivo finito.
///
///     (P1) Dos puntos distintos determinan exactamente una recta.
///     (P2) Dos rectas distintas se cortan en exactamente un punto.
///     (P3) Existen cuatro puntos tales que ningún trío es colineal.
///
/// El ejemplo canónico es el plano de Fano, PG(2,2): el plano proyectivo más
/// pequeño, con siete puntos y siete rectas.
///
/// Compilar: rustc -O -o finite_geometry finite_geometry.rs
/// Ejecutar: ./finite_geometry
use std::collections::BTreeSet;

type Point = u32;
type Line = BTreeSet<Point>;

/// Verifica si una estructura de incidencia satisface los axiomas de un
/// plano proyectivo. Devuelve el veredicto junto con su justificación.
fn is_projective_plane(points: &BTreeSet<Point>, lines: &[Line]) -> (bool, String) {
    let all: Vec<Point> = points.iter().copied().collect();

    // (P1) Cada par de puntos está en exactamente una recta
    for i in 0..all.len() {
        for j in (i + 1)..all.len() {
            let (a, b) = (all[i], all[j]);
            let incident = lines
                .iter()
                .filter(|line| line.contains(&a) && line.contains(&b))
                .count();

            if incident != 1 {
                return (
                    false,
                    format!("P1 falla: los puntos {},{} están en {} rectas", a, b, incident),
                );
            }
        }
    }

    // (P2) Cada par de rectas se corta en exactamente un punto
    for i in 0..lines.len() {
        for j in (i + 1)..lines.len() {
            let meet = lines[i].intersection(&lines[j]).count();
            if meet != 1 {
                return (
                    false,
                    format!(
                        "P2 falla: las rectas {},{} se cortan en {} puntos",
                        i + 1,
                        j + 1,
                        meet
                    ),
                );
            }
        }
    }

    // (P3) Existen cuatro puntos en posición general (ningún trío colineal)
    if !has_quadrangle(&all, lines) {
        return (
            false,
            "P3 falla: no existen cuatro puntos en posición general".to_string(),
        );
    }

    (true, "La estructura es un plano proyectivo".to_string())
}

/// Comprueba si existen cuatro puntos sin ningún trío colineal.
fn has_quadrangle(points: &[Point], lines: &[Line]) -> bool {
    let n = points.len();

    for a in 0..n {
        for b in (a + 1)..n {
            for c in (b + 1)..n {
                for d in (c + 1)..n {
                    let quad = [points[a], points[b], points[c], points[d]];

                    // Un trío es colineal si alguna recta contiene 3 de los 4
                    let collinear = lines.iter().any(|line| {
                        quad.iter().filter(|p| line.contains(p)).count() >= 3
                    });

                    if !collinear {
                        return true;
                    }
                }
            }
        }
    }

    false
}

/// Construye una recta a partir de la lista de sus puntos.
fn line(points: &[Point]) -> Line {
    points.iter().copied().collect()
}

fn main() {
    // Plano de Fano, PG(2,2): 7 puntos y 7 rectas; cada recta tiene 3 puntos
    // y por cada punto pasan 3 rectas.
    let fano_points: BTreeSet<Point> = (1..=7).collect();
    let fano_lines = vec![
        line(&[1, 2, 3]),
        line(&[1, 4, 5]),
        line(&[1, 6, 7]),
        line(&[2, 4, 6]),
        line(&[2, 5, 7]),
        line(&[3, 4, 7]),
        line(&[3, 5, 6]),
    ];

    let (is_valid, message) = is_projective_plane(&fano_points, &fano_lines);
    println!("Plano de Fano: {} -> {}", message, is_valid);

    // Geometría de tres puntos (el «triángulo»): cumple P1, pero no P3,
    // porque solo tiene tres puntos.
    let triangle_points: BTreeSet<Point> = (1..=3).collect();
    let triangle_lines = vec![line(&[1, 2]), line(&[1, 3]), line(&[2, 3])];

    let (is_valid, message) = is_projective_plane(&triangle_points, &triangle_lines);
    println!("Geometría de tres puntos: {} -> {}", message, is_valid);
}
