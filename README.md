# IrisCare Soluctions

    O IrisCare é um aplicativo móvel desenvolvido para a prevenção e controle do Retinoblastoma, uma forma de câncer ocular, 
    por meio da análise de imagem, controle periódico e encaminhamento para a Secretaria Municipal e GRAACC.


----
# <span style="color: #63C71F;">Pitch</span>

[Assista ao video Pitch](https://youtu.be/Xke6Jv6ONQ0)

----

# <span style="color: #63C71F;">Demonstração WebApp da Azure </span>

[Assista ao video do back-end integrado rodando](https://youtu.be/YqC0E4ZScxM)

<br/>

  link deploy: https://api-iriscare.azurewebsites.net/swagger-ui/index.html


---

# Desenvolvedores:

    -> RM: 93915 -  JAELSON DOS SANTOS

    -> RM: 94311 - MARCOS BILOBRAM

    -> RM: 96320 - NATHÁLIA MAIA

    -> RM: 94972 - RAFAELA DA SILVA

    -> RM: 93613 - VINICIUS DE OLIVEIRA



<div align="center"> 
    <a href="https://github.com/JaelsonJonas">
        <img align="center" height="100" width="100" style="border-radius: 50%;" src="https://avatars.githubusercontent.com/u/101295166?v=4" />
    </a>
    <a href="https://github.com/marcosbilobram">
        <img align="center" height="100" width="100" style="border-radius: 50%;" src="https://avatars.githubusercontent.com/u/92834827?v=4" />
    </a>
    <a href="https://github.com/natmaia">
        <img align="center" height="100" width="100" style="border-radius: 50%;" src="https://avatars.githubusercontent.com/u/105464103?s=96&v=4" />
    </a>
    <a href="https://github.com/gsrafaela">
        <img align="center" height="100" width="100" style="border-radius: 50%;" src="https://avatars.githubusercontent.com/u/99452621?v=4" />
    </a>
    <a href="https://github.com/ViniOlr">
        <img align="center" height="100" width="100" style="border-radius: 50%;" src="https://avatars.githubusercontent.com/u/81593244?v=4" />
    </a>
</div>




# <span style="color: #63C71F;">Tecnologias Utilizadas</span>

          
<div align="center">
    <img align="center" alt="weplant-java" height="40" width="12%" src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/java/java-original-wordmark.svg" />
    <img align="center" alt="weplant-illustrator" height="40" width="12%" src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/spring/spring-original-wordmark.svg" />
    <img align="center" alt="weplant-html5" height="40" width="12%" src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/postgresql/postgresql-original.svg" />
    <img align="center" alt="weplant-react" height="40" width="12%" src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/react/react-original-wordmark.svg" />
    <img align="center" alt="weplant-nodejs" height="40" width="12%" src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/python/python-original-wordmark.svg" />
    <img align="center" alt="weplant-nodejs" height="40" width="12%" src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/csharp/csharp-original.svg" />
    <img align="center" alt="weplant-nodejs" height="40" width="12%" src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/azure/azure-original.svg" />
          
          

</div>

<br/>

<br/>

# <span style="color: #63C71F;">Configuração e Execução </span>

## Requisitos : 

- Git
- JDK 17
- Node.JS
- Expo
- IDE de preferência (Ex: VsCode)
- Android Studio com emulador de Android

## Passo a passo

- [Clone o projeto Java do repositório DigitalBusiness](https://github.com/IrisCareSoluctions/DigitalBusiness)
- Abra o projeto Java clonado na IDE escolhida e ache a classe "IriscareapiApplication" para inicar a execução do projeto na porta localhost:8080.
- [Clone o projeto React do repositório DigitalBusiness](https://github.com/IrisCareSoluctions/HybridMobile)
- Execute o emulador instalado na máquina.
- Abra o projeto React clonado na IDE escolhida e execute o comando "npm i", logo após, npx expo start. Siga os passos para obter o projeto no emulador.


<br/>

# <span style="color: #63C71F;">Endpoints </span>

## UserController

### Método signup:
Rota: "localhost:8080/user/signup" <br>
Descrição: Cadastra um novo usuário com base nos dados fornecidos.

```js
Request Body:

{
    "name": "John Doe",
    "cpf": "752.106.910-20",
    "birthday": "01/01/1990",
    "email": "john.doe4@example.com",
    "password": "securepassword",
    "address": {
        "zipCode": "12345-678",
        "number": "123",
        "street": "Example Street",
        "neighborhood": "Sample Neighborhood",
        "city": "Sample City",
        "state": "Sample State"
    },
    "phone": {
        "ddd": "123",
        "number": "987654321"
    }
}


```

### Método login:
Rota: "localhost:8080/user/login" <br>
Descrição: Realiza o login do usuário com base nas informações fornecidas.

``` js
{
"email" : "email",
"password" : "senha"
}
```

### Método findById:
Rota: "localhost:8080/user/{**user_id**}" <br>
Descrição: Retorna um usuário com o ID especificado.

### Método updateUser:
Rota: "localhost:8080/users/{**user_id**}" <br>
Descrição: Atualiza um usuário existente com base nos dados fornecidos.

```js
Request body
 Irá variar de acordo com as informações a se atualizar: 
 
 {
  "name": "Jaelson",
  "cpf": "43133963813",
  "birthday": "06/06/1996",
  "email": "livedojonas@hotmail.com",
  "password": "1234"
}


```

### Método deactivateUser:
Rota: "localhost:8080/user/{**user_id**}" <br>
Descrição: Atualiza o atributo "active" de um usuário para false ou true.

...

Para um detalhamento completo dos endpoints feito pelo swagger, após a execução da aplicação Java, acesse a interface do swagger da aplicação pelo link : http://localhost:8080/swagger-ui/index.html#/.


# <span style="color: #63C71F;">Equipe</span>

     A equipe responsável por esse projeto é composta por:

- <span style="color: #63C71F;">RM: 93915 - Jaelson dos Santos </span> 
- <span style="color: #63C71F;">RM: 94311 - Marcos Bilobram </span> 
- <span style="color: #63C71F;">RM: 96320 - Nathália Maia </span> 
- <span style="color: #63C71F;">RM: 94972 - Rafaela da Silva </span>
- <span style="color: #63C71F;">RM: 93613 - Vinicus de Oliveira </span>

        Cada membro da equipe desempenha um papel fundamental no desenvolvimento e no sucesso do projeto, contribuindo com suas habilidades e conhecimentos na área de tecnologia.

<br/>

# <span style="color: #63C71F;">Considerações Finais</span>

        O desenvolvimento do Iriscare é um projeto realizado como parte da prova semestral da faculdade FIAP, com o tema "“Inovação e Tecnologia Moldandoo Futuro da Saúde: Prevenção,Automação e Precisão".

        A equipe se empenhou para criar uma solução eficiente e inovadora, que visa promover o combate ao retinoblastoma.

O projeto Iriscare está disponível na íntegra, incluindo todos os códigos-fonte e entregas, na organização do GitHub: 
https://github.com/IrisCareSoluctions.

<br/>

