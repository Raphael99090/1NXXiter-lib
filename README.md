# 🎨 1NXITER UI Library

![Version](https://img.shields.io/badge/version-1.5-red)
![Status](https://img.shields.io/badge/status-active-success)
![Platform](https://img.shields.io/badge/platform-Roblox-black)
![License](https://img.shields.io/badge/license-MIT-gold)

Uma biblioteca de interface moderna para Roblox focada em design limpo, modularidade e estabilidade.

---

## 🚀 Sobre o Projeto

A **1NXITER UI Library** é um framework de interface desenvolvido para facilitar a criação de janelas organizadas e componentes interativos dentro do ambiente Roblox.

Projetada com foco em:

- Estrutura modular
- Código organizado
- Componentes reutilizáveis
- Sistema visual consistente
- Fácil integração em projetos

---

## 🎨 Inspiração de Design

O design da **1NXITER UI Library** foi inspirado visualmente em painéis customizados populares na comunidade de jogos competitivos, especialmente layouts vistos na comunidade de Free Fire.

A inspiração é exclusivamente estética, baseada em:

- Sidebars verticais modernas  
- Interfaces compactas e organizadas  
- Uso de contraste forte em cores  
- Destaque visual em botões e toggles  
- Estrutura dividida por categorias  

A proposta foi adaptar esse estilo marcante para um padrão mais limpo, estruturado e reutilizável dentro do ambiente Roblox.

O foco não está na funcionalidade desses painéis originais, mas sim na identidade visual e na experiência de navegação, trazendo:

- Hierarquia clara de informações  
- Componentes bem espaçados  
- Feedback visual em interações  
- Organização modular  

O objetivo é unir estética chamativa com arquitetura organizada, resultando em uma biblioteca visualmente forte e tecnicamente estável.

---

## ✨ Recursos

✔️ Janela Arrastável  
✔️ Sistema de Abas (Sidebar)  
✔️ Minimização com Bubble Flutuante  
✔️ Notificações Animadas  
✔️ Tema Customizável  
✔️ Componentes Modulares  
✔️ Perfil de Usuário Integrado  
✔️ Estrutura Estável  

---

## 📦 Componentes Disponíveis

- CriarToggle()
- CriarBotao()
- CriarInput()
- CriarDropdown()
- CriarSlider()
- CriarLabel()
- CriarPerfil()
- Notificar()

---

## 📥 Instalação

1. Baixe o arquivo da biblioteca.
2. Coloque dentro de um **ModuleScript**.
3. Utilize no seu script:

```lua
local Library = require(path.to.library)

local UI = Library:CriarJanela("Meu Projeto")
local Tab = UI:CriarAba("⚙️")

Tab:CriarToggle("Ativar Sistema", false, function(state)
    print("Estado:", state)
end)

Tab:CriarBotao("Executar", function()
    UI:Notificar("Sucesso", "Sistema iniciado!", 3)
end)
```

---

## 📜 Change Log

### 🔹 v1.5
- Correção de glitch visual na sidebar  
- Ajuste de layout overflow  
- Melhor organização estrutural  
- Melhorias na estabilidade geral  
- Ajustes visuais no Header  

### 🔹 v1.2
- Adicionado sistema de Dropdown  
- Melhorias no Slider  
- Ajustes no sistema de abas  

### 🔹 v1.0
- Primeira versão estável  
- Sistema base de janela  
- Abas funcionais  
- Toggle, Botão e Input implementados  

---

## 📊 Detalhes Técnicos

- Linguagem: Lua (Luau)
- Plataforma: Roblox
- Estrutura: Modular
- Arquitetura: Orientada a Objetos (simples)
- Sistema de animação: TweenService
- Organização: UIListLayout
- Versão Atual: 1.5

---

## 🎯 Objetivo

Este projeto faz parte do meu desenvolvimento como programador e estudo de arquitetura de interfaces dentro do ambiente Roblox.

O foco é evoluir a biblioteca gradualmente com melhorias estruturais e novos recursos.

---

## 🛣 Roadmap

- [ ] Sistema de Save Config (JSON)
- [ ] Atualização automática de CanvasSize
- [ ] Sistema Destroy() completo
- [ ] Suporte a múltiplos temas
- [ ] Sistema interno de eventos

---

## 🤝 Contribuição

Contribuições são bem-vindas!

- Utilize a aba **Issues** para relatar bugs
- Sugira melhorias
- Envie Pull Requests

---

## ⚠️ Aviso

Esta biblioteca é destinada ao desenvolvimento dentro do ambiente Roblox.

O autor não se responsabiliza por:

- Uso indevido da biblioteca
- Banimentos causados por utilização em ambientes que violem os Termos de Serviço da plataforma
- Modificações externas feitas por terceiros

O uso deve respeitar os Termos de Serviço do Roblox.

---

## 🐞 Reportar Bug

Utilize a aba **Issues** do repositório ou entre em contato:

📧 jubileisao@gmail.com

---

## 👨‍💻 Autor

### Raphael99090

Desenvolvedor da **1NXITER UI Library**  
Focado em desenvolvimento de interfaces e arquitetura modular dentro do ambiente Roblox.

🔗 GitHub: https://github.com/Raphael99090  
📦 Projeto: 1NXITER UI Library  
🏷 Versão Atual: 1.5  

---

## 🌱 Sobre o Desenvolvedor

Este projeto faz parte da evolução contínua como programador, com foco em:

- Estrutura organizada
- Código reutilizável
- Arquitetura escalável
- Design consistente

A proposta é evoluir gradualmente a biblioteca aplicando boas práticas de desenvolvimento e aprimorando cada versão.

---

## ⭐ Apoie o Projeto

Se a biblioteca foi útil para você:

- ⭐ Dê uma estrela no repositório
- 🔁 Compartilhe com outros desenvolvedores
- 💡 Sugira melhorias na aba Issues
