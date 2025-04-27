<h1 align="center"> Projeto-de-Sistemas | Planejamento</h1>

<table align="center">
    <tr>
        <td><a href="..\README.md">Home</a></td>
        <td><a href="defaults.md">Padrões</a></td>
        <td>Planejamento</td>
        <td>
            <details style="position: relative;">
                <summary>Mais</summary>
                <ul style="position: absolute; background: transparent;">
                    <li><a href="contact.md">Contato</a></li>
                </ul>
            </details>
        </td>
    </tr>
</table>

<hr>

## Para o projeto:

- Realizar todas as comunicações com banco de dados via API com o servidor em Django, para padronizar os dados e facilitar futuras alterações


### Padrões Flutter para a aplicação mobile:

- Arquitetura limpa (Clean architeture)
- Separação do código em camadas (MVC)

### Para rodar o projeto:

###### É necessária a instalação dos seguintes programas:

1. <a hred="https://docs.flutter.dev/get-started/install">Flutter SDK</a>
2. <a href="https://developer.android.com/studio/install?hl=pt-br">Android Studio</a>, ou algum dispositivo para servir de emulador
    - Nota: É necessário ativar a opção de virtualização na BIOS do seu computador se optar por usar emulador
    - Se optar por usar um dispositivo físico, verifique-se de o dispositivo estar configurado para o modo desenvolvedor
3. <a href="https://code.visualstudio.com/download">Visual Studio Code</a> (qualquer editor de código pode ser utilizado, entretanto, o tutorial diz respeito a funções do VSCode)
4. <a hred="https://marketplace.visualstudio.com/items/?itemName=Dart-Code.flutter">Extensão oficial do Flutter do VSCode</a>

### Configurando o emulador:

Para essa etapa, configuramos um dispositivo android, para facilidade com a compilação

1. Instale o <a href="https://developer.android.com/studio/install?hl=pt-br">Android Studio</a>
2. Ao abrir, procurar a seção <strong>More Actions</strong>, e selecionar a opção <strong>Virtual Device Manager</strong>, e lá vão aparecer seus dispositivos configurados 
3. Para criar um dispositivo, apertar o botão <strong>+</strong> e selecionar o que deseja para seu dispositivo
4. No VSCode, com o projeto Flutter aberto, no canto inferior direito, aparecerá uma opção de escolher o emulador. Basta colocar o dispositivo que acabou de ser configurador e pronto!

#### Rodando o projeto:

- Com o Flutter SDK instalado e o emulador aberto, basta usar os comandos
    ```bash
    flutter pub get 
    ```
    Para instalar as dependências, e
    ```bash
    flutter run lib/main.dart
    ```
    Para iniciar a aplicação
    - No VSCode, também pode ser usado a tecla <strong>F5</strong>, que roda o projeto em modo de debug (necessário)
- Feitas alterações, no terminal que foi usado o flutter run, apertar <strong>r</strong> para usar o hot reload. Se estiver rodando com o F5 do VSCode, só é necessário salvar o arquivo
- Para parar a execução basta interromper o terminal com <strong>Control + C</strong> ou apertar em parar no menu do F5 do VSCode

#### Conectando ao Back-end:
- Para conectar ao back-end, no projeto Django, devem estar configuradas as portas de <strong>ALLOWED_HOSTS</strong> para aceitar requisições vindas do Flutter, encontradas no arquivo <code>.env</code>
    ```bash
    ALLOWED_HOSTS="localhost,<endereço_aqui>"
    ```
- Depois, criar, na pasta <code>utils</code> do projeto Flutter, um arquivo <code>api_configs.dart</code>, que tenha as variáveis necessárias para realizar a comunicação com o back-end
- Após isso, enquanto estiver rodando o servidor Django, ele deve aceitar requisições vindas do Flutter 
