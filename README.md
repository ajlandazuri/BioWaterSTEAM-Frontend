# 🌐 BioWaterSTEAM Frontend

Interfaz web desarrollada para el proyecto **BioWaterSTEAM**, una solución IoT enfocada en el monitoreo inteligente de la calidad del agua mediante sensores conectados a un ESP32.

Este sistema permite visualizar en tiempo real parámetros críticos como **pH, TDS y temperatura**, facilitando la interpretación de datos y la toma de decisiones de manera rápida y eficiente.

---

## 🚀 Descripción

El frontend de BioWaterSTEAM consume datos en tiempo real desde la API y la base de datos en la nube, mostrando información actualizada sobre el estado del agua.

El sistema está diseñado para:

- Presentar información clara y comprensible
- Actualizar datos automáticamente
- Funcionar en diferentes dispositivos
- Facilitar el monitoreo continuo

Los datos visualizados incluyen:

- `pH` → Nivel de acidez o alcalinidad  
- `TDS` → Sólidos disueltos totales (ppm)  
- `Temperatura` → Grados Celsius (°C)  

Con una frecuencia de actualización aproximada de **5 segundos**.

---

## 🧠 Funcionalidades principales

- 📊 Visualización en tiempo real de datos  
- 🔄 Actualización automática  
- ⚠️ Indicadores visuales para valores críticos  
- 📱 Diseño responsive (adaptable a móviles)  
- 🌐 Integración con API y Firebase  

---

## 🧠 Experiencia de Usuario (UX)

El diseño del frontend se centra en ofrecer una experiencia clara, intuitiva y orientada a la toma de decisiones en tiempo real.

### 🎯 Principios aplicados

- **Simplicidad visual**  
  Se priorizan los datos más importantes evitando saturar la interfaz.

- **Lectura rápida de información**  
  Los valores se muestran de forma destacada para facilitar su interpretación inmediata.

- **Feedback en tiempo real**  
  La actualización constante permite conocer el estado del sistema sin intervención del usuario.

- **Indicadores de alerta**  
  Se utilizan señales visuales cuando los valores superan límites críticos.

- **Consistencia visual**  
  Uso uniforme de colores, tipografía y estructura.

---

### 👤 Enfoque en el usuario

El sistema está pensado para:

- Técnicos en campo  
- Operadores de sistemas de agua  
- Usuarios sin conocimientos técnicos avanzados  

Se prioriza la facilidad de uso sobre la complejidad técnica.

---

### 🚀 Valor agregado

- Mejora la toma de decisiones  
- Reduce errores humanos  
- Permite monitoreo continuo  
- Facilita la interpretación de datos  

---

## 🏗️ Arquitectura

Sensores (ESP32)
↓
API REST
↓
Firebase Realtime Database
↓
Frontend Web


---

## ⚙️ Tecnologías utilizadas

- **HTML5** → Estructura de la interfaz  
- **CSS3** → Diseño y estilos visuales  
- **JavaScript** → Lógica del sistema  
- **Firebase** → Datos en tiempo real  
- **Fetch API / Axios** → Consumo de la API  

---

## 🌐 Integración

El frontend se conecta con:

- 🔗 API BioWaterSTEAM  
- ☁️ Firebase Realtime Database  
- 📡 Dispositivos IoT (ESP32)  

---

## 🔐 Consideraciones

- Manejo de errores en la obtención de datos  
- Validación de datos recibidos  
- Optimización para tiempo real  
- Posible implementación de autenticación  

---

## 👨‍💻 Autores

- Andy Jhoel Landázuri Ruales  
- Tito Amauri Córdova Lema  
- Anderson Darío Lechón Cuaspud  
- Andrés Oswaldo Villareal Bolaños  

---

## 📄 Licencia

Proyecto de uso académico.
