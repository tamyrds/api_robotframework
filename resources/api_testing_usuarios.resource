*** Settings ***
Library               RequestsLibrary
Library               String
Library               OperatingSystem
Library    Collections

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