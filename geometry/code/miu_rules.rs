/// Reglas de derivación del sistema formal MIU (acertijo MU de Hofstadter).
///
/// Alfabeto: M, I, U.  Axioma inicial: MI.
///
///     Regla 1:  xI    -> xIU     (si termina en I, añadir U)
///     Regla 2:  Mx    -> Mxx     (si empieza por M, duplicar el resto)
///     Regla 3:  xIIIy -> xUy     (sustituir III por U)
///     Regla 4:  xUUy  -> xy      (eliminar UU)
///
/// Compilar: rustc -O -o miu_rules miu_rules.rs
/// Ejecutar: ./miu_rules
use std::collections::BTreeSet;

/// Aplica las cuatro reglas del sistema MIU a una cadena y devuelve el
/// conjunto de todas las cadenas derivables en un solo paso.
fn apply_rules(string: &str) -> BTreeSet<String> {
    let mut derivations = BTreeSet::new();
    let bytes = string.as_bytes();

    // Regla 1: xI -> xIU
    if string.ends_with('I') {
        derivations.insert(format!("{}U", string));
    }

    // Regla 2: Mx -> Mxx
    if string.starts_with('M') {
        let rest = &string[1..];
        derivations.insert(format!("M{}{}", rest, rest));
    }

    // Regla 3: III -> U (en todas las posiciones posibles)
    for i in 0..bytes.len().saturating_sub(2) {
        if &string[i..i + 3] == "III" {
            derivations.insert(format!("{}U{}", &string[..i], &string[i + 3..]));
        }
    }

    // Regla 4: eliminar UU (en todas las posiciones posibles)
    for i in 0..bytes.len().saturating_sub(1) {
        if &string[i..i + 2] == "UU" {
            derivations.insert(format!("{}{}", &string[..i], &string[i + 2..]));
        }
    }

    derivations
}

/// Decide si una cadena es alcanzable desde el axioma MI.
///
/// El invariante del sistema es el número de letras I módulo 3: partiendo
/// de MI (una sola I) ese residuo nunca llega a ser cero. Por eso MU, que
/// no tiene ninguna I, es inalcanzable.
fn is_derivable(string: &str) -> bool {
    // La cadena debe empezar por M y usar solo el alfabeto del sistema
    if !string.starts_with('M') || !string.chars().all(|c| "MIU".contains(c)) {
        return false;
    }

    string.chars().filter(|&c| c == 'I').count() % 3 != 0
}

fn main() {
    let axiom = "MI";
    let derivations = apply_rules(axiom);

    println!("Axioma: {}", axiom);
    println!(
        "Derivaciones en un paso: {:?}",
        derivations.iter().collect::<Vec<_>>()
    );

    // Exploración por niveles del árbol de derivaciones
    let mut level: BTreeSet<String> = BTreeSet::from([axiom.to_string()]);
    for depth in 1..=3 {
        level = level.iter().flat_map(|s| apply_rules(s)).collect();
        println!("Nivel {}: {} cadenas", depth, level.len());
    }

    println!("\nComprobación del invariante (número de I módulo 3):");
    for candidate in ["MU", "MIU", "MIUIU", "MUII", "MIIII"] {
        let status = if is_derivable(candidate) {
            "derivable"
        } else {
            "NO derivable"
        };
        println!("  {:8} -> {}", candidate, status);
    }
}
