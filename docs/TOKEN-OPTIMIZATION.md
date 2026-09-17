# Token Optimization

O objetivo é reduzir contexto desperdiçado em Codex, Claude Code e GitHub Copilot sem
reduzir qualidade.

## Camadas

1. RTK: compacta saída de terminal.
2. Context Selector: limita arquivos lidos à task atual.
3. Context Manifest: declara dependências e exclusões.
4. Testes progressivos: roda primeiro o conjunto afetado.
5. Checkpoints: evita reconstruir contexto entre sessões.
6. Quality Gates: valida o sistema completo antes da entrega.

## Regra principal

Não leia o projeto inteiro por padrão. Comece pelo mapa, status e manifesto da task.

## RTK

RTK é opcional. Verifique:

```bash
rtk --version
rtk gain
```

Configuração por agente:

```bash
rtk init -g              # Claude Code
rtk init -g --codex      # Codex
rtk init -g --copilot    # GitHub Copilot
```

Depois da sessão, `rtk gain` pode ser usado para consultar estatísticas de economia
fornecidas pelo próprio RTK.

Se RTK não estiver disponível, use saída silenciosa, filtros, testes direcionados e
Context Manifest.

## Segurança operacional

Nunca executar instaladores externos automaticamente como parte da geração do CMS.
A instalação de ferramentas de desenvolvimento deve ser uma ação consciente do
desenvolvedor.
