*** Settings ***
Library               RequestsLibrary
Library               String
Library               OperatingSystem
Library               Collections

*** Keywords ***

Criar um usuario novo
    ${palavra_aleatoria}        Generate Random String    length=4    chars=[LETTERS]
    ${palavra_aleatoria}        Convert To Lower Case    ${palavra_aleatoria}
    Set Test Variable    ${EMAIL_TESTE}    ${palavra_aleatoria}@gmail.com.br
    Log   ${EMAIL_TESTE}

Cadastrar o usuario criado na ServeRest
    ${body}        Create Dictionary    
    ...            nome=Tamires Silva 
    ...            email=${EMAIL_TESTE} 
    ...            password=1234    
    ...            administrador=true
    Log            ${body}
    Criar sessão na ServeRest
    ${resposta}    POST On Session    
    ...            alias=ServeRest
    ...            url=/usuarios
    ...            json=${body}
    Status Should Be    201
    Log         ${resposta.json()}
    Set Test Variable    ${RESPOSTA}        ${resposta.json()}

    
Criar sessão na ServeRest
    ${headers}     Create Dictionary     accept=application/json     Content-Type=application/json
    Create Session        alias=ServeRest        url=https://serverest.dev    headers=${headers}


Conferir se o usuario foi cadastrado corretamente

    Log    ${RESPOSTA}
    Dictionary Should Contain Item        ${RESPOSTA}    message    Cadastro realizado com sucesso
    Dictionary Should Contain Key        ${RESPOSTA}    _id



Criar um produto novo
    ${palavra_aleatoria}        Generate Random String    length=10    chars=[LETTERS]
    ${palavra_aleatoria}        Convert To Lower Case    ${palavra_aleatoria}

    Set Test Variable    ${PRODUTO}        ${palavra_aleatoria}

Cadastrar o produto criado na ServeRest
    Criar sessão na ServeRest
    ${body}    Create Dictionary
    ...        nome=${PRODUTO}
    ...        preco= 350
    ...        descricao=guarana zero
    ...        quantidade=20
    ...        administrador=true
    Log        ${body}

    ${resposta}    POST On Session
    ...            alias=ServeRest
    ...            url=/produtos
    ...            json=${body}
    
    Status Should Be    401
    Log         ${resposta.json()}
    Set Test Variable    ${RESPOSTA}        ${resposta.json()}

Conferir mensagem de retorno
    Log    ${RESPOSTA}
    Dictionary Should Contain Item        ${RESPOSTA}    message    Token de acesso ausente, inválido, expirado ou usuário do token não existe mais

    