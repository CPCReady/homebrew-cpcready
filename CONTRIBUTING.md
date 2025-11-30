# homebrew-cpcready

Tap de Homebrew para CPCReady - Herramienta de desarrollo para Amstrad CPC

## Estructura del proyecto

```
.
├── .github/
│   └── workflows/
│       ├── test.yml       # Tests en Ubuntu y macOS
│       └── validate.yml   # Validación de fórmulas
├── Formula/
│   └── cpc.rb            # Fórmula de Homebrew
└── README.md             # Documentación
```

## Workflows

### Test Formula
- **Trigger**: Push, Pull Request, Manual
- **Plataformas**: Ubuntu Latest, macOS Latest
- **Acciones**:
  - Instalación de la fórmula
  - Verificación de comandos
  - Tests de Homebrew
  - Auditoría
  - Verificación de estilo

### Validate Formula
- **Trigger**: Cambios en `Formula/`, Manual
- **Plataforma**: Ubuntu Latest
- **Acciones**:
  - Validación de sintaxis
  - Verificación de estilo
  - Comprobación de dependencias
  - Validación de parseo

## Desarrollo local

```bash
# Clonar el repositorio
git clone https://github.com/CPCReady/homebrew-cpcready.git
cd homebrew-cpcready

# Probar la fórmula
brew install --build-from-source Formula/cpc.rb

# Auditar
brew audit --strict cpc

# Limpiar
brew uninstall cpc
```

## Actualizar la fórmula

1. Modificar `Formula/cpc.rb` con la nueva URL y SHA256
2. Probar localmente
3. Commit y push
4. Los workflows se ejecutarán automáticamente

## Licencia

MIT
