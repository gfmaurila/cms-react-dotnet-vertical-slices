# RTK — integração opcional

Rust Token Killer (RTK) é usado apenas durante desenvolvimento assistido por IA.
Ele não faz parte da aplicação .NET/React e não deve ser incluído na imagem de produção.

Projeto oficial:
https://github.com/rtk-ai/rtk

## Verificação

```bash
rtk --version
rtk gain
```

`rtk gain` deve funcionar. Existe outro projeto chamado RTK; não confundir os dois.

## Inicialização

```bash
# Claude Code
rtk init -g

# Codex
rtk init -g --codex

# GitHub Copilot
rtk init -g --copilot
```

## Windows

Use o executável apropriado pelo terminal/PowerShell ou WSL e mantenha-o no PATH.
Não execute o .exe por duplo clique.

## Política do Harness

- verificar antes de instalar;
- não instalar automaticamente;
- não tornar RTK dependência de runtime;
- continuar normalmente se RTK estiver ausente;
- usar `rtk gain` para medir economia quando disponível.
