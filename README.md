Oi-Fibra-Unblock-Us
===================

Explicação longa e motivação - [veja este post] (http://tumblr.macaubas.com/post/93930890220/configurando-seu-roteador-do-oi-fibra-technicolor)

Em resumo: script ruby para monitorar configuração do DNS do unblock-us no roteador do Oi Fibra e resetar para a configuração correta toda vez que rolar um renew no DNS.

Dá para não utilizar este script alterando as métricas dos servidores de DNS na hora de reconfigurar o router (como descrito no artigo). Porém, a tabela de forward de DNS vai ficar sempre suja, e isso pode causar comportamentos inesperados. Se você tem como deixar esse script rodando, você garante sempre uma tabela de DNS forwarding saudável e limpinha. Se não der para deixar o script rodando, faça a recomendação que está no artigo acima. 

### Quick-start:
```bash
$ git clone git@github.com:macaubas/Oi-Fibra-Unblock-Us.git
$ mv settings-sample.yml settings.yml
$ vim settings.yml
$ chmod +x check_router.rb
$ ./check_router.rb
```

### Configurando no OS X - launchd
Configurar o launchd para executar este script a cada 5 minutos é uma boa solução para não ter dor de cabeça com o unblock-us sendo desconfigurado a toda hora pelo renew do DNS.

```bash
$ vim ./LaunchAgents/com.macaubas.check_router.plist
```

E edite as chaves:
```xml
	<key>Program</key>
	<string>/Users/igor/Projects/oi-fibra_unblock-us/check_router.rb</string>
	<key>WorkingDirectory</key>
	<string>/Users/igor/Projects/oi-fibra_unblock-us</string>
```

Para refletir o path correto para a aplicação. Depois disso, é necessário copiar e registrar o novo _LaunchAgent_ junto ao launchd:
```bash
$ cp ./LaunchAgents/com.macaubas.check_router.plist ~/Library/LaunchAgents/
$ launchctl load ~/Library/LaunchAgents/com.macaubas.check_router.plist
$ launchctl start com.macaubas.check_router.plist
```

E o script será executado a cada 300 segundos, ou de 5 em 5 minutos. Monitore o log.txt para ver as execuções acontecendo.

### Configurando no Linux - crontab
Configurar no crontab é bem fácil. Execute:

```bash
$ crontab -e
```

Isso vai abrir as suas configurações atuais de crontab para o seu usuário em questão. Adicione a seguinte linha:
*/5 * * * * ruby /path/para/o/script/check_router.rb

Salve e saia.

Para verificar se está tudo certo, faça:
```bash
$ crontab -l
```

### Desinstalando no Mac - launchd
Para desinstalar este scritp no Mac, faça:
```bash
$ launchctl stop com.macaubas.check_router.plist
$ launchctl unload ~/Library/LaunchAgents/com.macaubas.check_router.plist
$ rm ~/Library/LaunchAgents/com.macaubas.check_router.plist
```

E apague o diretório com os demais arquivos.

### Desinstalando no Linux - crontab

Remova a linha do crontab referente à execução do script:
```bash
$ crontab -e
```

Salve e saia. E apague o diretório com os demais arquivos.

### Resetando o seu router
Caso alguma coisa dê errado (sua Internet ou IPTV parar de funcionar), faça um factory reset no seu router pela interface web do router, e abra uma issue aqui explicando o que houve.

