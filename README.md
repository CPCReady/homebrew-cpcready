# homebrew-cpcready

Tap oficial de Homebrew para **CPCReady**, una herramienta de desarrollo para Amstrad CPC.

## 📋 Descripción

Este repositorio contiene la fórmula de Homebrew para instalar CPCReady, una herramienta completa para el desarrollo de software para el ordenador Amstrad CPC. CPCReady incluye compiladores, ensambladores y utilidades para facilitar la creación de programas para esta plataforma retro.

## � Estado de CI/CD

![Test Formula](https://github.com/CPCReady/homebrew-cpcready/workflows/Test%20Formula/badge.svg)
![Validate Formula](https://github.com/CPCReady/homebrew-cpcready/workflows/Validate%20Formula/badge.svg)

Este tap incluye pruebas automáticas que se ejecutan en:
- **Ubuntu Latest**: Verifica la instalación en Linux
- **macOS Latest**: Verifica la instalación en macOS

Los workflows automáticos validan:
- ✅ Instalación correcta de la fórmula
- ✅ Ejecución de comandos básicos (`--version`, `--help`)
- ✅ Tests de Homebrew
- ✅ Auditoría de la fórmula
- ✅ Verificación de estilo de código

## �🚀 Instalación

### Instalación rápida

```bash
brew tap CPCReady/cpcready
brew install cpc
```

### Instalación en un solo comando

```bash
brew install CPCReady/cpcready/cpc
```

## 📦 Requisitos

- **Homebrew**: Asegúrate de tener Homebrew instalado en tu sistema macOS o Linux
- **Python 3.13**: La fórmula instalará automáticamente Python 3.13 como dependencia

## 🔧 Uso

Una vez instalado, puedes usar el comando `cpc` desde cualquier terminal:

```bash
# Ver la versión instalada
cpc --version

# Ver ayuda y comandos disponibles
cpc --help
```

## 🔄 Actualización

Para actualizar CPCReady a la última versión:

```bash
brew update
brew upgrade cpc
```

## 🗑️ Desinstalación

Para desinstalar CPCReady:

```bash
brew uninstall cpc
```

Para eliminar también el tap:

```bash
brew uninstall cpc
brew untap CPCReady/cpcready
```

## 🛠️ Desarrollo

### Estructura del repositorio

```
homebrew-cpcready/
├── Formula/
│   └── cpc.rb          # Fórmula de Homebrew para CPCReady
└── README.md           # Este archivo
```

### Actualizar la fórmula

Para actualizar la fórmula cuando hay una nueva versión de CPCReady:

1. Actualiza la URL y el SHA256 en `Formula/cpc.rb`
2. Verifica que la versión sea correcta
3. Haz commit y push de los cambios

```bash
# Calcular el SHA256 de un nuevo wheel
shasum -a 256 cpcready-X.Y.Z-py3-none-any.whl
```

### Probar la fórmula localmente

```bash
# Instalar desde el repositorio local
brew install --build-from-source Formula/cpc.rb

# Auditar la fórmula
brew audit --strict cpc

# Probar la fórmula
brew test cpc
```

### Workflows de GitHub Actions

Este repositorio incluye dos workflows automáticos:

#### 1. **Test Formula** (`.github/workflows/test.yml`)
Se ejecuta en cada push y pull request. Prueba la fórmula en Ubuntu y macOS:
- Instala la fórmula desde el tap
- Verifica que los comandos funcionen
- Ejecuta los tests de Homebrew
- Audita la fórmula
- Verifica el estilo de código

#### 2. **Validate Formula** (`.github/workflows/validate.yml`)
Se ejecuta cuando se modifican archivos en `Formula/`:
- Valida la sintaxis de la fórmula
- Verifica el estilo de código
- Comprueba las dependencias
- Valida que la fórmula se pueda parsear correctamente

Puedes ejecutar manualmente cualquier workflow desde la pestaña "Actions" en GitHub.

## 📝 Información de la fórmula

- **Nombre**: cpc
- **Descripción**: CPCReady - Amstrad CPC development tool
- **Homepage**: https://github.com/CPCReady/cpc
- **Licencia**: MIT
- **Dependencias**: Python 3.13

## 🐛 Reportar problemas

Si encuentras algún problema con la instalación o el funcionamiento de CPCReady a través de Homebrew:

1. Verifica que tienes la última versión: `brew update && brew upgrade cpc`
2. Revisa los logs: `brew gist-logs cpc`
3. Reporta el problema en el repositorio correspondiente:
   - Problemas con la fórmula de Homebrew: [homebrew-cpcready/issues](https://github.com/CPCReady/homebrew-cpcready/issues)
   - Problemas con CPCReady: [cpc/issues](https://github.com/CPCReady/cpc/issues)

## 📚 Recursos adicionales

- [Documentación de CPCReady](https://github.com/CPCReady/cpc)
- [Guía de Homebrew Taps](https://docs.brew.sh/Taps)
- [Fórmula Cookbook](https://docs.brew.sh/Formula-Cookbook)

## 📄 Licencia

Este tap de Homebrew está disponible bajo la licencia MIT, al igual que CPCReady.

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Si deseas mejorar esta fórmula:

1. Haz fork del repositorio
2. Crea una rama para tu feature (`git checkout -b feature/mejora`)
3. Haz commit de tus cambios (`git commit -am 'Añade nueva mejora'`)
4. Haz push a la rama (`git push origin feature/mejora`)
5. Abre un Pull Request

---

**Nota**: Este es un tap de terceros no oficial de Homebrew. Para más información sobre CPCReady, visita el [repositorio principal](https://github.com/CPCReady/cpc).