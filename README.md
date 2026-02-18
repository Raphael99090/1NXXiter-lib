# 🎨 Crimson UI Library - V3.0

![Version](https://img.shields.io/badge/version-3.0-crimson)
![Status](https://img.shields.io/badge/status-active-success)
![Platform](https://img.shields.io/badge/platform-Roblox-black)
![License](https://img.shields.io/badge/license-MIT-gold)

Uma biblioteca de interface moderna para Roblox focada em design limpo, modularidade e estabilidade.

---

## 🚀 Sobre o Projeto

A **Crimson UI Library** é um framework de interface desenvolvido para facilitar a criação de janelas organizadas e componentes interativos dentro do ambiente Roblox.

Projetada com foco em:
- Estrutura modular (Single-File Module Pattern)
- Código organizado e otimizado
- Sistema visual consistente
- Fácil integração em projetos

---

## 🎨 Inspiração de Design

O design da **Crimson UI Library** foi inspirado visualmente em painéis competitivos, trazendo:
- Sidebars verticais modernas
- Interfaces compactas e organizadas
- Uso de contraste forte (Crimson & Obsidian)
- Feedback visual em interações (Tweens)

---

## ✨ Recursos

✔️ Janela Arrastável
✔️ Sistema de Abas (Sidebar)
✔️ Minimização com Bubble Flutuante
✔️ Notificações Animadas
✔️ Tema Customizável
✔️ Componentes Modulares
✔️ Estrutura Estável

---

## 📦 Componentes Disponíveis

- CriarToggle()
- CriarBotao()
- CriarInput()
- CriarDropdown()
- CriarSlider()
- CriarLabel()
- Notify()

---

## 📥 Instalação

1. Coloque o código da biblioteca dentro de um **ModuleScript**.
2. Utilize no seu script:

```lua
local Library = -- require ou o próprio código aqui

-- Criando a Janela Principal
local UI = Library.Window.Create("Meu Projeto")

-- Criando uma Aba
local Tab = UI:CriarAba("⚙️", "Config")

-- Exemplo de Toggle
Tab:CriarToggle("Ativar Sistema", false, function(state)
    print("Estado do Toggle:", state)
end)

-- Exemplo de Notificação (Função interna da Window)
-- UI:Notify("Título", "Mensagem", Tempo)
```

---

## 📜 Change Log

### 🔴 v3.0 (Versão Atual)
- **Rebranding**: Migração total para **Crimson UI**.
- **Arquitetura**: Implementação de Modular Architecture (Single-File).
- **Bubble Mode**: Sistema de ícone flutuante automático ao minimizar.
- **Fixes**: Correção de sobreposição em Dropdowns e arraste de janela.

### 🔹 v1.5
- Correção de glitch visual na sidebar.
- Ajustes visuais no Header.

---

## 📊 Detalhes Técnicos
- **Linguagem**: Lua (Luau)
- **Plataforma**: Roblox
- **Estrutura**: Modular
- **Sistema de animação**: TweenService
- **Versão Atual**: 3.0

---

## 👨‍💻 Autor

### Raphael99090
Desenvolvedor da **Crimson UI Library**
Focado em desenvolvimento de interfaces e arquitetura modular dentro do ambiente Roblox.

- 🔗 GitHub: https://github.com/Raphael99090
- 📦 Projeto: Crimson UI Library
- 🏷 Versão Atual: 3.0

---

## ⚠️ Aviso
Esta biblioteca é destinada ao desenvolvimento dentro do ambiente Roblox. O uso deve respeitar os Termos de Serviço da plataforma. O autor não se responsabiliza por modificações externas feitas por terceiros.
